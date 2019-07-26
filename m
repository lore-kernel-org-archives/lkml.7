Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404B9C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F46A22ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6ymUR/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfGZLK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:10:29 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40180 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZLK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:10:28 -0400
Received: by mail-vk1-f194.google.com with SMTP id s16so10662917vke.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+Y4qgFTam8jDltpvXuikpB8NUvS6TICI4gc9Km9/9k=;
        b=h6ymUR/Wdkaz6QZ4Um19bcsrvjqfet3lOXOatySMUhcMsrmEKhWpAQeHUddOjCUNG3
         8WeP22kIavryy39NJwXKRvLKJ4vVKpMDEwh2N0XjjWNcFCgvidhJPjVQt0FzUNE/JMIQ
         yjLzh+5CdkEL9g3pA66wOLstWpNlcVMw7ByhMinQ3f0dGplCAFW29WoxF1qJRmvtks+z
         icKmRjT4r+Ny+PNs/ATAEP29tMcRIq8dHAJRDgkPcmyC0DI42VdXfqKcuQzdMAbJUAEz
         tycKTPE4UR3UJmQCszlSYhFC6yqR6bMEE0o5kVcW4yOFVAF2YeM8b2bbmNqh40JfB80y
         tBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+Y4qgFTam8jDltpvXuikpB8NUvS6TICI4gc9Km9/9k=;
        b=kRJvunfl2qSGBhBQ17MLynGbWB6ZGzJ2bb/JpMoFJn9kGRyB4SJp4LU2NtjBt3ZNw3
         mNApgt0FClr7jr/hPPOCVLqpu58dKLF28K0XuBbk43h3qtqVJNBjYMBAxZqSyU4WWIhs
         0WiL2EYdnfQarXeJ+HHWadg3l35kqrFIS8d6C4jJl2Bq5hvL86xoA8DRtA+wDSwhTiyy
         yqbec2Su742IODPg5EYm5P+vFzigC5og41MCTXHhI52EY6hIhX7cTEzXhEa7Bn7ixCy7
         UCu9+oNCApPNINgD2O8Dag2D+zDw0olOtvBAPmEvOhzG4XLL6Dtu+LzQUO5E/+09ncXu
         R8ug==
X-Gm-Message-State: APjAAAVqbM/LmoKQG5oY9ZOUXEhoT1UFQAIvMhmoTs4Om52NUYLZ2BVq
        OGr4KPK1FvXOcA/VUgup7e8GmuQFg5fnaTprfaY=
X-Google-Smtp-Source: APXvYqyEsPXdjlXDvRHyswcdqr7QLVWVINq/KpziiOOUpNZiXxfeIAhCZiR3dfWmbEtxVpwZXJ65KmcjHMQWEQ8HGPM=
X-Received: by 2002:a1f:62c3:: with SMTP id w186mr17914153vkb.82.1564139427268;
 Fri, 26 Jul 2019 04:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org> <20190726103605.GB3327@onstation.org>
In-Reply-To: <20190726103605.GB3327@onstation.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 26 Jul 2019 16:40:16 +0530
Message-ID: <CAHLCerOs3cMQrWrYk7F_bnxr_nxJ-nsRL8oOGALU63ySqmLaig@mail.gmail.com>
Subject: Re: [PATCH 00/15] thermal: qcom: tsens: Add interrupt support
To:     Brian Masney <masneyb@onstation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending from a desktop client because mobile gmail apparently sends
html that gets rejected by all lists)

On Fri, Jul 26, 2019 at 4:06 PM Brian Masney <masneyb@onstation.org> wrote:
>
> Hi Amit,
>
> On Fri, Jul 26, 2019 at 03:48:35AM +0530, Amit Kucheria wrote:
> > Add interrupt support to TSENS. The first 6 patches are general fixes and
> > cleanups to the driver before interrupt support is introduced.
> >
> > This series has been developed against qcs404 and sdm845 and then tested on
> > msm8916. Testing on msm8998 and msm8974 would be appreciated since I don't
> > have hardware handy. Further, I plan to test on msm8996 and also submit to
> > kernelci.
> >
> > I'm sending this out for more review to get help with testing.
>
> I can test this on msm8974 for you using a Nexus 5. Here's what I've
> done so far:

Thanks. I was hoping that would be the case given all your effort
getting Nexus 5 supported. :-)

> The device tree nodes appear in sysfs:
>
> / # ls -1 /sys/class/thermal/
> cooling_device0
> cooling_device1
> thermal_zone0
> thermal_zone1
> thermal_zone2
> thermal_zone3
> thermal_zone4
> thermal_zone5
> thermal_zone6
> thermal_zone7
> thermal_zone8
> thermal_zone9

Looks good. What are the contents of the files inside the two
cooling_device directories? The output of the following command would
be nice:

$ grep "" cooling_device?/*

> The various temperatures were in the upper 40s and I threw some work at
> all four CPU cores to warm up the phone and watched the various
> temperatures rise:
>
> / # for i in $(seq 0 9) ; do
> > TYPE=$(cat /sys/class/thermal/thermal_zone$i/type)
> > TEMP=$(cat /sys/class/thermal/thermal_zone$i/temp)
> > echo "$TYPE = $TEMP"
> > done
> cpu-thermal0 = 66000
> cpu-thermal1 = 66000
> cpu-thermal2 = 66000
> cpu-thermal3 = 66000
> q6-dsp-thermal = 60000
> modemtx-thermal = 57000
> video-thermal = 61000
> wlan-thermal = 65000
> gpu-thermal-top = 61000
> gpu-thermal-bottom = 59000
>
> To test the interrupt support, I lowered all of the temperature trips to
> 51C but I'm not sure where to read that notification. I assume one of
> the cooling devices or a governor should be started? Sorry but I haven't
> done any work in the thermal subsystem yet and I'm short on time this
> morning to investigate right now.

For now, just checking if the tsens interrupt in /proc/interrupts
fires should be fine. I have another patch to add some information to
debugs that I'll send at some point.

How well does cpufreq work on 8974? I haven't looked at it yet but
we'll need it for thermal throttling.

> Brian
