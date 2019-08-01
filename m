Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2375C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A594720B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMIm5VPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfHAOkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:40:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52150 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbfHAOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:40:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so64928332wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Tr0FeXYuU+2BdbrnzBKZV4E7SBNB4cbQUdji9DRqbE=;
        b=HMIm5VPVV34dLGcnEoG7EDIQlYC759qvLHdEdnrHgI7cBq5WMZR46TTTH2LudCymbg
         1nGIvARcNHsvj2UB9YLVVqsSU4xrPChyhBCZJiwKEkvq2qfgNibLUJE+Ybh2UVf/Q5KF
         RJRcPnscShKzc4U48e1+BlvK6XYAZ3IVcMHAlqPe8EcYdnFkl5pmzlsggAs2s10Cxs0s
         P0/nDWEnVr2Jvl51j/NfKv4lShtlJopRyyZ/4o7Z/UtJXuAbRQLxMfE7i03RP1RwVWaF
         6UfuWi5jFIoHniBjk+OBrk4kSuZl/FhM9BTwvKd8ARRXC+UK15zuv0F22kXZ50nWxlEJ
         uorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Tr0FeXYuU+2BdbrnzBKZV4E7SBNB4cbQUdji9DRqbE=;
        b=AlmXHTqhCXaexBv1dflifJMqzOKq30uRi0YuKdp9ps25pt3sjUQ+O+1nwO3fgFaRrz
         7NK+Xv2dYkmqxlvlupzStMAQi8BNSd727v+mDGdWwkksPVSy8qcZeFvytcvADmqT8Ea2
         +Xu697Dp1pORMdLHFAQyhgVLm5VRUuGzVSYu2kjP04rm+9PVLrZ9ZvIZUmk9gWZ5tCBv
         7PclysVLkhgaINXuEepDPGE3prxwEr08oJsB759RP05VztRHXzUaeE3tUDmhzYEof06N
         G9zNKeKHCeFqh7PlT5az5EkiwANiIFASEZWYMF2nQwwDlDknipxLuz9rxw3hUvDNzUDw
         0m3A==
X-Gm-Message-State: APjAAAUoc3J3O11jMM4qD+F+8epWQXZ9IIHQP/LhFkv3DpU8fWI7IrOV
        WGotPXvm+aVufzFpc9OJ5k6veKiOjxA=
X-Google-Smtp-Source: APXvYqyKRDawA5/D3pQAGOR2AL8ToSi6P/8h57WkzESPxxTmuPXMXwGXg2qcAYPsDoJraHSmbBZP7Q==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr89455332wmi.14.1564670436021;
        Thu, 01 Aug 2019 07:40:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9865:5ad1:5ff3:80c])
        by smtp.gmail.com with ESMTPSA id y10sm58768873wmj.2.2019.08.01.07.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 07:40:35 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 5/8] sched/fair: use rq->nr_running when balancing load
Date:   Thu,  1 Aug 2019 16:40:21 +0200
Message-Id: <1564670424-26023-6-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfs load_balance only takes care of CFS tasks whereas CPUs can be used by
other scheduling class. Typically, a CFS task preempted by a RT or deadline
task will not get a chance to be pulled on another CPU because the
load_balance doesn't take into account tasks from classes.
Add sum of nr_running in the statistics and use it to detect such
situation.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8681c3..f05f1ad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7774,6 +7774,7 @@ struct sg_lb_stats {
 	unsigned long group_load; /* Total load over the CPUs of the group */
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
+	unsigned int sum_nr_running; /* Nr tasks running in the group */
 	unsigned int sum_h_nr_running; /* Nr tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
@@ -8007,7 +8008,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_h_nr_running < sgs->group_weight)
+	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
@@ -8028,7 +8029,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_h_nr_running <= sgs->group_weight)
+	if (sgs->sum_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
@@ -8132,6 +8133,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
+		sgs->sum_nr_running += nr_running;
+
 		if (nr_running > 1)
 			*sg_status |= SG_OVERLOAD;
 
@@ -8480,7 +8483,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * groups.
 			 */
 			env->balance_type = migrate_task;
-			env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
+			env->imbalance = (busiest->sum_nr_running - local->sum_nr_running) >> 1;
 			return;
 		}
 
@@ -8643,7 +8646,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 
 	/* Try to move all excess tasks to child's sibling domain */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
-	    busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
+	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded &&
-- 
2.7.4

