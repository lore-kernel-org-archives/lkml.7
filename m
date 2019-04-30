Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB3CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2E62147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="em5ZTNco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfD3F4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:56:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40920 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3F4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:56:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so2564565pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 22:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KJqnuayR1GWYMSacPTdXL2izh528yVv0gkaP8rSromE=;
        b=em5ZTNcoev0+CLMxFYnwR2BWi9Mg2R3hopNftu5NRZP/iK6Ng6FaIsVwe+QHAwHBNO
         m2sNy4cok86ja3VQxWdCqUMr8dmNq2Rv6MV8X6R9JGu5wFZC2Rx0v4/fOYZGGfB3Gg7t
         dsEfAwhUvzd8IIrU1dwpyquelJfm7aRn9dnxzvtmqVx0m+C7/9ZGg1VbkOfmJm5l1SRG
         6u4e1OVKp+lcjAz7YWByczhkTRtwx9MhEmjheQy0sbG18GNLrdOR33EwFMlCK388KzUw
         VwtqnmXi0EC0tJLhIrfcHR7oWHsrhqd6WQAsyKMuFRxh3+7py9bJl8Zt3E8EI6y3YEHL
         p0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJqnuayR1GWYMSacPTdXL2izh528yVv0gkaP8rSromE=;
        b=h3kwqc91I1oJLf0m+ZEv4Qhb5+iNPXZQIi+YfprY4gr5IHoX0ZmGEv+iLnkhPJkLd7
         ih1hA5j50u1SUhG0WCQXkJO0cFcXXdGX3v33Vt/SbXYuVH1D41pQPYhUdU+yaf4qb24w
         fCkoTmZ1GGnS0dw3R47anMh7nXlekwO2eoeWOxT0MYDUkynuRRq9SsE63Pz1jfxDofXB
         D4eSHwpX1P5O5+ZJFPmDFUnIoWBXk/Sz7Us/iLQl9Kpcw6tjXMJQTbIvy5r1uxiZNWpc
         9I2nm5j7K2DIfYPQeYlgfmWFKXGYnQKhobbhoVWrSBE36/R5Si83NvM7+/8S/x1euVza
         GVdg==
X-Gm-Message-State: APjAAAXYzR1WaURZUNGevIBuldcnzAMSLmU4Pqhm4xx7GGNNs9N6VqrO
        4KvpiaToZ6eVWNbMsJz4iI03bg==
X-Google-Smtp-Source: APXvYqxsWWqQfasnTwpbbAloas5yB36I+crrxnd6pITuYZhOesxtPW/WXK7f8dI8wDkTvPXAmSq1zg==
X-Received: by 2002:a63:b48:: with SMTP id a8mr60387485pgl.368.1556603791195;
        Mon, 29 Apr 2019 22:56:31 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id g79sm26661445pfd.144.2019.04.29.22.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 22:56:29 -0700 (PDT)
Date:   Tue, 30 Apr 2019 11:26:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     mingo@kernel.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        hpa@zytor.com, tglx@linutronix.de, vincent.guittot@linaro.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com, tobin@kernel.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/urgent] sched/cpufreq: Fix kobject memleak
Message-ID: <20190430055627.oukh3dq6tk74q3wm@vireshk-i7>
References: <20190430001144.24890-1-tobin@kernel.org>
 <tip-8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8@git.kernel.org>
User-Agent: NeoMutt/20180716-1615-c6e4b7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-04-19, 22:52, tip-bot for Tobin C. Harding wrote:
> Commit-ID:  8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8
> Gitweb:     https://git.kernel.org/tip/8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8
> Author:     Tobin C. Harding <tobin@kernel.org>
> AuthorDate: Tue, 30 Apr 2019 10:11:44 +1000
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 30 Apr 2019 06:24:09 +0200
> 
> sched/cpufreq: Fix kobject memleak
> 
> Currently the error return path from kobject_init_and_add() is not
> followed by a call to kobject_put() - which means we are leaking
> the kobject.
> 
> Fix it by adding a call to kobject_put() in the error path of
> kobject_init_and_add().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> Add call to kobject_put() in error path of kobject_init_and_add().

This should have been present before the signed-off ?

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tobin C. Harding <tobin@kernel.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Link: http://lkml.kernel.org/r/20190430001144.24890-1-tobin@kernel.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 5c41ea367422..3638d2377e3c 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -771,6 +771,7 @@ out:
>  	return 0;
>  
>  fail:
> +	kobject_put(&tunables->attr_set.kobj);
>  	policy->governor_data = NULL;
>  	sugov_tunables_free(tunables);
>  

-- 
viresh
