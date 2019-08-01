Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19041C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89B120B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZLgdaUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbfHAOko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:40:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35868 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbfHAOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:40:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so59336669wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M2NFLK/zY34Il3CN9ocOI5d4GwkmGixwcSg2zvyFkdU=;
        b=AZLgdaUgvzf281Lh9Me9GLJ9HM7ksZx0exWcc3M06YCjvkJgxQRL0eNp8iIJt3CFPg
         S5lnCeMYzoTmQgu/M5iH0Op2fF5cGGbwjRVWRNO97eSbNfsIM8GtoqBsIA4rpn5TIU+K
         RpLbzpKHuFN9Su18XVPbbnIfrEBdIdYtxWZuivhFIEDq7R+CX7DmWtuhgIEGCa9P8+sR
         rYSTPPgOHupwuISVf/+DW5sByd2gxlrwIK30r6pEkaVdwT25cADrM4jhTbOBMZEtA0ld
         QntChvNFNwHb4wG5xR0osfqq0iPdfvFpgm02ozjN/pOwLVAZeIfTfXkKrx1DVbUS6JgR
         ntnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M2NFLK/zY34Il3CN9ocOI5d4GwkmGixwcSg2zvyFkdU=;
        b=lHjarZNUgHUeFKf/6/dKqu+BotkTh26v3VqcFRpiQolOIzueMDSVdjIA9a7uKAKFer
         gwvQitFlQYspvpMX7pJ8/t2B7RbqLSHJuOkOU4Y6f4GsCOkEdE/GtijYBqiyjj7T1QEw
         NCpwy6ulEYodL4JWISJ20Iq3mnThCaJIVkHLWBdFHdtgowEth8MBqyXy8LKOaOZ9a0v0
         lf2WYcBSDGTgoeC61pTJ0R4IWIFjGFJYYYrNM5gxui1bh28Uhrqwu/NMYKcUWKAPdAMS
         qMY5UzyV+/4XiO1sE1UNO5sG7JwHtzD8yCrsCRaQrSmRtulVtWnuzQ/xey0btlYpgnQP
         r7jA==
X-Gm-Message-State: APjAAAVV9oC7OHi1Tfyr1RSvye4JyafP+gy4f5kZQqgZH+OMMGxtHkF+
        11V0v1vkHqhM6ozIAqmDBE/bzdzz4N0=
X-Google-Smtp-Source: APXvYqxm90W8Ae+lIkkVhlV58c7HqZW27dzWVYq1IqJ6PBXtZLyecjiX4J4YEBarx5AsjE9kz7RNng==
X-Received: by 2002:a7b:c398:: with SMTP id s24mr118537283wmj.53.1564670437791;
        Thu, 01 Aug 2019 07:40:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9865:5ad1:5ff3:80c])
        by smtp.gmail.com with ESMTPSA id y10sm58768873wmj.2.2019.08.01.07.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 07:40:37 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 7/8] sched/fair: evenly spread tasks when not overloaded
Date:   Thu,  1 Aug 2019 16:40:23 +0200
Message-Id: <1564670424-26023-8-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is only 1 cpu per group, using the idle cpus to evenly spread
tasks doesn't make sense and nr_running is a better metrics.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dfaf0b8..53e64a7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8654,18 +8654,34 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
 
-	if (busiest->group_type != group_overloaded &&
-	     (env->idle == CPU_NOT_IDLE ||
-	      local->idle_cpus <= (busiest->idle_cpus + 1)))
-		/*
-		 * If the busiest group is not overloaded
-		 * and there is no imbalance between this and busiest group
-		 * wrt idle CPUs, it is balanced. The imbalance
-		 * becomes significant if the diff is greater than 1 otherwise
-		 * we might end up to just move the imbalance on another
-		 * group.
-		 */
-		goto out_balanced;
+	if (busiest->group_type != group_overloaded) {
+		if (env->idle == CPU_NOT_IDLE)
+			/*
+			 * If the busiest group is not overloaded (and as a
+			 * result the local one too) but this cpu is already
+			 * busy, let another idle cpu try to pull task.
+			 */
+			goto out_balanced;
+
+		if (busiest->group_weight > 1 &&
+		    local->idle_cpus <= (busiest->idle_cpus + 1))
+			/*
+			 * If the busiest group is not overloaded
+			 * and there is no imbalance between this and busiest
+			 * group wrt idle CPUs, it is balanced. The imbalance
+			 * becomes significant if the diff is greater than 1
+			 * otherwise we might end up to just move the imbalance
+			 * on another group. Of course this applies only if
+			 * there is more than 1 CPU per group.
+			 */
+			goto out_balanced;
+
+		if (busiest->sum_h_nr_running == 1)
+			/*
+			 * busiest doesn't have any tasks waiting to run
+			 */
+			goto out_balanced;
+	}
 
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
-- 
2.7.4

