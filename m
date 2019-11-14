Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45365C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A172071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtbncTT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfKNHDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:03:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42804 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfKNHDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:03:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id m4so4103019qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 23:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDWEwzVGX/Z+LhLTkyUvC+5Du7NTkM6wxTPRe/Giii8=;
        b=UtbncTT5Mcc2iIxq5EcLUpW7wJHJqWv8QO2+J5fJlVFCEKzUMU5n5sb5QktLpIhMz2
         7KOrmoB0hBSJW7Jfarnzt6rl7JNhTDWuQNhRB231fK/g3Oq6ngxWLeoE96tVh5jJvzGm
         zP38uDDRcefnZkkzU3OhCff95r3cUiY+6gFvPKECiCeyS3BBMbqdZK+H6VPpmQzbi4Jx
         INOelEZ0IE4w7v5zmqQ0nQAX5XYXwfhmuC+YJbbcsqy+2dzkcLeSSg8MToX+pqMKeD9/
         EyUGf+wYRR4BEdHvV7l2ZvyjbA0SXCWhSNrCUxjZxm5+WKiGBg/p3lgNs8QOaoQ80w8w
         ytCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDWEwzVGX/Z+LhLTkyUvC+5Du7NTkM6wxTPRe/Giii8=;
        b=gjkp5112hNamaakX5V88so+5PvzzT7kX6lzkz1f8BDl3veU4yHnFYQUFW61v+9qubw
         rD7pm0yMrUMuzcHoMFPWrZVcHjHXs0F1OkJM2gBSbRSbM7X5rwZCuxSqPzZwAprs4HrY
         w5ZcshasgBFbCdwepXfmYJbwdYI3tJKpV8tR2ig+jFUT8BYH67gY642PJlW10iVra1rP
         N0aKkgIu3zTi5BA2iEHIV1obC+PI4oZsIQSfVSCgctoq9EifgCu67TjmUioJii6+OGSA
         Uk9z8opO4uQjgKy5ncR2OjDAzGz+QXhhQlSQOFcsNMoNd8cKUoIPoPtS4szl7sljkJQ4
         410w==
X-Gm-Message-State: APjAAAVj459nQe+xvVvkTu6V80jLnbgoPlrGR0dIPsXud1ckaoZpL/Us
        0vFMB1W4aOS8GJ0PMgxrjR6GaIRM/4i95SRKmXLnEg==
X-Google-Smtp-Source: APXvYqyClIXRtpHWxVwISkB81In7x8GdFSI2pOnue5OUeAsLIZcRt8sSpsoXpyBIOobz9cg4CLFmsrcvnvm7sIRqkj4=
X-Received: by 2002:a37:5603:: with SMTP id k3mr6327873qkb.346.1573715009867;
 Wed, 13 Nov 2019 23:03:29 -0800 (PST)
MIME-Version: 1.0
References: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
In-Reply-To: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 14 Nov 2019 12:33:18 +0530
Message-ID: <CAP245DXgrnkVWp2ycObP+b5MV7CT8JzQdgxe8CeWktFT-eE6GQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Register cpufreq drivers only after CPU devices
 are registered
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 9:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cpufreq core heavily depends on the availability of the struct
> device for CPUs and if they aren't available at the time cpufreq driver
> is registered, we will never succeed in making cpufreq work.
>
> This happens due to following sequence of events:
>
> - cpufreq_register_driver()
>   - subsys_interface_register()
>   - return 0; //successful registration of driver
>
> ... at a later point of time
>
> - register_cpu();
>   - device_register();
>     - bus_probe_device();
>       - sif->add_dev();
>         - cpufreq_add_dev();
>           - get_cpu_device(); //FAILS
>   - per_cpu(cpu_sys_devices, num) = &cpu->dev; //used by get_cpu_device()
>   - return 0; //CPU registered successfully
>
> Because the per-cpu variable cpu_sys_devices is set only after the CPU
> device is regsitered, cpufreq will never be able to get it when
> cpufreq_add_dev() is called.
>
> This patch avoids this failure by making sure device structure of at
> least CPU0 is available when the cpufreq driver is registered, else
> return -EPROBE_DEFER.
>
> Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
> @Amit: I have added your sob without asking as you were involved in
> getting us to this patch, you did a lot of testing yesterday to find the
> root cause.

SoB for the SoB :-)

> @Rafael: This fixes the issues reported by Bjorn on Amit's series and so
> should land before Amit's series, if at all this is acceptable to you.
> Thanks.

My series was going to get merged through the thermal tree. Currently
it is hosted here[1] for linux-next testing. We could sign-off this
patch to the thermal tree or bring the series into the PM tree. Up to
Rafael and you.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

>  drivers/cpufreq/cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 681c1b5f0a1a..05293b43e56d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2641,6 +2641,13 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>         if (cpufreq_disabled())
>                 return -ENODEV;
>
> +       /*
> +        * The cpufreq core depends heavily on the availability of device
> +        * structure, make sure they are available before proceeding further.
> +        */
> +       if (!get_cpu_device(0))
> +               return -EPROBE_DEFER;
> +
>         if (!driver_data || !driver_data->verify || !driver_data->init ||
>             !(driver_data->setpolicy || driver_data->target_index ||
>                     driver_data->target) ||
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
