Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1868FC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D349A206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZeAoGiid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbfG2NZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:25:06 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42838 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbfG2NZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:25:05 -0400
Received: by mail-yw1-f67.google.com with SMTP id z63so22621057ywz.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZNU74C1BHudY0v+TRLf1ER5+Gf9d13ix6kb6K85l6k=;
        b=ZeAoGiidOHgi08wtMULgLv5UcGj/LEjUVpGD4LFcZ/OcRe+tETC3bPQairf7pF/sIc
         P2bpS6rlxICyOCKo55QXfYjPHnccf9FqbYmFE6aMF9azRxT0vhegY6cHXX381+p/zuwP
         Rrk6WGaoX7+qs0JculZyZ3e6murhHrgqLJMNBmC56XDpj9JTqjNptD1Nnwe2VVDvlE5J
         TE3UXjtM55I9jo6wZ3XU3SymluO/0Czj7+lPKYpq5aAotX1ZzJaasVI3mGAdBq3FImDk
         4O61B5JUGTQ5a+M7DOewjVtdXA4c/RjJkI0BP4hFBdxBuUlaLNNya2geFapyd/pCO9jA
         y3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZNU74C1BHudY0v+TRLf1ER5+Gf9d13ix6kb6K85l6k=;
        b=ZErZLXGat0RdovOxSyMuQ+9zxmjYN1XM3nnuJe/59P3ZSvHXmhvD5KRb1kQhTf1aN0
         9WEaqPGZcTpGC746IiBD6r3JA7H+9F/wihob5YwGQoTekEWnlGdK7ZiGdds2TygNrxCD
         4nwXsqwGJqYtEc4iO/UALlSYLxIb4mkqs5MsNC8N1DH342q2yxQpFehxGGvz9xwYuffP
         4+tfOmYemPUsRSAPwF2JvzQZMVPqKNTDKt8mVJwMZPVzuPThOrJtFGQki32HLobxtZcI
         4TnmpXZ72DcNJwZm1ezRZy8B9n96XqmTqwW6HrJf/Aoe079f+8Nlm4rJi2Ed0VMMucZl
         lj0A==
X-Gm-Message-State: APjAAAX8RF5xgf+QwfMJmsq/Xdh5VrV5d+/VCDkBjKH09RnPaFWQZNT1
        s/KpSK3SXmq4F7mvzh5gnH+S6ELGSPkhAM4u/SqhtA==
X-Google-Smtp-Source: APXvYqwNnIeXzFTCQpLlhIfWUqJKJRTPZ6Q+aDrjZTU6kmeuCjOPG21IyGPIYnbNwj7dUZ7Tbpq+qe8fI1vZ1FYfpwo=
X-Received: by 2002:a81:a909:: with SMTP id g9mr63804054ywh.233.1564406704522;
 Mon, 29 Jul 2019 06:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <1564387659-62064-1-git-send-email-rtresidd@electromag.com.au>
In-Reply-To: <1564387659-62064-1-git-send-email-rtresidd@electromag.com.au>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 29 Jul 2019 06:24:53 -0700
Message-ID: <CABXOdTdnGXuOiiRyNtvGvuxox2NN_ZTH2Fe8=EjnX576g24GAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] power/supply/sbs-battery: Fix confusing battery
 status when idle or empty
To:     Richard Tresidder <rtresidd@electromag.com.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>, andrew.smirnov@gmail.com,
        Guenter Roeck <groeck@chromium.org>, david@lechnology.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rfontana@redhat.com, allison@lohutok.net,
        Baolin Wang <baolin.wang@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 1:08 AM Richard Tresidder
<rtresidd@electromag.com.au> wrote:
>
> When a battery or batteries in a system are in parallel then one or more
> may not be providing any current to the system.
> This fixes an incorrect status indication of FULL for the battery simply
> because it wasn't discharging at that point in time.
> The battery will now be flagged as NOT CHARGING.
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
>     This fixes an incorrect status indication of FULL for the battery simply
>     because it wasn't discharging at that point in time.
>     The battery will now be flagged as NOT CHARGING.
>     Have also added the additional check for the battery FULL DISCHARGED flag
>     which will now flag a status of EMPTY.
>
>     v2: Missed a later merge that should have been included in original patch
>     v3: Refactor the sbs_status_correct function to capture all the states for
>         normal operation rather than being spread across multile functions.
>
>  drivers/power/supply/power_supply_sysfs.c |  2 +-
>  drivers/power/supply/sbs-battery.c        | 44 +++++++++++--------------------
>  include/linux/power_supply.h              |  1 +
>  3 files changed, 18 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index f37ad4e..305e833 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -51,7 +51,7 @@
>  };
>
>  static const char * const power_supply_status_text[] = {
> -       "Unknown", "Charging", "Discharging", "Not charging", "Full"
> +       "Unknown", "Charging", "Discharging", "Not charging", "Full", "Empty"
>  };
>
>  static const char * const power_supply_charge_type_text[] = {
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 048d205..b28402d 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -293,16 +293,18 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
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
> -               else if (ret < 0)
> -                       *intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +       if (ret > 0)
> +               *intval = POWER_SUPPLY_STATUS_CHARGING;
> +       else if (ret < 0)
> +               *intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +       else {
> +               /* Current is 0, so how full is the battery? */
> +               if (*intval & BATTERY_FULL_CHARGED)
> +                       *intval = POWER_SUPPLY_STATUS_FULL;
> +               else if (*intval & BATTERY_FULL_DISCHARGED)
> +                       *intval = POWER_SUPPLY_STATUS_EMPTY;
> +               else
> +                       *intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>         }
>
>         return 0;
> @@ -421,14 +423,9 @@ static int sbs_get_battery_property(struct i2c_client *client,
>                         return 0;
>                 }
>
> -               if (ret & BATTERY_FULL_CHARGED)
> -                       val->intval = POWER_SUPPLY_STATUS_FULL;
> -               else if (ret & BATTERY_DISCHARGING)
> -                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> -               else
> -                       val->intval = POWER_SUPPLY_STATUS_CHARGING;
> -
> -               sbs_status_correct(client, &val->intval);
> +               ret = sbs_status_correct(client, &val->intval);
> +               if (ret < 0)
> +                       return ret;
>
>                 if (chip->poll_time == 0)
>                         chip->last_state = val->intval;
> @@ -773,20 +770,11 @@ static void sbs_delayed_work(struct work_struct *work)
>
>         ret = sbs_read_word_data(chip->client, sbs_data[REG_STATUS].addr);
>         /* if the read failed, give up on this work */
> -       if (ret < 0) {
> +       if ((ret < 0) || (sbs_status_correct(chip->client, &ret) < 0)) {

unnecessary ( )

>                 chip->poll_time = 0;
>                 return;
>         }
>
> -       if (ret & BATTERY_FULL_CHARGED)
> -               ret = POWER_SUPPLY_STATUS_FULL;
> -       else if (ret & BATTERY_DISCHARGING)
> -               ret = POWER_SUPPLY_STATUS_DISCHARGING;
> -       else
> -               ret = POWER_SUPPLY_STATUS_CHARGING;
> -
> -       sbs_status_correct(chip->client, &ret);
> -
>         if (chip->last_state != ret) {
>                 chip->poll_time = 0;
>                 power_supply_changed(chip->power_supply);
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 28413f7..8fb10ec 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -37,6 +37,7 @@ enum {
>         POWER_SUPPLY_STATUS_DISCHARGING,
>         POWER_SUPPLY_STATUS_NOT_CHARGING,
>         POWER_SUPPLY_STATUS_FULL,
> +       POWER_SUPPLY_STATUS_EMPTY,
>  };
>
>  /* What algorithm is the charger using? */
> --
> 1.8.3.1
>
