Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D510EC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3DE20851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdtBwKkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfFNF1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:27:39 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:33648 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfFNF1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:27:37 -0400
Received: by mail-pl1-f171.google.com with SMTP id c14so520567plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 22:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gpmRrAai2U/u8FOxmf1mMEHtb8C5DvBiK/78zCxWoN8=;
        b=FdtBwKkGrvc8PbkOh7IgHRgb+bO406Z3RgusnYcYmsIkqRO8qW5ggLC/SPBKMfBsK2
         PesYYhBmzjDv4oFUeFgNGNgrVn9OhG6mawN1KgvA5PRLbqEZ4r6b2BDd4mu+7LMJKEoC
         v3zMw08i6e4xTK71w47QkprUWXzQQe3AMsDDNfZ10xd3gFDUKOzG9z8e+mmrzznd3gME
         p8R3KCVWTAOEb0hwDzrOw0tpa2pEI7n7eVqcO+zZvOtCqlSoIh4M/i74FRgLRGoRwaMG
         M8uzUA+O3fsjv2HRPPyu8ZZVN8th2KR+5YcNfF+x7GMwHxgW03ayzewUvHxZTgiEOzWR
         b1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gpmRrAai2U/u8FOxmf1mMEHtb8C5DvBiK/78zCxWoN8=;
        b=qRhfj5PxTzFyEVuSNGfBrlRkFbGjpsZqKHaZ41XqnEBw5cPx2GOIDGC1TGxkikpMzi
         V1NLaDKXrZlpjqbGRNhC+UoUt+dW2H9Ga4tYYHetKx+WOaMuhbCEXS7VQXQXNWIbzsRt
         oSsHO5iqyDCjTscG1w98IE5U7VzF0gaDc1fvpyqhuDew6ep2J9GXrhjshK6+GKGeFsCB
         wxRGCBae3te0jJdMk2C0iGNSAXvmrFvFSuufWAX69VTyqWjmOo7LO4Eg2PZjYzvrcLQ+
         UK6SW49OeV6yD76VrUxY/5vDuatVZ5YZVN4H0tRwHDf6RIaQCnVUfbmuunFxUzAMHsJU
         UPIw==
X-Gm-Message-State: APjAAAW1O3OiuFChGEboOsLR1/Xw5WJjoLAq7zyKYxzFaVkbN0bMdmS4
        NISoNc/lRWSopT604D0XSNERdw==
X-Google-Smtp-Source: APXvYqyzY+ZcDwS257e/DcRosvfsCUeYIQheDqeTIxEJrU3JUxKmTdM1JbGHllR8eOi2yEYOZ8KXFQ==
X-Received: by 2002:a17:902:7c90:: with SMTP id y16mr1583679pll.238.1560490056827;
        Thu, 13 Jun 2019 22:27:36 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id f88sm2289322pjg.5.2019.06.13.22.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 22:27:34 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:57:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     swboyd@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        vincent.guittot@linaro.org, mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, ulf.hansson@linaro.org,
        dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
Message-ID: <20190614052732.4w6vvwwich2h4cgu@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-2-rnayak@codeaurora.org>
 <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
 <c173a57d-a4de-99f7-e8d8-28a7612f4ca3@codeaurora.org>
 <20190612082506.m735bsk7bjijf2yg@vireshk-i7>
 <20190613095419.lfjeko7nmxtix2n4@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613095419.lfjeko7nmxtix2n4@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-06-19, 15:24, Viresh Kumar wrote:
> I am confused as hell on what we should be doing and what we are doing
> right now. And if we should do better.
> 
> Let me explain with an example.
> 
> - The clock provider supports following frequencies: 500, 600, 700,
>   800, 900, 1000 MHz.
> 
> - The OPP table contains/supports only a subset: 500, 700, 1000 MHz.
> 
> Now, the request to change the frequency starts from cpufreq
> governors, like schedutil when they calls:
> 
> __cpufreq_driver_target(policy, 599 MHz, CPUFREQ_RELATION_L);
> 
> CPUFREQ_RELATION_L means: lowest frequency at or above target. And so
> I would expect the frequency to get set to 600MHz (if we look at clock
> driver) or 700MHz (if we look at OPP table). I think we should decide
> this thing from the OPP table only as that's what the platform guys
> want us to use. So, we should end up with 700 MHz.
> 
> Then we land into dev_pm_opp_set_rate(), which does this (which is
> code copied from earlier version of cpufreq-dt driver):
> 
> - clk_round_rate(clk, 599 MHz).
> 
>   clk_round_rate() returns the highest frequency lower than target. So
>   it must return 500 MHz (I haven't tested this yet, all theoretical).
> 
> - _find_freq_ceil(opp_table, 500 MHz).
> 
>   This works like CPUFREQ_RELATION_L, so we find lowest frequency >=
>   target freq. And so we should get: 500 MHz itself as OPP table has
>   it.
> 
> - clk_set_rate(clk, 500 MHz).
> 
>   This must be doing round-rate again, but I think we will settle with
>   500 MHz eventually.
> 
> 
> Now the questionnaire:
> 
> - Is this whole exercise correct ?

No, I missed the call to cpufreq_frequency_table_target() in
__cpufreq_driver_target() which finds the exact frequency from cpufreq table
(which was created using opp table) and so we never screw up here. Sorry for
confusing everyone on this :(

> Now lets move to this patch, which makes it more confusing.
> 
> The OPP tables for CPUs and GPUs should already be somewhat like fmax
> tables for particular voltage values and that's why both cpufreq and
> OPP core try to find a frequency higher than target so we choose the
> most optimum one power-efficiency wise.
> 
> For cases where the OPP table is only a subset of the clk-providers
> table (almost always), if we let the clock provider to find the
> nearest frequency (which is lower) we will run the CPU/GPU at a
> not-so-optimal frequency. i.e. if 500, 600, 700 MHz all need voltage
> to be 1.2 V, we should be running at 700 always, while we may end up
> running at 500 MHz.

This won't happen for CPUs because of the reason I explained earlier. cpufreq
core does the rounding before calling dev_pm_opp_set_rate(). And no other
devices use dev_pm_opp_set_rate() right now apart from CPUs, so we are not going
to break anything.

> This kind of behavior (introduced by this patch) is important for
> other devices which want to run at the nearest frequency to target
> one, but not for CPUs/GPUs. So, we need to tag these IO devices
> separately, maybe from DT ? So we select the closest match instead of
> most optimal one.

Hmm, so this patch won't break anything and I am inclined to apply it again :)

Does anyone see any other issues with it, which I might be missing ?

-- 
viresh
