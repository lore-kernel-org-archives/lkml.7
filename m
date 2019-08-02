Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3905BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3F32064A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBpDVFZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390621AbfHBM4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:56:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56083 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390382AbfHBM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:56:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so67867512wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yjEMe5wuk6zRJXQKT5fhkZ+36XC9uZHCWgmdHyE58XY=;
        b=OBpDVFZIBBIkpNcqE4jGwaWXitaI6CuguZip4iFoAXWKm8LSDhYbAE2Tm8Nm5hOu6L
         n6+Bj0rHVMZID2sbxyEjT06dzgqarhID7D5J4TgPbZnrR4nLHu85F3T6erUeUBYxWem8
         KuR1vdqRSZL0Gcp5K/CRMXc08PUyBFewGyU2a6QjSrX4UN1wDbgskMuq9ZGCAJRO2OCb
         7mG0uTSaTgH6rrMb8aEJFxBUZT44+m2tMxAjau92B2RwttZFGM2Hej5S6Ilb8QtoN2r4
         XYr3ftU3MdtxrjNUnRv6bXNEddH/aH5QCL3D8x0DyiIaN+rbrwotL4yoHzK5FNpUZEj1
         v+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yjEMe5wuk6zRJXQKT5fhkZ+36XC9uZHCWgmdHyE58XY=;
        b=QzxfZe3JjluSIOXU1usct+ixYTLFeF5uitlk9IXTRuNhsVF0qNciHE6AS8gVEWCi9+
         UhG6NunviSOO3qkDoqWiBYPyXa6PzIxKPudV4CrrMVRl2RsiUsr8WR2BbC93AT3VobjG
         h1AGTq1O7dwgBiEXM6K1EqymHJCgMLyE0FfkfTA+aKtM02p4Zw4cDLnyXa5mvxniQKjJ
         QjUJOH/mH+hzK3CxaHm1RaSOKcCSayiFpGMW3FwxDQMDMojNH+DNtc4YnmSQrOtcbaou
         bA131ixGH0ogxkREqok6XRo82j/cMs4SdPKai6FyRupsp5CTsef4V8sPSJTwNxIZL56T
         FCrA==
X-Gm-Message-State: APjAAAWVTc/d25EfN3/I9sIj4HkX2cOAqh8mwp6sf9kt24ZYzBF0gOyb
        gRk6P9YW3TUdpNd5LDDv4RZ8v/TO5wg=
X-Google-Smtp-Source: APXvYqyxJYBXSeg7k/KW2FWFciZ8HrfRdGOIn8Juel+e3FPcNzJpzc0sn9K7d6Pj7Awoh+u+XFLLTQ==
X-Received: by 2002:a1c:3:: with SMTP id 3mr4569287wma.6.1564750575947;
        Fri, 02 Aug 2019 05:56:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:dfa:cc47:b267:2a71])
        by smtp.gmail.com with ESMTPSA id i6sm69543930wrv.47.2019.08.02.05.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Aug 2019 05:56:15 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3] sched/fair: use utilization to select misfit task
Date:   Fri,  2 Aug 2019 14:56:12 +0200
Message-Id: <1564750572-20251-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564670424-26023-9-git-send-email-vincent.guittot@linaro.org>
References: <1564670424-26023-9-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

utilization is used to detect a misfit task but the load is then used to
select the task on the CPU which can lead to select a small task with
high weight instead of the task that triggered the misfit migration.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
Keep tracking load instead of utilization but check that 
task doesn't fit CPU's capacity when selecting the task to detach as
suggested by Valentin 

 kernel/sched/fair.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 53e64a7..8496118 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7487,15 +7487,9 @@ static int detach_tasks(struct lb_env *env)
 			break;
 
 		case migrate_misfit:
-			load = task_h_load(p);
-
-			/*
-			 * utilization of misfit task might decrease a bit
-			 * since it has been recorded. Be conservative in the
-			 * condition.
-			 */
-			if (load < env->imbalance)
-				goto next;
+			/* This is not a misfit task */
+                       if (task_fits_capacity(p, capacity_of(env->src_cpu)))
+			       goto next;
 
 			env->imbalance = 0;
 			break;
-- 
2.7.4

