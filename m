Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B8C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925D2208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQ3xWBPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfF0VTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:19:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35988 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0VTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:19:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so4116071qtl.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VuNOIsrkuJn68sMQl+6AG/wlOYyIFCWpkQz0BYqbWUE=;
        b=tQ3xWBPTQxk0FQzSlaAULf9Rg1Cl8N8jLVvrZhrcuN0lNDuj9Lnc260PuYNKkwb+/S
         NuotQabeGzveYJ+sQ+jtTwXi31V+kZePGWqukTOyJla5IEsTJfoD3m9e+yvybm3BZfTV
         MDmMMqvXrJ5iFdbgoOdI2oaNoWJJPq0HKmH0wxXPE8OmPwdTW2JEaa1WcMDWRdZvJlC0
         NgiE3QD3h+F5l4cbEFu7xPu7kVvtbnPdrNTHRce7UfMF92tmmegP3qW9ilhubgcIcXpK
         0jdKIi2jxdhOdazKrfz57V1qd8yMUR4kgS5XxnCot+kFOB3C3B3FQU4cAHvO4lqPUsZJ
         XKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuNOIsrkuJn68sMQl+6AG/wlOYyIFCWpkQz0BYqbWUE=;
        b=cCJ7UeVjKtsyVi8Kp8CnT7lHK69zr8guVvl56IISKSD+dQj06iLH9pfGqi0hDKuSQA
         2WCCAhQYT9mcuv42mwzfUuUGYP/m7IN98Sc8LfPtBNE0M6tLO8rixUj3G6tDL4Mpf+oS
         SbUuHCpjFx1OPhhferSoyqiPlgkeqcrAFGvipKaATTN4MMP8BN7zGV+KHTViIjY5EAu4
         q3Z6yiVf14XPLA8Ht0sYw16sdwRphBFB4e9yJgsPMWwbwQCCswLIZ6L7CdNj+hDEzDCM
         Y2kzsWXQ9aFIN9lopb500VRa775ecYGsgeIvhHMb5I8Bq/2NwGmst+ZF+tBEOxUebw2f
         paeQ==
X-Gm-Message-State: APjAAAUQsdJ35tfZHIpP8PZQENaKi/U4AKB8xKFKxUm65cAN69VXXEQa
        AxhfK3z8U3GZ6HSrElHrnqSNcCJ7jka1cL9UWKs=
X-Google-Smtp-Source: APXvYqywkl0GL1zKMECsy2YHhZgiEQMeb5yeAmVPz9Ipon3l6CE5IAFG6D3Y5PsCmxjs6Mj2qAs0jTE9REvKQ78g6r8=
X-Received: by 2002:a0c:9687:: with SMTP id a7mr5285195qvd.163.1561670340320;
 Thu, 27 Jun 2019 14:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190627204446.52499-1-evgreen@chromium.org>
In-Reply-To: <20190627204446.52499-1-evgreen@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 27 Jun 2019 23:18:49 +0200
Message-ID: <CAFqH_53cmq+1Y_uL3D4-84v_vDJsoB0Qxr_zTVnOzX1XD7VEgQ@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: Expose resume result via debugfs
To:     Evan Green <evgreen@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan, Lee,

Missatge de Evan Green <evgreen@chromium.org> del dia dj., 27 de juny
2019 a les 22:46:
>
> For ECs that support it, the EC returns the number of slp_s0
> transitions and whether or not there was a timeout in the resume
> response. Expose the last resume result to usermode via debugfs so
> that usermode can detect and report S0ix timeouts.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Lee, actually this patch depends on some patches from chrome-platform
to apply cleanly. Once is fine with you and if you're happy to have
this merged for 5.3, I can just carry the patch with me, shouldn't be
any conflicts with your current changes or if you prefer I can create
an immutable branch for you.

Thanks,
~ Enric

> ---
>
> Changes in v3:
>  - Expose the debugfs file on all EC types (Enric)
>
> Changes in v2:
>  - Moved from sysfs to debugfs (Enric)
>  - Added documentation (Enric)
>
>
> ---
>  Documentation/ABI/testing/debugfs-cros-ec | 22 ++++++++++++++++++++++
>  drivers/mfd/cros_ec.c                     |  6 +++++-
>  drivers/platform/chrome/cros_ec_debugfs.c |  5 +++++
>  include/linux/mfd/cros_ec.h               |  1 +
>  4 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
> index 573a82d23c89..1fe0add99a2a 100644
> --- a/Documentation/ABI/testing/debugfs-cros-ec
> +++ b/Documentation/ABI/testing/debugfs-cros-ec
> @@ -32,3 +32,25 @@ Description:
>                 is used for synchronizing the AP host time with the EC
>                 log. An error is returned if the command is not supported
>                 by the EC or there is a communication problem.
> +
> +What:          /sys/kernel/debug/<cros-ec-device>/last_resume_result
> +Date:          June 2019
> +KernelVersion: 5.3
> +Description:
> +               Some ECs have a feature where they will track transitions to
> +               the (Intel) processor's SLP_S0 line, in order to detect cases
> +               where a system failed to go into S0ix. When the system resumes,
> +               an EC with this feature will return a summary of SLP_S0
> +               transitions that occurred. The last_resume_result file returns
> +               the most recent response from the AP's resume message to the EC.
> +
> +               The bottom 31 bits contain a count of the number of SLP_S0
> +               transitions that occurred since the suspend message was
> +               received. Bit 31 is set if the EC attempted to wake the
> +               system due to a timeout when watching for SLP_S0 transitions.
> +               Callers can use this to detect a wake from the EC due to
> +               S0ix timeouts. The result will be zero if no suspend
> +               transitions have been attempted, or the EC does not support
> +               this feature.
> +
> +               Output will be in the format: "0x%08x\n".
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 5d5c41ac3845..2a9ac5213893 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -102,12 +102,16 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>
>         /* For now, report failure to transition to S0ix with a warning. */
>         if (ret >= 0 && ec_dev->host_sleep_v1 &&
> -           (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
> +           (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> +               ec_dev->last_resume_result =
> +                       buf.u.resp1.resume_response.sleep_transitions;
> +
>                 WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
>                           EC_HOST_RESUME_SLEEP_TIMEOUT,
>                           "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
>                           buf.u.resp1.resume_response.sleep_transitions &
>                           EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 7ee060743844..967c78abfdd3 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -447,6 +447,11 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>         debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
>                             &cros_ec_uptime_fops);
>
> +       debugfs_create_x32("last_resume_result",
> +                          0444,
> +                          debug_info->dir,
> +                          &ec->ec_dev->last_resume_result);
> +
>         ec->debug_info = debug_info;
>
>         dev_set_drvdata(&pd->dev, ec);
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index 5ddca44be06d..45aba26db964 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -155,6 +155,7 @@ struct cros_ec_device {
>         struct ec_response_get_next_event_v1 event_data;
>         int event_size;
>         u32 host_event_wake_mask;
> +       u32 last_resume_result;
>  };
>
>  /**
> --
> 2.20.1
>
