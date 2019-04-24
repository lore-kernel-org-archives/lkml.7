Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3886AC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0528121773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfDXCOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 22:14:49 -0400
Received: from [13.77.154.182] ([13.77.154.182]:39744 "EHLO
        linux.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfDXCOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 22:14:48 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Apr 2019 22:14:47 EDT
Received: by linux.microsoft.com (Postfix, from userid 1020)
        id 6BF3730CB914; Tue, 23 Apr 2019 19:06:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 68CF85D0A8;
        Tue, 23 Apr 2019 19:06:09 -0700 (PDT)
Date:   Tue, 23 Apr 2019 19:06:09 -0700 (PDT)
From:   nramas@linux.microsoft.com
X-X-Sender: nramas@linuxonhyperv.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
cc:     zohar@linux.ibm.com, vgoyal@redhat.com,
        balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        nramas@linux.microsoft.com
Subject: [PATCH v1 1/1] Return the verified kernel image signature in
 kexec_file_load
Message-ID: <alpine.LRH.2.21.1904231852380.105892@linuxonhyperv.guj3yctzbm1etfxqx2vob5hsef.xx.intern>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Lakshmi Ramasubramanian <nramas@microsoft.com>

Signed-off-by: Lakshmi Ramasubramanian <nramas@microsoft.com>
---
When CONFIG_KEXEC_VERIFY_SIG is selected the signature on 
the new kernel image is verified in kexec_file_load.
The signature is embedded in the kernel image file.

This change returns the pointer to the verified signature and 
the length of that signature. kexec_file_load can log this
signature for attestation (To attest the signer of the new kernel).
The change to log the kernel signature for attestation will be added
in a future change set.


  arch/x86/kernel/kexec-bzimage64.c      |  7 +++++--
  arch/x86/kernel/machine_kexec_64.c     | 10 +++++++---
  crypto/asymmetric_keys/verify_pefile.c | 18 +++++++++++++++++-
  include/linux/kexec.h                  |  8 ++++++--
  include/linux/verification.h           |  4 +++-
  kernel/kexec_file.c                    | 14 +++++++++++---
  6 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 9d7fd5e6689a..030abd8adbce 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -530,11 +530,14 @@ static int bzImage64_cleanup(void *loader_data)
  }

  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
+static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len,
+				unsigned int *signature_len, void **signature)
  {
  	return verify_pefile_signature(kernel, kernel_len,
  				       NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
+				       VERIFYING_KEXEC_PE_SIGNATURE,
+					   signature_len,
+					   signature);
  }
  #endif

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 6f5ca4ebe6e5..b556a9750dd4 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -405,15 +405,19 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
  }

  #ifdef CONFIG_KEXEC_VERIFY_SIG
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
-				 unsigned long kernel_len)
+int arch_kexec_kernel_verify_sig(struct kimage *image,
+				void *kernel,
+				unsigned long kernel_len,
+				unsigned int *signature_len,
+				void **signature)
  {
  	if (!image->fops || !image->fops->verify_sig) {
  		pr_debug("kernel loader does not support signature verification.");
  		return -EKEYREJECTED;
  	}

-	return image->fops->verify_sig(kernel, kernel_len);
+	return image->fops->verify_sig(kernel, kernel_len,
+						signature_len, signature);
  }
  #endif

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 672a94c2c3ff..588a7966922f 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -394,6 +394,12 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
   * @pelen: Length of the binary image
   * @trust_keys: Signing certificate(s) to use as starting points
   * @usage: The use to which the key is being put.
+ * @signature_len: If non-NULL the number of bytes in the signature
+ *                 will be returned in this out parameter
+ * @signature: If non-NULL a pointer to the buffer containing
+ *             the file signature will be returned in this out parameter.
+ *             The pointer being returned is actually within the buffer
+ *             pointed to by pebuf. So the caller should not try to free it.
   *
   * Validate that the certificate chain inside the PKCS#7 message inside the PE
   * binary image intersects keys we already know and trust.
@@ -418,7 +424,9 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
   */
  int verify_pefile_signature(const void *pebuf, unsigned pelen,
  			    struct key *trusted_keys,
-			    enum key_being_used_for usage)
+			    enum key_being_used_for usage,
+				unsigned int *signature_len,
+				void **signature)
  {
  	struct pefile_context ctx;
  	int ret;
@@ -448,6 +456,14 @@ int verify_pefile_signature(const void *pebuf, unsigned pelen,
  	 * contents.
  	 */
  	ret = pefile_digest_pe(pebuf, pelen, &ctx);
+	if (ret < 0)
+		goto error;
+
+	/* Check if the caller needs the file signature */
+	if (signature_len != NULL && signature != NULL) {
+		*signature_len = ctx.sig_len;
+		*signature = pebuf + ctx.sig_offset;
+	}

  error:
  	kfree(ctx.digest);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c9481ebcbc0c..1c790a5b03a0 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -131,7 +131,9 @@ typedef int (kexec_cleanup_t)(void *loader_data);

  #ifdef CONFIG_KEXEC_VERIFY_SIG
  typedef int (kexec_verify_sig_t)(const char *kernel_buf,
-				 unsigned long kernel_len);
+				 unsigned long kernel_len,
+				 unsigned int *signature_len,
+				 void **signature);
  #endif

  struct kexec_file_ops {
@@ -288,7 +290,9 @@ int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
  void * __weak arch_kexec_kernel_image_load(struct kimage *image);
  int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
  int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len);
+					unsigned long buf_len,
+					unsigned int *signature_len,
+					void **signature);
  int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
  					Elf_Shdr *sechdrs, unsigned int relsec);
  int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
diff --git a/include/linux/verification.h b/include/linux/verification.h
index a10549a6c7cd..2ad9ff1dab5e 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -42,7 +42,9 @@ extern int verify_pkcs7_signature(const void *data, size_t len,
  #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
  extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
  				   struct key *trusted_keys,
-				   enum key_being_used_for usage);
+				   enum key_being_used_for usage,
+				   unsigned int *signature_len,
+				   void **signature);
  #endif

  #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b118735fea9d..fb0c94b8e52b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -54,7 +54,9 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)

  #ifdef CONFIG_KEXEC_VERIFY_SIG
  int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len)
+					unsigned long buf_len,
+					unsigned int *signature_len,
+					void **signature)
  {
  	return -EKEYREJECTED;
  }
@@ -126,6 +128,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
  	int ret = 0;
  	void *ldata;
  	loff_t size;
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+	unsigned int signature_len;
+	void *signature;
+#endif

  	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
  				       &size, INT_MAX, READING_KEXEC_IMAGE);
@@ -144,12 +150,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,

  #ifdef CONFIG_KEXEC_VERIFY_SIG
  	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
-					   image->kernel_buf_len);
+					   image->kernel_buf_len,
+					   &signature_len,
+					   &signature);
  	if (ret) {
  		pr_debug("kernel signature verification failed.\n");
  		goto out;
  	}
-	pr_debug("kernel signature verification successful.\n");
+	pr_debug("Verified kernel signature. Sig len %d\n", signature_len);
  #endif
  	/* It is possible that there no initramfs is being loaded */
  	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
-- 
2.17.1

