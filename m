Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B37C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75A72133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vacZwQqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbfB1XM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:27 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:50656 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387620AbfB1XMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:23 -0500
Received: by mail-qt1-f202.google.com with SMTP id q17so19941057qta.17
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S5u50ou6dLla6blYKl9fHyc7svwyBxHkPxLMCzeyAEs=;
        b=vacZwQqGEp3ylZYtfKbzDAvzH6q8iWcOmQf/YfNzzgpnrWTZt9W1I2AS+9TGuBDBEl
         VV9gCnae6QsKxfO6iYMu8Ra2JEkhVSV/wz7K3kd8rVuat3kvwk95orvzlUpblJmAlwT+
         ab4BWJg1bWXYZr0nZgrsqZ/6Qrn7NvKyRRXrvNePu8x2TFPRkksINMEor1PXlEPQSdjO
         o93SDyp8GVxNW1JnnqizY35wBjF2dTb0tDpZtdJtCTa43mzROuBVRPyTAd61NIzZ+v8i
         FAtdktJWfGWsg8UiamglKTkFos7nlKMdvdWHPtMSP2k2vdxRRDWuM8aYsk0JiwSD7vJW
         TSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S5u50ou6dLla6blYKl9fHyc7svwyBxHkPxLMCzeyAEs=;
        b=MJNoPuPlUcxGJ6R2dmVeegRXLapmWXsw1GaZoMX3ATraqR1YZHD/abbnWypT92mbSD
         qoI0a2vyJ4vR8WS1mPjgvOuhvfcxzlrjmbN/wPLhaGUQbygaF8rhIe9S6ie9MvwIf6q9
         InwoyR/mmdngXuJuCxRFLVcAKoHZQj9v87g4QrWo3AEyoRNeO9IFNT8sHByT2nDwWA+9
         mBcsQ//R6V3b1BuT29CT7hbuSFWRAeOluXZwR2HoUIgZ9Shf69lOgizjNzN4wx2o8RXy
         QyuaKmocvPHT6UYa8rqjx99EuObdiwO0ka+bsBDiSOkhp6jil7vYJFGQJAJ+xjvBzV6u
         tJVQ==
X-Gm-Message-State: APjAAAX70OucG4iQAkQmmY9APZ0mj03ypoyTnhpCyRWSKex5oqVxCZvC
        UGnexEW+J6Fyu2qSGWb4uB8tIbnU0loJrBIgoXGZHQ==
X-Google-Smtp-Source: APXvYqy51W/BZ3X5mYccqp5lVKNTiVG1/HR55C7q8BMxPHgC03iuGkCYOFNeuU8qK1i243zEQ5eaOQ5SbeFs5lZzdW3/4g==
X-Received: by 2002:a05:6214:1048:: with SMTP id l8mr1032741qvr.46.1551395542083;
 Thu, 28 Feb 2019 15:12:22 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:43 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 07/27] kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Bohac <jbohac@suse.cz>

This is a preparatory patch for kexec_file_load() lockdown.  A locked down
kernel needs to prevent unsigned kernel images from being loaded with
kexec_file_load().  Currently, the only way to force the signature
verification is compiling with KEXEC_VERIFY_SIG.  This prevents loading
usigned images even when the kernel is not locked down at runtime.

This patch splits KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE.
Analogous to the MODULE_SIG and MODULE_SIG_FORCE for modules, KEXEC_SIG
turns on the signature verification but allows unsigned images to be
loaded.  KEXEC_SIG_FORCE disallows images without a valid signature.

[Modified by David Howells such that:

 (1) verify_pefile_signature() differentiates between no-signature and
     sig-didn't-match in its returned errors.

 (2) kexec fails with EKEYREJECTED and logs an appropriate message if
     signature checking is enforced and an signature is not found, uses
     unsupported crypto or has no matching key.

 (3) kexec fails with EKEYREJECTED if there is a signature for which we
     have a key, but signature doesn't match - even if in non-forcing mode.

 (4) kexec fails with EBADMSG or some other error if there is a signature
     which cannot be parsed - even if in non-forcing mode.

 (5) kexec fails with ELIBBAD if the PE file cannot be parsed to extract
     the signature - even if in non-forcing mode.

]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: Matthew Garrett <mjg59@srcf.ucam.org>
cc: Chun-Yi Lee <jlee@suse.com>
cc: kexec@lists.infradead.org
---
 arch/x86/Kconfig                       | 20 ++++++++---
 crypto/asymmetric_keys/verify_pefile.c |  4 ++-
 include/linux/kexec.h                  |  4 +--
 kernel/kexec_file.c                    | 48 ++++++++++++++++++++++----
 4 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..710f77a0caef 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2016,20 +2016,30 @@ config KEXEC_FILE
 config ARCH_HAS_KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
-config KEXEC_VERIFY_SIG
+config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
 	---help---
-	  This option makes kernel signature verification mandatory for
-	  the kexec_file_load() syscall.
 
-	  In addition to that option, you need to enable signature
+	  This option makes the kexec_file_load() syscall check for a valid
+	  signature of the kernel image.  The image can still be loaded without
+	  a valid signature unless you also enable KEXEC_SIG_FORCE, though if
+	  there's a signature that we can check, then it must be valid.
+
+	  In addition to this option, you need to enable signature
 	  verification for the corresponding kernel image type being
 	  loaded in order for this to work.
 
+config KEXEC_SIG_FORCE
+	bool "Require a valid signature in kexec_file_load() syscall"
+	depends on KEXEC_SIG
+	---help---
+	  This option makes kernel signature verification mandatory for
+	  the kexec_file_load() syscall.
+
 config KEXEC_BZIMAGE_VERIFY_SIG
 	bool "Enable bzImage signature verification support"
-	depends on KEXEC_VERIFY_SIG
+	depends on KEXEC_SIG
 	depends on SIGNED_PE_FILE_VERIFICATION
 	select SYSTEM_TRUSTED_KEYRING
 	---help---
diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index d178650fd524..4473cea1e877 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -100,7 +100,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 
 	if (!ddir->certs.virtual_address || !ddir->certs.size) {
 		pr_debug("Unsigned PE binary\n");
-		return -EKEYREJECTED;
+		return -ENODATA;
 	}
 
 	chkaddr(ctx->header_size, ddir->certs.virtual_address,
@@ -408,6 +408,8 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
  *  (*) 0 if at least one signature chain intersects with the keys in the trust
  *	keyring, or:
  *
+ *  (*) -ENODATA if there is no signature present.
+ *
  *  (*) -ENOPKG if a suitable crypto module couldn't be found for a check on a
  *	chain.
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9b1bc5f9669..58b27c7bdc2b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -125,7 +125,7 @@ typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
 			     unsigned long cmdline_len);
 typedef int (kexec_cleanup_t)(void *loader_data);
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 typedef int (kexec_verify_sig_t)(const char *kernel_buf,
 				 unsigned long kernel_len);
 #endif
@@ -134,7 +134,7 @@ struct kexec_file_ops {
 	kexec_probe_t *probe;
 	kexec_load_t *load;
 	kexec_cleanup_t *cleanup;
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 	kexec_verify_sig_t *verify_sig;
 #endif
 };
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1d0e00a3971..67f3a866eabe 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -90,7 +90,7 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
 					  unsigned long buf_len)
 {
@@ -188,7 +188,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			     const char __user *cmdline_ptr,
 			     unsigned long cmdline_len, unsigned flags)
 {
-	int ret = 0;
+	const char *reason;
+	int ret;
 	void *ldata;
 	loff_t size;
 
@@ -207,15 +208,48 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	if (ret)
 		goto out;
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
 					   image->kernel_buf_len);
-	if (ret) {
-		pr_debug("kernel signature verification failed.\n");
+#else
+	ret = -ENODATA;
+#endif
+
+	switch (ret) {
+	case 0:
+		break;
+
+		/* Certain verification errors are non-fatal if we're not
+		 * checking errors, provided we aren't mandating that there
+		 * must be a valid signature.
+		 */
+	case -ENODATA:
+		reason = "kexec of unsigned image";
+		goto decide;
+	case -ENOPKG:
+		reason = "kexec of image with unsupported crypto";
+		goto decide;
+	case -ENOKEY:
+		reason = "kexec of image with unavailable key";
+	decide:
+		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
+			pr_notice("%s rejected\n", reason);
+			ret = -EKEYREJECTED;
+			goto out;
+		}
+
+		ret = 0;
+		break;
+
+		/* All other errors are fatal, including nomem, unparseable
+		 * signatures and signature check failures - even if signatures
+		 * aren't required.
+		 */
+	default:
+		pr_notice("kernel signature verification failed (%d).\n", ret);
 		goto out;
 	}
-	pr_debug("kernel signature verification successful.\n");
-#endif
+
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
-- 
2.21.0.352.gf09ad66450-goog

