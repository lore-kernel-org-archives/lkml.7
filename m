Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DECC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13545218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfGZOMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:12:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfGZOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:12:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A77D53082E0F;
        Fri, 26 Jul 2019 14:11:59 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 286D06062B;
        Fri, 26 Jul 2019 14:11:59 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [CHANGE] sched: use rq_lock/unlock in online_fair_sched_group
Date:   Fri, 26 Jul 2019 10:11:56 -0400
Message-Id: <20190726141156.32042-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 26 Jul 2019 14:11:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling WARN_DOUBLE_CLOCK in /sys/kernel/debug/sched_features causes
warning to fire in update_rq_clock. This seems to be caused by onlining
a new fair sched group not using the rq lock wrappers.

[  612.379993] rq->clock_update_flags & RQCF_UPDATED
[  612.380007]	WARNING: CPU: 6 PID: 21426 at kernel/sched/core.c:225 update_rq_clock+0x90/0x130
[  612.393082] Modules linked in: binfmt_misc rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache sunrpc vfat fat sg xgene_hwmon gpio_xgene_sb gpio_dwapb gpio_generic xgene_edac mailbox_xgene_slimpro xgene_rng uio_pdrv_genirq uio sch_fq_codel xfs libcrc32c xgene_enet i2c_xgene_slimpro at803x realtek ahci_xgene libahci_platform mdio_xgene dm_mirror dm_region_hash dm_log dm_mod
[  612.427615] CPU: 6 PID: 21426 Comm: (dnf) Not tainted 4.16.0-10.el8+5.aarch64 #1
[  612.434973] Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene Mustang Board, BIOS 3.06.25 Oct 17 2016
[  612.444667] pstate: 60000085 (nZCv daIf -PAN -UAO)
[  612.449434] pc : update_rq_clock+0x90/0x130
[  612.453595] lr : update_rq_clock+0x90/0x130
[  612.457754] sp : ffff00000efefd60
[  612.461050] x29: ffff00000efefd60 x28: ffff8003c23d5400
[  612.466335] x27: ffff8003ca119c00 x26: ffff0000090bc000
[  612.471620] x25: ffff0000090bc090 x24: ffff0000090b3c68
[  612.476905] x23: ffff8003cefe1500 x22: ffff000008dbd280
[  612.482192] x21: 0000000000000000 x20: 0000000000000000
[  612.487478] x19: ffff8003ffddd280 x18: ffffffffffffffff
[  612.492763] x17: 0000000000000000 x16: 0000000000000000
[  612.498049] x15: ffff0000090b3c08 x14: ffff0000897a5a17
[  612.503334] x13: ffff0000097a5a25 x12: ffff0000090ff000
[  612.508620] x11: ffff0000090bbc90 x10: ffff000008548a78
[  612.513906] x9 : 00000000ffffffd0 x8 : 50555f4643515220
[  612.519191] x7 : 26207367616c665f x6 : 00000000000001cd
[  612.524477] x5 : 00ffffffffffffff x4 : 0000000000000000
[  612.529761] x3 : 0000000000000000 x2 : ffffffffffffffff
[  612.535047] x1 : 1f9a6a58385a9900 x0 : 0000000000000000
[  612.540333] Call trace:
[  612.542767]  update_rq_clock+0x90/0x130
[  612.546585]  online_fair_sched_group+0x70/0x140
[  612.551092]  sched_online_group+0xd0/0xf0
[  612.555082]  sched_autogroup_create_attach+0xd0/0x198
[  612.560108]  sys_setsid+0x140/0x160
[  612.563579]  el0_svc_naked+0x44/0x48

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>

---
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

