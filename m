Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D295C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7132067B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569013932;
	bh=v11LobAmANuILe8bBfxqMEIERFE+9ieK3u/5aIIBcIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iM+agVJkMC5LR3Hu4hrtpLdQT9ojnLzfdbmLr4udQB86/S8pc2y51+2iSGixIRf5v
	 8OMxzLXK9x1yA1d82be8nPAoh+ar5XiI+Eyvz9VvdSrzz5PqEtkMon7/O28DnPuYgl
	 nY385aeEq30IE4APzlQlYXv52KX2cZbMrXSWrHyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfITVML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:12:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41158 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfITVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:12:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so8713717qkg.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6fn4li2u42620a7LY19pcWfvrz9FTQPSCqBSiPAoYU=;
        b=B28uUSXfVt3dnkaq7z6Iwn2CQIzxNXr1oSvTHYNLWioja1lAAy1HTDwPJmElGqeGQ1
         VO5oyQFJKRqmMSOlg2IkIiSMR1P81DigsnkTm8e5Q+cGMponqjepZ3ybV+0e3wHLV3yr
         3WSvfDB9Phvk2NwxwmjGpHWQQTawoAXOZ7xlTS2MmzkmGSUpq5mH4P+xHW8442ess5qs
         LMfkRM7i4IBXUpECOohT/jKzJecuQHMTtl2OdJucnNVJF1kW68jgu2FNrUVCT76WQ8pr
         YenUMlbFVi3UuuQMag9lQA1FHyQDBOJ4TlQ0nhElzYpER4WuV64zCpSoXyUyLuqH18rX
         P2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6fn4li2u42620a7LY19pcWfvrz9FTQPSCqBSiPAoYU=;
        b=DW9z0vss/d4I22/nr1KDMNPSzZfJO2KqTODqNjcu2yMFfloIJI/8e+aT3oJYSMQ2Ig
         lweuEq/ughN/LPrRMSL9sZEIJZ1zVRVbLHPeCZHWgp+G4Hm4vmID3abclOvrc+EjEpOC
         1fiCr6zIxwx7GvyvvAN027atrWJUo+UFH4GJOZJSbjnCuwm2e55ERIzWPBN0lbl2bLKa
         EYA7AeKXEVSLnmo6JGVR2MwssoDZjJmIInqgCQi3jWJE+/Iw5D/xpAiWVG8/BZhp/LhF
         fwcMmiwu6PsB5pzLNLLGlI+Fq4Xx9P0Ldpmq9zzCjxnmu3XoCHoXQSaHLWaTGhDfgSH8
         Zd/g==
X-Gm-Message-State: APjAAAWabqhAd09zVheyeBGxpWijnSrl9L5jQPM3+iGd4DP4R4FaDmW5
        j0EdBG70ghkY+47bpQIzlbFJVz/gnSM=
X-Google-Smtp-Source: APXvYqzZCHR9P3mt5jmzM63yHKraJwxIr56xxfZiKBy9vKnSNM82aSyPSH6j5j6jsZqXi625vbxcng==
X-Received: by 2002:ae9:d803:: with SMTP id u3mr5887165qkf.25.1569013929574;
        Fri, 20 Sep 2019 14:12:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::7520])
        by smtp.gmail.com with ESMTPSA id z38sm1851594qtj.83.2019.09.20.14.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 14:12:08 -0700 (PDT)
Date:   Fri, 20 Sep 2019 14:12:05 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Marcin Pawlowski <mpawlowski@fb.com>,
        "Williams, Gerald S" <gerald.s.williams@intel.com>
Subject: [PATCH] workqueue: Minor follow-ups to the rescuer destruction change
Message-ID: <20190920211205.GD2233839@devbig004.ftw2.facebook.com>
References: <20190919014340.GM3084169@devbig004.ftw2.facebook.com>
 <CAJhGHyBd53ogp35FkmwDhzCv7=MipXwyoHGPVXjsaxSH540O8A@mail.gmail.com>
 <20190920210833.GC2233839@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920210833.GC2233839@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 30ae2fc0a75eb5f1a38bbee7355d8e3bc823a6e1 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 20 Sep 2019 14:09:14 -0700

* Now that wq->rescuer may be cleared while rescuer is still there,
  switch show_pwq() debug printout to test worker->rescue_wq to
  identify rescuers intead of testing wq->rescuer.

* Update comment on ->rescuer locking.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
Applied to workqueue/for-5.4-fixes.

Thanks.

 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3f067f1d72e3..7f7aa45dac37 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -248,7 +248,7 @@ struct workqueue_struct {
 	struct list_head	flusher_overflow; /* WQ: flush overflow list */
 
 	struct list_head	maydays;	/* MD: pwqs requesting rescue */
-	struct worker		*rescuer;	/* I: rescue worker */
+	struct worker		*rescuer;	/* MD: rescue worker */
 
 	int			nr_drainers;	/* WQ: drain in progress */
 	int			saved_max_active; /* WQ: saved pwq max_active */
@@ -4672,7 +4672,7 @@ static void show_pwq(struct pool_workqueue *pwq)
 
 			pr_cont("%s %d%s:%ps", comma ? "," : "",
 				task_pid_nr(worker->task),
-				worker == pwq->wq->rescuer ? "(RESCUER)" : "",
+				worker->rescue_wq ? "(RESCUER)" : "",
 				worker->current_func);
 			list_for_each_entry(work, &worker->scheduled, entry)
 				pr_cont_work(false, work);
-- 
2.17.1

