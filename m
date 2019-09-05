Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEC9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B99C206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="TjzIp1x/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbfIEXoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 19:44:05 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:33980 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfIEXoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:44:05 -0400
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2019 19:44:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rASns3U+6Oa/LoIG4M+RXQqZmudbbKPab+NbWJxo+g0=; b=TjzIp1x/oChw/7uIFnctLEQNYP
        29PS6hDMe4HNArik8U+9zc2IChTbjg4v1emSxDQZGgVhPh/go6t1DcUVc7gnOg2zNK5WbQpUOjLpq
        0MKbE0eYl3+hfF/RIgR+0FOS+dZX2RxoErfR0yYxunUupCclVkfFI8y8DbKLUTrCVj4k=;
Received: from cpe-107-184-2-226.socal.res.rr.com ([107.184.2.226] helo=brendan-dell.bslabs.net)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <bshanks@codeweavers.com>)
        id 1i61AR-0004DI-Re; Thu, 05 Sep 2019 18:27:57 -0500
From:   Brendan Shanks <bshanks@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Brendan Shanks <bshanks@codeweavers.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] x86/umip: Add emulation for 64-bit processes
Date:   Thu,  5 Sep 2019 16:22:21 -0700
Message-Id: <20190905232222.14900-1-bshanks@codeweavers.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add emulation of the sgdt, sidt, and smsw instructions for 64-bit
processes.

Wine users have encountered a number of 64-bit Windows games that use
these instructions (particularly sgdt), and were crashing when run on
UMIP-enabled systems.

Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
---
 arch/x86/kernel/umip.c | 55 +++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5b345add550f..1812e95d2f55 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -51,9 +51,7 @@
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
+ * @x86_64:     true if process is 64-bit, false otherwise
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
@@ -291,10 +302,9 @@ static void force_sig_info_umip_fault(void __user *addr, struct pt_regs *regs)
  * @regs:	Registers as saved when entering the #GP handler
  *
  * The instructions sgdt, sidt, str, smsw, sldt cause a general protection
- * fault if executed with CPL > 0 (i.e., from user space). If the offending
- * user-space process is not in long mode, this function fixes the exception
- * up and provides dummy results for sgdt, sidt and smsw; str and sldt are not
- * fixed up. Also long mode user-space processes are not fixed up.
+ * fault if executed with CPL > 0 (i.e., from user space). This function fixes
+ * the exception up and provides dummy results for sgdt, sidt and smsw; str
+ * and sldt are not fixed up.
  *
  * If operands are memory addresses, results are copied to user-space memory as
  * indicated by the instruction pointed by eIP using the registers indicated in
@@ -373,13 +383,14 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	umip_pr_warning(regs, "%s instruction cannot be used by applications.\n",
 			umip_insns[umip_inst]);
 
-	/* Do not emulate SLDT, STR or user long mode processes. */
-	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT || user_64bit_mode(regs))
+	/* Do not emulate SLDT or STR. */
+	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
 		return false;
 
 	umip_pr_warning(regs, "For now, expensive software emulation returns the result.\n");
 
-	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size))
+	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
+			      user_64bit_mode(regs)))
 		return false;
 
 	/*
-- 
2.17.1

