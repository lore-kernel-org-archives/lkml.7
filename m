Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99148C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCD027D78
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HKXKteSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfFCIUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:20:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6990 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfFCIUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:20:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45HSfc02pHz9typt;
        Mon,  3 Jun 2019 10:20:24 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=HKXKteSe; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zr09SGG8LgmD; Mon,  3 Jun 2019 10:20:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45HSfb66BNz9typs;
        Mon,  3 Jun 2019 10:20:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1559550023; bh=+Dy4E19F4WwnCTLPgVfWD0Hzr4dGN4PVcDn0mVnwdX4=;
        h=From:Subject:To:Cc:Date:From;
        b=HKXKteSeJVqAwnfV652Zlbx/9HBL6LLz0ee+FohA66lTxGEmoJRWHxZ/jlM8/vxiK
         PJWHxCothJ27GwxxvTKjt9y8M/6WKV2tQBo7RjFfa2Dg3quIH/XYJnefgUrZ58gR0s
         gflCbR5IEkusGiIW12lxirectA+CQXWuWyNcecxA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FB5E8B7B8;
        Mon,  3 Jun 2019 10:20:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0biTqtzBvmD1; Mon,  3 Jun 2019 10:20:28 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 596B48B7B1;
        Mon,  3 Jun 2019 10:20:28 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2570168B20; Mon,  3 Jun 2019 08:20:28 +0000 (UTC)
Message-Id: <56efc3b317622d5f607d1f7a35894b194c385492.1559549824.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3] powerpc: fix kexec failure on book3s/32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  3 Jun 2019 08:20:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the old days, _PAGE_EXEC didn't exist on 6xx aka book3s/32.
Therefore, allthough __mapin_ram_chunk() was already mapping kernel
text with PAGE_KERNEL_TEXT and the rest with PAGE_KERNEL, the entire
memory was executable. Part of the memory (first 512kbytes) was
mapped with BATs instead of page table, but it was also entirely
mapped as executable.

In commit 385e89d5b20f ("powerpc/mm: add exec protection on
powerpc 603"), we started adding exec protection to some 6xx, namely
the 603, for pages mapped via pagetables.

Then, in commit 63b2bc619565 ("powerpc/mm/32s: Use BATs for
STRICT_KERNEL_RWX"), the exec protection was extended to BAT mapped
memory, so that really only the kernel text could be executed.

The problem here is that kexec is based on copying some code into
upper part of memory then executing it from there in order to install
a fresh new kernel at its definitive location.

However, the code is position independant and first part of it is
just there to deactivate the MMU and jump to the second part. So it
is possible to run this first part inplace instead of running the
copy. Once the MMU is off, there is no protection anymore and the
second part of the code will just run as before.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Aaro, can you test this patch ? Thanks.

 arch/powerpc/include/asm/kexec.h       | 3 +++
 arch/powerpc/kernel/machine_kexec_32.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 4a585cba1787..c68476818753 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -94,6 +94,9 @@ static inline bool kdump_in_progress(void)
 	return crashing_cpu >= 0;
 }
 
+void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_code_buffer,
+			 unsigned long start_address) __noreturn;
+
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_elf64_ops;
 
diff --git a/arch/powerpc/kernel/machine_kexec_32.c b/arch/powerpc/kernel/machine_kexec_32.c
index affe5dcce7f4..2b160d68db49 100644
--- a/arch/powerpc/kernel/machine_kexec_32.c
+++ b/arch/powerpc/kernel/machine_kexec_32.c
@@ -30,7 +30,6 @@ typedef void (*relocate_new_kernel_t)(
  */
 void default_machine_kexec(struct kimage *image)
 {
-	extern const unsigned char relocate_new_kernel[];
 	extern const unsigned int relocate_new_kernel_size;
 	unsigned long page_list;
 	unsigned long reboot_code_buffer, reboot_code_buffer_phys;
@@ -58,6 +57,9 @@ void default_machine_kexec(struct kimage *image)
 				reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
 
+	if (!IS_ENABLED(CONFIG_FSL_BOOKE) && !IS_ENABLED(CONFIG_44x))
+		relocate_new_kernel(page_list, reboot_code_buffer_phys, image->start);
+
 	/* now call it */
 	rnk = (relocate_new_kernel_t) reboot_code_buffer;
 	(*rnk)(page_list, reboot_code_buffer_phys, image->start);
-- 
2.13.3

