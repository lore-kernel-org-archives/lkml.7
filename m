Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E19C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA5D21848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="otw9vtrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbfISHeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:34:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54676 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388671AbfISHeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:34:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so3063087wmp.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AbILMuuDKN55sODbN+TLyTtglr3cL8J1sJ9BIBcXt6A=;
        b=otw9vtrwhhPK8FHKTcBk1J76bXEWX0hh4qd3KHNz4DE/4ogtL5vjwN8cGO7gpWGqns
         m3+31f30t6LakblwZJig06N4cS+FBHSap9q6xCdZto7aJKF3yZmmR1vb8EuScHhUJSjr
         fBYdoTeaqZLSinNRy1KJ8hgTCrTgxIX/3WvqqWvoHXlBVwtcAU5YfRMgOY+uFrubEIIs
         VtdY1+hc6mbIRODCttt/dayg7Nibpiaad1JXUFJgH1Nmfly7s4iMHFU3FoVEbgdWSR+j
         NydRukRgLiPCJXIQ1w4L0YLvRXncbZFS12/YvxdbLNK2B2Iy4vvTPND4CMk4xvhEz2yL
         PlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AbILMuuDKN55sODbN+TLyTtglr3cL8J1sJ9BIBcXt6A=;
        b=ukFhl6jd7V3+AWbFUNGD1QN6JhVdr060sXLpecoKFEut2wnNZs42gTn4hBSrATRRfo
         bNp3cyDmFFP5JBzTdTBe34anQM+kEETVK1v+mNdeLR8wy3t5wSGyWLz+wTEgbJ7Ecvjm
         PjoCcPCaeRGD9WvaVNAt018tC/oDlbYlZ6eTpfmLgMPfm4AUTmHbxRC8XMkg57iL7U6z
         759r2uzEumoEwjwBORmlWqpMvnE8d8oHnfarGNINSvru4eKcyRP0CIf2x6p9m4lIsVl9
         ibBvM6+MnRhNs/PApf6VpOjRb4BffRIXyFe1YDBDdBOsEVH5ceEqU3RLmdJ3mt1/+KJC
         YnOw==
X-Gm-Message-State: APjAAAUhqNsRENy++qZr9NSDxPiz/0Q6V+XPp0JUw/Ziobfe94v0yXX1
        MyYy343wLDP0jMayQd/ybJInDGEPFzQ=
X-Google-Smtp-Source: APXvYqxpPl3g706dHpPjD6Fj7lZifLAC7QISKvUu33MaZ0wHkZzQRJKtvkK64QA7785uZ9fehVzWtg==
X-Received: by 2002:a05:600c:254f:: with SMTP id e15mr1487005wma.163.1568878450982;
        Thu, 19 Sep 2019 00:34:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d555:8fca:a19c:222c])
        by smtp.gmail.com with ESMTPSA id s12sm13300250wra.82.2019.09.19.00.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:34:09 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 08/10] sched/fair: use utilization to select misfit task
Date:   Thu, 19 Sep 2019 09:33:39 +0200
Message-Id: <1568878421-12301-9-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

utilization is used to detect a misfit task but the load is then used to
select the task on the CPU which can lead to select a small task with
high weight instead of the task that triggered the misfit migration.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a7c8ee6..acca869 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7429,14 +7429,8 @@ static int detach_tasks(struct lb_env *env)
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
+			/* This is not a misfit task */
+			if (task_fits_capacity(p, capacity_of(env->src_cpu)))
 				goto next;
 
 			env->imbalance = 0;
-- 
2.7.4

