Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545F6C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4C9217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nivcbY2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFNQqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:46:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45506 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:46:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id s21so1843833pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yf8AaZQCzwIcFoIppyOptGSt+yOTkl5BeJ2O0ErAtlY=;
        b=nivcbY2W2jCDywDVEROgcoel9+RmuFM394rEuAbBkZ7FmgB7YDOPVzzaN7/vWluvCJ
         znwydKoHFp4gR4cXxVA70LSg1seuu8YKkPKfmw5Ito8FLP6jEmeEkeVJqUvqQP2+uxJR
         ZZj0r9za8esEvab9jQ2IMJJJwGSRhTKCsE56E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yf8AaZQCzwIcFoIppyOptGSt+yOTkl5BeJ2O0ErAtlY=;
        b=szxq+21YsuMR26+rgCLgOsULBpvLFgNGlMtiqo7R5hWAEitVZaYyN/K+Vds2LhOmvw
         hrLyjSQbezWsprBagJnZzFXc6lDHp2v7b/WTff1rbWBedK7PFHR0UnjuOR0cSiXZZE4l
         bXXArHInMPmI1zHVZyR4xSUDs7LaYY42zkc8pjK05LfwsOSHCmYZtf6yz6amSdBjrOS4
         7PESJ504BwUsth5aCxJBFKHkyzFIRFRYGjuvEP0ner+430oJAYGasJAUuBDmP94qyt1N
         sGY9ScUWK4lKwRBwVsoGccxQsdXUtfHFmVAf0d85gg2k0JpbtiWm7Dn/D3r0XXKXx61y
         2jxg==
X-Gm-Message-State: APjAAAWPjZ0w4fsotqQkrOYn1JoIo0fFpGlUYzPNNPd4WS0rKkbjbZzH
        kgl3jFjKDUxJulH7jPaxMkMHjg==
X-Google-Smtp-Source: APXvYqyXMk7ZfP/0d6oGbg9M5RURFbm0kAH8HF/iLk/DodByjVz3Pz9UAhRTisfbR4mQaLnDr6PceQ==
X-Received: by 2002:a17:90a:bd8c:: with SMTP id z12mr12174873pjr.60.1560530807697;
        Fri, 14 Jun 2019 09:46:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f21sm3487102pjq.2.2019.06.14.09.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:46:47 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:46:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190614164641.GP137143@google.com>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Mon, Jun 10, 2019 at 04:21:35PM +0530, Viresh Kumar wrote:
> This registers the notifiers for min/max frequency constraints with the
> PM QoS framework. The constraints are also taken into consideration in
> cpufreq_set_policy().
> 
> This also relocates cpufreq_policy_put_kobj() as it is required to be
> called from cpufreq_policy_alloc() now.
> 
> No constraints are added until now though.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 139 +++++++++++++++++++++++++++++++-------
>  include/linux/cpufreq.h   |   4 ++
>  2 files changed, 120 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 85ff958e01f1..547d221b2ff2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -26,6 +26,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
> @@ -1126,11 +1127,77 @@ static void handle_update(struct work_struct *work)
>  	cpufreq_update_policy(cpu);
>  }
>  
> +static void cpufreq_update_freq_work(struct work_struct *work)
> +{
> +	struct cpufreq_policy *policy =
> +		container_of(work, struct cpufreq_policy, req_work);
> +	struct cpufreq_policy new_policy = *policy;
> +
> +	/* We should read constraint values from QoS layer */
> +	new_policy.min = 0;
> +	new_policy.max = UINT_MAX;
> +
> +	down_write(&policy->rwsem);
> +
> +	if (!policy_is_inactive(policy))
> +		cpufreq_set_policy(policy, &new_policy);
> +
> +	up_write(&policy->rwsem);
> +}
> +
> +static int cpufreq_update_freq(struct cpufreq_policy *policy)
> +{
> +	schedule_work(&policy->req_work);

I think you need to add a cancel_work_sync() in cpufreq_policy_free()
to make sure the work doesn't run after the policy has been freed.

Otherwise it looks good to me.

Cheers

Matthias
