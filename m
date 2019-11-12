Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08253C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF5921D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMb39mxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKLOu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:50:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56279 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKLOuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:50:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so3478302wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CSSsI2E/AiwCeLu7wa0R7LPkJ/eK9242R5fWGg+wk0I=;
        b=dMb39mxspTbdHC4iFApss1EWXM5N+rSxaMEFfB0mfptxqMKhBSWTiKhtpPV/xxGgzp
         /uDBQGXfaz8Z17Jsp7jVFk6bMrbwRIArta6tYmD9cHRRtLMaMYBY+Wy8Ox7BO+zL4+0S
         NNVUPBfzg/2D4OFEIN2dGxAqQUYA9VjlOiegFAVn2X8UIR+d1NpGgt9b4wh5Dx0gulK4
         O2X24QLpD8k7W/Jn0BI5e+PUul9dKvXk/RBIbklw3bpMomi31HmUeBMRf+XywseWfiXO
         xGrCtLrF4DoQ/ER9pABDr8yZMW+yz7KzfZkW5MJZdWFcURnhfxTKQmNNQit4pkhaXOEN
         jAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CSSsI2E/AiwCeLu7wa0R7LPkJ/eK9242R5fWGg+wk0I=;
        b=JeQNTcRCCLwFzG6bJP0QGu+lPKZexNSBXmjbqRIjwW/omE77uGvCTE8DV4zUk3BOtP
         ekBJiM0FjH683X/UrUk7d62/EzVu+vyz8xKbcNs4v/h3eNyfLvXrMkVuu4BHYY5+niIr
         xpgz1DJoGYlrJbGr/7NaToJC5Rqwx4vc5s17sK2ianbiaS2Ry1NZ26hSczfGzqbsajTD
         jAbuyWWe2TG5MP6//mDKslZ+JWHSmC493omOBjTHOmanbJrAhRkF49jzXAOw8+mQWPvh
         S9EyAsMZALu1T6cYV4LvhGRYI5BbChaTxWU64lSEpZYyS1emIwey9DNEULzexrAAbZxq
         RTUA==
X-Gm-Message-State: APjAAAX3it2nIA4jTRzNfWvTXXeeX9cU9KZYfeyrdKMGl2XuTGaBdeAZ
        CFFRIMduRILes/2BqZDMcSWExMkBIiU=
X-Google-Smtp-Source: APXvYqwxLo5cnbZ6l/zzgDmaXQOjefKtsf7NlOWb12xxeXd72R4Q2gVADX/cUbJqQB6JUZPwCDXkxg==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr4211360wmi.16.1573570253239;
        Tue, 12 Nov 2019 06:50:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e45f:4180:5590:a312])
        by smtp.gmail.com with ESMTPSA id x26sm3224976wmc.14.2019.11.12.06.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 06:50:52 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de
Cc:     bsegall@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: add comments for group_type and balancing at SD_NUMA level
Date:   Tue, 12 Nov 2019 15:50:43 +0100
Message-Id: <1573570243-1903-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments to describe each state of goup_type and to add some details
about the load balance at NUMA level.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c93d534..268e441 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6986,11 +6986,34 @@ enum fbq_type { regular, remote, all };
  * group. see update_sd_pick_busiest().
  */
 enum group_type {
+	/*
+	 * The group has spare capacity that can be used to process more work.
+	 */
 	group_has_spare = 0,
+	/*
+	 * The group is fully used and the tasks don't compete for more CPU
+	 * cycles. Nevetheless, some tasks might wait before running.
+	 */
 	group_fully_busy,
+	/*
+	 * One task doesn't fit with CPU's capacity and must be migrated on a
+	 * more powerful CPU.
+	 */
 	group_misfit_task,
+	/*
+	 * One local CPU with higher capacity is available and task should be
+	 * migrated on it instead on current CPU.
+	 */
 	group_asym_packing,
+	/*
+	 * The tasks affinity prevents the scheduler to balance the load across
+	 * the system.
+	 */
 	group_imbalanced,
+	/*
+	 * The CPU is overloaded and can't provide expected CPU cycles to all
+	 * tasks.
+	 */
 	group_overloaded
 };
 
@@ -8608,7 +8631,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 	/*
 	 * Try to use spare capacity of local group without overloading it or
-	 * emptying busiest
+	 * emptying busiest.
+	 * XXX Spreading tasks across numa nodes is not always the best policy
+	 * and special cares should be taken for SD_NUMA domain level before
+	 * spreading the tasks. For now, load_balance() fully relies on
+	 * NUMA_BALANCING and fbq_classify_group/rq to overide the decision.
 	 */
 	if (local->group_type == group_has_spare) {
 		if (busiest->group_type > group_fully_busy) {
-- 
2.7.4

