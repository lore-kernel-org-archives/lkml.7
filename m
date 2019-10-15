Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CF1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4404221848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfJOL3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:29:23 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:59514 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJOL3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:29:22 -0400
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 04BC4DD4;
        Tue, 15 Oct 2019 19:29:12 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [14.18.236.69])
        by smtp.263.net (postfix) whith ESMTP id P39712T140117121373952S1571138947996401_;
        Tue, 15 Oct 2019 19:29:11 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c7b9006010d277e23615aa8612eaf206>
X-RL-SENDER: yili@winhong.com
X-SENDER: yili@winhong.com
X-LOGIN-NAME: yili@winhong.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 14.18.236.69
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Yi Li <yili@winhong.com>
To:     linux-kernel@vger.kernel.org
Cc:     joseph.qi@linux.alibaba.com, Yi Li <yilikernel@gmail.com>
Subject: [PATCH v2] ocfs2: fix panic due to ocfs2_wq is null
Date:   Tue, 15 Oct 2019 19:29:03 +0800
Message-Id: <1571138943-22631-1-git-send-email-yili@winhong.com>
X-Mailer: git-send-email 2.7.5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Li <yilikernel@gmail.com>

mount.ocfs2 failed when read ocfs2 filesystem super error.
the func ocfs2_initialize_super will return before allocate ocfs2_wq.
ocfs2_dismount_volume will triggered the following panic.

  Oct 15 16:09:27 cnwarekv-205120 kernel: On-disk corruption
discovered.Please run fsck.ocfs2 once the filesystem is unmounted.
  Oct 15 16:09:27 cnwarekv-205120 kernel: (mount.ocfs2,22804,44):
ocfs2_read_locked_inode:537 ERROR: status = -30
  Oct 15 16:09:27 cnwarekv-205120 kernel: (mount.ocfs2,22804,44):
ocfs2_init_global_system_inodes:458 ERROR: status = -30
  Oct 15 16:09:27 cnwarekv-205120 kernel: (mount.ocfs2,22804,44):
ocfs2_init_global_system_inodes:491 ERROR: status = -30
  Oct 15 16:09:27 cnwarekv-205120 kernel: (mount.ocfs2,22804,44):
ocfs2_initialize_super:2313 ERROR: status = -30
  Oct 15 16:09:27 cnwarekv-205120 kernel: (mount.ocfs2,22804,44):
ocfs2_fill_super:1033 ERROR: status = -30
  ------------[ cut here ]------------
  Oops: 0002 [#1] SMP NOPTI
  Modules linked in: ocfs2 rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs fscache
lockd grace ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager
ocfs2_stackglue configfs sunrpc ipt_REJECT nf_reject_ipv4
nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT
nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack
ip6table_filter ip6_tables ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad
rdma_cm ib_cm iw_cm ib_sa ib_mad ib_core ib_addr ipv6 ovmapi ppdev
parport_pc parport fb_sys_fops sysimgblt sysfillrect syscopyarea
acpi_cpufreq pcspkr i2c_piix4 i2c_core sg ext4 jbd2 mbcache2 sr_mod cdrom
  CPU: 1 PID: 11753 Comm: mount.ocfs2 Tainted: G  E
        4.14.148-200.ckv.x86_64 #1
  Hardware name: Sugon H320-G30/35N16-US, BIOS 0SSDX017 12/21/2018
  task: ffff967af0520000 task.stack: ffffa5f05484000
  RIP: 0010:mutex_lock+0x19/0x20
  Call Trace:
    flush_workqueue+0x81/0x460
    ocfs2_shutdown_local_alloc+0x47/0x440 [ocfs2]
    ocfs2_dismount_volume+0x84/0x400 [ocfs2]
    ocfs2_fill_super+0xa4/0x1270 [ocfs2]
    ? ocfs2_initialize_super.isa.211+0xf20/0xf20 [ocfs2]
    mount_bdev+0x17f/0x1c0
    mount_fs+0x3a/0x160

Signed-off-by: Yi Li <yilikernel@gmail.com>
---
 fs/ocfs2/journal.c    | 3 ++-
 fs/ocfs2/localalloc.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 930e3d3..699a560 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -217,7 +217,8 @@ void ocfs2_recovery_exit(struct ocfs2_super *osb)
 	/* At this point, we know that no more recovery threads can be
 	 * launched, so wait for any recovery completion work to
 	 * complete. */
-	flush_workqueue(osb->ocfs2_wq);
+	if (osb->ocfs2_wq)
+		flush_workqueue(osb->ocfs2_wq);
 
 	/*
 	 * Now that recovery is shut down, and the osb is about to be
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 158e5af..720e9f9 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -377,7 +377,8 @@ void ocfs2_shutdown_local_alloc(struct ocfs2_super *osb)
 	struct ocfs2_dinode *alloc = NULL;
 
 	cancel_delayed_work(&osb->la_enable_wq);
-	flush_workqueue(osb->ocfs2_wq);
+	if (osb->ocfs2_wq)
+		flush_workqueue(osb->ocfs2_wq);
 
 	if (osb->local_alloc_state == OCFS2_LA_UNUSED)
 		goto out;
-- 
2.7.5



