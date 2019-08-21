Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BF8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7402339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hM6Fu3eO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfHUHTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:19:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37332 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHUHTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:19:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id y9so465939pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FkJM4wynvEDjSv55nCBZjxZ4nfbYdG1xhCESPelPXrk=;
        b=hM6Fu3eOmJeUS1mp0d4iT6KPQSLfJ+L7oIbJsslSxagYxGKpr36rd69/lVTqnxI9rO
         b6hoHTAFneJvayjHovCtsWYQSEVSsSnXXWUJyndRD9yZX2+CKUlVevWrBiA7G5ZQWyyC
         rrQF+5Tn6xuWxO5UnDOKhVxpj30H8OmfRzWTRsxwhRgWEFIN2RYwMW+WweKLQIkcnkBg
         skg/uz93tToSllHxbVwMOd65q6M5IcfSeJwl+/bI10SG+YEB8i+AwoOmkHaVgszlxwbY
         m+gyC+FukcjvK9oweW027gtIlXojJap/Sp7uK1gtmeWOScVZB2iCYx0bG/C8Aeey+RWd
         +bPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FkJM4wynvEDjSv55nCBZjxZ4nfbYdG1xhCESPelPXrk=;
        b=RATEmDeLnDEzBRxcy2XnTU+qp8HnoEQJIP3bP9P2YrZcLlyRD2MnnIvKQFNoWgJi2+
         FouBby2kDF74vjuICzLxXW7l5Y/CViEi/rA99/CwWu4ssKrp9iektiMmTSKYaeB0YWgg
         8j1x2Aruipvszy4irljnxCFdHGTnGGxhcdatUPKlOhxTG1pwQue/LixCJLsY/82J6tgF
         IYW+XysSgTqB0eC3IYAFdfa6tSdrIwJHQs5yxGNhVkTDfFPE0+yrDFPQ0DGT9YNnqdgO
         JSo3oYGDfkrC4vwXQJW+4TebsjqJLSJ5x0RLtHpLDVnOHPb1GsH7AyLk0atvzhA1zKH0
         hpqw==
X-Gm-Message-State: APjAAAUGma8dAgqvH/XMICDnn7iqzw+UeC6Woeml6da4aulJ/pN+BqEe
        E0GSjzrnWkE2CdLvjPzJtkQWNQ==
X-Google-Smtp-Source: APXvYqwEDvoUFruZ1cI1w/uLuzMrxsWLTz4u2DEjZqDcUmjoaXpVVub1eWJBySBR+TlXPSZger0yVA==
X-Received: by 2002:a17:90a:8c01:: with SMTP id a1mr3739474pjo.82.1566371979240;
        Wed, 21 Aug 2019 00:19:39 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j1sm20816512pgl.12.2019.08.21.00.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 00:19:38 -0700 (PDT)
Date:   Wed, 21 Aug 2019 00:19:37 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>, Edward Chron <echron@arista.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] mm/oom: Add oom_score_adj value to oom Killed process
 message
In-Reply-To: <20190821064732.GW3111@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1908210017320.177871@chino.kir.corp.google.com>
References: <20190821001445.32114-1-echron@arista.com> <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com> <20190821064732.GW3111@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019, Michal Hocko wrote:

> > vm.oom_dump_tasks is pretty useful, however, so it's curious why you 
> > haven't left it enabled :/
> 
> Because it generates a lot of output potentially. Think of a workload
> with too many tasks which is not uncommon.

Probably better to always print all the info for the victim so we don't 
need to duplicate everything between dump_tasks() and dump_oom_summary().

Edward, how about this?

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -420,11 +420,17 @@ static int dump_task(struct task_struct *p, void *arg)
  * State information includes task's pid, uid, tgid, vm size, rss,
  * pgtables_bytes, swapents, oom_score_adj value, and name.
  */
-static void dump_tasks(struct oom_control *oc)
+static void dump_tasks(struct oom_control *oc, struct task_struct *victim)
 {
 	pr_info("Tasks state (memory values in pages):\n");
 	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
 
+	/* If vm.oom_dump_tasks is disabled, only show the victim */
+	if (!sysctl_oom_dump_tasks) {
+		dump_task(victim, oc);
+		return;
+	}
+
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
 	else {
@@ -465,8 +471,8 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 		if (is_dump_unreclaim_slabs())
 			dump_unreclaimable_slab();
 	}
-	if (sysctl_oom_dump_tasks)
-		dump_tasks(oc);
+	if (p || sysctl_oom_dump_tasks)
+		dump_tasks(oc, p);
 	if (p)
 		dump_oom_summary(oc, p);
 }
