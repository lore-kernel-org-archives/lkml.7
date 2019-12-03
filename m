Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13177C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE74B2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrQNp+5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLCIYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:24:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38065 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfLCIYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:24:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so1477324pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 00:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ePyWpgO6SpDrkwgrOacCpFzQ/j20hTY+sW9Shl7aHi4=;
        b=WrQNp+5gaTi99HubsuUWY6+TPybVxVIy7K33TJMN6dkjxskbH8MgX/EfawEULeEv2m
         YRdy5kBChVwI2ybVNPQJwTMuCFTEqT7vqNy92OEzphn8q829Msb6uIk+5N2s9+i3tZuD
         cJItlyjxcvybI3I9QU/ssLAvnC5hVnGceiR10V2tOx3o2kD8d80BdmCUGGBoUMheWzhm
         zV5+HitRVdsAFOfUEKsJPuMRynuM4IIC5fqvWHfyMaHlN8RrsDjCxDjJQEevYnZgtX/N
         cQzqDn6rBsxPQ/cyG2DXpN9rgudaaDL6dMMTfMxebOxfNqHRfh08RqY7KN0APfZ4llCc
         z5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ePyWpgO6SpDrkwgrOacCpFzQ/j20hTY+sW9Shl7aHi4=;
        b=MI/zk7e/A9Zio/QTme6xIJe1a38hv1t+QXDPYTwO+VG7NuTzvU3QZr6t2XDfywoNYj
         BEHhx3uRi20y9/fqmjxC+xPy70XGu2vsDb/YAaTn93JM1q8raGNAcPGGe55IXBAUvPgk
         UXIgkqf1X/wJWUrcVob7DBF5t/OIhjFadrntZYqHxlAWyLse/Ms6zqLdTiaCF9QSuLSh
         btcEqV+27LMfTWs5U03KFMp17TJsjy77aoeIyyxPGpn+FEVGVRKsNtSGyrGx8AQZAT6g
         Y1OmySRguo7asMAs9Kv7vaAHCro2ef3lTKG50ajHalS2ZP/wEr9F6EofA4zkyjuAPWW9
         /jsg==
X-Gm-Message-State: APjAAAUe/gVlSbqGDVllt5r5baqmK85eI4qFNxhlvAW5ucv5f/lH6UJW
        Mjv6gozY0CmmGKh3TjoLyPXtfA==
X-Google-Smtp-Source: APXvYqywMuHAbETMeQr0BvdpfwYyzAXKj1Ia6vHnnLBFcNh+6+z/idLccu1jFpbRBS/g1rDnpDQGpw==
X-Received: by 2002:a62:1d90:: with SMTP id d138mr3549471pfd.223.1575361485999;
        Tue, 03 Dec 2019 00:24:45 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id u24sm2288069pfh.48.2019.12.03.00.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 00:24:45 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:54:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, edubezval@gmail.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/4] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20191203082443.p6aeg3ijkiva4ugb@vireshk-i7>
References: <20191202202815.22731-1-daniel.lezcano@linaro.org>
 <20191202202815.22731-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202202815.22731-3-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-19, 21:28, Daniel Lezcano wrote:
> The cpu idle cooling device offers a new method to cool down a CPU by
> injecting idle cycles at runtime.
> 
> It has some similarities with the intel power clamp driver but it is
> actually designed to be more generic and relying on the idle injection
> powercap framework.
> 
> The idle injection cycle is fixed while the running cycle is variable. That
> allows to have control on the device reactivity for the user experience.
> 
> An idle state powering down the CPU or the cluster will allow to drop
> the static leakage, thus restoring the heat capacity of the SoC. It
> can be set with a trip point between the hot and the critical points,
> giving the opportunity to prevent a hard reset of the system when the
> cpufreq cooling fails to cool down the CPU.
> 
> With more sophisticated boards having a per core sensor, the idle
> cooling device allows to cool down a single core without throttling
> the compute capacity of several cpus belonging to the same clock line,
> so it could be used in collaboration with the cpufreq cooling device.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  V2:
>    - Remove idle_duration_us field and use idle_inject API instead (Viresh Kumar)
>    - Fixed function definition wheh CPU_IDLE_COOLING is not set
>    - Inverted the initialization in the init function (Viresh Kumar)
> ---
>  drivers/thermal/cpuidle_cooling.c | 233 ++++++++++++++++++++++++++++++

This needs to go in MAINTAINERS file btw :)

-- 
viresh
