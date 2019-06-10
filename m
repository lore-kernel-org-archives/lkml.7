Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1025C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24D2207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbfFJRPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfFJRPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:15:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DF71C057E37;
        Mon, 10 Jun 2019 17:15:48 +0000 (UTC)
Received: from prarit.khw1.lab.eng.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DA905C1B4;
        Mon, 10 Jun 2019 17:15:46 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86/resctrl: Fix panic on systems that do not enable local MBM
Date:   Mon, 10 Jun 2019 13:15:44 -0400
Message-Id: <20190610171544.13474-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 10 Jun 2019 17:15:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting with kernel parameter "rdt=cmt,mbmtotal,memlocal,l3cat,mba" and
executing "mount -t resctrl resctrl -o mba_MBps /sys/fs/resctrl"
results in a panic on systems without local MBM support enabled in
firmware.

BUG: kernel NULL pointer dereference, address: 0000000000000020
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 722 Comm: kworker/0:3 Not tainted 5.2.0-0.rc3.git0.1.el7_UNSUPPORTED.x86_64 #2
Hardware name: Dell Inc. PowerEdge R740/0923K0, BIOS 2.1.8 04/30/2019
Workqueue: events mbm_handle_overflow
RIP: 0010:mbm_handle_overflow+0x150/0x2b0

Only call the bandwith update loop if the system has local MBM enabled.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 7ee93125a211..397206f23d14 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -360,6 +360,9 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	struct list_head *head;
 	struct rdtgroup *entry;
 
+	if (!is_mbm_local_enabled())
+		return;
+
 	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-- 
2.21.0

