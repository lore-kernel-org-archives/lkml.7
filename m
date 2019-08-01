Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE77DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FDE20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfHANhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:37:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfHANhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:37:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFD2B3CA00;
        Thu,  1 Aug 2019 13:37:53 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7896860BF7;
        Thu,  1 Aug 2019 13:37:51 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched: use rq_lock/unlock in online_fair_sched_group
Date:   Thu,  1 Aug 2019 09:37:49 -0400
Message-Id: <20190801133749.11033-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 01 Aug 2019 13:37:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling WARN_DOUBLE_CLOCK in /sys/kernel/debug/sched_features causes
warning to fire in update_rq_clock. This seems to be caused by onlining
a new fair sched group not using the rq lock wrappers.

[472978.683085] rq->clock_update_flags & RQCF_UPDATED
[472978.683100] WARNING: CPU: 5 PID: 54385 at kernel/sched/core.c:210 update_rq_clock+0xec/0x150
[472978.758465] Modules linked in: fuse vfat msdos fat ext4 mbcache jbd2 sunrpc iTCO_wdt gpio_ich iTCO_vendor_support intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass ipmi_si crct10dif_pclmul crc32_pclmul ghash_clmulni_intel joydev pcspkr intel_cstate acpi_power_meter ipmi_devintf sg intel_uncore i7core_edac hpilo hpwdt lpc_ich ipmi_msghandler acpi_cpufreq ip_tables xfs libcrc32c sr_mod sd_mod cdrom ata_generic radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ata_piix drm myri10ge hpsa libata serio_raw crc32c_intel scsi_transport_sas netxen_nic dca dm_mirror dm_region_hash dm_log dm_mod
[472979.050101] CPU: 5 PID: 54385 Comm: cgcreate Not tainted 5.2.0-rc6+ #135
[472979.089586] Hardware name: HP ProLiant DL580 G7, BIOS P65 08/16/2015
[472979.123638] RIP: 0010:update_rq_clock+0xec/0x150
[472979.146435] Code: a8 04 0f 84 55 ff ff ff 80 3d 93 34 2c 01 00 0f 85 48 ff ff ff 48 c7 c7 08 b9 a8 b7 31 c0 c6 05 7d 34 2c 01 01 e8 04 21 fd ff <0f> 0b 8b 83 b0 09 00 00 e9 26 ff ff ff e8 72 c3 f5 ff 66 90 4c 8b
[472979.247671] RSP: 0018:ffffa9addac67d48 EFLAGS: 00010086
[472979.277071] RAX: 0000000000000000 RBX: ffff9db3ff62a380 RCX: 0000000000000000
[472979.314842] RDX: 0000000000000005 RSI: ffffffffb8434a45 RDI: ffffffffb84325ec
[472979.352189] RBP: 0000000000000000 R08: ffffffffb8434a20 R09: ffffffb27562d751
[472979.389326] R10: 000000000000d471 R11: ffffa9addac67a58 R12: ffff9d8a1c9d5a00
[472979.425255] R13: ffff9db3fbbed400 R14: 000000000002a380 R15: 0000000000000000
[472979.462417] FS:  00007f6a8218cb80(0000) GS:ffff9db3ff740000(0000) knlGS:0000000000000000
[472979.511306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[472979.543386] CR2: 00007f6a82198000 CR3: 0000003f33f16005 CR4: 00000000000206e0
[472979.578646] Call Trace:
[472979.591702]  online_fair_sched_group+0x53/0x100
[472979.618172]  cpu_cgroup_css_online+0x16/0x20
[472979.640264]  online_css+0x1c/0x60
[472979.657648]  cgroup_apply_control_enable+0x231/0x3b0
[472979.684979]  cgroup_mkdir+0x41b/0x530
[472979.704845]  kernfs_iop_mkdir+0x61/0xa0
[472979.726278]  vfs_mkdir+0x108/0x1a0
[472979.745665]  do_mkdirat+0x77/0xe0
[472979.764981]  do_syscall_64+0x55/0x1d0
[472979.785990]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Using the wrappers in online_fair_sched_group instead of the raw locking 
removes this warning. 

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 Resend with PATCH instead of CHANGE in subject, and more recent upstream x86 backtrace.

 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95a87e9..5c1299a5675c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10242,17 +10242,17 @@ void online_fair_sched_group(struct task_group *tg)
 {
 	struct sched_entity *se;
 	struct rq *rq;
+	struct rq_flags rf;
 	int i;
 
 	for_each_possible_cpu(i) {
 		rq = cpu_rq(i);
 		se = tg->se[i];
-
-		raw_spin_lock_irq(&rq->lock);
+		rq_lock(rq, &rf);
 		update_rq_clock(rq);
 		attach_entity_cfs_rq(se);
 		sync_throttle(tg, i);
-		raw_spin_unlock_irq(&rq->lock);
+		rq_unlock(rq, &rf);
 	}
 }
 
-- 
2.18.0

