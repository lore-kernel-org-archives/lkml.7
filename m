Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A61BC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26C121D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HnOQjAxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbfIYUvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:51:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39228 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbfIYUvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:51:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so7123049ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwxqGOJ4EK6HWwfzrt6IbqWGZET3zrS4nF5lIFmhKAQ=;
        b=HnOQjAxzxL/iJzgJXaCg8DLlJ7/U1bQzB2lHrCLH5blJi062W+/tBvhocCWxwQVLsG
         ZdNqs+k7YEQBDqFIPZmRn8Ket7KapoV3xCDu6OtwHCiotUTgZBgy39vuq/TFo6DsxHwT
         w6dakydXCqPgTAGvQ8t4fyhq30lgeDC8VTFuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwxqGOJ4EK6HWwfzrt6IbqWGZET3zrS4nF5lIFmhKAQ=;
        b=rYR9HyIseuFe8aynGU0v31wy4H7wZu1CA6p92i5b9kKvJkXFiLNqnZdlcB5QH9On1z
         W6StyX/Im4hVaBC/BMviQBNZUZooPtYf9enZwe1BUDdCi2tJzO04aK2TeHef/+u/GroZ
         GBfmJW1vmtMfjYc9SuZdLH20pGq009XwXMppMgQsewjSrclCglOZWugVkOXuG0r/L+i2
         Tn3c1b1ETOj+x9/yM7cgfoCHctx655YtzFEv8lvbt62wD9IQUHMp2fiRFa4wzBJ9syOr
         GalllDbpLabMzzWi2VpJC5pWZFMefLmAzrbYw4h66C17v8aZh+GTiZpqXtB9yY34HW11
         Murw==
X-Gm-Message-State: APjAAAVQXmBiCircSatJu3JZ/yl6KMY4ITlyPFMWZjppvlWjfi7DiXM4
        /0avhXIYGIUJUCdrVGuzcyVjqBmXfmU=
X-Google-Smtp-Source: APXvYqygHo8nhoQbe9mpkEUcBWPYpieRrFMib8DSoEnT97Eibr2+13U8D6jg59xyclDL3KYz8RiOFA==
X-Received: by 2002:a2e:7c17:: with SMTP id x23mr167315ljc.210.1569444674117;
        Wed, 25 Sep 2019 13:51:14 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id y26sm1691868ljj.90.2019.09.25.13.51.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:51:13 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id e17so7114632ljf.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:51:13 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr183696ljs.156.1569444672670;
 Wed, 25 Sep 2019 13:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190925203209.79941-1-ncrews@chromium.org>
In-Reply-To: <20190925203209.79941-1-ncrews@chromium.org>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Wed, 25 Sep 2019 13:51:01 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ9ohsoeGuk-gJ+ZtP4J7yCAB5b2JcO1HbHDZUj2PaQvyA@mail.gmail.com>
Message-ID: <CAE_wzQ9ohsoeGuk-gJ+ZtP4J7yCAB5b2JcO1HbHDZUj2PaQvyA@mail.gmail.com>
Subject: Re: [PATCH v3] rtc: wilco-ec: Handle reading invalid times
To:     Nick Crews <ncrews@chromium.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>, dlaurie@chromium.org,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 1:32 PM Nick Crews <ncrews@chromium.org> wrote:
>
> If the RTC HW returns an invalid time, the rtc_year_days()
> call would crash. This patch adds error logging in this
> situation, and removes the tm_yday and tm_wday calculations.
> These fields should not be relied upon by userspace
> according to man rtc, and thus we don't need to calculate
> them.
>
> Signed-off-by: Nick Crews <ncrews@chromium.org>

Reviewed-by: Dmitry Torokhov <dtor@chromium.org>

> ---
>  drivers/rtc/rtc-wilco-ec.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> index 8ad4c4e6d557..53da355d996a 100644
> --- a/drivers/rtc/rtc-wilco-ec.c
> +++ b/drivers/rtc/rtc-wilco-ec.c
> @@ -110,10 +110,15 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
>         tm->tm_mday     = rtc.day;
>         tm->tm_mon      = rtc.month - 1;
>         tm->tm_year     = rtc.year + (rtc.century * 100) - 1900;
> -       tm->tm_yday     = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> -
> -       /* Don't compute day of week, we don't need it. */
> -       tm->tm_wday = -1;
> +       /* Ignore other tm fields, man rtc says userspace shouldn't use them. */
> +
> +       if (rtc_valid_tm(tm)) {
> +               dev_err(dev,
> +                        "Time from RTC is invalid: second=%u, minute=%u, hour=%u, day=%u, month=%u, year=%u, century=%u",
> +                        rtc.second, rtc.minute, rtc.hour, rtc.day, rtc.month,
> +                        rtc.year, rtc.century);
> +               return -EIO;
> +       }
>
>         return 0;
>  }
> --
> 2.21.0
>

Thanks.

-- 
Dmitry
