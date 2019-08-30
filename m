Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B73C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C327D21670
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfH3NZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:25:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6147 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727135AbfH3NZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:25:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 14283D940CB8D64295D9;
        Fri, 30 Aug 2019 21:25:33 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 30 Aug 2019 21:25:24 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <linux@armlinux.org.uk>, <ebiederm@xmission.com>,
        <kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>, <bhelgaas@google.com>,
        <jingxiangfeng@huawei.com>, <tglx@linutronix.de>,
        <sakari.ailus@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH] arm: fix page faults in do_alignment
Date:   Fri, 30 Aug 2019 21:31:17 +0800
Message-ID: <1567171877-101949-1-git-send-email-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function do_alignment can handle misaligned address for user and
kernel space. If it is a userspace access, do_alignment may fail on
a low-memory situation, because page faults are disabled in
probe_kernel_address.

Fix this by using __copy_from_user stead of probe_kernel_address.

Fixes: b255188 ("ARM: fix scheduling while atomic warning in alignment handling code")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 arch/arm/mm/alignment.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 04b3643..2ccabd3 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -774,6 +774,7 @@ static ssize_t alignment_proc_write(struct file *file, const char __user *buffer
 	unsigned long instr = 0, instrptr;
 	int (*handler)(unsigned long addr, unsigned long instr, struct pt_regs *regs);
 	unsigned int type;
+	mm_segment_t fs;
 	unsigned int fault;
 	u16 tinstr = 0;
 	int isize = 4;
@@ -784,16 +785,22 @@ static ssize_t alignment_proc_write(struct file *file, const char __user *buffer
 
 	instrptr = instruction_pointer(regs);
 
+	fs = get_fs();
+	set_fs(KERNEL_DS);
 	if (thumb_mode(regs)) {
 		u16 *ptr = (u16 *)(instrptr & ~1);
-		fault = probe_kernel_address(ptr, tinstr);
+		fault = __copy_from_user(tinstr,
+				(__force const void __user *)ptr,
+				sizeof(tinstr));
 		tinstr = __mem_to_opcode_thumb16(tinstr);
 		if (!fault) {
 			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
 			    IS_T32(tinstr)) {
 				/* Thumb-2 32-bit */
 				u16 tinst2 = 0;
-				fault = probe_kernel_address(ptr + 1, tinst2);
+				fault = __copy_from_user(tinst2,
+						(__force const void __user *)(ptr+1),
+						sizeof(tinst2));
 				tinst2 = __mem_to_opcode_thumb16(tinst2);
 				instr = __opcode_thumb32_compose(tinstr, tinst2);
 				thumb2_32b = 1;
@@ -803,10 +810,13 @@ static ssize_t alignment_proc_write(struct file *file, const char __user *buffer
 			}
 		}
 	} else {
-		fault = probe_kernel_address((void *)instrptr, instr);
+		fault = __copy_from_user(instr,
+				(__force const void __user *)instrptr,
+				sizeof(instr));
 		instr = __mem_to_opcode_arm(instr);
 	}
 
+	set_fs(fs);
 	if (fault) {
 		type = TYPE_FAULT;
 		goto bad_or_fault;
-- 
1.8.3.1

