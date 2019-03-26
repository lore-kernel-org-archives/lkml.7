Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1197B2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfCZMMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:12:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:14005 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfCZMMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:12:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 05:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="128764842"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.182])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2019 05:11:59 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linuxibm.com>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] KEYS: trusted: allow trusted.ko to initialize w/o a TPM
Date:   Tue, 26 Mar 2019 14:11:58 +0200
Message-Id: <20190326121158.13499-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow trusted.ko to initialize w/o a TPM. This commit adds checks to the
key type callbacks and exported functions to fail when a TPM is not
available.

Cc: James Morris <jmorris@namei.org>
Reported-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v3:
- remove unnecessary check for chip in init_trusted()
v2:
- Remove checks from the key type callbacks because the key type will
  not be registered.
- Cc to James Morris because hopefully we can land this 5.1.0.
 security/keys/trusted.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ecec672d3a77..efdbf17f3915 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -135,6 +135,9 @@ int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 	int ret;
 	va_list argp;
 
+	if (!chip)
+		return -ENODEV;
+
 	sdesc = init_sdesc(hashalg);
 	if (IS_ERR(sdesc)) {
 		pr_info("trusted_key: can't alloc %s\n", hash_alg);
@@ -196,6 +199,9 @@ int TSS_checkhmac1(unsigned char *buffer,
 	va_list argp;
 	int ret;
 
+	if (!chip)
+		return -ENODEV;
+
 	bufsize = LOAD32(buffer, TPM_SIZE_OFFSET);
 	tag = LOAD16(buffer, 0);
 	ordinal = command;
@@ -363,6 +369,9 @@ int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 {
 	int rc;
 
+	if (!chip)
+		return -ENODEV;
+
 	dump_tpm_buf(cmd);
 	rc = tpm_send(chip, cmd, buflen);
 	dump_tpm_buf(cmd);
@@ -429,6 +438,9 @@ int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
 {
 	int ret;
 
+	if (!chip)
+		return -ENODEV;
+
 	INIT_BUF(tb);
 	store16(tb, TPM_TAG_RQU_COMMAND);
 	store32(tb, TPM_OIAP_SIZE);
@@ -1245,9 +1257,13 @@ static int __init init_trusted(void)
 {
 	int ret;
 
+	/* encrypted_keys.ko depends on successful load of this module even if
+	 * TPM is not used.
+	 */
 	chip = tpm_default_chip();
 	if (!chip)
-		return -ENOENT;
+		return 0;
+
 	ret = init_digests();
 	if (ret < 0)
 		goto err_put;
@@ -1269,10 +1285,12 @@ static int __init init_trusted(void)
 
 static void __exit cleanup_trusted(void)
 {
-	put_device(&chip->dev);
-	kfree(digests);
-	trusted_shash_release();
-	unregister_key_type(&key_type_trusted);
+	if (chip) {
+		put_device(&chip->dev);
+		kfree(digests);
+		trusted_shash_release();
+		unregister_key_type(&key_type_trusted);
+	}
 }
 
 late_initcall(init_trusted);
-- 
2.19.1

