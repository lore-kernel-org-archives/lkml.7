Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92606C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A43F20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQjBNJGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDHFyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:54:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40312 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfDHFyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:54:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so6926837pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aBw3iLas6eOr+vzQGiTNfrXUj7XMiPmKvH74ykWIYyI=;
        b=HQjBNJGd5Vbnd2KEBZkbANk6d4bHmJ7BszDPOfDN1D4xQr/RsxphYj896X5S0fiX+l
         9HDD96F82G2WVeW4MC+QYysOz2/ugSagy6L/GF27sqPT3876mqTdkSaBhqactUmNcVAA
         ZLsHOKVniL/Ipe6Gs/KOMDltxghy5K9r4V6VSUGnhd37zaGff82xU3cSdEtSMut6VvRT
         z7sHb5nL5mXZPzrFaq/ctHDsinzl4E7TQC6X1huCsNnBxMUs6MZdhOaVivvGrcHzjLEQ
         fIXb3j0OR4E8H7tvaj1bJIlh7UOY2Y0bINQ2TECZDAvG86Ta92wsD0Y0pZ1kdBxZUJ0t
         IwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aBw3iLas6eOr+vzQGiTNfrXUj7XMiPmKvH74ykWIYyI=;
        b=jg1VUqOMJkMWVrk3tcBwHrmPWEE/0D9p5dxeDZMmJqtezHiuS3YFYX8trZ22CGHKJA
         kmjDUv2uJ136h2Rt1vEmeU+72GjYAyEL4FfQKgcUFBXQzbLZlTV76pO5cgxhseWDIjPL
         5NyIp/LnhWeOgUfe5/qlz7bZ0NO6zKFg2TVNRSBhFJhilCMNA6rgHkUhSIzPsB3YpGmQ
         vJI40z60c6t86UkffVwre4J+RFkeETsQFEb84LeJuGkkz34sUSm1vx+UAHW7lhb6+OFs
         UZC9+Xv6S5KxufQF+BzJ9a8rsZEHDTiYyjRl5yfFL1QObxvyH1ftvb6ApWNXFPW5jMe9
         h6Bw==
X-Gm-Message-State: APjAAAWR+OHijpwJNyg6MwVSaean8LhkZOvIfcqFselDlb5InbDL8Wag
        VOtDZOJDxf2BNf+F2APLhM6gEQ==
X-Google-Smtp-Source: APXvYqw8k0E4WnU3cle1IrtJN3ij+bcXrTUlm8CqsNHkQWSrUtDXQLNCNQBMmwfdmem9j9CEIh265g==
X-Received: by 2002:a62:6086:: with SMTP id u128mr28095572pfb.148.1554702888354;
        Sun, 07 Apr 2019 22:54:48 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id t82sm76861369pfa.153.2019.04.07.22.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 22:54:47 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:24:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Update][PATCH v3 3/4] cpufreq: schedutil: Simplify iowait
 boosting
Message-ID: <20190408055445.6civdatkw7crwxes@vireshk-i7>
References: <11953735.uMqeHy63Iu@aspire.rjw.lan>
 <2864116.v8IU97Resm@aspire.rjw.lan>
 <3714586.Xfz7sSM4fi@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3714586.Xfz7sSM4fi@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-19, 11:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is not reason for the minimum iowait boost value in the
> schedutil cpufreq governor to depend on the available range of CPU
> frequencies.  In fact, that dependency is generally confusing,
> because it causes the iowait boost to behave somewhat differently
> on CPUs with the same maximum frequency and different minimum
> frequencies, for example.
> 
> For this reason, replace the min field in struct sugov_cpu
> with a constant and choose its values to be 1/8 of
> SCHED_CAPACITY_SCALE (for consistency with the intel_pstate
> driver's internal governor).
> 
> [Note that policy->cpuinfo.max_freq will not be a constant any more
>  after a subsequent change, so this change is depended on by it.]
> 
> Link: https://lore.kernel.org/lkml/20190305083202.GU32494@hirez.programming.kicks-ass.net/T/#ee20bdc98b7d89f6110c0d00e5c3ee8c2ced93c3d
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> As pointed out by Quentin, the original patch overlooked two kerneldoc
> comments that needed to be updated along with the code, so do that here.
> 
> No other changes with respect to the original.
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |   21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
