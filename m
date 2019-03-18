Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F7DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998C52086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfCRCNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:13:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37968 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbfCRCNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 22:13:21 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B6E086946B95840C0EBF;
        Mon, 18 Mar 2019 10:13:17 +0800 (CST)
Received: from linux-work.huawei.com (10.67.189.231) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Mar 2019 10:13:11 +0800
From:   <chenjie6@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zengweilin@huawei.com>, chen jie <chenjie6@huawei.com>
Subject: [PATCH] splice: sendfile() softlockup for big files
Date:   Mon, 18 Mar 2019 02:02:15 +0000
Message-ID: <1552874535-15679-1-git-send-email-chenjie6@huawei.com>
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

sendfile() softlockup for big files

[34922.213193] [Softlockup Clock][34922213187422]
[34922.213204] BUG: soft lockup - CPU#1 stuck for 60008ms! [trinity-c1:20239]
[34922.213211] Modules linked in: rtos_snapshot(O) rsm(O) nfsv3 veth(O) higmac(O) comm(O) nand mtdblock mtd_blkdevs nand_ecc nand_ids pramdisk(O) rtos_kbox_panic(O) double_cluster(O) uart_suspend(O) cache_ops(O) nfsd nfs_acl exportfs auth_rpcgss nfs lockd sunrpc oid_registry grace physmap cfi_probe cfi_cmdset_0002 cfi_util mtd gen_probe chipreg ohci_platform ehci_platform ohci_hcd ehci_hcd usb_device_hisi(O) vfat fat sd_mod enable_uart_rx(O) [last unloaded: rtos_snapshot]
[34922.213476] CPU: 1 PID: 20239 Comm: trinity-c1 Tainted: G        W  O    4.1.12 #12
[34922.213484] Hardware name: Hisilicon A9
[34922.213495] task: ef16b2a0 ti: ede92000 task.ti: ede92000
[34922.213512] PC is at eventfd_write+0x250/0x26c
[34922.213528] LR is at sched_clock+0x84/0xa4
[34922.213540] pc : [<c0258ed8>]    lr : [<c017afc8>]    psr: 20000213
sp : ede93d18  ip : 0000000a  fp : c050ab90
[34922.213550] r10: 00000008  r9 : c2d432a0  r8 : 00000ce0
[34922.213559] r7 : 00000008  r6 : c35b4700  r5 : 00000000  r4 : 00000000
[34922.213569] r3 : 00000000  r2 : 00000000  r1 : 000010c4  r0 : 00000000
[34922.213581] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[34922.213591] Control: 1ac5387d  Table: aecc004a  DAC: 55555555
[34922.213604] CPU: 1 PID: 20239 Comm: trinity-c1 Tainted: G        W  O    4.1.12 #12
[34922.213612] Hardware name: Hisilicon A9
[34922.213639] [<c010eeb0>] (unwind_backtrace) from [<c010ad20>] (show_stack+0x10/0x14)
[34922.213664] [<c010ad20>] (show_stack) from [<c04291cc>] (dump_stack+0xa4/0xdc)
[34922.213695] [<c04291cc>] (dump_stack) from [<c019de10>] (watchdog_timer_fn+0x33c/0x42c)
[34922.213715] [<c019de10>] (watchdog_timer_fn) from [<c016f920>] (hrtimer_run_queues+0x1d0/0x3a8)
[34922.213732] [<c016f920>] (hrtimer_run_queues) from [<c016ea5c>] (run_local_timers+0x8/0x14)
[34922.213748] [<c016ea5c>] (run_local_timers) from [<c016ea90>] (update_process_times+0x28/0x5c)
[34922.213764] [<c016ea90>] (update_process_times) from [<c0179f20>] (tick_periodic+0xac/0xcc)
[34922.213780] [<c0179f20>] (tick_periodic) from [<c0179fac>] (tick_handle_periodic+0x24/0x80)
[34922.213797] [<c0179fac>] (tick_handle_periodic) from [<c010e2e0>] (twd_handler+0x30/0x44)
[34922.213824] [<c010e2e0>] (twd_handler) from [<c0162378>] (handle_percpu_devid_irq+0xb4/0x1b0)
[34922.213842] [<c0162378>] (handle_percpu_devid_irq) from [<c015e3fc>] (generic_handle_irq+0x20/0x30)
[34922.213859] [<c015e3fc>] (generic_handle_irq) from [<c015e6a0>] (__handle_domain_irq+0xd8/0x160)
[34922.213876] [<c015e6a0>] (__handle_domain_irq) from [<c01013c0>] (gic_handle_irq+0x40/0x6c)
[34922.213894] [<c01013c0>] (gic_handle_irq) from [<c042ec04>] (__irq_svc+0x44/0x5c)
[34922.213904] Exception stack(0xede93cd0 to 0xede93d18)
[34922.213916] 3cc0:                                     00000000 000010c4 00000000 00000000
[34922.213930] 3ce0: 00000000 00000000 c35b4700 00000008 00000ce0 c2d432a0 00000008 c050ab90
[34922.213943] 3d00: 0000000a ede93d18 c017afc8 c0258ed8 20000213 ffffffff
[34922.213958] [<c042ec04>] (__irq_svc) from [<c0258ed8>] (eventfd_write+0x250/0x26c)
[34922.213980] [<c0258ed8>] (eventfd_write) from [<c0216b28>] (__vfs_write+0x2c/0xe8)
[34922.213996] [<c0216b28>] (__vfs_write) from [<c0216c20>] (__kernel_write+0x3c/0xf0)
[34922.214016] [<c0216c20>] (__kernel_write) from [<c0241450>] (write_pipe_buf+0x38/0x4c)
[34922.214032] [<c0241450>] (write_pipe_buf) from [<c02415e4>] (__splice_from_pipe+0x138/0x280)
[34922.214049] [<c02415e4>] (__splice_from_pipe) from [<c0242d28>] (splice_from_pipe+0x58/0x70)
[34922.214065] [<c0242d28>] (splice_from_pipe) from [<c0242d5c>] (default_file_splice_write+0x1c/0x3c)
[34922.214082] [<c0242d5c>] (default_file_splice_write) from [<c0241fd8>] (direct_splice_actor+0x34/0x3c)
[34922.214098] [<c0241fd8>] (direct_splice_actor) from [<c024194c>] (splice_direct_to_actor+0x15c/0x278)
[34922.214113] [<c024194c>] (splice_direct_to_actor) from [<c0241af8>] (do_splice_direct+0x90/0xb8)
[34922.214130] [<c0241af8>] (do_splice_direct) from [<c0217458>] (do_sendfile+0x188/0x354)
[34922.214148] [<c0217458>] (do_sendfile) from [<c021828c>] (SyS_sendfile64+0xcc/0xdc)
[34922.214172] [<c021828c>] (SyS_sendfile64) from [<c0107b6c>] (__sys_trace_return+0x0/0x14)
[34922.214182] =====================SOFTLOCKUP INFO BEGIN=======================
[34922.214191] ------------------CPU#1-----------------------------------
[34922.214200] [CPU#1] the task [trinity-c1] is not waiting for a lock,maybe a delay or deadcircle!
[34922.214209] trinity-c1      R running      0 20239  19220 0x00000203
[34922.214241] [<c010eeb0>] (unwind_backtrace) from [<c010ad20>] (show_stack+0x10/0x14)
[34922.214257] [<c010ad20>] (show_stack) from [<c019e68c>] (show_lock_info+0xd0/0x29c)
[34922.214276] [<c019e68c>] (show_lock_info) from [<c019de44>] (watchdog_timer_fn+0x370/0x42c)
[34922.214294] [<c019de44>] (watchdog_timer_fn) from [<c016f920>] (hrtimer_run_queues+0x1d0/0x3a8)
[34922.214309] [<c016f920>] (hrtimer_run_queues) from [<c016ea5c>] (run_local_timers+0x8/0x14)
[34922.214325] [<c016ea5c>] (run_local_timers) from [<c016ea90>] (update_process_times+0x28/0x5c)
[34922.214340] [<c016ea90>] (update_process_times) from [<c0179f20>] (tick_periodic+0xac/0xcc)
[34922.214355] [<c0179f20>] (tick_periodic) from [<c0179fac>] (tick_handle_periodic+0x24/0x80)
[34922.214371] [<c0179fac>] (tick_handle_periodic) from [<c010e2e0>] (twd_handler+0x30/0x44)

Signed-off-by: chen jie <chenjie6@huawei.com>
---
 fs/splice.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index de2ede0..f4ce9e8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -989,6 +989,8 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 			sd->pos = prev_pos + ret;
 			goto out_release;
 		}
+
+		cond_resched();
 	}
 
 done:
-- 
1.8.3.4

