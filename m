Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F86C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE4D21D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfKGIT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:19:27 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:16164 "EHLO SHSQR01.unisoc.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726800AbfKGIT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:19:27 -0500
X-Greylist: delayed 1909 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 03:19:26 EST
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id xA77lUVu065852
        for <linux-kernel@vger.kernel.org>; Thu, 7 Nov 2019 15:47:30 +0800 (CST)
        (envelope-from lvqiang.huang@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xA77j9w1060787
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 7 Nov 2019 15:45:09 +0800 (CST)
        (envelope-from lvqiang.huang@unisoc.com)
Received: from localhost (10.0.74.59) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 7 Nov 2019 15:45:14
 +0800
From:   Lvqiang <Lvqiang.Huang@unisoc.com>
To:     <linux@armlinux.org.uk>, <ebiederm@xmission.com>,
        <dave.hansen@linux.intel.com>, <anshuman.khandual@arm.com>,
        <akpm@linux-foundation.org>, <Lvqiang.Huang@unisoc.com>,
        <f.fainelli@gmail.com>, <will@kernel.org>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: check __ex_table in do_bad()
Date:   Thu, 7 Nov 2019 15:45:13 +0800
Message-ID: <1573112713-10115-1-git-send-email-Lvqiang.Huang@unisoc.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.59]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com xA77j9w1060787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We got many crashs in for_each_frame+0x18 arch/arm/lib/backtrace.S
    1003: ldr r2, [sv_pc, #-4]

The backtrace is
    dump_backtrace
    show_stack
    sched_show_task
    show_state_filter
    sysrq_handle_showstate_blocked
    __handle_sysrq
    write_sysrq_trigger
    proc_reg_write
    __vfs_write
    vfs_write
    sys_write

Related Kernel config
    CONFIG_CPU_SW_DOMAIN_PAN=y
    # CONFIG_ARM_UNWIND is not set
    CONFIG_FRAME_POINTER=y

The task A was dumping the stack of an UN task B. However, the task B
scheduled to run on another CPU, which cause it stack content changed.
Then, task A may hit a page domain fault and die().
    [520.661314] Unhandled fault: page domain fault (0x01b) at 0x32848c02

The addr 0x32848c02 is a valid user-space address.
    PAGE DIRECTORY: d1854000
      PGD: d1854ca0 => bb21e835
      PMD: d1854ca0 => bb21e835
      PTE: bb21e120 => afffa79f

With CONFIG_CPU_SW_DOMAIN_PAN=y, a page domain fault occurred.
    { do_bad, SIGSEGV, SEGV_ACCERR, "page domain fault"},

Without check the __ex_table entry, do_bad() just return fault and die().
    .pushsection __ex_table,"a"
    .long	1003b, 1006b

This patch try __ex_table in do_bad(), the same as in __do_kernel_fault().

Signed-off-by: Lvqiang <Lvqiang.Huang@unisoc.com>
---
 arch/arm/mm/fault.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bd0f482..22f45df 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -487,11 +487,14 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 #endif /* CONFIG_ARM_LPAE */
 
 /*
- * This abort handler always returns "fault".
+ * Checks __ex_table before returns "fault".
  */
 static int
 do_bad(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
+	if (fixup_exception(regs))
+		return 0;
+
 	return 1;
 }
 
-- 
1.7.9.5


