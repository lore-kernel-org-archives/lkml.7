Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0293C0044D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D14206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="put0ttU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfLDIl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:41:27 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43450 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfLDIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:41:26 -0500
Received: by mail-vs1-f65.google.com with SMTP id x4so1416269vsx.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 00:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQKWqo5Ul5HVHtOUORHbCDERxt4j9fxv7YCvpaF1TZM=;
        b=put0ttU5VLO+EBQ6LYQzbIk0N4pidLcjzTd6Pj7xQJASCeQmIM/VssqLUy0bq0b93v
         HtZQvs7oYlSH32sUBG5S5Lr82TM9OJ6/POfRKTbx1ViReB2+WcTmqE1ykDbro4CmDDD3
         6MccHJGUw0+msMG4qTETOofaRI2hLJ0ZUkynpA7wHyQPFOQgoAnjiBdeO6lSGW6nQfkn
         Pet+mmzBCMQUQ71EQiVvTQkVRTvEsHueTT3nGCLMa3SfNRYc08vQNs1R5P3LmmqZ7DPb
         xg7CsXpWQ2Ke28nlBlnBFWaQ7P9rT/R9f8eq9MIOORW6d7bXomitJN7oh+pD65pAUBRa
         LdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQKWqo5Ul5HVHtOUORHbCDERxt4j9fxv7YCvpaF1TZM=;
        b=ZXrcAdp2G/5hcVqk7q4oTSli6n0h88Z/PhQiYf2kgZR6hunnZDoFpH/qOce5OlxBsF
         g35fvL4ajSGdGrVk9WofZFxyhP3Lpldn2wNNGBjvZK0kIF8O+qMPSfLQY6GqnpvhJTk0
         5bDcliu1kaM6+5IdwXO2Eih1D7RZLyRP8ZIvtqED0MNhIk5Y1gV1aKhWPsKkPfQUdp9A
         FJnRHEFd1LO6OazKVybVqpISLvMekxc1WKc+LnE67KQHH5uNAYUpAbOVGVN5WEF3Cdkv
         D3pR+0xj/Hp4V1Ut98zYVJ5hh1EO+rJU/mDLLiQpD58juu22ndlXqaS0EHQk7rcxAk4D
         QcFQ==
X-Gm-Message-State: APjAAAWNqyD2sacvn8q8RpPYaBjvspM67JxHfNoCY4qOEhpAHwtRrThm
        3aAkDFwruYfAtO0xIoVC0qaeBVtehQumpHd/Fx+BeQ==
X-Google-Smtp-Source: APXvYqx3ReMhc5/tnLLDNWde+euvUxoDV0VfeZHcxwaUg5zM7WwrWNoEI3QnjNkobs25W8XAc4phHgFcVksuksneb78=
X-Received: by 2002:a67:f8cf:: with SMTP id c15mr954910vsp.27.1575448884828;
 Wed, 04 Dec 2019 00:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20191030182132.25763-1-f.fainelli@gmail.com> <20191030182132.25763-2-f.fainelli@gmail.com>
In-Reply-To: <20191030182132.25763-2-f.fainelli@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 4 Dec 2019 14:11:13 +0530
Message-ID: <CAHLCerP6ricempeG=x-a2_aA6__YqADPKAEG5y7qPYNcD2=47Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] thermal: brcmstb_thermal: Do not use DT coefficients
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:51 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> At the time the brcmstb_thermal driver and its binding were merged, the
> DT binding did not make the coefficients properties a mandatory one,
> therefore all users of the brcmstb_thermal driver out there have a non
> functional implementation with zero coefficients. Even if these
> properties were provided, the formula used for computation is incorrect.
>
> The coefficients are entirely process specific (right now, only 28nm is
> supported) and not board or SoC specific, it is therefore appropriate to
> hard code them in the driver given the compatibility string we are
> probed with which has to be updated whenever a new process is
> introduced.
>
> We remove the existing coefficients definition since subsequent patches
> are going to add support for a new process and will introduce new
> coefficients as well.
>
> Fixes: 9e03cf1b2dd5 ("thermal: add brcmstb AVS TMON driver")

I think you should fix the computation formula as the first patch and
then merge the rest of this patch into your second patch.

I don't think the intermediate state of converting named constants to
magic numbers is needed just to convert it over to another set of
parameters.

Regards,
Amit

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 37 ++++------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 5825ac581f56..42482af0422e 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -48,15 +48,6 @@
>  #define AVS_TMON_TEMP_INT_CODE         0x1c
>  #define AVS_TMON_TP_TEST_ENABLE                0x20
>
> -/* Default coefficients */
> -#define AVS_TMON_TEMP_SLOPE            -487
> -#define AVS_TMON_TEMP_OFFSET           410040
> -
> -/* HW related temperature constants */
> -#define AVS_TMON_TEMP_MAX              0x3ff
> -#define AVS_TMON_TEMP_MIN              -88161
> -#define AVS_TMON_TEMP_MASK             AVS_TMON_TEMP_MAX
> -
>  enum avs_tmon_trip_type {
>         TMON_TRIP_TYPE_LOW = 0,
>         TMON_TRIP_TYPE_HIGH,
> @@ -108,23 +99,11 @@ struct brcmstb_thermal_priv {
>         struct thermal_zone_device *thermal;
>  };
>
> -static void avs_tmon_get_coeffs(struct thermal_zone_device *tz, int *slope,
> -                               int *offset)
> -{
> -       *slope = thermal_zone_get_slope(tz);
> -       *offset = thermal_zone_get_offset(tz);
> -}
> -
>  /* Convert a HW code to a temperature reading (millidegree celsius) */
>  static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
>                                         u32 code)
>  {
> -       const int val = code & AVS_TMON_TEMP_MASK;
> -       int slope, offset;
> -
> -       avs_tmon_get_coeffs(tz, &slope, &offset);
> -
> -       return slope * val + offset;
> +       return (410040 - (int)((code & 0x3FF) * 487));
>  }
>
>  /*
> @@ -136,20 +115,16 @@ static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
>  static inline u32 avs_tmon_temp_to_code(struct thermal_zone_device *tz,
>                                         int temp, bool low)
>  {
> -       int slope, offset;
> -
> -       if (temp < AVS_TMON_TEMP_MIN)
> -               return AVS_TMON_TEMP_MAX; /* Maximum code value */
> -
> -       avs_tmon_get_coeffs(tz, &slope, &offset);
> +       if (temp < -88161)
> +               return 0x3FF;   /* Maximum code value */
>
> -       if (temp >= offset)
> +       if (temp >= 410040)
>                 return 0;       /* Minimum code value */
>
>         if (low)
> -               return (u32)(DIV_ROUND_UP(offset - temp, abs(slope)));
> +               return (u32)(DIV_ROUND_UP(410040 - temp, 487));
>         else
> -               return (u32)((offset - temp) / abs(slope));
> +               return (u32)((410040 - temp) / 487);
>  }
>
>  static int brcmstb_get_temp(void *data, int *temp)
> --
> 2.17.1
>
