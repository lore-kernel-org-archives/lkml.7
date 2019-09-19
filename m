Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47841C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C9221924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWLPydG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbfISHeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:34:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55679 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388657AbfISHeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:34:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id a6so3048409wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EBLUOB2EXDZsxDF6E6gn9L3xHCrHxfXfVGa48LIRlDY=;
        b=kWLPydG7rKDJilBY5fR43MCB50iZ6fjHCaPSf8iG4jbYCpmgwNMIRGSn1rhTb8MJUV
         HkGHdW4R/uzQo5p9Ru6uWh63KeB0DI3eYbrB+qbp0DBfKVUmzshM23iSPiG5hluIM6VS
         z7ch/Puy6hYlu/tDbjFMhpEgQWLx6Drx3qST/mlredIsROxcFxe3wHZobKujOFiyUhtH
         i9PZOZBLlq1dJyWrlcqAEOL5XTFH0uA56Qm69s0Na8/mxqBTVoFnCf3SJ3QjU2BS2gDd
         n/iu9EDM4ZiB+pjlrQjk6QECQVjbM4dayHr90rriQQmXHw+KeZY8nwXf2rdstTD+viKQ
         DCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EBLUOB2EXDZsxDF6E6gn9L3xHCrHxfXfVGa48LIRlDY=;
        b=hWvsz3olBeC5HwJ5FmB45ceai2jEzLBJwNy/WNqcOzSbLGRSBnLV6aVHLMhvrlB4Ey
         +ZDv7Bhpqq/eVmeK7lRQxpmD2nHlI84s4LSYhXaxVdHsNcdMWGmfP5d5FbKb5eWUVMt3
         IzxxxhOjXOv5VhUuo1nrKfGG579Lka0PnjZkBdfbAfRKWa8vaJ366HyovVfpg1Snuq01
         uAagrE2bRsQZecDQQ4suhgj7RAPDflxYomayfJlvhWB6OtRm/6nCwTTFUOm5Vh7w/Xdh
         BpOLNLhqm9NjjrfwgzeNOqe5SnfkWpg5bdP+e41/jxZMcyTbw0fCh0tD/QblM9AiNDH4
         ADuA==
X-Gm-Message-State: APjAAAUTaaA29t0YTsJeqW/WF7X4AoQ79KmwEPNPJMvtgsiD+0irMdBt
        hDOlS5jqXf+7tnMxK7yIXMdyV+5NV20=
X-Google-Smtp-Source: APXvYqxqk93OeiObuSGILxhlMNDTRJSBIDESOmD3H0ogKBwKipl/bgHhHMgsAndu3vsQHMHY2Mnm7A==
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr1577723wml.52.1568878449259;
        Thu, 19 Sep 2019 00:34:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d555:8fca:a19c:222c])
        by smtp.gmail.com with ESMTPSA id s12sm13300250wra.82.2019.09.19.00.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:34:06 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 07/10] sched/fair: evenly spread tasks when not overloaded
Date:   Thu, 19 Sep 2019 09:33:38 +0200
Message-Id: <1568878421-12301-8-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
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
index 15ec38c..a7c8ee6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8596,18 +8596,34 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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

