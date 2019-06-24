Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97475C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE1320663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561414117;
	bh=dy7uDZ+s0jJhQj5LYz6HtlMtLfkofeu8zE7uCiKKKh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f0IVYWgInLYT+v2MTDOrLCn9va/i41vM5Jqc9w2681nAmYBGpzO4W331MacuRukfn
	 det8rDm2xx3kIInYoH351neQqVpo3rhoU94PlOl17nmrlH8PyMhGXEZcySIUojjb+0
	 hPC3MKTv/fxObuWra8btqsj4OJdnKRjmrSUFurI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfFXWIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:08:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33550 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFXWIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:08:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id i4so15379359otk.0;
        Mon, 24 Jun 2019 15:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iGRYLuRVzU9YzxqK6jPghJ0dUfb/GOU2YwLj9C9w2k=;
        b=RNcFy/0uSvwaxnUUc70zCSSrriH1l1vXjMt2Xo7uPCjaW3BGZGGzh2lMypb2YdoXaf
         9+K1LT4hQJpd7o612iT2ud9ovmSHUpW8Ol8UO8UAJutJhqIvo6JYSxyUlBREq0bmg08i
         Vtyh0VglSpG7whXr00x96tp4yMZzIceGHKmh5QZ4j3Hq2jyl2xmcphZwMxHVmI37lrbU
         u7ZdSmYu1OVUvqFgFrteglJwiIv7lWy7Ze/TATtFyDFJjJq/XYz0WZNI4V3OmF63bWXF
         RB5PCARpBRg5+TUMMdSp/XnVXU73ym0lw9SBe+RQ8uabopvUjLC3LPm90smFOmnWg/a7
         0oaA==
X-Gm-Message-State: APjAAAXqCfh+Aci3GlXycTrsKo0iazsK8wUvyB5SEz77rPSMKeydO0HY
        zjN+CVzRUx9kzwzPjv5XpiXimEibClTaj2s7rsg=
X-Google-Smtp-Source: APXvYqwgzCf5b4E6QZBa9WMG2t/ihRyD3pwVSm4UHJaeDdPUJynzus7tlNl3NtRerTvrfgtAyOk/8J4fnig5t+KEUgI=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr18253366otn.266.1561414115009;
 Mon, 24 Jun 2019 15:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190624131715.1857-1-daniel.lezcano@linaro.org> <20190624131715.1857-2-daniel.lezcano@linaro.org>
In-Reply-To: <20190624131715.1857-2-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jun 2019 00:08:24 +0200
Message-ID: <CAJZ5v0hMGMETyJyLxCKxiGOojAhmJ+Crioj7Gw_2wA+YUAS9QQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal/drivers/cpu_cooling: Unregister with the policy
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

) On Mon, Jun 24, 2019 at 3:17 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Currently the function cpufreq_cooling_register() returns a cooling
> device pointer which is used back as a pointer to call the function
> cpufreq_cooling_unregister(). Even if it is correct, it would make
> sense to not leak the structure inside a cpufreq driver and keep the
> code thermal code self-encapsulate. Moreover, that forces to add an
> extra variable in each driver using this function.

[cut]

> @@ -667,9 +667,9 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>         np = of_get_cpu_node(data->policy->cpu, NULL);
>
>         if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
> -               data->cdev = cpufreq_cooling_register(data->policy);
> -               if (IS_ERR(data->cdev)) {
> -                       ret = PTR_ERR(data->cdev);
> +               cdev = cpufreq_cooling_register(data->policy);

It looks like after the changes in this patch the only reason for
returning (struct thermal_cooling_device *) from
cpufreq_cooling_register() is error checking, but it would be much
more straightforward to return int for this purpose.

Moreover, that would prevent the callers of it from doing incorrect
things with the returned pointers (like using it to unregister the
cooling device).

> +               if (IS_ERR(cdev)) {
> +                       ret = PTR_ERR(cdev);
>                         cpufreq_cpu_put(data->policy);
>                         return ret;
>                 }
