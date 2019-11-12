Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DA820679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="QK1rwIVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKLQIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:08:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40432 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKLQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:08:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id o49so20298913qta.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ElBAh19h76fNw1WL7LmYDraY77y8dXIFpVkCkHJ9aiM=;
        b=QK1rwIVJNbc09PoprNMmCK3WHkH1jHk1qrWN7F1bsm/Yrqj92VGD5NsvIhvWD0BlM4
         8LHLZLm1SQoGQRGHM5DS7WcUlWv9B3cO91liUr/VuuL6ifwmASEH604H9Xo6WH1AvBB5
         awlcMhO/6dnueYIu/Eg2gvQV+Y2NXK67SUgNGzJboP7hOJhxjOqLOmGCCI/CWsFEAWFT
         b4xwL2Nl0rgERIAGoUMNoh1Fq+07eQ4vLjWVa0kZalpWPnRuSVnLKEUTCRUg2XCylMjZ
         d5NhXCEwGpQt0OvfTxGglZptMb8UwH7xf4kW962uIR4XOBlxC9yQ7SktKA7XqgcOom/t
         IOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ElBAh19h76fNw1WL7LmYDraY77y8dXIFpVkCkHJ9aiM=;
        b=pH1wUT58XX0wjYhmnVOI/sYrFfGioYOODlavmextT2e6bbEjwRCeaArv0MJVP4jAcK
         JiYN+rsZ6hZC6yFDLFX40+qF0QG4M2aYyQTtCSP87pKpAzaQg3a9m1ooya0Dj5et2Rtg
         3lZa9TYRqwnvFGsZp7mNZk3XRimUHPR2VP+GfjjQera6xlBhCcGvn1MPY3kwM8QkWJll
         bWHKx+lBlzZGfNeZxi8xHlTV90Sb/rNFowgrT5kLhkMvIY0fJ3sM4asZ+pqDcTOCSXgu
         emaKriEo53aX1R/L5hfW19MlRtmcilFwt2fILd4kFduYDKuf8kiMbuZOBByGMHj4wKYp
         goMQ==
X-Gm-Message-State: APjAAAXuXk5VRX3Nq3m3Tn5JZYaOULN5cj7hVSpmnE9UA1XovQLzPuuI
        Evr1cyyAhQJkL5OeOrtf+ZuGGpCBoLPwDw==
X-Google-Smtp-Source: APXvYqyKGAAq4JHv1jF2aRio6iyGex1cD+JQn3i2pjmUMJ5ENrlq26r1J+HNufGMjPTo9ouE0IQ7hw==
X-Received: by 2002:ac8:6ec4:: with SMTP id f4mr32489946qtv.271.1573574903089;
        Tue, 12 Nov 2019 08:08:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::aa8c])
        by smtp.gmail.com with ESMTPSA id n66sm9462775qkb.72.2019.11.12.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:08:22 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:08:21 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     tim <xiejingfeng@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] psi:fix divide by zero in psi_update_stats
Message-ID: <20191112160821.GE168812@cmpxchg.org>
References: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
 <20191112154144.GC168812@cmpxchg.org>
 <20191112154844.GD168812@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112154844.GD168812@cmpxchg.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:48:46AM -0500, Johannes Weiner wrote:
> On Tue, Nov 12, 2019 at 10:41:46AM -0500, Johannes Weiner wrote:
> > On Fri, Nov 08, 2019 at 03:33:24PM +0800, tim wrote:
> > > In psi_update_stats, it is possible that period has value like
> > > 0xXXXXXXXX00000000 where the lower 32 bit is 0, then it calls div_u64 which
> > > truncates u64 period to u32, results in zero divisor.
> > > Use div64_u64() instead of div_u64()  if the divisor is u64 to avoid
> > > truncation to 32-bit on 64-bit platforms.
> > > 
> > > Signed-off-by: xiejingfeng <xiejingfeng@linux.alibaba.com>
> > 
> > This is legit. When we stop the periodic averaging worker due to an
> > idle CPU, the period after restart can be much longer than the ~4 sec
> > in the lower 32 bits. See the missed_periods logic in update_averages.
> 
> Argh, that's not right. Of course I notice right after hitting send.
> 
> missed_periods are subtracted out of the difference between now and
> the last update, so period should be not much bigger than 2s.
> 
> Something else is going on here.

Tim, does this happen right after boot? I wonder if it's because we're
not initializing avg_last_update, and the initial delta between the
last update (0) and the first scheduled update (sched_clock() + 2s)
ends up bigger than 4 seconds somehow. Later on, the delta between the
last and the scheduled update should always be ~2s. But for that to
happen, it would require a pretty slow boot, or a sched_clock() that
does not start at 0.

Tim, if you have a coredump, can you extract the value of the other
variables printed in the following patch?

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 84af7aa158bf..1b6836d23091 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -374,6 +374,10 @@ static u64 update_averages(struct psi_group *group, u64 now)
 	 */
 	avg_next_update = expires + ((1 + missed_periods) * psi_period);
 	period = now - (group->avg_last_update + (missed_periods * psi_period));
+
+	WARN(period >> 32, "period=%ld now=%ld expires=%ld last=%ld missed=%ld\n",
+	     period, now, expires, group->avg_last_update, missed_periods);
+
 	group->avg_last_update = now;
 
 	for (s = 0; s < NR_PSI_STATES - 1; s++) {

And we may need something like this to make the tick initialization
more robust regardless of the reported bug here:

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 84af7aa158bf..ce8f6748678a 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -185,7 +185,8 @@ static void group_init(struct psi_group *group)
 
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
-	group->avg_next_update = sched_clock() + psi_period;
+	group->avg_last_update = sched_clock();
+	group->avg_next_update = group->avg_last_update + psi_period;
 	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	mutex_init(&group->avgs_lock);
 	/* Init trigger-related members */
