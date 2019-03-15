Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B6EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAABF21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYclonLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfCOHcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:32:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33290 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfCOHcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:32:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id i7so2617202pgq.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NSI5SnPu960lYYcGK1Kzyn54+GVGEVj7oVhYWXLgvaM=;
        b=YYclonLBmRnTDp8eKBtr0A4ujNy37uVhx8u5LGfgL6OUK8WIuSntzWJjsRDRxORaDA
         NS9F1f+JiJQR1vOur8AWYNO6yldn+3nCmcYBhJpvRpcXybqyoY+AOOjVSK7gU9tWWt6o
         P7T9Rd5qVGvAgvzvscvq+hZcGes2YQhQdibdVlh/bT2KQgj4KxuWN+Lh3RacEYCKA8U6
         IaUMSbUwH2NifmeoAYYJsPn5DpSh3W130P6G7zcjlgiGHU7juhdImC2SBSz97wTjcnYS
         aPY0QA+PizPkeyGG3PA372nOA5sRv1MiFEmcSV5GpsJcmvnmqzvhyfHkrZOBrTXYKqOC
         nE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NSI5SnPu960lYYcGK1Kzyn54+GVGEVj7oVhYWXLgvaM=;
        b=bY5wU+fjht3KMbRxW7SN3FoHs29QUGsOR8nXl9zzV3r/zGb32E6WfAPFZNKCPt6OS4
         D+e1O5nXprXDDscsTrnvo7u90HmolPOGVvYlQDd04svoqtkfBsF772w+0qhzDEdrDUGq
         yZZbzizgCjVoSyPUFVpRX8EhoKPhX/U/jDWZNYN4yJWf8jsTGXv7WdQq3u1ULmoy8oSF
         AToAzulgR17Y5An/PK3CiD6nNDP76DCa/h4d9giv5ROc3TVb+OHL58ZMvFPx3t9Crl5a
         E5KaTN4HK+flGaHvBp/Kx1ZFUVvnd4Yybo+NeIyD/UFmIioNBuU8wCDHepQ72gao+hUW
         yMSw==
X-Gm-Message-State: APjAAAUyWk/Xdl2BqsCokVDQK5fui45L4T8Rkwqwih/NYapLN7IM0Mp/
        7ezWggJBzrqfywLBISstHlE=
X-Google-Smtp-Source: APXvYqw99QtXSEgkNoQx1y096Hmasoar1Hftfyh2wfnUBa66c6FZPA3gCCcvEidcqm+yUKpZfju7nQ==
X-Received: by 2002:a63:4142:: with SMTP id o63mr1977446pga.81.1552635126985;
        Fri, 15 Mar 2019 00:32:06 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m13sm2023766pff.175.2019.03.15.00.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 00:32:05 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] sched: fair: fix error statement in check_schedstat_required()
Date:   Fri, 15 Mar 2019 15:31:45 +0800
Message-Id: <1552635105-23484-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_stat_runtime doesn't require CONFIG_SCHEDSTATS currently,
not to mention kernel parameter schedstats=enable or
kernel.sched_schedstats=1.

I think that is okay for sched_stat_runtime, because the information
reported in sched_stat_runtime isn't related with CONFIG_SCHEDSTATS.
So I remove the statement about sched_stat_runtime in
check_schedstat_required().

Some other minor changes in this patch,
- stat_wait is missed in the print log before.
- CONFIG_SCHEDSTATS is unnecessary as schedstat_enabled() is used.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8213ff6..dc0d7ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3831,7 +3831,6 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static inline void check_schedstat_required(void)
 {
-#ifdef CONFIG_SCHEDSTATS
 	if (schedstat_enabled())
 		return;
 
@@ -3839,14 +3838,12 @@ static inline void check_schedstat_required(void)
 	if (trace_sched_stat_wait_enabled()    ||
 			trace_sched_stat_sleep_enabled()   ||
 			trace_sched_stat_iowait_enabled()  ||
-			trace_sched_stat_blocked_enabled() ||
-			trace_sched_stat_runtime_enabled())  {
+			trace_sched_stat_blocked_enabled()) {
 		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, "
-			     "stat_blocked and stat_runtime require the "
+			     "stat_blocked and stat_wait require the "
 			     "kernel parameter schedstats=enable or "
 			     "kernel.sched_schedstats=1\n");
 	}
-#endif
 }
 
 
-- 
1.8.3.1

