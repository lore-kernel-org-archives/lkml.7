Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20EEECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9A521D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BltQBkOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436929AbfJPUBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:01:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41635 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436913AbfJPUBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:01:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id v52so37968110qtb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=To7bUWVp3XvcnHsBm0oiOp1tLIO852ts6wlx+cNajXo=;
        b=BltQBkOk1uAjUjhwIZhcIGmX8i7xAxK94UWa8kc1Ev2sUhdRynGQocSBFvybfvzGpJ
         JAvn6za5IMSG3mKEFhxCncIGjbBFFhvbJjU5C+d+HgMhe/nQB9xhG5zXRUT7hf8kQtNB
         f4BRHRQuQeMik8u7RubhYuH7Le8AdBGyEUW3t9zbbfVpMvtDTd7N4RJ4omu4BA20Dh63
         byzXqGXUS+JU2iz0g4eoS7s+Q18zVQWDOfX/nI8g08XYD+yFmBMJHYWdcMwFxJiLOHHO
         Gq8SK6cC+B2TyTl0qMKoEKoFKvVfMTvz5YfdWy5sJgfrhm1ytZSdOKqoCt3w1wrCDWjI
         JwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=To7bUWVp3XvcnHsBm0oiOp1tLIO852ts6wlx+cNajXo=;
        b=cMXq56tUwBb/RJgRk6JJC7r1CdQsrRx0H8XGNSxUPFnwj+XrNmoTx5ZDQKBFED4HM7
         gR7yjUvAbaaDXLZbBJrcjnsXgbu1J8l2xqrMM+Di+j4Nj2P0isduX/fgdMPt4oY3ml54
         ndrBqowR4x/uCmUS8KKXThKP2j89in9Wci1yuZ3WJHDO7Ae1lgPxhkGUJrOjoJPSBmkR
         gEvdJFEYXxsMAxGFESqOBj+8zZJId6NbER9hkqUfALaKpWVTiz+EO9SC9axCw+sHLKZh
         JPBppvE9P1Gl7jcVXdgMsvXnFD8uZeGllzfV2igOlfBzCyc291SJyvvQ4jgkxUpML5le
         4kQg==
X-Gm-Message-State: APjAAAU/bBbT2/Vum8gtdrjyoFDZr3XdXVDBxIC15wtkeq/tMP0R67BZ
        jU7W9sQPIcPnYwFQmw2K3NPOOQ==
X-Google-Smtp-Source: APXvYqzrXjWRNzoabbZjIOx0ffX9s+D0y1PdrRPM3VIx35Vt9ZH1Y9308HHhFhRvWQ8N84T1AefQCg==
X-Received: by 2002:a0c:bf45:: with SMTP id b5mr43086279qvj.150.1571256061093;
        Wed, 16 Oct 2019 13:01:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:01:00 -0700 (PDT)
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
Subject: [PATCH v7 15/25] arm64: kexec: move relocation function setup
Date:   Wed, 16 Oct 2019 16:00:24 -0400
Message-Id: <20191016200034.1342308-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel relocation function is configured in machine_kexec()
at the time of kexec reboot by using control_code_page.

This operation, however, is more logical to be done during kexec_load,
and thus remove from reboot time. Move, setup of this function to
newly added machine_kexec_post_load().

Because once MMU is enabled, kexec control page will contain more than
relocation kernel, but also vector table, add pointer to the actual
function within this page arch.kern_reloc. Currently, it equals to the
beginning of page, we will add offsets later, when vector table is
added.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    |  1 +
 arch/arm64/kernel/machine_kexec.c | 28 +++++++++++++++-------------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index ad6afed69078..00dbcc71aeb2 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -95,6 +95,7 @@ static inline void crash_post_resume(void) {}
 struct kimage_arch {
 	void *dtb;
 	phys_addr_t dtb_mem;
+	phys_addr_t kern_reloc;
 };
 
 #ifdef CONFIG_KEXEC_FILE
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index ae1bad0156cd..46718b289a6b 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -42,6 +42,7 @@ static void _kexec_image_info(const char *func, int line,
 	pr_debug("    start:       %lx\n", kimage->start);
 	pr_debug("    head:        %lx\n", kimage->head);
 	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+	pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
 
 	for (i = 0; i < kimage->nr_segments; i++) {
 		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
@@ -58,6 +59,18 @@ void machine_kexec_cleanup(struct kimage *kimage)
 	/* Empty routine needed to avoid build errors. */
 }
 
+int machine_kexec_post_load(struct kimage *kimage)
+{
+	void *reloc_code = page_to_virt(kimage->control_code_page);
+
+	memcpy(reloc_code, arm64_relocate_new_kernel,
+	       arm64_relocate_new_kernel_size);
+	kimage->arch.kern_reloc = __pa(reloc_code);
+
+	return 0;
+}
+
+
 /**
  * machine_kexec_prepare - Prepare for a kexec reboot.
  *
@@ -143,8 +156,7 @@ static void kexec_segment_flush(const struct kimage *kimage)
  */
 void machine_kexec(struct kimage *kimage)
 {
-	phys_addr_t reboot_code_buffer_phys;
-	void *reboot_code_buffer;
+	void *reboot_code_buffer = page_to_virt(kimage->control_code_page);
 	bool in_kexec_crash = (kimage == kexec_crash_image);
 	bool stuck_cpus = cpus_are_stuck_in_kernel();
 
@@ -155,18 +167,8 @@ void machine_kexec(struct kimage *kimage)
 	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
-	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
-	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
-
 	kexec_image_info(kimage);
 
-	/*
-	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
-	 * after the kernel is shut down.
-	 */
-	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
-		arm64_relocate_new_kernel_size);
-
 	/* Flush the reboot_code_buffer in preparation for its execution. */
 	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
 
@@ -202,7 +204,7 @@ void machine_kexec(struct kimage *kimage)
 	 * userspace (kexec-tools).
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
-	cpu_soft_restart(reboot_code_buffer_phys, kimage->head, kimage->start,
+	cpu_soft_restart(kimage->arch.kern_reloc, kimage->head, kimage->start,
 			 kimage->arch.dtb_mem);
 
 	BUG(); /* Should never get here. */
-- 
2.23.0

