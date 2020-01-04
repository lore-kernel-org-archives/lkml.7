Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A9CC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC57215A4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 13:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKWwGqo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgADNIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 08:08:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37365 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgADNIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 08:08:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so24772323pfn.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 05:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9K+9ne+JvZSfD/JJqOskWRM73hc7SRmruaTZbiPWDa4=;
        b=TKWwGqo8lLYgXJm8coeBoQVNvhsH/noQX/wlvJIDp1Q1CuTKO0ByXZac4i8qJbV/ZT
         3NctCB1yIZkP+XyJQnJVPmsnTYoQyJ6iA5ze/SwFDrSDpXEkYTJeDdncSecE1jR6GSfg
         C7z6c8rFofQd1TibYChfMhZLuV/4VWCvRXbZcb47qpL/zwMFhU5Ih1nseArG2AaZJ6xn
         3NVurAgEFuv5jHW0deAUC01OdyT2uHURj8hVSXdbw5x5Dkgc7HSmX2GpdrQnVQORgFAU
         KJR60y7lEEq7klKyN2CxmUnIJGtGwF/2yKuQPoGfbB9oAHeHssaFb+hiPc/tZdAVmlj1
         YZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9K+9ne+JvZSfD/JJqOskWRM73hc7SRmruaTZbiPWDa4=;
        b=GdkBmDi8pxGIuLEFe99g8Pt55Qz743M7ceQI/xBqEy5OoWB8pmvb4hZ1CRdj2hUfKf
         1mRtFIrhGL6tDUauzl8xN7JEqOgjODaISFVvg9M1t5JaHmEEgbMwvaWpdtk1vj5W62m/
         JQBwK8yfTJeUs8c8jFgKxB3AYE9PmqF9SLTMP6Z6zkJh/wn8gr/BQMx9n0dBbOsRGUzp
         aOB4QZjbWR8XrpI4KoMlHvFPoTx3jBYA3dmPEcrEE/Jz1vYcF0tkNKRPy7cpT4DBTnRF
         a88sBj93il4yoM3pC39alIbmeY7i0lewJ/DfhUgB4ovBilt5mld4+QRNcbRWf7c3xvSY
         XA/w==
X-Gm-Message-State: APjAAAVhfZKDYF8m3FnsA6pTO2yKnEHMo2XGNowUEE082jniBm1fyMpB
        x+PKHwS3WUymcjFY3mKr+UJotXn6
X-Google-Smtp-Source: APXvYqxPHyllFO9zvfGcWjyuQZFTBBxYh9NP0CZnNAum8eBKNp3NZD+XFMcX3sLCF2x61aXr3xvC4A==
X-Received: by 2002:a63:338e:: with SMTP id z136mr102439344pgz.60.1578143313395;
        Sat, 04 Jan 2020 05:08:33 -0800 (PST)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id z13sm18468568pjz.15.2020.01.04.05.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jan 2020 05:08:32 -0800 (PST)
Date:   Sat, 4 Jan 2020 21:08:28 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        qais.yousef@arm.com, morten.rasmussen@arm.com,
        valentin.schneider@arm.com
Subject: [PATCH v2] sched/fair: fix sgc->{min,max}_capacity miscalculate
Message-ID: <20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
sched_group_capacity") introduced per-cpu min_capacity.

commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
introduced per-cpu max_capacity.

Here, capacity is the accumulated sum of (maybe) many CPUs' capacity.
Compare with capacity to get {min,max}_capacity makes no sense. Instead,
we should compare one by one in each iteration to get
sgc->{min,max}_capacity of the group.

Also, the only CPU in rq->sd->groups should be rq's CPU. Thus,
capacity_of(cpu_of(rq)) should be equal to rq->sd->groups->sgc->capacity.
Code can be simplified by removing the if/else.

Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
---
v1: https://lkml.org/lkml/2019/12/30/502

 kernel/sched/fair.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d170b5da0e3..e14698a8ee38 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7793,29 +7793,11 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 		 */
 
 		for_each_cpu(cpu, sched_group_span(sdg)) {
-			struct sched_group_capacity *sgc;
-			struct rq *rq = cpu_rq(cpu);
+			unsigned long cpu_cap = capacity_of(cpu);
 
-			/*
-			 * build_sched_domains() -> init_sched_groups_capacity()
-			 * gets here before we've attached the domains to the
-			 * runqueues.
-			 *
-			 * Use capacity_of(), which is set irrespective of domains
-			 * in update_cpu_capacity().
-			 *
-			 * This avoids capacity from being 0 and
-			 * causing divide-by-zero issues on boot.
-			 */
-			if (unlikely(!rq->sd)) {
-				capacity += capacity_of(cpu);
-			} else {
-				sgc = rq->sd->groups->sgc;
-				capacity += sgc->capacity;
-			}
-
-			min_capacity = min(capacity, min_capacity);
-			max_capacity = max(capacity, max_capacity);
+			min_capacity = min(cpu_cap, min_capacity);
+			max_capacity = max(cpu_cap, max_capacity);
+			capacity += cpu_cap;
 		}
 	} else  {
 		/*
-- 
2.17.1

