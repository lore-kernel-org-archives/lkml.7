Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D579C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415112070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2Vvvj5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfDBSrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:47:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41585 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfDBSrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:47:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id o129so8558253qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wbnnvRHb0lPsNaU/XDt0OX50w24Lrp0+QFNJFhAzPFA=;
        b=A2Vvvj5CGtwm4Vz9bdDool4LI0k6JeJ659yLmXt4T2TAjV0m4biRy2TEasASsi8LgH
         BGW+uJDOfj1Rsdn5bOIznLhGgoI6QuXDsCEmy48BD+llJIqytZGEgCg1q+dvAGDwZ+C0
         WNvlR1VURHykriR87LmJAnexo46lpg8dkjCTzEqlogoGqNb1CgpjbUaIdhkMD+cBBPhd
         zDg6lLJMkoWK+0OtXImsv/k4qhm+1xBAnvn1xeMhCZwPiXoOgF/6oS2Er+FZDwFRcNhr
         +OEtXbO+XK01beHZwYugZIbliXVsU1JKIra8j5KoQ3xhrpqkFSOhyUO8z0hn6oxtSiYk
         ssRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbnnvRHb0lPsNaU/XDt0OX50w24Lrp0+QFNJFhAzPFA=;
        b=kWwlFK5Nz/8lU5hkhJYSjsXs81Z+yEYasSTFZnFDCqJyQ4vi+ImoTny6CxDCpYs6SW
         KwjTUjAyPkYh2z3/SCEILOzVWW5hCnpc6dWW5mvR+/3uIHXnPOtOJ45feB9/3sOkHSVB
         s+hSWWaRr45bLzTVYGKx+Dup1VFdxjo8SjNwdEonhZek084mNoAZacd6GHwAa2cz6zws
         LClqiM/iJvrdUk1OJPR2XsSFd1hO0IZ294mngvvx6z6bw3aT0sNqatvUdlfK0qm/Olb7
         0Puc3AWTu9HeF3GarwfebsSNGP3jk6mmKsFNOKswghXngPvUy9Ov7BNoIHuu3I8y56u+
         MtIg==
X-Gm-Message-State: APjAAAUYpkf6yutzYReH3ThViWNxRZrEDMLHQrehSWk6GntkfPRbRhGR
        J8ImliS3g1CFmQ4L2Jed7BDCp4B/5GFh3SabREnQBw==
X-Google-Smtp-Source: APXvYqwjAkUYzuL3FZV7lCF9S3v2iyZLdD493PgxAsVFMhHAU/dxZyAChCGVgidFRrI+trVuXBtfz70itSuMx9bMYeE=
X-Received: by 2002:a37:e20e:: with SMTP id g14mr38821708qki.138.1554230822537;
 Tue, 02 Apr 2019 11:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553853990.git.amit.kucheria@linaro.org> <5583cae1-8fea-724a-24a4-59b38a205ac3@free.fr>
In-Reply-To: <5583cae1-8fea-724a-24a4-59b38a205ac3@free.fr>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 3 Apr 2019 01:46:50 +0700
Message-ID: <CAP245DUNo02QUkGDPFfzow9535GKO9x6ZusETRjEgTmnHL4D2g@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] qcom: dts: thermal cleanups
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 8:58 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 29/03/2019 11:12, Amit Kucheria wrote:
>
> > Changes since v1:
> > - Devices that are not associated with cooling-maps use the 'hot' type
> > - Remove critical trip from such devices too and restrict that type of CPUs
> > - For 8916, add the sensor on the modem
> >
> > Description:
> > - Expose all temperature sensors on msm8916, msm996, msm8998, sdm845
> > - split up the register address map for msm8998
> > - standardize names of the various thermal-zones across boards to make it
> >   easy for test scripts to parse
>
> This is what I see on msm8998 with your patch series applied on top of
> yesterday's next:
>
> # dmesg | grep of_parse_thermal_zones
> of_parse_thermal_zones: build cpu0-thermal zone 0
> of_parse_thermal_zones: build cpu1-thermal zone 0
> of_parse_thermal_zones: build cpu2-thermal zone 0
> of_parse_thermal_zones: build cpu3-thermal zone 0
> of_parse_thermal_zones: build cpu4-thermal zone 0
> of_parse_thermal_zones: build cpu5-thermal zone 0
> of_parse_thermal_zones: build cpu6-thermal zone 0
> of_parse_thermal_zones: build cpu7-thermal zone 0
> of_parse_thermal_zones: build gpu-thermal-bottom zone 0
> of_parse_thermal_zones: build gpu-thermal-top zone 0
> of_parse_thermal_zones: build cluster0-mhm-thermal zone -22
> of_parse_thermal_zones: build cluster1-mhm-thermal zone -22
> of_parse_thermal_zones: build cluster1-l2-thermal zone 0
> of_parse_thermal_zones: build modem-thermal zone 0
> of_parse_thermal_zones: build mem-thermal zone 0
> of_parse_thermal_zones: build wlan-thermal zone 0
> of_parse_thermal_zones: build q6-dsp-thermal zone 0
> of_parse_thermal_zones: build camera-thermal zone 0
> of_parse_thermal_zones: build multimedia-thermal zone 0
> of_parse_thermal_zones: build pm8998 zone 0
> of_parse_thermal_zones: build battery-thermal zone 0
> of_parse_thermal_zones: build skin-thermal zone 0
>
> NB: -EINVAL for cluster0-mhm-thermal and cluster1-mhm-thermal
>
>
> # cat /sys/devices/virtual/thermal/thermal_zone*/temp
> 35800
> 35200
> 34500
> 34800
> 34500
> 34100
> 34100
> 33500
> 33800
> cat: /sys/devices/virtual/thermal/thermal_zone17/temp: Invalid argument
> 36100
> cat: /sys/devices/virtual/thermal/thermal_zone19/temp: Invalid argument
> 35500
> 36100
> 35800
> 35200
> 35500
> 36100
> cat: /sys/devices/virtual/thermal/thermal_zone8/temp: Invalid argument
> cat: /sys/devices/virtual/thermal/thermal_zone9/temp: Invalid argument
>
>
> Are the failures expected?
> (cluster*-mhm-thermal and thermal_zone*/temp)

No they are not. Unfortunately, I didn't have HW to test, so
appreciate the help with testing. I'll check the 8, 9, 17 and 19 again
before resubmitting.

Regards,
Amit
