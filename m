Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F662C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F337821917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfCVSEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:04:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32912 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727693AbfCVSEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:04:36 -0400
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E0BA87EBD14F17CE7D47;
        Fri, 22 Mar 2019 18:04:34 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.49) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 22 Mar 2019 18:04:24 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <dhowells@redhat.com>,
        <zohar@linux.ibm.com>, <dan.j.williams@intel.com>
CC:     <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <david.safford@ge.com>, <jejb@linux.ibm.com>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] KEYS: trusted: defer execution of TPM-specific code until key instantiate
Date:   Fri, 22 Mar 2019 19:01:39 +0100
Message-ID: <20190322180139.18856-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure from
tpm_default_chip()") changed the tpm_chip argument of every TPM function
from NULL to a pointer that is retrieved at module initialization time.

Unlike before this patch, the trusted module cannot be loaded if no TPM is
available. Unfortunately, this causes a dependency problem because the
encrypted key type requires the 'key_type_trusted' symbol when
CONFIG_TRUSTED_KEYS is defined.

This patch fixes the issue by deferring the execution of TPM-specific code
until a new trusted key is instantiated: init_tpm(), to obtain a tpm_chip
pointer; init_digests(), introduced by commit 0b6cf6b97b7e ("tpm: pass an
array of tpm_extend_digest structures to tpm_pcr_extend()"), to get random
bytes from the TPM to lock a PCR.

Cc: stable@vger.kernel.org
Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()")
Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/keys/trusted.c | 89 +++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ecec672d3a77..c5162ca9c944 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -946,6 +946,44 @@ static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
 	return p;
 }
 
+static int init_tpm(void)
+{
+	if (chip)
+		return 0;
+
+	chip = tpm_default_chip();
+	if (!chip)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int init_digests(void)
+{
+	u8 digest[TPM_MAX_DIGEST_SIZE];
+	int ret;
+	int i;
+
+	if (digests)
+		return 0;
+
+	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
+	if (ret < 0)
+		return ret;
+	if (ret < TPM_MAX_DIGEST_SIZE)
+		return -EFAULT;
+
+	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
+			  GFP_KERNEL);
+	if (!digests)
+		return -ENOMEM;
+
+	for (i = 0; i < chip->nr_allocated_banks; i++)
+		memcpy(digests[i].digest, digest, TPM_MAX_DIGEST_SIZE);
+
+	return 0;
+}
+
 /*
  * trusted_instantiate - create a new trusted key
  *
@@ -967,6 +1005,14 @@ static int trusted_instantiate(struct key *key,
 	size_t key_len;
 	int tpm2;
 
+	ret = init_tpm();
+	if (ret < 0)
+		return ret;
+
+	ret = init_digests();
+	if (ret < 0)
+		return ret;
+
 	tpm2 = tpm_is_tpm2(chip);
 	if (tpm2 < 0)
 		return tpm2;
@@ -1218,58 +1264,23 @@ static int __init trusted_shash_alloc(void)
 	return ret;
 }
 
-static int __init init_digests(void)
-{
-	u8 digest[TPM_MAX_DIGEST_SIZE];
-	int ret;
-	int i;
-
-	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
-	if (ret < 0)
-		return ret;
-	if (ret < TPM_MAX_DIGEST_SIZE)
-		return -EFAULT;
-
-	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
-			  GFP_KERNEL);
-	if (!digests)
-		return -ENOMEM;
-
-	for (i = 0; i < chip->nr_allocated_banks; i++)
-		memcpy(digests[i].digest, digest, TPM_MAX_DIGEST_SIZE);
-
-	return 0;
-}
-
 static int __init init_trusted(void)
 {
 	int ret;
 
-	chip = tpm_default_chip();
-	if (!chip)
-		return -ENOENT;
-	ret = init_digests();
-	if (ret < 0)
-		goto err_put;
 	ret = trusted_shash_alloc();
 	if (ret < 0)
-		goto err_free;
+		return ret;
 	ret = register_key_type(&key_type_trusted);
 	if (ret < 0)
-		goto err_release;
-	return 0;
-err_release:
-	trusted_shash_release();
-err_free:
-	kfree(digests);
-err_put:
-	put_device(&chip->dev);
+		trusted_shash_release();
 	return ret;
 }
 
 static void __exit cleanup_trusted(void)
 {
-	put_device(&chip->dev);
+	if (chip)
+		put_device(&chip->dev);
 	kfree(digests);
 	trusted_shash_release();
 	unregister_key_type(&key_type_trusted);
-- 
2.17.1

