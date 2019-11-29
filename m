Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F45BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7BF21721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IU0LNMh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfK2UFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 15:05:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38923 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfK2UFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 15:05:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id v93so10470144pjb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ipR+DrBtOJQIudnRaII7nJ3+mq7nKbRqBwicLRMc3w=;
        b=IU0LNMh0TWniaggb1y5v7B/hYj06AGeQ6rFf4JXFP3ecy8Snmq/f80SwI5lmzFWIrJ
         tWeJyOxzIUhXa6LVLo+l/RdrzAEalAseSjkKIbR+FPLLc9VzYIasV3qKMRq0GnJU0azI
         ZcBiRNEHd7jjx1UEILokbjyRcOPFK6vVOXhrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ipR+DrBtOJQIudnRaII7nJ3+mq7nKbRqBwicLRMc3w=;
        b=R6Xv595X33LBmjnyO+3j8M7dT0QuWpRQsZIwhZbgwqeh2+kxlQgTz0Mo4QHduRcASL
         oZJe3FfLtmb3vUsue0kMPwzy3ajeHIxivcyQjSsuJJ0tw/U4Wx9h1/MBo+5Pd999JfUo
         X6KZ85v1xV/Hzz4whtaamKKiOfPbRlNiFLsKmI8pSK6PV01KuEXQfVHzRHI9Nl6YwXQy
         SrZGNX03XgBl/rI5P3gyHvRJ9BijjMz1X1AzhcgLBOXuBHIJz6Lgn5S6EXFdgfR+hVCb
         YsHBKJeCf7ztsvn21a2J/GMYyK8Tx0A29dyWE4Tcm//pshx665aV56c5R5SC60AQsrL8
         Egcg==
X-Gm-Message-State: APjAAAWQFGvE/IJHybviU2HeRFyrt+rNKLqGYF1EqaFUHOmn9eoB9Te5
        fjA2pBJWjJQGpLCWv0qeYxpbk4A76ac=
X-Google-Smtp-Source: APXvYqzv+PIer9ks5zR5Vza4ROybRs9nR2wonFy59tez+ucGy/ExMOXQl27Izq38p0bVRbv+ekYwvw==
X-Received: by 2002:a17:90a:aa96:: with SMTP id l22mr19758027pjq.112.1575057924147;
        Fri, 29 Nov 2019 12:05:24 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 83sm25542605pgh.12.2019.11.29.12.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 12:05:23 -0800 (PST)
Date:   Fri, 29 Nov 2019 15:05:22 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf/core: Add SRCU annotation for pmus list walk
Message-ID: <20191129200522.GA239292@google.com>
References: <20191119121429.zhcubzdhm672zasg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119121429.zhcubzdhm672zasg@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 01:14:29PM +0100, Sebastian Andrzej Siewior wrote:
> Since commit
>    28875945ba98d ("rcu: Add support for consolidated-RCU reader checking")
> 
> there is an additional check to ensure that a RCU related lock is held
> while the RCU list is iterated.
> This section holds the SRCU reader lock instead.
> 
> Add annotation to list_for_each_entry_rcu() that pmus_srcu must be
> acquired during the list traversal.
> 

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> I see the warning in in v5.4-rc during boot. For some reason I don't see
> it in tip/master during boot but "perf stat w" triggers it again (among
> other things).
> 
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5224388872069..dbb3b26a55612 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10497,7 +10497,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
>  		goto unlock;
>  	}
>  
> -	list_for_each_entry_rcu(pmu, &pmus, entry) {
> +	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>  		ret = perf_try_init_event(pmu, event);
>  		if (!ret)
>  			goto unlock;
> -- 
> 2.24.0
> 
