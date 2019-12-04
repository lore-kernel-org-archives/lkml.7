Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE4EC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD0E21555
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cu+p4RqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfLDQAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:00:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45187 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfLDQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:00:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so311227qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SvTPGoWzcPkObV2Ws85OzWUy+7CYa3mnpkPEsJWZNzE=;
        b=cu+p4RqK3Zmx7hWnQSABCZglBgezn5eGQzuTkON/BGZNxKpEU1LoNRODi9ekiA+9ku
         /ZobcizQIRPhtU0+snmXbaF2M5yZuiN5PFlBdWDIJm0AGn5BWV5LQDz9CJt6/0Lity+v
         xisJmjhNGiX136oinbjNKH1rvVjN2c7Z/Q35xKU3qcr3ajjy4dgHBBdtaWrOSBhz12kM
         0SYxeCJnYQrKHjEAHJP+56wX8ja0DAATSwJnv7/BmALDrdxSnUR3j8/KTYpW6LeaZchE
         LqLej/VDgFvtbMsFSBcXgG/inm+Uf4Q2j9eK03s8vaFMKhFYmUBAqGeceb6c2l7XmwVw
         s/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SvTPGoWzcPkObV2Ws85OzWUy+7CYa3mnpkPEsJWZNzE=;
        b=keJZEtBVECmNv8ONHDjIYRe2NdXY/TuXyUe5+voHLlstKrR72v+GW3JW9Mq+Mr//N6
         zHWVuo/lNr6U2ADziuuXHeSuEaPrgRPDvKHI77WN+9pgJUuqjURZrsTMPHGfZsGwAwLr
         ffvOqNRJGozpUacdTKM3s2CPlv3Jnl6moYiXD/e0W0bnJL1axHTEox6Cw5Ue+sXWgESh
         nnX8Fkqjc9UnZFZjxF1Bv0MbRcymd4T0MDyh5oeJ5OqnepZjCs63LZS0q2ZX8Gg1Y/za
         H842CLmpTbzMTitcYxen4LUaOSh5uM4uvIj6HCFWGdf0IAxiUQZ1mlOOZKWglmTLtPlp
         mt/g==
X-Gm-Message-State: APjAAAUdC9Uyar0hhprzhJXFwPwTeoyDKg80miwIaJFBFrbwtjNhDkaC
        V8nHHVK/2HrReBrtidn+gpBKgg==
X-Google-Smtp-Source: APXvYqwJu5ElHhYW15zTS5aeaMgKbUmMET7cn1hc9pUfr6v0add/5xWuzNZp92mrLeWlXbSulQ5WUw==
X-Received: by 2002:a37:9fce:: with SMTP id i197mr3504897qke.466.1575475212067;
        Wed, 04 Dec 2019 08:00:12 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.08.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:00:11 -0800 (PST)
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
Subject: [PATCH v8 21/25] arm64: kexec: offset for relocation function
Date:   Wed,  4 Dec 2019 10:59:34 -0500
Message-Id: <20191204155938.2279686-22-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soon, relocation function will share the same page with EL2 vectors.
Add offset within this page to arm64_relocate_new_kernel, and also
the total size of relocation code which will include both the function
and the EL2 vectors.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  7 +++++++
 arch/arm64/kernel/machine_kexec.c   | 13 ++++---------
 arch/arm64/kernel/relocate_kernel.S | 13 ++++++++-----
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 189dce24f4cb..8cad34e7a9d9 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,6 +90,13 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#if defined(CONFIG_KEXEC_CORE)
+/* The beginning and size of relcation code to stage 2 kernel */
+extern const unsigned long kexec_relocate_code_size;
+extern const unsigned char kexec_relocate_code_start[];
+extern const unsigned long kexec_kern_reloc_offset;
+#endif
+
 /*
  * kern_reloc_arg is passed to kernel relocation function as an argument.
  * head		kimage->head, allows to traverse through relocation segments.
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 5f1211f3aeef..5e7b1f6569c4 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -23,10 +23,6 @@
 
 #include "cpu-reset.h"
 
-/* Global variables for the arm64_relocate_new_kernel routine. */
-extern const unsigned char arm64_relocate_new_kernel[];
-extern const unsigned long arm64_relocate_new_kernel_size;
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -82,9 +78,8 @@ int machine_kexec_post_load(struct kimage *kimage)
 	if (!kern_reloc_arg)
 		return -ENOMEM;
 
-	memcpy(reloc_code, arm64_relocate_new_kernel,
-	       arm64_relocate_new_kernel_size);
-	kimage->arch.kern_reloc = __pa(reloc_code);
+	memcpy(reloc_code, kexec_relocate_code_start, kexec_relocate_code_size);
+	kimage->arch.kern_reloc = __pa(reloc_code) + kexec_kern_reloc_offset;
 	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
 	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
@@ -190,7 +185,7 @@ void machine_kexec(struct kimage *kimage)
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
 	/* Flush the reboot_code_buffer in preparation for its execution. */
-	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
+	__flush_dcache_area(reboot_code_buffer, kexec_relocate_code_size);
 
 	/*
 	 * Although we've killed off the secondary CPUs, we don't update
@@ -199,7 +194,7 @@ void machine_kexec(struct kimage *kimage)
 	 * the offline CPUs. Therefore, we must use the __* variant here.
 	 */
 	__flush_icache_range((uintptr_t)reboot_code_buffer,
-			     arm64_relocate_new_kernel_size);
+			     kexec_relocate_code_size);
 
 	/* Flush the kimage list and its buffers. */
 	kexec_list_flush(kimage);
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 22ccdcb106d3..3c05220a79ab 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -14,6 +14,8 @@
 #include <asm/page.h>
 #include <asm/sysreg.h>
 
+GLOBAL(kexec_relocate_code_start)
+
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
  *
@@ -86,13 +88,14 @@ ENTRY(arm64_relocate_new_kernel)
 .ltorg
 END(arm64_relocate_new_kernel)
 
-.Lcopy_end:
+.Lkexec_relocate_code_end:
 .org	KEXEC_CONTROL_PAGE_SIZE
 .align 3	/* To keep the 64-bit values below naturally aligned. */
 /*
- * arm64_relocate_new_kernel_size - Number of bytes to copy to the
+ * kexec_relocate_code_size - Number of bytes to copy to the
  * control_code_page.
  */
-.globl arm64_relocate_new_kernel_size
-arm64_relocate_new_kernel_size:
-	.quad	.Lcopy_end - arm64_relocate_new_kernel
+GLOBAL(kexec_relocate_code_size)
+	.quad	.Lkexec_relocate_code_end - kexec_relocate_code_start
+GLOBAL(kexec_kern_reloc_offset)
+	.quad	arm64_relocate_new_kernel - kexec_relocate_code_start
-- 
2.24.0

