Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B3C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DAD21994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UDJP2bis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfGZRrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:47:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35218 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfGZRrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:47:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so17687917otq.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7z6dNzLQwHauzjv5HWtjy9UESeH74tVv2xbqeEDTt7Y=;
        b=UDJP2bislowt+bJkhM1yROHULgolAvA6H3mbxoXKtYzB/zMAiga86zkXvNPo9q0bYZ
         mnsUYz/GOvtDmURibJk058hYTZwhq6s/xeGKk6K7N7Q0spxYpaaN7MXIC/3sArlUYpl9
         5Hwa2uiWd8eSLV/H5OwWs3+o5hztgefXBuTLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7z6dNzLQwHauzjv5HWtjy9UESeH74tVv2xbqeEDTt7Y=;
        b=UsQoTx+13eia3nfUexknqRCKSD2C3JNwdjyBjLGfCv9vS0sXacr9w3KfRI1sXmNeZD
         I0odHhZzFFJsZYX++kxRrpd/DZotwKQy0zsb6l5FAkPJuoM/SWUlPJkumeXdkpBO1thJ
         4n2O6+2SHcOLlrhi54fUyFfHCSDMUerh+06SUaW3KyLd2pgat4t0pio4BfArLnmk5aug
         ubX9G9NPpEU0k9EYjcN7gfBhlxhZfqoT6nIomXEQitWCcznfEXE3OTCWnVRW0U9oMmim
         rGSbPppUfod7bTKZjzaz7F8oGCA7sFC6Wp8lL//hM3RL+uEnnLum2442bpyRlbndKzof
         IEyQ==
X-Gm-Message-State: APjAAAUbS24utv6hh8fp3bDBbmibrLhar8ce+qKvG8WkNkybnxiXET0b
        AZQrivtJr58V+UIvBJs7haEli32pmAc=
X-Google-Smtp-Source: APXvYqwFwIlyXU41dGvj4gXqhwRzogMy4FvKVDZRrNrT3aHgTY4oVjKXC1QAWol0JBCwAG0MBn7wLQ==
X-Received: by 2002:a05:6830:10da:: with SMTP id z26mr65920846oto.348.1564163249024;
        Fri, 26 Jul 2019 10:47:29 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id e205sm18756050oia.23.2019.07.26.10.47.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 10:47:27 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id g7so40821447oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 10:47:27 -0700 (PDT)
X-Received: by 2002:aca:488e:: with SMTP id v136mr45193504oia.49.1564163246824;
 Fri, 26 Jul 2019 10:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <1564044929-26104-1-git-send-email-rtresidd@electromag.com.au>
In-Reply-To: <1564044929-26104-1-git-send-email-rtresidd@electromag.com.au>
From:   Nick Crews <ncrews@chromium.org>
Date:   Fri, 26 Jul 2019 11:47:15 -0600
X-Gmail-Original-Message-ID: <CAHX4x84ZVKS+O4oZDTq2rG1+WumQBTk_Sbp5Q44-divde6tdRw@mail.gmail.com>
Message-ID: <CAHX4x84ZVKS+O4oZDTq2rG1+WumQBTk_Sbp5Q44-divde6tdRw@mail.gmail.com>
Subject: Re: [RESEND v2 1/1] power/supply/sbs-battery: Fix confusing battery
 status when idle or empty
To:     Richard Tresidder <rtresidd@electromag.com.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        andrew.smirnov@gmail.com, Guenter Roeck <groeck@chromium.org>,
        david@lechnology.com, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rfontana@redhat.com, allison@lohutok.net, baolin.wang@linaro.org,
        linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard!

Thanks for the patch. I'm not familiar with these batteries, but I have
a few thoughts. For others, the SBS battery spec is at
http://sbs-forum.org/specs/sbdat110.pdf, and section 5.1.21 at page 28
is useful.

On Thu, Jul 25, 2019 at 2:55 AM Richard Tresidder
<rtresidd@electromag.com.au> wrote:
>
> When a battery or batteries in a system are in parallel then one or more
> may not be providing any current to the system.
> This fixes an incorrect status indication of FULL for the battery simply
> because it wasn't discharging at that point in time.
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
>     v2: missed a later merge that should have been included in original patch
>
>  drivers/power/supply/power_supply_sysfs.c |  3 ++-
>  drivers/power/supply/sbs-battery.c        | 32 +++++++++++++++----------------
>  include/linux/power_supply.h              |  2 ++
>  3 files changed, 20 insertions(+), 17 deletions(-)
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

How is "Idle" different" from "Not charging"? To me they both mean that the
battery is at an intermediate state of charge and that there is no significant
current going into or out of the battery. Can you just use "Not
charging" instead
of adding a new status type? Idle seems like a better name to me, but
unfortunately we can't change that at this point.

Adding "Empty" seems quite reasonable.

>  };
>
>  static const char * const power_supply_charge_type_text[] = {
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index ea8ba3e..664c317 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -294,16 +294,12 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
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
> +       if ((*intval == POWER_SUPPLY_STATUS_DISCHARGING && (ret == 0)) {
> +               /* Charging indicator not set in battery */
> +               *intval = POWER_SUPPLY_STATUS_IDLE;
> +       } else if ((*intval == POWER_SUPPLY_STATUS_FULL) && (ret < 0)) {
> +               /* Full Flag set but we are discharging */
> +               *intval = POWER_SUPPLY_STATUS_DISCHARGING;

In any of these cases do we really care about intval? Wouldn't the
current be the
ultimate ground truth of what is happening? e.g.
-(ret == 0) means "Idle"/"Not charging"
-(ret > 0) mean charging
-(ret < 0) means discharging

At the least, how about a check for
else if ((*intval == POWER_SUPPLY_STATUS_EMPTY) && (ret > 0)) {
               /* Empty flag set but current is positive. */
               *intval = POWER_SUPPLY_STATUS_CHARGING;
}

>         }
>
>         return 0;
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

Unrelated, but sbs_status_correct() can return a negative error code.
We should check for that. Here pass it up the call stack, in the other
call site probably do something else.

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

This last case is somewhat misleading, when the DISCHARGING flag is set all
it means that it the battery is not charging (what a dumb name in the
spec, but whatever).
Thus the battery could actually be idle when we say here that it is
discharging. We correct
this later by reading the current, but at least a comment explaining
as such would be nice.
Otherwise this pattern of "if not A, then B, else A" as opposed to the
more standard
"if A, then A, else B" looks really weird.

I'm being an armchair coder here, but is there anything keeping you from moving
all of this code into sbs_status_correct()? That would de-duplicate it
and solve the
problem mentioned above. What about:

/*
 * @intval: On input is the result of sbs_read_word_data(REG_STATUS),
 *               on output is a POWER_SUPPLY_STATUS_* value after
 *               correcting for the current.
 */
static int sbs_status_correct(struct i2c_client *client, int *intval)
{
        int ret;
        s16 current;

        ret = sbs_read_word_data(client, sbs_data[REG_CURRENT].addr);
        if (ret < 0)
                return ret;

        current = (s16)ret;

        if (current > 0)
                *intval = POWER_SUPPLY_STATUS_CHARGING;
        else if (current < 0)
                *intval = POWER_SUPPLY_STATUS_DISCHARGING;
        else {
                /* Current is 0, so how full is the battery? */
                if (*intval & BATTERY_FULL_CHARGED)
                        *intval = POWER_SUPPLY_STATUS_FULL;
                else if (*intval & BATTERY_FULL_DISCHARGED)
                        *intval = POWER_SUPPLY_STATUS_EMPTY;
                else
                        *intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
        }

        return 0;
}

and then you would call it without doing any of the original parsing?

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

Cheers,
Nick
