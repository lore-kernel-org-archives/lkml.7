Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2962C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DE320674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6gYtTDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfFXGDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:03:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45478 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXGDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:03:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id z19so3552816pgl.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dNs4bFTn0f/H2512covQPvgW7xHEQrBSIemzlMYE1WU=;
        b=F6gYtTDouoTcZyvItCkzcdGIm2GiI5ij2KNmjl/uLGOHVF2Mgm3DYbvhBuN+5OjeHL
         gp6gGnmh2wXuboNfODnOsROpHwsUB9Ah54gRqCRbwzS+v36jwN8cRN7coJoZm1T8h5m9
         Lc/SvxQO+ojDltrR1frfHPAqHVEaQ4rZzvi2puGHraCUF6e74PXvr3xPErsg6EpQr4yj
         hLAjMEOKC+z12zOExSiI2StSVfgVkC8OuGmJS5f3b0R6Gbjp6VKG5Z39CCOrbIkpccjh
         mSAPWAu7IbIkiDA0ajpEjHQorirY8MFMy+N2aZyiyn/PgVaFliemA83jUL/+xt4Y6rB7
         zeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNs4bFTn0f/H2512covQPvgW7xHEQrBSIemzlMYE1WU=;
        b=n41aaJaPZEq8pPu4NcoO/QA90bWLFBxeepYP3AbLIfN9V9n4zsdg9rhozl5wVMKOr/
         5RACBTnpvXQDElDrOpJXUZA9SikOL1pn6CVV7RHFYle87/LfA7F8feIQKYydkHws8iJT
         0YJIviCIRziUL7cQvM55tVLrxmiOQo1sEmXWmr/Cu+odjFfLQ8ZNRSjkdQtQivNnRdLO
         ADbi2PBBCW3rp8HR/dEz5nonXqXSscwJoVqyku6UUDIIer225gArIIk44uOxh/mv0VPg
         x9ENhHTYLNLI/aoMoPqt6aB+O+i1ibpzvYabU8XRv4GJp5RDLHpvaIHRlPT04xXU1y1M
         U1xw==
X-Gm-Message-State: APjAAAUEmBK5Vaalj2/R3ZkPbtQsdXAZrlEHubSlnhyLQYKRdjjEUtF2
        km6B8LNjoRMzx8n+jEYdh5CaSg==
X-Google-Smtp-Source: APXvYqy9bO/usfvdFvRCWkxVVdZwwaK8oMRu4R8n9ullXNpcFe0FPzC2a9IPf+ONlr+KOyOJ5GZlLw==
X-Received: by 2002:a63:dd53:: with SMTP id g19mr30047290pgj.3.1561356218023;
        Sun, 23 Jun 2019 23:03:38 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id bo20sm10925850pjb.23.2019.06.23.23.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 23:03:36 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:33:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 2/6] thermal/drivers/cpu_cooling: Unregister with the
 policy
Message-ID: <20190624060334.kak2mjuou4napi4x@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621132302.30414-2-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-19, 15:22, Daniel Lezcano wrote:
> Currently the function cpufreq_cooling_register() returns a cooling
> device pointer which is used back as a pointer to call the function
> cpufreq_cooling_unregister(). Even if it is correct, it would make
> sense to not leak the structure inside a cpufreq driver and keep the
> code thermal code self-encapsulate. Moreover, that forces to add an
> extra variable in each driver using this function.
> 
> Instead of passing the cooling device to unregister, pass the policy.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpufreq/arm_big_little.c               |  2 +-
>  drivers/cpufreq/cpufreq.c                      |  2 +-
>  drivers/thermal/cpu_cooling.c                  | 18 ++++++++++--------
>  drivers/thermal/imx_thermal.c                  |  4 ++--
>  .../thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
>  include/linux/cpu_cooling.h                    |  6 +++---
>  6 files changed, 18 insertions(+), 16 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
