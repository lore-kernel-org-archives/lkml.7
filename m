Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C8BC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B562467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGj0PFqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLTLE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:04:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55406 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTLE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:04:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so8512599wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 03:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jrgPtumQvg8G9sARo/xUdw47qbx6jZT8hzxCVJ9KrmI=;
        b=RGj0PFqtMVoxJOEUNFSawFkUfgk6IiC5QWCo21/R0XMBSGbUzZyaNsHkIsv4aOecss
         j/a4oaPJvPZeUd8hSrO7U3Uhtp8ZNWiOrcLqyOU96WkuvZwUa3OC0XgWVZqftg9xCe6D
         GuRMu2adfCugqcgge3zBbM7XgpH3aPbCXy8LfhHS2zM8Yh+FkGADJOttKqJdfYp6sROH
         7LU0/G5vl2+YWiKc9NISm3deOBCjsP4tDDNpQ4qeORb7nyD39I/GQDzim/TXVnhzLud+
         ltMnnbVaoiyWL3Tr/BCj+JgIKecoBfKML2crNFICGVyrh+azZ43Q/UKBPvrnpB2X6Gy+
         lb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jrgPtumQvg8G9sARo/xUdw47qbx6jZT8hzxCVJ9KrmI=;
        b=MW7hMvMDzNLaW+JG9/4HTP5j53T1grmPeg4Q+eznNDpE30KRwHG1ok7esPAV0gaYyJ
         56MpYuBZALfYuL4dU8Xfq2rfflvemhmZgRI2kd1ym2Gu5dZpxiVtjZnp/kZkOEE/WR5H
         qPrRi9pYdp1CHjhICIaFubmObDN+iL5oewh6cr8AHjJxG1WAMn56yLhjkl9AIig+Bclr
         Cl+Zonzi8pokBMFqdP2vMJ35Xr0RJM13+By19W6dQAMwIAGzU9wSrLiUjD0r68oNuAZm
         CBCB427kekLNGA5FwBClMMyRmc50cteI3QyNSTJqqKsx0AXL0vUoDBPja2t+lX4JFOIy
         SEaw==
X-Gm-Message-State: APjAAAWDEatoAK3fPAfsMwDAMeeNwdd5UYa8PPAlY6GUXvkJtkVbyroP
        Y1GBB85mpzFJpmy0kdxQentnWg==
X-Google-Smtp-Source: APXvYqyd0ux1nfSO/aOasv+m3NL53CfTIqiVT7cADq5ENukcO1YNSItj/M5OEWebPQnBhBqwaTo0tg==
X-Received: by 2002:a1c:16:: with SMTP id 22mr16108904wma.8.1576839896862;
        Fri, 20 Dec 2019 03:04:56 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:717a:3ce9:a90a:85a])
        by smtp.gmail.com with ESMTPSA id 5sm9962489wrh.5.2019.12.20.03.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Dec 2019 03:04:55 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair : Improve update_sd_pick_busiest for spare capacity case
Date:   Fri, 20 Dec 2019 12:04:53 +0100
Message-Id: <1576839893-26930-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to calculate_imbalance() and find_busiest_group(), using the
number of idle CPUs when there is only 1 CPU in the group is not efficient
because we can't make a difference between a CPU running 1 task and a CPU
running dozens of small tasks competing for the same CPU but not enough
to overload it. More generally speaking, we should use the number of
running tasks when there is the same number of idle CPUs in a group instead
of blindly select the 1st one.

When the groups have spare capacity and the same number of idle CPUs, we
compare the number of running tasks to select the busiest group.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 280d54ccb4be..808bba8c9f6d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8162,14 +8162,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 
 	case group_has_spare:
 		/*
-		 * Select not overloaded group with lowest number of
-		 * idle cpus. We could also compare the spare capacity
-		 * which is more stable but it can end up that the
-		 * group has less spare capacity but finally more idle
+		 * Select not overloaded group with lowest number of idle cpus
+		 * and highest number of running tasks. We could also compare
+		 * the spare capacity which is more stable but it can end up
+		 * that the group has less spare capacity but finally more idle
 		 * CPUs which means less opportunity to pull tasks.
 		 */
-		if (sgs->idle_cpus >= busiest->idle_cpus)
+		if (sgs->idle_cpus > busiest->idle_cpus)
 			return false;
+		else if ((sgs->idle_cpus == busiest->idle_cpus) &&
+			 (sgs->sum_nr_running <= busiest->sum_nr_running))
+			return false;
+
 		break;
 	}
 
-- 
2.7.4

