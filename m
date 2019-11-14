Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA333C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B8D2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mok+lx5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfKNInc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:43:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41472 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:43:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id h4so3286105pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 00:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dtXf1cklkEILsdJe1BKmSn+H2sUj3L7wyP1UZ92tPKI=;
        b=Mok+lx5+2tneGl5Q8292wQfcG9ogwNvHx+Af4Ura3ONzfPqpaD6F17vKXMnxIc10pU
         RVKMLLwuCR/6CFa3UmeJrWMtPspfYbxvTQJz/hAFRtNQVh5dAMx8Ez4/HBuDFzENGkI1
         H4j+J+m3Bm5r9flMQlValkUQyEgmoGc2HyHv3c+mrb/+wp5eAt/a4z3YjPhiq/KGeYsp
         dNTpZb3jeMYiSdlie+3XeGPS/WA/CpjgqZQG1p3FpOf5VT+Fdre2/1acs/fjrif2fPux
         3hos112hB2n3qnkSKih/VkNHkhWtkC45liABkgQpZggOinzG18NdqlN7zH4JV0Nznrhh
         nVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dtXf1cklkEILsdJe1BKmSn+H2sUj3L7wyP1UZ92tPKI=;
        b=k7XMUvK+bdykzZyk3gpOb81f2oMWCExBdcOPUGgCfqLN+2OvWI2bSH4PKpAEkA7qlm
         7P1tJykev6Q9lkjJP+zlB3LCS4pwGhuCQulE8t//Kf1AVE+R4+6Xc71ycfG+v5rDHkUT
         kAlQTvygCtdjv+UxpX0znEL7BWV0DP0zU+hCEiiGNUcdvesVg8dHYCO/DlFcMJXX8blD
         o9D0kEl8qrqazSVrTWV0xK2H463cU4ptG4qJ5M9RHSbrvSdhSo8f9ZZDV2+WceLtygwt
         qqVGNXgq0jVBvUNwGx2IyzyOc1aUCgc6eURkYKbHIAmhqrrHYxIwDCW0AZ9bhPmnEF58
         64pg==
X-Gm-Message-State: APjAAAU9B1TtnTI9Pw3p9VHWMPKVC5Xoy5wlVDse6V/7yAXkx4+f7qIN
        xxHDxtkAJVSo7CX5IXsHEdQFBA==
X-Google-Smtp-Source: APXvYqyYhTC0ce+qbjrbGFQFfaNT3sAvLA5TGFmVIHESn/S8uxnmD9nXoKF3hLsxV8VXjaDGQHLtxQ==
X-Received: by 2002:a63:1402:: with SMTP id u2mr8732447pgl.391.1573721010376;
        Thu, 14 Nov 2019 00:43:30 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id z7sm7012468pfr.165.2019.11.14.00.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 00:43:29 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:13:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Register cpufreq drivers only after CPU devices
 are registered
Message-ID: <20191114084327.ra5hnpizeffxzis2@vireshk-i7>
References: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
 <CAJZ5v0jPkP4Nu2zbWuCGCtiBMQcnfaAOdm-GW1KX81GsyV_Cdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jPkP4Nu2zbWuCGCtiBMQcnfaAOdm-GW1KX81GsyV_Cdg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-19, 09:40, Rafael J. Wysocki wrote:
> On Thu, Nov 14, 2019 at 4:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The cpufreq core heavily depends on the availability of the struct
> > device for CPUs and if they aren't available at the time cpufreq driver
> > is registered, we will never succeed in making cpufreq work.
> >
> > This happens due to following sequence of events:
> >
> > - cpufreq_register_driver()
> >   - subsys_interface_register()
> >   - return 0; //successful registration of driver
> >
> > ... at a later point of time
> >
> > - register_cpu();
> >   - device_register();
> >     - bus_probe_device();
> >       - sif->add_dev();
> >         - cpufreq_add_dev();
> >           - get_cpu_device(); //FAILS
> >   - per_cpu(cpu_sys_devices, num) = &cpu->dev; //used by get_cpu_device()
> >   - return 0; //CPU registered successfully
> >
> > Because the per-cpu variable cpu_sys_devices is set only after the CPU
> > device is regsitered, cpufreq will never be able to get it when
> > cpufreq_add_dev() is called.
> >
> > This patch avoids this failure by making sure device structure of at
> > least CPU0 is available when the cpufreq driver is registered, else
> > return -EPROBE_DEFER.
> >
> > Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > @Amit: I have added your sob without asking as you were involved in
> > getting us to this patch, you did a lot of testing yesterday to find the
> > root cause.
> 
> Co-developed-by is for that, so I used it in the commit.
> 
> > @Rafael: This fixes the issues reported by Bjorn on Amit's series and so
> > should land before Amit's series, if at all this is acceptable to you.
> 
> Well, yes it is.
> 
> Applied for 5.5 with a reworded subject, thanks!

Thanks.

-- 
viresh
