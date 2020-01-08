Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4324FC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C90B20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAHUMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:12:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:40620 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgAHUMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:12:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 12:12:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="303655750"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2020 12:12:17 -0800
Date:   Wed, 8 Jan 2020 12:23:11 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [bug report] resctrl high memory comsumption
Message-ID: <20200108202311.GA40461@romley-ivt3.sc.intel.com>
References: <CALvZod7E9zzHwenzf7objzGKsdBmVwTgEJ0nPgs0LUFU3SN5Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7E9zzHwenzf7objzGKsdBmVwTgEJ0nPgs0LUFU3SN5Pw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 09:07:41AM -0800, Shakeel Butt wrote:
> Hi,
> 
> Recently we had a bug in the system software writing the same pids to
> the tasks file of resctrl group multiple times. The resctrl code
> allocates "struct task_move_callback" for each such write and call
> task_work_add() for that task to handle it on return to user-space
> without checking if such request already exist for that particular
> task. The issue arises for long sleeping tasks which has thousands for
> such request queued to be handled. On our production, we notice
> thousands of tasks having thousands of such requests and taking GiBs
> of memory for "struct task_move_callback". I am not very familiar with
> the code to judge if task_work_cancel() is the right approach or just
> checking closid/rmid before doing task_work_add().
> 

Thank you for reporting the issue, Shakeel!

Could you please check if the following patch fixes the issue?
From 3c23c39b6a44fdfbbbe0083d074dcc114d7d7f1c Mon Sep 17 00:00:00 2001
From: Fenghua Yu <fenghua.yu@intel.com>
Date: Wed, 8 Jan 2020 19:53:33 +0000
Subject: [RFC PATCH] x86/resctrl: Fix redundant task movements

Currently a task can be moved to a rdtgroup multiple times.
But, this can cause multiple task works are added, waste memory
and degrade performance.

To fix the issue, only move the task to a rdtgroup when the task
is not in the rdgroup. Don't try to move the task to the rdtgroup
again when the task is already in the rdtgroup.

Reported-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2e3b06d6bbc6..75300c4a5969 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -546,6 +546,17 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	struct task_move_callback *callback;
 	int ret;
 
+	/* If the task is already in rdtgrp, don't move the task. */
+	if ((rdtgrp->type == RDTCTRL_GROUP && tsk->closid == rdtgrp->closid &&
+	    tsk->rmid == rdtgrp->mon.rmid) ||
+	    (rdtgrp->type == RDTMON_GROUP &&
+	     rdtgrp->mon.parent->closid == tsk->closid &&
+	     tsk->rmid == rdtgrp->mon.rmid)) {
+		rdt_last_cmd_puts("Task is already in the rdgroup\n");
+
+		return -EINVAL;
+	}
+
 	callback = kzalloc(sizeof(*callback), GFP_KERNEL);
 	if (!callback)
 		return -ENOMEM;
-- 
2.19.1

