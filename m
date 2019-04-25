Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C274C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59396217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmlEx3Co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfDYFds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:33:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42257 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbfDYFds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:33:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so10523765pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bGbOlwrEu27uYFRCRa8Q0xuJA8piGO/iw07sacj4LBQ=;
        b=DmlEx3Cou3fYcL5Tc9n45aJNBfqx6ET7RZxGJ43WK/sVsrYiJ19gnFdi9Ph71USj7y
         zlaVKPsUg4ZwhXhg/WZQnMe3JaeNnkYIJwztVkdsiSIR8T1xBzHkAVpzPPuQiPn7Fwrl
         aRGjVeX3Do4GSKjolysd84Ch7ISASC2MNDzhRBojseUaw2EWVHnQThaU8m/Ibo7gwN2N
         nO60SCni4liW381QVt0CIA8eEbuZl+bqNe/9q2jAZveUN5vq35dMU0TVsDFSGRaCcCU8
         qbJbgjKG9J9Gz7Ego70U9xJhrstLeMQvPv0cC2/Bo/sGdZUAk+yoMkyq6iquohO1Wa0I
         iFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bGbOlwrEu27uYFRCRa8Q0xuJA8piGO/iw07sacj4LBQ=;
        b=eqLWTyb7QuYkdAHdyYWUrBpFURLX843IvxmWhiGxi7I938fVP1GN0PlYe88YeLVzm9
         4JccGhCascZFcy6x47P04PMabo75XYg2bLCQLxuDb+USljikHwhjhOifVNzEc/M5ENrS
         Oey6fLS5J8oJwvklOXyPCjn5VRNnu3rz+ONffY4wbU6Zjri/o+v8yZG6NDRlp1vpRAS0
         hvWvUuCc6ghhamPBnR7n7qteRgTc/0/SSPxYX7XBwVObOg0zgxSEDE08QYHjR1JY+X3R
         VaOEb/LhuEWtYuzmdCwTYzwQp4PgUx9LprPNEXF5MCpmf8tS+jFYOh/VRV4ucjs1pSM+
         W9Tw==
X-Gm-Message-State: APjAAAXffArcL/+1HLQ91Jx3SQPcwooxuiEWiAJLIRxplbF7VBjA8+N7
        a1YDNY6lIatu/3Xi93t7qnTm4A==
X-Google-Smtp-Source: APXvYqwtUnXXdq6HS2MftOK2MHAFwU/1+JxWis1kobwXPRwHPQXM4xsAIBMAHMaJTj2HyTMu+N1WpA==
X-Received: by 2002:a63:243:: with SMTP id 64mr34747986pgc.214.1556170427003;
        Wed, 24 Apr 2019 22:33:47 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id h19sm34841891pfd.130.2019.04.24.22.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 22:33:45 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:03:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/cpu_cooling: Remove pointless test in
 power2state()
Message-ID: <20190425053343.zmvwd3ndpxkh24j5@vireshk-i7>
References: <20190424205610.9376-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424205610.9376-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-19, 22:56, Daniel Lezcano wrote:
> When the static power computation was removed, the test with the power
> being negative was not removed. However, the substraction which was
> responsible of the negative value was removed and the variable is now
> an u32. A double reason to remove the test which does not make sense.
> 
> Fixes: 84fe2cab48590 ("cpu_cooling: Drop static-power related stuff")
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..ee8419a6390c 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -541,7 +541,6 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
>  	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>  	struct cpufreq_policy *policy = cpufreq_cdev->policy;
>  
> -	power = power > 0 ? power : 0;
>  	last_load = cpufreq_cdev->last_load ?: 1;
>  	normalised_power = (power * 100) / last_load;
>  	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
