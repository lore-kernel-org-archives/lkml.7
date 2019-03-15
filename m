Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9BFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B044206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCOD4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:56:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727096AbfCOD4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 23:56:03 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2272329FEB20CBBEC565;
        Fri, 15 Mar 2019 11:56:00 +0800 (CST)
Received: from linux-work.huawei.com (10.67.189.231) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Mar 2019 11:55:50 +0800
From:   <chenjie6@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <dvhart@infradead.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <zengweilin@huawei.com>,
        chen jie <chenjie6@huawei.com>
Subject: [PATCH] futex:fix robust futex alignment exception
Date:   Fri, 15 Mar 2019 03:44:38 +0000
Message-ID: <1552621478-119787-1-git-send-email-chenjie6@huawei.com>
X-Mailer: git-send-email 1.8.3.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.231]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chen jie <chenjie6@huawei.com>

trinity test bug fix:
/tmp/trinity --children 4 --quiet -N 10000000 --logging=off -X -x perf_event_open --enable-fds=testfile

[1542.195981] Task track: trinity-c3(6911)>trinity-main(28313)>sh(839)>bash(824)>sshd(820)>sshd(662)>init(1)
[11542.214694] Alignment trap: not handling instruction e1915f9f at [<c017b1d4>]
[11542.214724] Unhandled fault: alignment exception (0x011) at 0x000265f9
[11542.214749] pgd = edde0000
[11542.214774] [000265f9] *pgd=84aa9831, *pte=bc10359f, *ppte=bc103e7e
[11542.214851] Internal error: : 11 [#1] SMP ARM
[11542.214857] Modules linked in: rtos_snapshot(O) rsm(O) nfsv3 veth(O) pthread_lsof(O) higmac(O) comm(O) nand mtdblock mtd_blkdevs nand_ecc nand_ids pramdisk(O) rtos_kbox_panic(O) double_cluster(O) uart_suspend(O) cache_ops(O) nfsd nfs_acl exportfs auth_rpcgss nfs lockd sunrpc oid_registry grace physmap cfi_probe cfi_cmdset_0002 cfi_util mtd gen_probe chipreg ohci_platform ehci_platform ohci_hcd ehci_hcd usb_device_hisi(O) vfat fat sd_mod enable_uart_rx(O) [last unloaded: rtos_snapshot]
[11542.215042] CPU: 3 PID: 6911 Comm: trinity-c3 Tainted: G    B   W  O    4.1.12 #1
[11542.215048] Hardware name: Hisilicon A9
[11542.215055] task: c3df8a20 ti: ebb2c000 task.ti: ebb2c000
[11542.215071] PC is at cmpxchg_futex_value_locked+0x44/0x88
[11542.215081] LR is at handle_futex_death+0x78/0xcc
[11542.215090] pc : [<c017b1d4>]    lr : [<c017da50>]    psr: 60000213
sp : ebb2dee4  ip : fffffff2  fp : fffffff2
[11542.215096] r10: 000238e3  r9 : 00000000  r8 : 00001000
[11542.215103] r7 : c3df8a20  r6 : 00000000  r5 : 00001aff  r4 : ebb2def4
[11542.215110] r3 : 40000000  r2 : 00001aff  r1 : 000265f9  r0 : 410265fc
[11542.215119] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[11542.215126] Control: 1ac5387d  Table: ae7e004a  DAC: 55555555
[11542.215133] Process trinity-c3 (pid: 6911, stack limit = 0xebb2c210)
[11542.215140] Stack: (0xebb2dee4 to 0xebb2e000)
[11542.215151] dee0:          000265f9 00001aff c017da50 000265f9 c3df8a20 b5ebc000 00000800
[11542.215161] df00: c3df8a20 00001000 00001000 c017dba8 c3df8a20 c399ef40 00000000 c3df8a20
[11542.215172] df20: c399ef40 c399ef40 000000f8 c0107b84 ebb2c000 00000001 0094d810 c011b40c
[11542.215182] df40: c3df8a20 c399ef40 c3df8a20 c399ef40 0094d830 c011f9a4 00000000 000000f8
[11542.215192] df60: c0107b84 c0197388 00002d16 ef1d3520 00000000 0094d830 000000f8 c0107b84
[11542.215203] df80: ebb2c000 00000200 0094d810 c0120250 00097d80 0094d8a4 0094d830 c01202a8
[11542.215213] dfa0: 00000000 c0107b6c 00097d80 0094d8a4 00000000 b6f0f4c0 b63ef000 00000000
[11542.215223] dfc0: 00097d80 0094d8a4 0094d830 000000f8 00000001 0094db88 0094db94 0094d810
[11542.215233] dfe0: 00097d64 be938310 00017a40 b6e1a340 60000210 00000000 00000000 00000000
[11542.215247] [<c017b1d4>] (cmpxchg_futex_value_locked) from [<c017da50>] (handle_futex_death+0x78/0xcc)
[11542.215259] [<c017da50>] (handle_futex_death) from [<c017dba8>] (exit_robust_list+0x104/0x160)
[11542.215273] [<c017dba8>] (exit_robust_list) from [<c011b40c>] (mm_release+0x1c/0x108)
[11542.215287] [<c011b40c>] (mm_release) from [<c011f9a4>] (do_exit+0x218/0x9a4)
[11542.215299] [<c011f9a4>] (do_exit) from [<c0120250>] (do_group_exit+0xac/0xf4)
[11542.215311] [<c0120250>] (do_group_exit) from [<c01202a8>] (__wake_up_parent+0x0/0x18)
[11542.215321] Code: 0dc0e0e3 0a00001a 5bf07ff5 00f091f5 (9f5f91e1)
[11542.217918] CPU 1 will stop doing anything useful since another CPU has crashed
[11542.217924] CPU 0 will stop doing anything useful since another CPU has crashed
[11542.217930] CPU 2 will stop doing anything useful since another CPU has crashed
[11542.218626] Loading crashdump kernel...
[11542.218668] Bye!

Signed-off-by: chen jie <chenjie6@huawei.com>
---
 kernel/futex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index a0514e0..70231c4 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3440,6 +3440,9 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int p
 {
 	u32 uval, uninitialized_var(nval), mval;
 
+	if (((unsigned long)uaddr & 0x3) > 0)
+		return -1;
+
 retry:
 	if (get_user(uval, uaddr))
 		return -1;
-- 
1.8.3.4

