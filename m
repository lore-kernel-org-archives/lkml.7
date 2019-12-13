Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FA0C341B3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3515D246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X8T0kfd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLMMN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:13:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48704 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfLMMN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=utMjoxUDezcWxJk4mk8LSviqN/OVWsX79SL4Aqpy8v0=; b=X8T0kfd96r7lIgFHNCTWx+MQq
        74YSXj7t43tq/9BwRPWobFD7JFCl2nifRB1qdaQxatTQf+A7gpA2kBFM6fl1nij6hLTkMsqEVMTNS
        bMEeExUxeGHN5e0SNqlCS71xSn/jxq9IpfksszxKHwDhk8Jc3WDSBz7VPl0Kyx5kYxpAgVJbV2pD4
        i6dt0ORFYpWFtz5dKmm9YhxV9k6lvXeW3/DeKxDN28/htxEwhg9fDdiBy6RBvZCttLczuxhEp/l0r
        uys+XTf6eD0w+npDhCc7zI6CibINH9bdfo6uN0L+CzmSU75hQP/J0X8gTJP9eRCZSvnDJflTj+afs
        H2a6jqCzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifjoh-0003cX-3A; Fri, 13 Dec 2019 12:13:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5A8C304637;
        Fri, 13 Dec 2019 13:11:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C5AF2B1886CC; Fri, 13 Dec 2019 13:13:04 +0100 (CET)
Date:   Fri, 13 Dec 2019 13:13:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Wang <rocking@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] schied/fair: Skip calculating @contrib without load
Message-ID: <20191213121304.GC2844@hirez.programming.kicks-ass.net>
References: <1575648862-12095-1-git-send-email-rocking@linux.alibaba.com>
 <1576208740-35609-1-git-send-email-rocking@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576208740-35609-1-git-send-email-rocking@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 11:45:40AM +0800, Peng Wang wrote:
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a96db50..4392953 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -129,8 +129,9 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
>  		 * Step 2
>  		 */
>  		delta %= 1024;
> -		contrib = __accumulate_pelt_segments(periods,
> -				1024 - sa->period_contrib, delta);
> +		if (load)
> +			contrib = __accumulate_pelt_segments(periods,
> +					1024 - sa->period_contrib, delta);
>  	}
>  	sa->period_contrib = delta;

I've made that:

--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -129,8 +129,20 @@ accumulate_sum(u64 delta, struct sched_a
 		 * Step 2
 		 */
 		delta %= 1024;
-		contrib = __accumulate_pelt_segments(periods,
-				1024 - sa->period_contrib, delta);
+		if (load) {
+			/*
+			 * This relies on the:
+			 *
+			 * if (!load)
+			 *	runnable = running = 0;
+			 *
+			 * clause from ___update_load_sum(); this results in
+			 * the below usage of @contrib to dissapear entirely,
+			 * so no point in calculating it.
+			 */
+			contrib = __accumulate_pelt_segments(periods,
+					1024 - sa->period_contrib, delta);
+		}
 	}
 	sa->period_contrib = delta;
 
@@ -205,7 +217,9 @@ ___update_load_sum(u64 now, struct sched
 	 * This means that weight will be 0 but not running for a sched_entity
 	 * but also for a cfs_rq if the latter becomes idle. As an example,
 	 * this happens during idle_balance() which calls
-	 * update_blocked_averages()
+	 * update_blocked_averages().
+	 *
+	 * Also see the comment in accumulate_sum().
 	 */
 	if (!load)
 		runnable = running = 0;
