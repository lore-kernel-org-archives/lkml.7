Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52012C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DA421900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfDXQCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:02:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfDXQCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E38493082230;
        Wed, 24 Apr 2019 16:02:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 96C6360C8E;
        Wed, 24 Apr 2019 16:02:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Apr 2019 18:02:40 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:02:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Message-ID: <20190424160237.GH16167@redhat.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405174708.1010-5-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 24 Apr 2019 16:02:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05, Roman Gushchin wrote:
>
> @@ -5830,6 +5926,12 @@ void cgroup_exit(struct task_struct *tsk)
>  		spin_lock_irq(&css_set_lock);
>  		css_set_move_task(tsk, cset, NULL, false);
>  		cset->nr_tasks--;
> +
> +		if (unlikely(cgroup_task_frozen(tsk)))
> +			cgroup_freezer_frozen_exit(tsk);
> +		else if (unlikely(cgroup_task_freeze(tsk)))
> +			cgroup_update_frozen(task_dfl_cgroup(tsk));
> +

Now that I actually applied these patches, I can't understand how can
cgroup_exit() hit cgroup_task_frozen(current)...

A cgroup_task_frozen() task must never return to user-mode or escape
from get_signal() without leave_frozen() or we have a bug?

I must have missed something, could you explain why the patch below is
wrong?

Oleg.


diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 3e2efd4..24b8757 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -889,7 +889,6 @@ void cgroup_update_frozen(struct cgroup *cgrp);
 void cgroup_freeze(struct cgroup *cgrp, bool freeze);
 void cgroup_freezer_migrate_task(struct task_struct *task, struct cgroup *src,
 				 struct cgroup *dst);
-void cgroup_freezer_frozen_exit(struct task_struct *task);
 static inline bool cgroup_task_freeze(struct task_struct *task)
 {
 	bool ret;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6f09f9b..3d5f76a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6008,11 +6008,8 @@ void cgroup_exit(struct task_struct *tsk)
 		css_set_move_task(tsk, cset, NULL, false);
 		cset->nr_tasks--;
 
-		if (unlikely(cgroup_task_frozen(tsk)))
-			cgroup_freezer_frozen_exit(tsk);
-		else if (unlikely(cgroup_task_freeze(tsk)))
+		if (unlikely(cgroup_task_freeze(tsk)))
 			cgroup_update_frozen(task_dfl_cgroup(tsk));
-
 		spin_unlock_irq(&css_set_lock);
 	} else {
 		get_css_set(cset);
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index b5ccc87..68aa506 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -249,16 +249,6 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
 	cgroup_freeze_task(task, test_bit(CGRP_FREEZE, &dst->flags));
 }
 
-void cgroup_freezer_frozen_exit(struct task_struct *task)
-{
-	struct cgroup *cgrp = task_dfl_cgroup(task);
-
-	lockdep_assert_held(&css_set_lock);
-
-	cgroup_dec_frozen_cnt(cgrp);
-	cgroup_update_frozen(cgrp);
-}
-
 void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 {
 	struct cgroup_subsys_state *css;

