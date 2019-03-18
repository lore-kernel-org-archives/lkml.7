Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F334C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F9E217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfCRX5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:57:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:22304 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbfCRX5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:57:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 16:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="152911954"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002.fm.intel.com with ESMTP; 18 Mar 2019 16:57:52 -0700
Subject: [PATCH] security/keys/trusted: Allow operation without hardware TPM
From:   Dan Williams <dan.j.williams@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 16:45:13 -0700
Message-ID: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than fail initialization of the trusted.ko module, arrange for
the module to load, but rely on trusted_instantiate() to fail
trusted-key operations.

Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 security/keys/trusted.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index bcc9c6ead7fd..d959597a688e 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -45,6 +45,13 @@ struct sdesc {
 static struct crypto_shash *hashalg;
 static struct crypto_shash *hmacalg;
 
+static struct device *chip_dev(struct tpm_chip *chip)
+{
+	if (chip)
+		return &chip->dev;
+	return NULL;
+}
+
 static struct sdesc *init_sdesc(struct crypto_shash *alg)
 {
 	struct sdesc *sdesc;
@@ -1224,6 +1231,14 @@ static int __init init_digests(void)
 	int ret;
 	int i;
 
+	/*
+	 * Hardware tpm operations are disabled, but allow the software
+	 * module to initialize, and depend on trusted_instantiate() to
+	 * fail any attempts to access the missing hardware.
+	 */
+	if (!chip)
+		return 0;
+
 	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
 	if (ret < 0)
 		return ret;
@@ -1246,8 +1261,6 @@ static int __init init_trusted(void)
 	int ret;
 
 	chip = tpm_default_chip();
-	if (!chip)
-		return -ENOENT;
 	ret = init_digests();
 	if (ret < 0)
 		goto err_put;
@@ -1263,13 +1276,13 @@ static int __init init_trusted(void)
 err_free:
 	kfree(digests);
 err_put:
-	put_device(&chip->dev);
+	put_device(chip_dev(chip));
 	return ret;
 }
 
 static void __exit cleanup_trusted(void)
 {
-	put_device(&chip->dev);
+	put_device(chip_dev(chip));
 	kfree(digests);
 	trusted_shash_release();
 	unregister_key_type(&key_type_trusted);

