Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A720C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F039B206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9UWWQ2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfDWM4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:56:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36476 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfDWM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:56:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id m137so4777840qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEze09IdSHBGGlH96R+KwNIu2LaROjVW7jKqngW7jgA=;
        b=G9UWWQ2WoAseR9WV0y8T5h6iRyZcXmWAiF3BPd9bmTcKSY6bfbwpW9DwstED4UA+xU
         TCnjAWt8Fy74r6o28OEdrm3swN6R9Gpz3voEiZA4Deoo+FxrE3SjL8gq7VbkNrMzzRn/
         Vz7RKOc8ePC6EuSRPbkyRalT2fqju2/TfbWeM1KVvtZ+IRlTbqo9kdHY+4zpBzMxLocm
         QXKL1Mqj9kGjtoHIOTRHRTNiQTqr5lpVR0D2dN3x2+KnI5eQ3wv1YjJ97PqL1ea/6XZB
         Iw2vduUfWLne7dy7LwYRI6RGkrKT97m46+/lr2Ycoqo0+pRayNvrH+na6qcwX0o2viVL
         q5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEze09IdSHBGGlH96R+KwNIu2LaROjVW7jKqngW7jgA=;
        b=bOlwgmxGkpq1lzKM94owISAYROyPqy+aYPftEquHYAHm8pbTNCx8KThIG+1rNebS8s
         w5OAkynfXXTpupqdWusNGTYo5JthJp7vxP14xSrmGbY6njIaJ4rj1UIQeodTd4IyoerZ
         AgcXP+J6Tl2lJcOovPkTZ0x/WQ6vSVfWnpPNWv9l8hRES0R0ILbORZaGRSqBNaNkn9+X
         jODwF8JrkXlDgGBeKcBq8VZYjjtXeiLPJh06/+ZEbixAsX1gTjpidnu0Q4M+mXKUN9AW
         vl/pa9/MVSUztqOwEEx0ApButHDVJYhjU6O1KBSfC7VWXM3ygWVjb/YIZkW6uXLjVysB
         +6FA==
X-Gm-Message-State: APjAAAUULMh0XyZuzZZrO+cWF5SjghEK0oJJElxEdZF8d346X4HCltBl
        vienrwexFhB3H2M9WhroEz4LP1jXV/oNPqfw+E5jrQ==
X-Google-Smtp-Source: APXvYqwn+wWks9tto2Z41zGXeWqZuRRzCi7D/T8ro52aUdmjCC3FwGne9MA5gGI/UAZaNC+PTyN+SHPHaqRVKfRK8Jc=
X-Received: by 2002:a37:b444:: with SMTP id d65mr18843156qkf.125.1556024211546;
 Tue, 23 Apr 2019 05:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553853990.git.amit.kucheria@linaro.org>
 <5583cae1-8fea-724a-24a4-59b38a205ac3@free.fr> <CAP245DUNo02QUkGDPFfzow9535GKO9x6ZusETRjEgTmnHL4D2g@mail.gmail.com>
 <842b06c6-15b2-7ba6-702e-c8b043d390a6@free.fr>
In-Reply-To: <842b06c6-15b2-7ba6-702e-c8b043d390a6@free.fr>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 23 Apr 2019 18:26:40 +0530
Message-ID: <CAP245DVqGQ6MEfcYjr2PYnD=BR86vC=BsRMpZe0jsgbAc6jFGg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] qcom: dts: thermal cleanups
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 3:01 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 02/04/2019 20:46, Amit Kucheria wrote:
>
> > On Tue, Apr 2, 2019 at 8:58 PM Marc Gonzalez wrote:
> >>
> >> On 29/03/2019 11:12, Amit Kucheria wrote:
> >>
> >>> Changes since v1:
> >>> - Devices that are not associated with cooling-maps use the 'hot' type
> >>> - Remove critical trip from such devices too and restrict that type of CPUs
> >>> - For 8916, add the sensor on the modem
> >>>
> >>> Description:
> >>> - Expose all temperature sensors on msm8916, msm996, msm8998, sdm845
> >>> - split up the register address map for msm8998
> >>> - standardize names of the various thermal-zones across boards to make it
> >>>   easy for test scripts to parse
> >>
> >> This is what I see on msm8998 with your patch series applied on top of
> >> yesterday's next:
> >>
> >> # dmesg | grep of_parse_thermal_zones
> >> of_parse_thermal_zones: build cpu0-thermal zone 0
> >> of_parse_thermal_zones: build cpu1-thermal zone 0
> >> of_parse_thermal_zones: build cpu2-thermal zone 0
> >> of_parse_thermal_zones: build cpu3-thermal zone 0
> >> of_parse_thermal_zones: build cpu4-thermal zone 0
> >> of_parse_thermal_zones: build cpu5-thermal zone 0
> >> of_parse_thermal_zones: build cpu6-thermal zone 0
> >> of_parse_thermal_zones: build cpu7-thermal zone 0
> >> of_parse_thermal_zones: build gpu-thermal-bottom zone 0
> >> of_parse_thermal_zones: build gpu-thermal-top zone 0
> >> of_parse_thermal_zones: build cluster0-mhm-thermal zone -22
> >> of_parse_thermal_zones: build cluster1-mhm-thermal zone -22
> >> of_parse_thermal_zones: build cluster1-l2-thermal zone 0
> >> of_parse_thermal_zones: build modem-thermal zone 0
> >> of_parse_thermal_zones: build mem-thermal zone 0
> >> of_parse_thermal_zones: build wlan-thermal zone 0
> >> of_parse_thermal_zones: build q6-dsp-thermal zone 0
> >> of_parse_thermal_zones: build camera-thermal zone 0
> >> of_parse_thermal_zones: build multimedia-thermal zone 0
> >> of_parse_thermal_zones: build pm8998 zone 0
> >> of_parse_thermal_zones: build battery-thermal zone 0
> >> of_parse_thermal_zones: build skin-thermal zone 0
> >>
> >> NB: -EINVAL for cluster0-mhm-thermal and cluster1-mhm-thermal
> >>
> >>
> >> # cat /sys/devices/virtual/thermal/thermal_zone*/temp
> >> 35800
> >> 35200
> >> 34500
> >> 34800
> >> 34500
> >> 34100
> >> 34100
> >> 33500
> >> 33800
> >> cat: /sys/devices/virtual/thermal/thermal_zone17/temp: Invalid argument
> >> 36100
> >> cat: /sys/devices/virtual/thermal/thermal_zone19/temp: Invalid argument
> >> 35500
> >> 36100
> >> 35800
> >> 35200
> >> 35500
> >> 36100
> >> cat: /sys/devices/virtual/thermal/thermal_zone8/temp: Invalid argument
> >> cat: /sys/devices/virtual/thermal/thermal_zone9/temp: Invalid argument
> >>
> >>
> >> Are the failures expected?
> >> (cluster*-mhm-thermal and thermal_zone*/temp)
> >
> > No they are not. Unfortunately, I didn't have HW to test, so
> > appreciate the help with testing. I'll check the 8, 9, 17 and 19 again
> > before resubmitting.
>
> Looks like Andy merged this series?

Argh! my bad, I completely forgot about the need to fix this up. I
need to get me one of these boards.

> https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next
>
> I was expecting a respin, or a discussion of the failures.
>
> Slightly confused. What next?
>

We can either revert that one patch for the msm8998, but I think it
might be better if I send a fixup patch that could fixup those 4 zones
instead.

Does that work for you?

Regards,
Amit
