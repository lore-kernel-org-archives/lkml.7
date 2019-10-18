Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E018ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D9F222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjJZTlYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634100AbfJRN1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:27:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45104 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410324AbfJRN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:27:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so1296910wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+8jnwsi/OmvMHtm1PwUS69bLbdlbxHcNftrW5yRwhLg=;
        b=FjJZTlYA8PpPgWv6KZYWHaxO2XAZZBU9r+ZOPZQwTUDI0H8meXrJbKqMRqJpbPJ1VI
         iZcv2qeW2BZ4CM3PAxjJUZSdAQnB2vrBsZZsqiAeqCOFvDDLe5aKyhxztqq0WGmaV7Ki
         F1/solils4dofYwDL1hPx5ZcpkayypL3pbIBN2bJhqV3sn9rlHxyBERi8i27egDPh25y
         d0V54tpUCmEeafhIzyX025Xpb/vvRzFMsYWgs5mDo02hfJXjUR1mGo963Qz5zFVp143U
         2XZguQgVtZZUWRUemHyMQs1EyHMN4aq080amxvz42hv017cexxLGEt71iKZdTvAaec1c
         OXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+8jnwsi/OmvMHtm1PwUS69bLbdlbxHcNftrW5yRwhLg=;
        b=jymF2IL14LatddNJKQ4krIoEoksE7e/5tUNG28Sswzh/15xoNQq8jyOWB7mom/P/D7
         Owl2TJziWUfl3lWyzJFJIlXwvBnu+F1hIx7OgoWF90x1BUQ/ZU+MmrM6n13sOWyu0tKU
         brL2h5F626i9Aqaqftr1ZvwHNHnxYQAsp9Ot0s1UcTUXvAmEwkM1KfH9SDJ5y+QI3dm5
         qlUp0qiFtNrvOAAOp30MO3OBeR24UvSmGAQAdf5eXLc35rjd/TXe69+HVGuzcU2tpVhn
         RPQsx3gNLLdX/r1gvEZbbzXnqduf0j/xWexMWWbnqJrD8/3HsKxs7hIT5w7tikTSE6+4
         OA0A==
X-Gm-Message-State: APjAAAWvaxSoB5GmpLKEDktyak4EN5Bkf/X36POe8iIMqezEPbDdIlka
        7d8viuKlMA+p84l86MbcxGnsv+Rs/hY=
X-Google-Smtp-Source: APXvYqxXrrHIdDh0Icvrbb1WQr8q7oQe2P8dJ9X/UyhDatG+2U7ol/SbKASbzKkwAk5mtb9z1VXMkg==
X-Received: by 2002:a5d:408f:: with SMTP id o15mr7115548wrp.139.1571405218501;
        Fri, 18 Oct 2019 06:26:58 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:26:57 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 08/11] sched/fair: use utilization to select misfit task
Date:   Fri, 18 Oct 2019 15:26:35 +0200
Message-Id: <1571405198-27570-9-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

utilization is used to detect a misfit task but the load is then used to
select the task on the CPU which can lead to select a small task with
high weight instead of the task that triggered the misfit migration.

Check that task can't fit the CPU's capacity when selecting the misfit
task instead of using the load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9b8e20d..670856d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7418,13 +7418,8 @@ static int detach_tasks(struct lb_env *env)
 			break;
 
 		case migrate_misfit:
-			load = task_h_load(p);
-
-			/*
-			 * load of misfit task might decrease a bit since it has
-			 * been recorded. Be conservative in the condition.
-			 */
-			if (load / 2 < env->imbalance)
+			/* This is not a misfit task */
+			if (task_fits_capacity(p, capacity_of(env->src_cpu)))
 				goto next;
 
 			env->imbalance = 0;
@@ -8368,7 +8363,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	if (busiest->group_type == group_misfit_task) {
 		/* Set imbalance to allow misfit task to be balanced. */
 		env->migration_type = migrate_misfit;
-		env->imbalance = busiest->group_misfit_task_load;
+		env->imbalance = 1;
 		return;
 	}
 
-- 
2.7.4

