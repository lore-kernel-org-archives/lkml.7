Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BFAC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E230206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Se+GtdqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfLDQAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:00:17 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43186 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfLDQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:00:15 -0500
Received: by mail-qt1-f194.google.com with SMTP id q8so194875qtr.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AH9Zqm50+NfM1iWI5KoXJ3ULW24qoAyNsWFwS8TvaKI=;
        b=Se+GtdqPYx3xghEzAGZthtisSe0ZQjQrvlWzeSNSy/PBuc1k2WDaJOz1Ua2HdHbt90
         vlYAYKeycRP8dZ0IYThzw9EfzySjQKGlpoSBQzYMMrtStHE76eOKP52iZqlnK6p0cP7j
         gT72AJ1psutEHuFmURZrNMBYKB+do8ORxZYR3rBjdiebQPNlmtDslGtvzobm5T2JsnT2
         tFBaua2a3xWKA+xX7IB2HWT+jnLcqRDwisuhdJIO+SubNOlZa7pcKM397Kwg7mWXRtHu
         lyNxrkrxhgTHykYLF+DjPfPhNu3BQG990kW5kOOBEEk/z2zD5LPSL8WW7vOt5Oo3P4e0
         iyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AH9Zqm50+NfM1iWI5KoXJ3ULW24qoAyNsWFwS8TvaKI=;
        b=mYXfHZNTimBEMpoSeLY2P2OmC/SsTZYTtjUdFRnj7wc9dsjpEdu6arXHxcY5Z4Sxxy
         wnJq3jcCZsgqXLNIuUg9ZYgzs726XpJJK44FDkcQvNHl/sX912I5bD+hj8v2RVRTgZSQ
         MMSixUFU3j+4aaPo4j66zne1nuTwKUV5TaOWhWKoSnPQ+ISKOAEbxkXWk/2aywBSAtwz
         WqubLA7B8Z7804Sp9R294SGk+ltcgHNJv0mFXBd7JcZyymey6U7xfFI5Xv2sLFrPblW6
         NSNOPI7vpGNWo8FauJHSLSy5mmjcvnFxXZPvboJeCyaKQj3BhWvnTcnsXX0LfXei7pKN
         0G5A==
X-Gm-Message-State: APjAAAW/WQALWS5+k2hK2dn/jgmLksCBDRtpXmaHDgHSavgqr/g7r1pL
        KJn0SBW5tcBx9wcchFnKU+VlpQ==
X-Google-Smtp-Source: APXvYqy2qMRBi3u87BVr/0hJi/9zKWwZkhz36ju8Yj72sdPE1OrC/7nG0llQRtLFJTezSaUkAAYoRQ==
X-Received: by 2002:aed:2d01:: with SMTP id h1mr3410420qtd.239.1575475213602;
        Wed, 04 Dec 2019 08:00:13 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:00:12 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v8 22/25] arm64: kexec: kexec EL2 vectors
Date:   Wed,  4 Dec 2019 10:59:35 -0500
Message-Id: <20191204155938.2279686-23-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a EL2 mode without VHE, the EL2 vectors are needed in order
to switch to EL2 and jump to new world with hyperivsor privileges.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  5 +++++
 arch/arm64/kernel/asm-offsets.c     |  1 +
 arch/arm64/kernel/machine_kexec.c   |  5 +++++
 arch/arm64/kernel/relocate_kernel.S | 34 +++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 8cad34e7a9d9..414a0a41a60a 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -95,6 +95,7 @@ static inline void crash_post_resume(void) {}
 extern const unsigned long kexec_relocate_code_size;
 extern const unsigned char kexec_relocate_code_start[];
 extern const unsigned long kexec_kern_reloc_offset;
+extern const unsigned long kexec_el2_vectors_offset;
 #endif
 
 /*
@@ -104,6 +105,9 @@ extern const unsigned long kexec_kern_reloc_offset;
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
  *		arguments are currently unused, and must be set to 0
+ * el2_vector	If present means that relocation routine will go to EL1
+ *		from EL2 to do the copy, and then back to EL2 to do the jump
+ *		to new world.
  */
 struct kern_reloc_arg {
 	phys_addr_t head;
@@ -112,6 +116,7 @@ struct kern_reloc_arg {
 	phys_addr_t kern_arg1;
 	phys_addr_t kern_arg2;
 	phys_addr_t kern_arg3;
+	phys_addr_t el2_vector;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 448230684749..ff974b648347 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -136,6 +136,7 @@ int main(void)
   DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
   DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
+  DEFINE(KEXEC_KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, el2_vector));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 5e7b1f6569c4..ac6ade7c96ff 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -84,6 +84,11 @@ int machine_kexec_post_load(struct kimage *kimage)
 	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
 	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
+	/* Setup vector table only when EL2 is available, but no VHE */
+	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
+		kern_reloc_arg->el2_vector = __pa(reloc_code)
+						+ kexec_el2_vectors_offset;
+	}
 	kexec_image_info(kimage);
 
 	return 0;
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 3c05220a79ab..67efa42575a5 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -88,6 +88,38 @@ ENTRY(arm64_relocate_new_kernel)
 .ltorg
 END(arm64_relocate_new_kernel)
 
+.macro el1_sync_64
+	br	x4			/* Jump to new world from el2 */
+	.fill 31, 4, 0			/* Set other 31 instr to zeroes */
+.endm
+
+.macro invalid_vector label
+\label:
+	b \label
+	.fill 31, 4, 0			/* Set other 31 instr to zeroes */
+.endm
+
+/* el2 vectors - switch el2 here while we restore the memory image. */
+	.align 11
+ENTRY(kexec_el2_vectors)
+	invalid_vector el2_sync_invalid_sp0	/* Synchronous EL2t */
+	invalid_vector el2_irq_invalid_sp0	/* IRQ EL2t */
+	invalid_vector el2_fiq_invalid_sp0	/* FIQ EL2t */
+	invalid_vector el2_error_invalid_sp0	/* Error EL2t */
+	invalid_vector el2_sync_invalid_spx	/* Synchronous EL2h */
+	invalid_vector el2_irq_invalid_spx	/* IRQ EL2h */
+	invalid_vector el2_fiq_invalid_spx	/* FIQ EL2h */
+	invalid_vector el2_error_invalid_spx	/* Error EL2h */
+		el1_sync_64			/* Synchronous 64-bit EL1 */
+	invalid_vector el1_irq_invalid_64	/* IRQ 64-bit EL1 */
+	invalid_vector el1_fiq_invalid_64	/* FIQ 64-bit EL1 */
+	invalid_vector el1_error_invalid_64	/* Error 64-bit EL1 */
+	invalid_vector el1_sync_invalid_32	/* Synchronous 32-bit EL1 */
+	invalid_vector el1_irq_invalid_32	/* IRQ 32-bit EL1 */
+	invalid_vector el1_fiq_invalid_32	/* FIQ 32-bit EL1 */
+	invalid_vector el1_error_invalid_32	/* Error 32-bit EL1 */
+END(kexec_el2_vectors)
+
 .Lkexec_relocate_code_end:
 .org	KEXEC_CONTROL_PAGE_SIZE
 .align 3	/* To keep the 64-bit values below naturally aligned. */
@@ -99,3 +131,5 @@ GLOBAL(kexec_relocate_code_size)
 	.quad	.Lkexec_relocate_code_end - kexec_relocate_code_start
 GLOBAL(kexec_kern_reloc_offset)
 	.quad	arm64_relocate_new_kernel - kexec_relocate_code_start
+GLOBAL(kexec_el2_vectors_offset)
+	.quad	kexec_el2_vectors - kexec_relocate_code_start
-- 
2.24.0

