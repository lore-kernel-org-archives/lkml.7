Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D86C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E2921473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="NVTnC0Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfEONyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:54:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45322 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfEONyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:54:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so4188299edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKV+uSM8ED3SyB5lJb/FZewRZDk4c2DIjIkqO9WcvJ0=;
        b=NVTnC0Ie5XWK7QVTDvul3LRHk3EvVSRyo7cTLoQNPRAamduiRDXkYcJ/Ytv6iDxH2/
         23bQAXbUZ6H4BT5QlNky91b6mn07g0QlVEoXG1OFGaCYDlGjdwMnNa5Ii36QfRHNH9hA
         +D5nxQ1oFWbIRmtkuB1a32nvJMr2C2JsN7NqWhX6lk6JETQCdw4D/8tIZ2sCXIoW5isk
         ElgW++GL8jgwpOM82/g/xJBxB2mxW+SW4GHJhdRA5iXw1zHlvipBzkMrJsAQqcjn6n6A
         TYgr2Fb9T8vmo2GE2Y9FZyzfykFAckO+GPz7q0BuawIUstPOLrXl+y8gs/TtK3RDhrkF
         UuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKV+uSM8ED3SyB5lJb/FZewRZDk4c2DIjIkqO9WcvJ0=;
        b=JfamNGf79CmY/F6wUNOkr0jnBV34UMVK4mi0H5+9vrs/PA2FtTAeynNZFPgz7Dd0c4
         X7ZhSnbcpslfE2F77oVGPBdtP/B6qGUgbBzK24nAhyBCZxGlQopgZJXLhZwCEtBe3T9S
         OcHUvVSifSSiLNrOgkHdbGL1XspkdUfW4T8iyYfA1SUUWMi1ebN8/SCgwetpFxf+wRfV
         nTJdJXfSdcnHIN4exxSb+zEqjwqSW/Uc4Lbh2ZnVaHIcS62sBGEfvCbtr1uteIC67ArE
         TRPih+Jt5A6km+iPjo4Pn89irEIa7GwG2VSyBhEPZu+zF2tYmpH6KZ9KV0Mf1wCLzHpW
         qZUQ==
X-Gm-Message-State: APjAAAXDeZqw9rLCzrM0iEYo1gT4PC8//tEk0G1Awav+AWuBjAPNnkHJ
        jESjGhmXmuRNxoAy6YNP8+ZMO0boxayDEULJ37ApNKgX
X-Google-Smtp-Source: APXvYqzRmoeD2vpymxFiAGQFSGz4QZRDGGzJMEQiMwkPUkjEncjhQY5mvhbAnBhNEbe10t44+E9P0okUkbnlKj2a/qc=
X-Received: by 2002:a17:906:5e10:: with SMTP id n16mr32619643eju.143.1557928448803;
 Wed, 15 May 2019 06:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190515111436.14513-1-roman.stratiienko@globallogic.com>
 <20190515123241.GL7622@piout.net> <CAODwZ7vuBndm2i7CFm0RT1wM3phyQkQ+g0Gyjb1GE7k1-bHccQ@mail.gmail.com>
In-Reply-To: <CAODwZ7vuBndm2i7CFm0RT1wM3phyQkQ+g0Gyjb1GE7k1-bHccQ@mail.gmail.com>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Wed, 15 May 2019 16:53:57 +0300
Message-ID: <CAODwZ7t1UgPMeMYcadALD_gCa1Zp1fq65oF9fL65u5DTTft0Sw@mail.gmail.com>
Subject: Re: [PATCH] rtc: test: enable wakeup flags
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Thank you for the review.
See my answers below.


On Wed, May 15, 2019 at 3:32 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi,
>
> (You didn't use my correct email address, please update your kernel)

Fixed.

>
> On 15/05/2019 14:14:36+0300, roman.stratiienko@globallogic.com wrote:
> > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > Alarmtimer interface uses only the RTC with wekeup flags enabled.
> > Allow to use rtc-test driver with alarmtimer interface.
> >
> > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > ---
> >  drivers/rtc/rtc-test.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
> > index 6c5f09c815e8..c839ae575c77 100644
> > --- a/drivers/rtc/rtc-test.c
> > +++ b/drivers/rtc/rtc-test.c
> > @@ -123,6 +123,8 @@ static int test_probe(struct platform_device *plat_dev)
> >
> >       platform_set_drvdata(plat_dev, rtd);
> >
> > +     device_init_wakeup(&plat_dev->dev, 1);
> > +
>
> The first created RTC doesn't have any alarm, so this must not be done
> for all the devices.

Thanks. I will fix this in v2.

>
> Also, this driver will never wake up the platform so I'm not sure it is
> relevant to test alarmtimers.

Alarmtimer interface relies only on RTC with alarm support,
but it also checks wake flags for some reason.
As far as rtc-test driver do have alarm support, I expect
that related drivers should use it.

Let me share some information about my use-case:
Alarmtimer support is required for generic AOSP bluedroid library.
To enable Bluetooth in Android on the devices that does not
have hardware RTC, enabling rtc-test driver is a good option.

>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Best regards,
Roman Stratiienko
Global Logic Inc.
