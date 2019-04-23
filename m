Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178EAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D988920685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rucpjxGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDWImS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:42:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47044 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfDWImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:42:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id v2so4825608pge.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4XIzHt8EOSLAhq67k8eQ4xsJegTmaUjP/QnOwJlp2xY=;
        b=rucpjxGiHBOYAQ6E4i+ozIXWTb3dnS/rh8sEk64vlAmy5+uyATq3iw+HToTFE7MlV3
         LjKtzZnOJrwn/2/wCu2UciWLZdHmafqD3nHtiEaHiQ1n06jRti9FgR8nkD4tmNoYfLm4
         C5GvD5+i/euT5W6vDcGs4AphJU9AAP423qB9Hq4nkiYTS7UFIfsFrRi1/Q4dmtvhKhVR
         JFmgcidpI4O5omOYMruZa6cAtmmFy4WExOAoCC2EncdH/kQ9Y0FkIa0H9sVCewUf50lk
         R5P5BAwD8vnQDuXQlArKIWMv9NzgPkksfN9VU4Q8GQsGABmQr/+tTIlW56brTWiZoo+w
         6FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4XIzHt8EOSLAhq67k8eQ4xsJegTmaUjP/QnOwJlp2xY=;
        b=KDXr6Y0RtRNPt9IgXvTHxSh3tfPqbHqaqXrTHXrwkPOt1dHiv0fAdpLSV0g09k0HOA
         o3ox6froBuSc58Eo90ylTL61OTk+xtpDEowHLQLEiNZBhl41F9RFRllC5h6MzFuekWCE
         7HlhDw1KMoTF9JjFhG5Kmqu2wsULWkBA6Fsizmk6BiA3HdYGCfDnSNi49ywB+tPTiw+y
         3fExGMGHjnix6KtEGSvCp4Oq0oVp+Vl9EcJhCCGWtfOmx5I3ODMVWfUQsmIiIXJNUVOj
         N3ZFOZHEzGjtLyqdpcyowEdyHU6kdAjT7HjS3fXDF0vsRW0+//+HOttMagMyeJbk8jzS
         TY2g==
X-Gm-Message-State: APjAAAXWQOAYDVqS+4zb7/IeDiWjYsWSPIBZGMPyD300NN9cDrKkLdAl
        pZLa5z5YDceTg1aHnmbXoVP1Rg==
X-Google-Smtp-Source: APXvYqxNXMaWYhX/5MxjBqGGPv6Pno1uJmqd+FGYByG+Sb8A7HXLi2aBb1NXKxwH8AIWc0k2McM0Jg==
X-Received: by 2002:a63:6e01:: with SMTP id j1mr23611134pgc.442.1556008937770;
        Tue, 23 Apr 2019 01:42:17 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id 66sm23649339pfr.44.2019.04.23.01.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 01:42:16 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:12:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: tsc: Rework time_cpufreq_notifier()
Message-ID: <20190423084215.hygce3d66wyncqig@vireshk-i7>
References: <38900622.ao2n2t5aPS@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38900622.ao2n2t5aPS@kreacher>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-19, 16:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are problems with running time_cpufreq_notifier() on SMP
> systems.
> 
> First off, the rdtsc() called from there runs on the CPU executing
> that code and not necessarily on the CPU whose sched_clock() rate is
> updated which is questionable at best.
> 
> Second, in the cases when the frequencies of all CPUs in an SMP
> system are always in sync, it is not sufficient to update just
> one of them or the set associated with a given cpufreq policy on
> frequency changes - all CPUs in the system should be updated and
> that would require more than a simple transition notifier.
> 
> Note, however, that the underlying issue (the TSC rate depending on
> the CPU frequency) has not been present in hardware shipping for the
> last few years and in quite a few relevant cases (acpi-cpufreq in
> particular) running time_cpufreq_notifier() will cause the TSC to
> be marked as unstable anyway.
> 
> For this reason, make time_cpufreq_notifier() simply mark the TSC
> as unstable and give up when run on SMP and only try to carry out
> any adjustments otherwise.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/kernel/tsc.c |   29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
