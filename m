Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22365C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F6E206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hoTHoIe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfG2RYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:24:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46825 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2RYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:24:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so45817127oid.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H82CfpsAPxY1U4pICmy55gvPsfNE9tQu1bS2v8fGtDA=;
        b=hoTHoIe4KGfmjmWVbXeqcu2ZFyS3273iHszAwfnIijiaVLSvzliPZa86nMrhXe87ux
         CM9hn8aYM4If4h+4Y5c+mJIJPpVFX9SWC1i6+xlBF4Zh0SSzpQ+XZcijD1FopSIEGbym
         591+5DcB+Ute2WaU7H+qDuSLslk2Ga15lHChI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H82CfpsAPxY1U4pICmy55gvPsfNE9tQu1bS2v8fGtDA=;
        b=NLqaubugzmHXQHBNILfEpGhSbWvl6RnocxmvPPtwvIwaEzGCn9K5U1TWNdAtTmPEyO
         tJ1ouI9sNnl9kP8UQzF79ZXFoyzrw8DhMEEjU8HSvMelVisiMrzZmvIm9lMIxvy1WYdw
         Jf18flGlKNDxUO1y4AjdjowzMOZBUXo4Z1fK4p+lFEGCBlZvRBileQv8kZ2/PERMv0zy
         PQZ2eXDtVIZnD54yU+jiG3Xlup6D89iBU4vTXexvXfrcCVspvgkczw4LClOL8a9MwBoU
         C+x1/IzllmZrEdfH1KkZLD9ZlUL96nLlZud2j1eePFIgYb57l5ckzGaC0KgFEgCOMYSL
         QvTw==
X-Gm-Message-State: APjAAAWZfZXh+29QG8gvgoGhiTEVhTw6YsxBXUDZQYjn9YjcWVVyVxXv
        qD44T6D9H+cXrVKJvj+QKsuY0wQD8gU=
X-Google-Smtp-Source: APXvYqxog5fGbN+fubJAkodyuav6j8Qij8fX9NSX8oeh3MZLnhd+UgLp0CKXp/N8D4xP60LuCekZ7Q==
X-Received: by 2002:aca:191a:: with SMTP id l26mr55459766oii.4.1564421061784;
        Mon, 29 Jul 2019 10:24:21 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id s82sm22050261oie.40.2019.07.29.10.24.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 10:24:21 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id x21so24902270otq.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 10:24:21 -0700 (PDT)
X-Received: by 2002:a9d:19cd:: with SMTP id k71mr48832659otk.351.1564420662376;
 Mon, 29 Jul 2019 10:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <1564387659-62064-1-git-send-email-rtresidd@electromag.com.au>
In-Reply-To: <1564387659-62064-1-git-send-email-rtresidd@electromag.com.au>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 29 Jul 2019 11:17:31 -0600
X-Gmail-Original-Message-ID: <CAHX4x86Afz2BXG476sVNNc4QP8jdO7F7n0QXqAG5+hRDwAAQGg@mail.gmail.com>
Message-ID: <CAHX4x86Afz2BXG476sVNNc4QP8jdO7F7n0QXqAG5+hRDwAAQGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] power/supply/sbs-battery: Fix confusing battery
 status when idle or empty
To:     Richard Tresidder <rtresidd@electromag.com.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        andrew.smirnov@gmail.com, Guenter Roeck <groeck@chromium.org>,
        david@lechnology.com, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rfontana@redhat.com, allison@lohutok.net,
        Baolin Wang <baolin.wang@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 2:07 AM Richard Tresidder
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

sbs_status_correct() sounds like it is checking for a condition. Change
to sbs_correct_status() or sbs_correct_battery_status() to imply that it
is performing an action. Also, change "intval" to "status"?

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

This will cause some behavior changes for users. Can we get the opinion
of someone familiar with the users of this driver as to whether this is OK?

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
