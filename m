Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968DBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA1720872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568097446;
	bh=iXwR5E+V3IMrkAlLuBkFaBvywhV49oCFScu9hDsTHiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SaoA+dVXXIH84a/fcLm3ebCdO5vPk6HEWPmDPVsZvUdj7hU2f0OvDsYx1PwhAYERr
	 prRPdwd4CcfzuUewBS2Cs/mZKeIgZn9Y2OPplosHIr60dJMJiusrv/6C8Ndxp9a+kG
	 IxEzACE0cXLRNmKhRO30K5MsosopJ0YeZ5xcXcwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403856AbfIJGhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:37:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42419 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbfIJGhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:37:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id q14so17607917wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WwreKyJz6a0m9AsIB4mh5cJwRXEulm8GSDTGV49+p+4=;
        b=iFGdTxOY1ArJwYZtufy5HoiITmr5KoGP4h4T1E9Ti+pvHZd/zoqroxiX4HhUXyMHKt
         WU7GPw6ahU4BDH6L4TKAhTJJk/q7yKtk0WTHFmuFo5i5ieIuLVj6/QC/49DxqQhkrhbb
         QveHgNXG33sa+TtN7WgqK3QTtf2bjz67DnqDrYmGb+56CxRuKU1Mli8mkGLae2hxI3zN
         tIDKb4sw+w6ri/79kLuq3wouWbf+XjAKeeclYn5LqA5OPmrfDWpwfWejl0g3iFrZycrR
         Cn6KmfnOnlNq740ubnQrqeBQaNp7cHB/XwnH8DxRB4XJpJtHmCTBa/YpVCDTF16W+LrG
         4fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WwreKyJz6a0m9AsIB4mh5cJwRXEulm8GSDTGV49+p+4=;
        b=rmMLqt9/Wp+yPUPOY2Blx5khczeSmVNlJa7/0D30GetAdfodVfklwrtD/YyNnVdEmw
         d/3+hRQ1E1tw6/32bmScnxr+BafqQPCfEN3M5BDMcmz9hQeWiRKZ8KlxOVafxiJG4UNT
         YQGVj7vWsXqn5vUZsEJTu5Chu94pzfI/JA/Lhe3dbpnsgYp5/wqQU0z0KQVRnYHkbQPv
         fmnqLRdrX2SdYUhks7nPaD/yQTkSRWbBNLnSNkSyTjCsuH/2nrJiISvluBTNyaLwHLfd
         BgQap20DXmdr5KklE2KDOdeYwW7XnzBvzCNkG5sg1m7t6I3mAh2OUpwylbt/cMY5INFO
         KNiA==
X-Gm-Message-State: APjAAAVkdGD85dP7/wJqtlBdY74dyF8Z11cZ+nzxpaJqU7hI9D31HGJ2
        WkZbbRfB4FAa7wcbn//hpRw=
X-Google-Smtp-Source: APXvYqwxhbuPcMc0USKFhWX4CFmU1OZIxN7YclQHX3/YLo/SzibisszPJIBK75yySMuHergiKnETSg==
X-Received: by 2002:adf:ff91:: with SMTP id j17mr21581651wrr.5.1568097441594;
        Mon, 09 Sep 2019 23:37:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m17sm18138001wrs.9.2019.09.09.23.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 23:37:21 -0700 (PDT)
Date:   Tue, 10 Sep 2019 08:37:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     hpa@zytor.com
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2] x86/umip: Add emulation for 64-bit processes
Message-ID: <20190910063719.GC1579@gmail.com>
References: <20190905232222.14900-1-bshanks@codeweavers.com>
 <7BFFC7D1-6158-4237-AEF9-D10635F054FC@zytor.com>
 <20190910062828.GA40888@gmail.com>
 <193CDEE9-B533-4BFE-972E-384C00359945@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193CDEE9-B533-4BFE-972E-384C00359945@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* hpa@zytor.com <hpa@zytor.com> wrote:

> On September 10, 2019 7:28:28 AM GMT+01:00, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >* hpa@zytor.com <hpa@zytor.com> wrote:
> >
> >> I would strongly suggest that we change the term "emulation" to 
> >> "spoofing" for these instructions. We need to explain that we do
> >*not* 
> >> execute these instructions the was the CPU would have, and unlike the
> >
> >> native instructions do not leak kernel information.
> >
> >Ok, I've edited the patch to add the 'spoofing' wording where 
> >appropriate, and I also made minor fixes such as consistently 
> >capitalizing instruction names.
> >
> >Can I also add your Reviewed-by tag?
> >
> >So the patch should show up in tip:x86/asm today-ish, and barring any 
> >complications is v5.4 material.
> >
> >Thanks,
> >
> >	Ingo
> 
> Yes, please do.
> 
> Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>

Thanks!

I've attached the updated version of the patch I'm testing.

	Ingo

==================>
From e86c2c8b9380440bbe761b8e2f63ab6b04a45ac2 Mon Sep 17 00:00:00 2001
From: Brendan Shanks <bshanks@codeweavers.com>
Date: Thu, 5 Sep 2019 16:22:21 -0700
Subject: [PATCH] x86/umip: Add emulation (spoofing) for UMIP covered instructions in 64-bit processes as well

Add emulation (spoofing) of the SGDT, SIDT, and SMSW instructions for 64-bit
processes.

Wine users have encountered a number of 64-bit Windows games that use
these instructions (particularly SGDT), and were crashing when run on
UMIP-enabled systems.

Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190905232222.14900-1-bshanks@codeweavers.com
[ Minor edits: capitalization, added 'spoofing' wording. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/umip.c | 65 +++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5b345add550f..548fefed71ee 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -19,7 +19,7 @@
 /** DOC: Emulation for User-Mode Instruction Prevention (UMIP)
  *
  * The feature User-Mode Instruction Prevention present in recent Intel
- * processor prevents a group of instructions (sgdt, sidt, sldt, smsw, and str)
+ * processor prevents a group of instructions (SGDT, SIDT, SLDT, SMSW and STR)
  * from being executed with CPL > 0. Otherwise, a general protection fault is
  * issued.
  *
@@ -36,8 +36,8 @@
  * DOSEMU2) rely on this subset of instructions to function.
  *
  * The instructions protected by UMIP can be split in two groups. Those which
- * return a kernel memory address (sgdt and sidt) and those which return a
- * value (sldt, str and smsw).
+ * return a kernel memory address (SGDT and SIDT) and those which return a
+ * value (SLDT, STR and SMSW).
  *
  * For the instructions that return a kernel memory address, applications
  * such as WineHQ rely on the result being located in the kernel memory space,
@@ -45,15 +45,13 @@
  * value that, lies close to the top of the kernel memory. The limit for the GDT
  * and the IDT are set to zero.
  *
- * Given that sldt and str are not commonly used in programs that run on WineHQ
+ * Given that SLDT and STR are not commonly used in programs that run on WineHQ
  * or DOSEMU2, they are not emulated.
  *
  * The instruction smsw is emulated to return the value that the register CR0
  * has at boot time as set in the head_32.
  *
- * Also, emulation is provided only for 32-bit processes; 64-bit processes
- * that attempt to use the instructions that UMIP protects will receive the
- * SIGSEGV signal issued as a consequence of the general protection fault.
+ * Emulation is provided for both 32-bit and 64-bit processes.
  *
  * Care is taken to appropriately emulate the results when segmentation is
  * used. That is, rather than relying on USER_DS and USER_CS, the function
@@ -63,17 +61,18 @@
  * application uses a local descriptor table.
  */
 
-#define UMIP_DUMMY_GDT_BASE 0xfffe0000
-#define UMIP_DUMMY_IDT_BASE 0xffff0000
+#define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
+#define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
 
 /*
  * The SGDT and SIDT instructions store the contents of the global descriptor
  * table and interrupt table registers, respectively. The destination is a
  * memory operand of X+2 bytes. X bytes are used to store the base address of
- * the table and 2 bytes are used to store the limit. In 32-bit processes, the
- * only processes for which emulation is provided, X has a value of 4.
+ * the table and 2 bytes are used to store the limit. In 32-bit processes X
+ * has a value of 4, in 64-bit processes X has a value of 8.
  */
-#define UMIP_GDT_IDT_BASE_SIZE 4
+#define UMIP_GDT_IDT_BASE_SIZE_64BIT 8
+#define UMIP_GDT_IDT_BASE_SIZE_32BIT 4
 #define UMIP_GDT_IDT_LIMIT_SIZE 2
 
 #define	UMIP_INST_SGDT	0	/* 0F 01 /0 */
@@ -189,6 +188,7 @@ static int identify_insn(struct insn *insn)
  * @umip_inst:	A constant indicating the instruction to emulate
  * @data:	Buffer into which the dummy result is stored
  * @data_size:	Size of the emulated result
+ * @x86_64:	true if process is 64-bit, false otherwise
  *
  * Emulate an instruction protected by UMIP and provide a dummy result. The
  * result of the emulation is saved in @data. The size of the results depends
@@ -202,11 +202,8 @@ static int identify_insn(struct insn *insn)
  * 0 on success, -EINVAL on error while emulating.
  */
 static int emulate_umip_insn(struct insn *insn, int umip_inst,
-			     unsigned char *data, int *data_size)
+			     unsigned char *data, int *data_size, bool x86_64)
 {
-	unsigned long dummy_base_addr, dummy_value;
-	unsigned short dummy_limit = 0;
-
 	if (!data || !data_size || !insn)
 		return -EINVAL;
 	/*
@@ -219,6 +216,9 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 	 * is always returned irrespective of the operand size.
 	 */
 	if (umip_inst == UMIP_INST_SGDT || umip_inst == UMIP_INST_SIDT) {
+		u64 dummy_base_addr;
+		u16 dummy_limit = 0;
+
 		/* SGDT and SIDT do not use registers operands. */
 		if (X86_MODRM_MOD(insn->modrm.value) == 3)
 			return -EINVAL;
@@ -228,13 +228,24 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 		else
 			dummy_base_addr = UMIP_DUMMY_IDT_BASE;
 
-		*data_size = UMIP_GDT_IDT_LIMIT_SIZE + UMIP_GDT_IDT_BASE_SIZE;
+		/*
+		 * 64-bit processes use the entire dummy base address.
+		 * 32-bit processes use the lower 32 bits of the base address.
+		 * dummy_base_addr is always 64 bits, but we memcpy the correct
+		 * number of bytes from it to the destination.
+		 */
+		if (x86_64)
+			*data_size = UMIP_GDT_IDT_BASE_SIZE_64BIT;
+		else
+			*data_size = UMIP_GDT_IDT_BASE_SIZE_32BIT;
+
+		memcpy(data + 2, &dummy_base_addr, *data_size);
 
-		memcpy(data + 2, &dummy_base_addr, UMIP_GDT_IDT_BASE_SIZE);
+		*data_size += UMIP_GDT_IDT_LIMIT_SIZE;
 		memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
 
 	} else if (umip_inst == UMIP_INST_SMSW) {
-		dummy_value = CR0_STATE;
+		unsigned long dummy_value = CR0_STATE;
 
 		/*
 		 * Even though the CR0 register has 4 bytes, the number
@@ -290,11 +301,10 @@ static void force_sig_info_umip_fault(void __user *addr, struct pt_regs *regs)
  * fixup_umip_exception() - Fixup a general protection fault caused by UMIP
  * @regs:	Registers as saved when entering the #GP handler
  *
- * The instructions sgdt, sidt, str, smsw, sldt cause a general protection
- * fault if executed with CPL > 0 (i.e., from user space). If the offending
- * user-space process is not in long mode, this function fixes the exception
- * up and provides dummy results for sgdt, sidt and smsw; str and sldt are not
- * fixed up. Also long mode user-space processes are not fixed up.
+ * The instructions SGDT, SIDT, STR, SMSW and SLDT cause a general protection
+ * fault if executed with CPL > 0 (i.e., from user space). This function fixes
+ * the exception up and provides dummy results for SGDT, SIDT and SMSW; STR
+ * and SLDT are not fixed up.
  *
  * If operands are memory addresses, results are copied to user-space memory as
  * indicated by the instruction pointed by eIP using the registers indicated in
@@ -373,13 +383,14 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	umip_pr_warning(regs, "%s instruction cannot be used by applications.\n",
 			umip_insns[umip_inst]);
 
-	/* Do not emulate SLDT, STR or user long mode processes. */
-	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT || user_64bit_mode(regs))
+	/* Do not emulate (spoof) SLDT or STR. */
+	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
 		return false;
 
 	umip_pr_warning(regs, "For now, expensive software emulation returns the result.\n");
 
-	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size))
+	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
+			      user_64bit_mode(regs)))
 		return false;
 
 	/*
