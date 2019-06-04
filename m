Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3E9C04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D098261E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITvr9Khp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFDC6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 22:58:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41156 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDC6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 22:58:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id s24so7590571plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VLAZA3mAxtAxc7sjq/ycXQ3CaKlvlwmmoeCBvwMr7B8=;
        b=ITvr9KhpT8ky5VlbXAeC73PK4m3joLBkof6irFxZHpCnty3heHbDfVg5eAlO9lQ2x+
         J+7n/Qj4eJ8Yh2KAUsxBOOlUYbwGGHJyC82zqtWnNXW0fOs4kqnoFR//ffUXD4Gk3Uo6
         uQLb0ZqLfp7m5cEepRI9bj0MqNBWv+ZlPJa/syTu7P1kLO3BmsrSJRQasidhQisjy2IW
         hzAznOo29tsvjDD7lEV1b98m0IuSZJ6OKgo6Q23meb/wLu6oaWDXVI3i2QB/J3EpDjf3
         jcH2+l3ROuv6fySejyOu5rbAlIY4S7r1G2vd2yglkG4NEDvYAN2H8bS9RggTOP4YX59/
         hkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VLAZA3mAxtAxc7sjq/ycXQ3CaKlvlwmmoeCBvwMr7B8=;
        b=YRYzC23ocI5SF+aUuG6mvhm5AU2zQKZzxltfO4zCmcXWHayttxPe9h4kt7lgEB+eDD
         VIR3ukflzEdSV7UYwnTLqHGn3S/y1eVwKUy3N9RYPOPnH2tH1J85S1UbShwJrn3IoFOA
         KWQmNo0xN1vaC2jSi+O8EJ1SBWzjOl6JlD96C5dm4npEtT6lhWsaBbzm+oc271aSYGBQ
         LdMxFqIcL66u29gCqUy6RdKx8kRHcMp6nPTiXH54PIyUa1+On9fKhxUg78DHqSSkFYwy
         efGCxLLvLSwqnchurS46Horm8ViFQe6IUgrckShNCh0nLaCqI0kOYnb9Pu927O65AM8B
         9xAQ==
X-Gm-Message-State: APjAAAUefSoluGvTv9EDCU1R1jM40qbHg/9mUDqTEDhSl/0gwJjuhLYU
        Pn+iV3MW3bmXLhTwEU3E4uc34ItsSt0=
X-Google-Smtp-Source: APXvYqxf9PeMHR15w+6O7G1DNcjciSY+CmqIcYtt7DvFBckAVFIcpkK8zH1d/QFf2EJVxFmVjT7HaA==
X-Received: by 2002:a17:902:2a69:: with SMTP id i96mr25404027plb.108.1559617086552;
        Mon, 03 Jun 2019 19:58:06 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id b15sm15929188pfi.141.2019.06.03.19.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 19:58:04 -0700 (PDT)
Date:   Tue, 4 Jun 2019 08:28:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU
 isn't found
Message-ID: <20190604025802.p7k5l3jhqrwbxy6j@vireshk-i7>
References: <cover.1556182964.git.viresh.kumar@linaro.org>
 <59b37c56b8fcb834f7d3234e776eaeff74ad117f.1556182965.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b37c56b8fcb834f7d3234e776eaeff74ad117f.1556182965.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-04-19, 15:07, Viresh Kumar wrote:
> We target for an idle CPU in select_idle_sibling() to run the next task,
> but in case we don't find idle CPUs it is better to pick a CPU which
> will run the task the soonest, for performance reason. A CPU which isn't
> idle but has only SCHED_IDLE activity queued on it should be a good
> target based on this criteria as any normal fair task will most likely
> preempt the currently running SCHED_IDLE task immediately. In fact,
> choosing a SCHED_IDLE CPU shall give better results as it should be able
> to run the task sooner than an idle CPU (which requires to be woken up
> from an idle state).
> 
> This patch updates the fast path to fallback to a sched-idle CPU if the
> idle CPU isn't found, the slow path can be updated separately later.
> 
> Following is the order in which select_idle_sibling() picks up next CPU
> to run the task now:
> 
> 1. idle_cpu(target) OR sched_idle_cpu(target)
> 2. idle_cpu(prev) OR sched_idle_cpu(prev)
> 3. idle_cpu(recent_used_cpu) OR sched_idle_cpu(recent_used_cpu)
> 4. idle core(sd)
> 5. idle_cpu(sd)
> 6. sched_idle_cpu(sd)
> 7. idle_cpu(p) - smt
> 8. sched_idle_cpu(p)- smt
> 
> Though the policy can be tweaked a bit if we want to have different
> priorities.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/fair.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Hi Peter,

I was looking to send V3 with the changes you suggested for the patch 1/2, are
there any changes that I should be doing in this patch along with it ?

-- 
viresh
