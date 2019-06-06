Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F238C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794752083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkVnKPIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfFFRVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:21:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40823 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFRVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:21:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so1184753pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yHBg5dE04dtDIltMCPcU1SBSHTz4a6xaAKj9AjlTGWg=;
        b=dkVnKPInjIYUZkmVMG+i5hsGsaWB5UP+LZiFEDcOG7nEpXOeTcZ391s51nL8lZ3VpP
         DBv2voHpc+ivQMjILXgVOa3MmtmYlSHFFXs2RtMz5Kxs4Soisp9RjGQkBsSP+/dHZ6An
         qbOQUUcI/0d5zq6smczBJ08Aauw8AGw6mabBAkuVZ4tjDUk32dVe7QmrHAWnR3coMLvV
         f4DoxfxyxJ0NalMrvTY0OaE0vRsSiycp+JlzrnZ0M/AyTjFlILVo69C3lNjYJSAZC1zx
         p2ly5iZiaZDI6V5zqjR6S8Nm5wihG2qnjlnxkFjoKZwJjfI/asxiEviLnJNxFaBWPCzJ
         cwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=yHBg5dE04dtDIltMCPcU1SBSHTz4a6xaAKj9AjlTGWg=;
        b=th3xPrCLDAr+N7XEShXE0IGpl7ImAAmJ7bajYQ775IZNwrS5QTuei26daIGv9Yo9dy
         AD4IJfCu+WC5qMKeYFxjNrOM31TBvAuQZZbTpBciwhwPvZeWDIxAN6JnKus6jnsmvRFb
         xdPTf5Y1nLJsdGy0Zge6hPnXF6mtW02bVMtIZrdrR6Y/sfHQ8TTz0vmxvLto1at2kyWx
         HX8yDwsF69KgsVWY3tfo5AQZCBMtSs+FLrdOLfL9GVDXbvZrau7RedPxocXn3R7NktTs
         t2sUucYo/RLnOZVU40rIYZmd+VYgr5IT5lwVVk4nyHG6ER62BaKqAoAaVNI2rxrzw5cv
         GwUw==
X-Gm-Message-State: APjAAAVB779cLww0QEti5lpgPSK5Q0jIFJvzf/wOM5wZDm44GR4Hui/i
        H9+CE/kIl7/u1XsZdaXRul8ZUzU196w34Q==
X-Google-Smtp-Source: APXvYqz9FTgOnqAVmD9RgITOH+hgFZ8TEfRDstuuMirabwn9vUhS/xlEhPK5HTsbJbp4dxTnDRcs5Q==
X-Received: by 2002:a17:902:2947:: with SMTP id g65mr50235856plb.115.1559841663354;
        Thu, 06 Jun 2019 10:21:03 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id 137sm4700573pfz.116.2019.06.06.10.21.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 10:21:02 -0700 (PDT)
From:   bsegall@google.com
To:     linux-kernel@vger.kernel.org
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: [PATCH v2] sched/fair: don't push cfs_bandwith slack timers forward
References: <xm26ef47yeyh.fsf@bsegall-linux.svl.corp.google.com>
        <eafe846f-d83c-b2f3-4458-45e3ae6e5823@linux.alibaba.com>
Date:   Thu, 06 Jun 2019 10:21:01 -0700
In-Reply-To: <eafe846f-d83c-b2f3-4458-45e3ae6e5823@linux.alibaba.com> (Xunlei
        Pang's message of "Thu, 6 Jun 2019 22:11:29 +0800")
Message-ID: <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cfs_rq sleeps and returns its quota, we delay for 5ms before
waking any throttled cfs_rqs to coalesce with other cfs_rqs going to
sleep, as this has to be done outside of the rq lock we hold.

The current code waits for 5ms without any sleeps, instead of waiting
for 5ms from the first sleep, which can delay the unthrottle more than
we want. Switch this around so that we can't push this forward forever.

This requires an extra flag rather than using hrtimer_active, since we
need to start a new timer if the current one is in the process of
finishing.

Signed-off-by: Ben Segall <bsegall@google.com>
Reviewed-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 kernel/sched/fair.c  | 7 +++++++
 kernel/sched/sched.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8213ff6e365d..2ead252cfa32 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4729,6 +4729,11 @@ static void start_cfs_slack_bandwidth(struct cfs_bandwidth *cfs_b)
 	if (runtime_refresh_within(cfs_b, min_left))
 		return;
 
+	/* don't push forwards an existing deferred unthrottle */
+	if (cfs_b->slack_started)
+		return;
+	cfs_b->slack_started = true;
+
 	hrtimer_start(&cfs_b->slack_timer,
 			ns_to_ktime(cfs_bandwidth_slack_period),
 			HRTIMER_MODE_REL);
@@ -4782,6 +4787,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 
 	/* confirm we're still not at a refresh boundary */
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
+	cfs_b->slack_started = false;
 	if (cfs_b->distribute_running) {
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
@@ -4920,6 +4926,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->distribute_running = 0;
+	cfs_b->slack_started = false;
 }
 
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index efa686eeff26..60219acda94b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -356,6 +356,7 @@ struct cfs_bandwidth {
 	u64			throttled_time;
 
 	bool                    distribute_running;
+	bool                    slack_started;
 #endif
 };
 
-- 
2.22.0.rc1.257.g3120a18244-goog

