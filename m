Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C814CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9A9206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfJUGTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:19:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39685 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfJUGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:19:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id r141so1845283wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fZtnzwTPHSQvPJDZUcwgj7ynIMWGqG+RkdmFd+sxTOc=;
        b=Qz2HB2J0Rk5y91MDwPQ9n+gYKUWw4Cqkefd1f5WDki9pW2pBGeoupiqkcLsCiyuhh4
         99K+eJlWQcBzr6V7eZ/MGpOyItoQWI0ZCYbZfyO6uALpwSD2zKiKmo/cf/lb8nKzV8Go
         95K8Qo91Av1RWhJ7M2fmPxiNQKTOcYnTNBGNb1oGh/br36ByEfXZ60LsOLLL4JlaLexr
         1ll+S51qZKUKKJPEUz8qcSyRWeoE2rscJwnfRia+IRXVlZeW2FcsPwXUeAr6l0o4czZh
         +g1f6wxt/atrYtaYCEKMSMVPUOTWTb0EZe/jGjjxqQrbiHsyzeBZJxHpRbcRLQuMHodv
         tHcw==
X-Gm-Message-State: APjAAAWLnaeibeS71LqltH1Pfe2yWco9rekYqq4KTNsO3iw+EvVVaz4g
        hpEHstmPdBfr99oQ1swAINE=
X-Google-Smtp-Source: APXvYqzOc6540fFTubZWW1bHvzM9znfaCv7whthvSnpLoKjD4GfzviF2NjygshuN+a0GfJLfyUlSZg==
X-Received: by 2002:a1c:d0:: with SMTP id 199mr18475027wma.67.1571638754398;
        Sun, 20 Oct 2019 23:19:14 -0700 (PDT)
Received: from darkstar ([109.70.119.5])
        by smtp.gmail.com with ESMTPSA id 12sm6217046wmk.13.2019.10.20.23.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Oct 2019 23:19:13 -0700 (PDT)
Date:   Mon, 21 Oct 2019 07:19:11 +0100
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization
 increases
Message-ID: <20191021061911.GA3550@darkstar>
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin>
 <20190628123800.GS3419@hirez.programming.kicks-ass.net>
 <20190628140057.7aujh2wsk7wtqib3@e110439-lin>
 <20190802094725.ploqfarz7fj7vrtp@e110439-lin>
 <20191014145218.GI2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014145218.GI2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 14-Oct 16:52, Peter Zijlstra wrote:
> 
> The energy aware schedutil patches remimded me this was still pending.
> 
> On Fri, Aug 02, 2019 at 10:47:25AM +0100, Patrick Bellasi wrote:
> > Hi Peter, Vincent,
> > is there anything different I can do on this?
> 
> I think both Vincent and me are basically fine with the patch, it was
> the Changelog/explanation for it that sat uneasy.
> 
> Specifically I think the 'confusion' around the PELT invariance stuff
> doesn't help.
> 
> I think that if you present it simply as making util_est directly follow
> upward motion and only decay on downward -- and the rationale for it --
> then it should be fine.

Ok, I'll update the commit message to remove the PELT related
ambiguity and post a new version soon.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
