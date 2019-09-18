Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE293C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BEA2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1qkZm00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfIRTf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:35:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfIRTf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:35:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so431992pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y0n4YOu1xaM555d4aI7Bta2bxtCQAQm73v5aumDVDEg=;
        b=y1qkZm00Pe7tOuIgzsBIDTlc6Eu43jhxRfNJdbYoSiu6prUUQ6uQOrsY4TpquWsVUJ
         fXGKVYSQAEQr3pxTXRiWFEso11ByxFu/2b1hTkLInAdIEYvjtgLVwisz72Fw7sDIPQyf
         IteQxIQwnQGti48UHojn2Uq5aFqQFTeAfA7MzMLKyCSnOzuUAUaVCZEMGkzWwhgiXSqn
         LG3jxEIFuxJG4rioaT3FYYejRumLH1rknGI/6iYNpi3SYRW67GPY3CsOKaIyb0jFekeN
         pExifeOyNW1mOoAHC0Aw941iqFr3UHqGysnNEuBSZ63RlnEJ68pxjYjTnvEXD+M7DuyF
         A6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0n4YOu1xaM555d4aI7Bta2bxtCQAQm73v5aumDVDEg=;
        b=Zk5983WDH/expOp83v7Ku53teiFIYIvNG8eOH8+xBs7baMtI8iiij9b1IPylI+D4d+
         7lFWI2lxcxvNZF7VSndZD4NgIiDOE7rUnyxklWccN0mPpT0/Kot0n8g5pkBKWrTWR8pB
         RrWPSnh7Pbsc0SfV3OGDMwvMhvnehDfHZr5oFbMzhjbOykNyUiiIG3yqLoCCvsdbEDLj
         pKjC3sVR3dznV7qDFW8pJHoNBbQ8VaJkhP/t3Iv87iBBnO+lEs0GzvzkTdsiePhojCWZ
         ohyCiONEdgB3FtGpjvskqyrZaoeVOhcF3W0uor78U7sWdeKHl/HXKVjpvjsGs5tPqGql
         UfIg==
X-Gm-Message-State: APjAAAWR9DmUh0DSBm+1tHyPPdle/9iBJPL86PRtYlyMvTr+W3YcEWDD
        yZ+tZchAY17T5/NQdXoem9vZb9rGikQ=
X-Google-Smtp-Source: APXvYqxommAUTPNUFYJSt/UvqD6qFStIBjthOrZfrVk617EcPX50zEBDezE/w2xVRnVO59k4C7gm8g==
X-Received: by 2002:a63:1608:: with SMTP id w8mr5526196pgl.223.1568835356949;
        Wed, 18 Sep 2019 12:35:56 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p189sm8810331pfp.163.2019.09.18.12.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 12:35:56 -0700 (PDT)
Date:   Wed, 18 Sep 2019 13:35:54 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] powercap/drivers/idle_inject: Specify the idle state
 to inject
Message-ID: <20190918193554.GC24433@xps15>
References: <20190909145015.26317-1-daniel.lezcano@linaro.org>
 <20190909145015.26317-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909145015.26317-3-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 04:50:15PM +0200, Daniel Lezcano wrote:
> Currently the idle injection framework only allows to inject the
> deepest idle state available on the system.
> 
> Give the opportunity to specify which idle state we want to inject by
> adding a new function helper to set the state and use it when calling
> play_idle().
> 
> There is no functional changes, the cpuidle state is the deepest one.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/idle_inject.c | 15 ++++++++++++++-
>  include/linux/idle_inject.h    |  3 +++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index 9b18667b9f26..a612c425d74c 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -38,6 +38,7 @@
>  #define pr_fmt(fmt) "ii_dev: " fmt
>  
>  #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>  #include <linux/hrtimer.h>
>  #include <linux/kthread.h>
>  #include <linux/sched.h>
> @@ -65,6 +66,7 @@ struct idle_inject_thread {
>   */
>  struct idle_inject_device {
>  	struct hrtimer timer;
> +	int state;
>  	unsigned int idle_duration_us;
>  	unsigned int run_duration_us;
>  	unsigned long int cpumask[0];
> @@ -139,7 +141,7 @@ static void idle_inject_fn(unsigned int cpu)
>  	iit->should_run = 0;
>  
>  	play_idle(READ_ONCE(ii_dev->idle_duration_us),
> -		  cpuidle_find_deepest_state());
> +		  READ_ONCE(ii_dev->state));
>  }
>  
>  /**
> @@ -170,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>  	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
>  }
>  
> +/**
> + * idle_inject_set_state - set the idle state to inject
> + * @state: an integer for the idle state to inject
> + */
> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int state)
> +{
> +	if (state >= CPUIDLE_STATE_NOUSE && state < CPUIDLE_STATE_MAX)
> +		WRITE_ONCE(ii_dev->state, state);
> +}
> +
>  /**
>   * idle_inject_start - start idle injections
>   * @ii_dev: idle injection control device structure
> @@ -298,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>  	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>  	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	ii_dev->timer.function = idle_inject_timer_fn;
> +	ii_dev->state = cpuidle_find_deepest_state();
>  
>  	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>  
> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
> index a445cd1a36c5..e2b26b9ccd34 100644
> --- a/include/linux/idle_inject.h
> +++ b/include/linux/idle_inject.h
> @@ -26,4 +26,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>  void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>  				 unsigned int *run_duration_us,
>  				 unsigned int *idle_duration_us);
> +
> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int state);
> +

The above function is not used in this patch and as such should be introduce as
part of future work.  Otherwise I agree that this patch does not carry any
functional changes.

Without function idle_inject_set_state():

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org> 

>  #endif /* __IDLE_INJECT_H__ */
> -- 
> 2.17.1
> 
