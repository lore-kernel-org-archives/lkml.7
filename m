Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D9DC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1522C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pClRb23D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbfGYNkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:40:02 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46789 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389523AbfGYNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:40:01 -0400
Received: by mail-yw1-f68.google.com with SMTP id z197so19242339ywd.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lpEIpCXHFfNmFCZkOjPjl+kYtFsIolKVOJaYVjNOcQ=;
        b=pClRb23DEELadcP2hvlaLTNBN9yBrISbS5y+2Sy58VGj4Na8t28OTw/3TBQxSeKiGa
         ya/pMORmmEz8ivB9+l0x9g+WjZdQpqbyWpPuVjw78499uHVw+bJFxkYRu0MRjvQxcoqG
         ttIEHjWh5R85T1aAoaUjRzo236BGJ9Gl2NMSilykUIVINmhDuhX8oCAhtlfWhLYzsI6c
         f6g43kIRS45FZ/q9owmTbNtyaBVbijlHYeSrZRY+MaHzS9r8LMV6QPc/F6pud16pN7gH
         O03xcv5jrziakvliPeRdtuDU0qkVKSERW+WK0HBkkPxeJQbNlVTC+lyZg+RegmnXrEqV
         BO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lpEIpCXHFfNmFCZkOjPjl+kYtFsIolKVOJaYVjNOcQ=;
        b=M1rXHSB2+yX7Qj8gFqK1KqdMdDme020fINwgRgVxu9AwbffT7fHsFR1JQkjNRqpt8H
         wOWo9LMQ3LvH63uju44EE0dJ2o7fSuRxeMMSV/W5nPxJExug7ni9jMdgrFI3lVMJTxdx
         D7DfSaw8OqMBWxycjnLLbpCKvmTk9cp6mX/beXPM80lnugZDyo/EiSi1eMLNLwsw53Gp
         4MJOVdHTZjIqynTf3L2ZFxF5CYuibT3beprFWZ4/oHRYVNGN4KMQ2AELCKhVJpWdLBXy
         p/y71OQzhPq21GVFZ4J3baW+iSbN+QHdHHh77oNiHypoHVqjdzGl6Vm8qqIqsZ5kN72r
         mYRA==
X-Gm-Message-State: APjAAAWAdgvV1so4oH+BPxPNcMqhVUFRpMN+vMN+NLmKKF0lCBwoKWFP
        C/T/brgJM2/hvyEx1YrSmR/8mYu0EfNoT3PSI8rqJw==
X-Google-Smtp-Source: APXvYqwd3ANdyuU4S5oyUK8fV7stI4swqyK5QqzOFTOJPMGNzaeJPgrXe08Y8mGViXoInWrGAq7qVh1nEqKY+yR2k2U=
X-Received: by 2002:a81:30c9:: with SMTP id w192mr52641306yww.371.1564062000403;
 Thu, 25 Jul 2019 06:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <1564043102-25298-1-git-send-email-rtresidd@electromag.com.au>
In-Reply-To: <1564043102-25298-1-git-send-email-rtresidd@electromag.com.au>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 25 Jul 2019 06:39:48 -0700
Message-ID: <CABXOdTdz=+P-HXaUbGAuLBjNE1GA0C8o4OPmF996DOrXxkQJAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] power/supply/sbs-battery: Fix confusing battery
 status when idle or empty
To:     Richard Tresidder <rtresidd@electromag.com.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>, andrew.smirnov@gmail.com,
        Guenter Roeck <groeck@chromium.org>, david@lechnology.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rfontana@redhat.com, allison@lohutok.net, baolin.wang@linaro.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 1:25 AM Richard Tresidder
<rtresidd@electromag.com.au> wrote:
>
> When a battery or batteries in a system are in parallel then one or more
> may not be providing any current to the system.
> This fixes an incorrect
> status indication of FULL for the battery simply because it wasn't
> discharging at that point in time.
> The battery will now be flagged as IDLE.
> Have also added the additional check for the battery FULL DISCHARGED flag
> which will now flag a status of EMPTY.
>
> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> ---
>
> Notes:
>     power/supply/sbs-battery: Fix confusing battery status when idle or empty
>
>     When a battery or batteries in a system are in parallel then one or more
>     may not be providing any current to the system.
>     This fixes an incorrect
>     status indication of FULL for the battery simply because it wasn't
>     discharging at that point in time.
>     The battery will now be flagged as IDLE.
>     Have also added the additional check for the battery FULL DISCHARGED flag
>     which will now flag a status of EMPTY.
>
>  drivers/power/supply/power_supply_sysfs.c |  3 ++-
>  drivers/power/supply/sbs-battery.c        | 28 ++++++++++++++--------------
>  include/linux/power_supply.h              |  2 ++
>  3 files changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index ce6671c..68ec49d 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -51,7 +51,8 @@
>  };
>
>  static const char * const power_supply_status_text[] = {
> -       "Unknown", "Charging", "Discharging", "Not charging", "Full"
> +       "Unknown", "Charging", "Discharging", "Not charging", "Full",
> +       "Empty", "Idle"
>  };
>
>  static const char * const power_supply_charge_type_text[] = {
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index ea8ba3e..e6c636c 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -294,14 +294,10 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
>
>         ret = (s16)ret;
>
> -       /* Not drawing current means full (cannot be not charging) */
> -       if (ret == 0)
> -               *intval = POWER_SUPPLY_STATUS_FULL;
> -
> -       if (*intval == POWER_SUPPLY_STATUS_FULL) {
> -               /* Drawing or providing current when full */
> -               if (ret > 0)
> -                       *intval = POWER_SUPPLY_STATUS_CHARGING;
> +       if (*intval == POWER_SUPPLY_STATUS_DISCHARGING) {
> +               /* Charging indicator not set in battery */
> +               if (ret == 0)
> +                       *intval = POWER_SUPPLY_STATUS_IDLE;

But doesn't the above already indicate that it _is_ discharging ?

>                 else if (ret < 0)
>                         *intval = POWER_SUPPLY_STATUS_DISCHARGING;

This doesn't make sense. *intval is already set to
POWER_SUPPLY_STATUS_DISCHARGING
in this situation.

>         }
> @@ -424,10 +420,12 @@ static int sbs_get_battery_property(struct i2c_client *client,
>
>                 if (ret & BATTERY_FULL_CHARGED)
>                         val->intval = POWER_SUPPLY_STATUS_FULL;
> -               else if (ret & BATTERY_DISCHARGING)
> -                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> -               else
> +               else if (ret & BATTERY_FULL_DISCHARGED)
> +                       val->intval = POWER_SUPPLY_STATUS_EMPTY;
> +               else if (!(ret & BATTERY_DISCHARGING))
>                         val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +               else
> +                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>
>                 sbs_status_correct(client, &val->intval);
>
> @@ -781,10 +779,12 @@ static void sbs_delayed_work(struct work_struct *work)
>
>         if (ret & BATTERY_FULL_CHARGED)
>                 ret = POWER_SUPPLY_STATUS_FULL;
> -       else if (ret & BATTERY_DISCHARGING)
> -               ret = POWER_SUPPLY_STATUS_DISCHARGING;
> -       else
> +       else if (ret & BATTERY_FULL_DISCHARGED)
> +               ret = POWER_SUPPLY_STATUS_EMPTY;
> +       else if (!(ret & BATTERY_DISCHARGING))
>                 ret = POWER_SUPPLY_STATUS_CHARGING;
> +       else
> +               ret = POWER_SUPPLY_STATUS_DISCHARGING;
>
>         sbs_status_correct(chip->client, &ret);
>
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 28413f7..c9f3347 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -37,6 +37,8 @@ enum {
>         POWER_SUPPLY_STATUS_DISCHARGING,
>         POWER_SUPPLY_STATUS_NOT_CHARGING,
>         POWER_SUPPLY_STATUS_FULL,
> +       POWER_SUPPLY_STATUS_EMPTY,
> +       POWER_SUPPLY_STATUS_IDLE,
>  };
>
>  /* What algorithm is the charger using? */
> --
> 1.8.3.1
>
