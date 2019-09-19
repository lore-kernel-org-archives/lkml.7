Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8911C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9A521848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Msd7C7Yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbfISHeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:34:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45539 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388627AbfISHeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:34:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so1880273wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kRzPPO6auHhE/DujuF4oxr11CuUWI/AICc91av/Y9I8=;
        b=Msd7C7YgcknAK6Jfv3VHjT2ctWoJqZl8q7RbneMRKIIwnsAlECkOyIaISFN18R2H4p
         Z06DTe5L0CaYseMfh8g1bEgjBTXHlxi5Aij3602uqqrk8IUILjtF/8Mipe9d8aDN7OIq
         zYeg3bdV7llUY8F3uFIxCaPy6WUAI7PKxkeFx+BMJeaXciBd6Hi3AAon5ILdmycMiXHO
         aTpN1fz8r6gA128dMW3z1xDtKTztiu90PC7ze+dzmwn3OLIExhbfZxK+hdIwD0Plrh2s
         a0+ckgV0vOMkT13GBBxADDSC4w0EBQQeSWyKumJMJmGMtI5gt+c5TuD2a9xQr/Gp2lp/
         kiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kRzPPO6auHhE/DujuF4oxr11CuUWI/AICc91av/Y9I8=;
        b=j10nI44eflN3IpECOYjdJz5VKnynma9qG5Nju4YMaiwSB0oSNCNVRa1+8yuPjzqSYg
         VCgNw84aOYagQUKPXwYwjlrbE58jlMhLsX9/UwpKNkA2T/F5WcPEtmXjbWVO4zSV6WbN
         ItpvFv6BoHsc/Fu7WpKaQGfzrSzOrmJN/JDLkogoJlMC9ZlaskqOzON2H8D8MhNK0bqc
         YtG0vZ5jUMyZ3egEMpy3oWNRVhQKLIaXScv3X9/PdhQhxT5YY52claVSnvbjQm2lIs/S
         aOmQkVUoFynHNpPh297VsfMzNfoB8Wfrhuh1aYlnzZorG8JmTFSma36qyQ6owFommlJX
         7NaQ==
X-Gm-Message-State: APjAAAVt1oH0IIpguKlcvvytgmiF2kX37HeZao3t00EsCXGY8I85UOVc
        yygjhHyIhbemBYpVw4k0uKPi9NBSsgY=
X-Google-Smtp-Source: APXvYqwm2CFMUgxGcgidLBfHnFMj9RbnmEpTVsZ25GGimzlOUbCfY+7xsOjfhNBt6qk8LfQl5BLTLA==
X-Received: by 2002:adf:f008:: with SMTP id j8mr6400595wro.75.1568878445082;
        Thu, 19 Sep 2019 00:34:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d555:8fca:a19c:222c])
        by smtp.gmail.com with ESMTPSA id s12sm13300250wra.82.2019.09.19.00.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:34:03 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 05/10] sched/fair: use rq->nr_running when balancing load
Date:   Thu, 19 Sep 2019 09:33:36 +0200
Message-Id: <1568878421-12301-6-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfs load_balance only takes care of CFS tasks whereas CPUs can be used by
other scheduling class. Typically, a CFS task preempted by a RT or deadline
task will not get a chance to be pulled on another CPU because the
load_balance doesn't take into account tasks from other classes.
Add sum of nr_running in the statistics and use it to detect such
situation.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d33379c..7e74836 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7716,6 +7716,7 @@ struct sg_lb_stats {
 	unsigned long group_load; /* Total load over the CPUs of the group */
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
+	unsigned int sum_nr_running; /* Nr of tasks running in the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
@@ -7949,7 +7950,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_h_nr_running < sgs->group_weight)
+	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
@@ -7970,7 +7971,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_h_nr_running <= sgs->group_weight)
+	if (sgs->sum_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
@@ -8074,6 +8075,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
+		sgs->sum_nr_running += nr_running;
+
 		if (nr_running > 1)
 			*sg_status |= SG_OVERLOAD;
 
@@ -8423,7 +8426,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * groups.
 			 */
 			env->balance_type = migrate_task;
-			env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
+			env->imbalance = (busiest->sum_nr_running - local->sum_nr_running) >> 1;
 			return;
 		}
 
@@ -8585,7 +8588,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 
 	/* Try to move all excess tasks to child's sibling domain */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
-	    busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
+	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded &&
-- 
2.7.4

