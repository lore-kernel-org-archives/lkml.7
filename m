Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A258C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 03:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACB2206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 03:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0MQrtdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfLaDv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 22:51:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43434 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfLaDv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 22:51:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so18986971pga.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 19:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LxqW63gNt+zxxT7StUjJBELGbfxi8smcFBc9U8y/oWA=;
        b=t0MQrtdIJr5pIctu01WazQGkAdXvUFIB9grH2WFsfV9MlDQXmFJNNJJgt8nfqq0BNp
         BHahrrVFwiz9LA5ZRCQY+KO0Rt3UTP7gx0sN+u9IdbgctcIjpjaBthxp+ZPScBbZ2Hnr
         LZ98mmCd/rUMjQAFvU/G02i7Bf1hpNonxt/NzzD4zzURL4dofxhMQcTUiBk2myZ7MNLw
         DkunLCpi5Gmu5JbRAc3nQRf1oR65hYgUjhvHmYnUazWwU6o4uFYqDrC9IcqA3LpePLuJ
         IHRbUhZhjhXTtrA0U4L2kS3VCBkEHzoJL0Tn6CFLq6iotbW2Xq05OHfoHpY+RlwQzufj
         NLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LxqW63gNt+zxxT7StUjJBELGbfxi8smcFBc9U8y/oWA=;
        b=TPhZyhM47UeNSkmc0qdGR45zPaJRkYwMbZB8mlKpbZvb+igBEhXFBPHOH4pd+jRcRb
         HIB5ZH9zhyuMW+NHsG5BB2o219AlrOaMyDUkKIvEPOxNDuZOswPo7NPMYdBwtCeZ+4im
         kgWpuC/FmmpuYCKipbbpls5nkyL6FPX7pjS+YVC1lNxcUBH3yhDULqGwtuNRJUawNfgy
         xOJmO7+ep4+5XR/y+gDqJbSbhiftzTcBj4hCbo7M9aWQStHwMuZFlLcODZMenc/0EaXo
         set6klH4korovePtZ7Ggxr0mTmSkeFilZLfnf2GQGqiPZbhf4Qyd3l6AvyqzgCbTYVgY
         CYdw==
X-Gm-Message-State: APjAAAVKsWC6BuspkAHIAmXvWUTfXC2RNf7aeVRQKKRJsnnUdU+U6Id+
        qxjGH34cHnyfNZBCA2eXS2hS0o0d
X-Google-Smtp-Source: APXvYqz5ALH7Gaz+AbsCkkXgzxET9EFLBCMJ7EW/RwWpwwIjmw9uoA7XwLeXb9R3PaPbBPBvj8/55Q==
X-Received: by 2002:a63:590e:: with SMTP id n14mr74433933pgb.10.1577764287205;
        Mon, 30 Dec 2019 19:51:27 -0800 (PST)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id y21sm32635523pfm.136.2019.12.30.19.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Dec 2019 19:51:26 -0800 (PST)
Date:   Tue, 31 Dec 2019 11:51:22 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH] sched/fair: fix sgc->{min,max}_capacity miscalculate
Message-ID: <20191231035122.GA10020@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
sched_group_capacity") introduced per-cpu min_capacity.

commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
introduced per-cpu max_capacity.

sgc->capacity is the *SUM* of all CPU's capacity in the group.
sgc->{min,max}_capacity are the sg per-cpu variables. Compare with
sgc->capacity to get sgc->{min,max}_capacity makes no sense. Instead,
we should compare one by one in each iteration to get
sgc->{min,max}_capacity of the group.

Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d170b5da0e3..97b164fcda93 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7795,6 +7795,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 		for_each_cpu(cpu, sched_group_span(sdg)) {
 			struct sched_group_capacity *sgc;
 			struct rq *rq = cpu_rq(cpu);
+			unsigned long cap;
 
 			/*
 			 * build_sched_domains() -> init_sched_groups_capacity()
@@ -7808,14 +7809,16 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 			 * causing divide-by-zero issues on boot.
 			 */
 			if (unlikely(!rq->sd)) {
-				capacity += capacity_of(cpu);
+				cap = capacity_of(cpu);
+				capacity += cap;
+				min_capacity = min(cap, min_capacity);
+				max_capacity = max(cap, max_capacity);
 			} else {
 				sgc = rq->sd->groups->sgc;
 				capacity += sgc->capacity;
+				min_capacity = min(sgc->min_capacity, min_capacity);
+				max_capacity = max(sgc->max_capacity, max_capacity);
 			}
-
-			min_capacity = min(capacity, min_capacity);
-			max_capacity = max(capacity, max_capacity);
 		}
 	} else  {
 		/*
-- 
2.17.1

