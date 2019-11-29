Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B31217BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOYbbdG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfK2OFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:05:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53278 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfK2OFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:05:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so14313076wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 06:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iPGXcngV7gc8XOhdKzAAwDcDJ65rcOda9DJ67kLXj4k=;
        b=cOYbbdG1IlRBWl2RJ0R8oige9Y+cIW9lbyUGtDErNupd+VWfdoeeQnlPAa/Ksg5TJl
         NRFd/VcHwUFD9B59CKzW7HF7G+f8KXBsgw/FzUNheIlNwa8SM/Lmzpve/nTJ4VSDs61v
         /LhfUSy30og1Fgssip616rTKzqv5nxFFo0iWnKemwGuqknMTwYiBhZtfbEoAlBZD/iuc
         vNH7lrUqpn4wSVjQA3obtwBMh0kqrJg5ByWb5/VOiqgFmNUmgP4JMGzAeXMef47ZGsfS
         HRCiEqQXpggkzqFiuoYL/RgZHgwDPz1IGeYNz+hXxMpLX0JX+1DwBF1OsHegD2wjtO83
         AT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iPGXcngV7gc8XOhdKzAAwDcDJ65rcOda9DJ67kLXj4k=;
        b=G62Fhwp5xRDyvHw3MwKcirdX2b/CYmJLGkiq67ATKaBszfwr6zOAh+mtqymUek77R9
         xx4TEEV5efwUKsnl3ciLN6cE/jd4Q1X1SR6/rPb/8cbeq1VDEzXsCV3IeIighSe2Ej1w
         z8iYnREgXZc4mVgeX9QL16le05vGGD208egA3+1U5xzqrQcicf26cfPt+o5H/AsQGuO9
         p41BQ/j679lbeJBcb5qI/7NAIOGJtle5RlCaiZ5IBVdJr1B8v2+xPGzdjEagY3q80tYs
         wgOzHTa3ld2oQfSR9epd/tNSLuFySlUBGrnhByJtZYl6xCYoS/0NbNt/UH6v6je5GPvz
         zX8A==
X-Gm-Message-State: APjAAAUDb5mXFktQ+wvLPsFVR5vpXWm/PmKq+WXJteNgSMxsXi/UBisv
        jNbQQk9dbg0j8q+nOtsYnRsPZQ==
X-Google-Smtp-Source: APXvYqzisM4NdYBySYEo3Oyrfqbq8ztBVcGPXGh1S6vXO3M81mAduCnizeer69MBt4ara4u+3cKzHw==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr14431487wma.177.1575036332011;
        Fri, 29 Nov 2019 06:05:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:7d72:5485:2a04:b211])
        by smtp.gmail.com with ESMTPSA id k20sm12838804wmj.10.2019.11.29.06.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Nov 2019 06:05:29 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/cfs: fix spurious active migration
Date:   Fri, 29 Nov 2019 15:04:47 +0100
Message-Id: <1575036287-6052-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The load balance can fail to find a suitable task during the periodic check
because  the imbalance is smaller than half of the load of the waiting
tasks. This results in the increase of the number of failed load balance,
which can end up to start an active migration. This active migration is
useless because the current running task is not a better choice than the
waiting ones. In fact, the current task was probably not running but
waiting for the CPU during one of the previous attempts and it had already
not been selected.

When load balance fails too many times to migrate a task, we should relax
the contraint on the maximum load of the tasks that can be migrated
similarly to what is done with cache hotness.

Before the rework, load balance used to set the imbalance to the average
load_per_task in order to mitigate such situation. This increased the
likelihood of migrating a task but also of selecting a larger task than
needed while more appropriate ones were in the list.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

I haven't seen any noticable performance changes on the benchmarks that I
usually run but the problem can be easily highlight with a simple test
with 9 always running tasks on 8 cores.

 kernel/sched/fair.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e0d662a..d1b4fa7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7433,7 +7433,14 @@ static int detach_tasks(struct lb_env *env)
 			    load < 16 && !env->sd->nr_balance_failed)
 				goto next;
 
-			if (load/2 > env->imbalance)
+			/*
+			 * Make sure that we don't migrate too much load.
+			 * Nevertheless, let relax the constraint if
+			 * scheduler fails to find a good waiting task to
+			 * migrate.
+			 */
+			if (load/2 > env->imbalance &&
+			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
 				goto next;
 
 			env->imbalance -= load;
-- 
2.7.4

