Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1F6C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCF22133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DVBHxTvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbfJCUhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:37:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42014 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJCUhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:37:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id i185so3841811oif.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDo4o+KAvY5sr/pnubCDYIV+K4Ff/iB9FuRG+d3osIk=;
        b=DVBHxTvb3jy9Hdh53nbhNksRXqsoBIbMD2MdH6p09K0SQfUK2/aqMMcfxgJvARCAUD
         hC+KMejJL8CT+692KQPoLGckpxwDnTwnN6xvGfQq7Nl4WRxrs48oPjbHTwYhA8cyXfu3
         +cPJ2Y6G0bAF5M0jdFaE+lymffS3ukq3tuLQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDo4o+KAvY5sr/pnubCDYIV+K4Ff/iB9FuRG+d3osIk=;
        b=Ss1kTQGK09JBTcGmj8ykTGVx1aATCSBhNse0lR6xovQJNmTKKa3ARqT+uUWK0oIkK4
         /Bguy2IkLeYyfZvHiraBJlej4ZN+0DKc1JwBUej+zc7H6+GfK3ySk+bFeijwwSE6H/sA
         QjyLGgZR7yRV5InVSsOWDM6EXQzQ2sdROtAmE4mil50qKwgfvofLNpzBxblMqoHxBNGs
         U5D9+D2mOXDTkkUXLLhOC0DaQk4QmfZ+vkl1XhkRFUQHsTozCGfpvGarh5mR6Lqjzn3L
         AnnoDBfL0DfdakC/9L/nZVI/oswXmxQsdHQ6/xuFz2V6+L5uy/fPR5ThKDcarYuWyks9
         TaJw==
X-Gm-Message-State: APjAAAWws87X1CBOBW/oGeCRDZ9NnrmLhRJLwF4QqQb4knfN1XLiYjzt
        nHde8hmASeCuyvCRypN7puMj6wjpHCA=
X-Google-Smtp-Source: APXvYqwYujbMIF+0dJOapSZV1WvPPqDI7KM2L9wL2Ccr7ciQ7MAs4VNvfRTXTm5bX7NfYDcBjpKxZA==
X-Received: by 2002:aca:b9d4:: with SMTP id j203mr4395735oif.19.1570135064115;
        Thu, 03 Oct 2019 13:37:44 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id r187sm1125420oie.17.2019.10.03.13.37.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:37:43 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id k25so3824119oiw.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:37:43 -0700 (PDT)
X-Received: by 2002:aca:7509:: with SMTP id q9mr4051833oic.111.1570135062854;
 Thu, 03 Oct 2019 13:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190925203209.79941-1-ncrews@chromium.org> <20191001195342.GH4106@piout.net>
 <CAE_wzQ8ugGgRsjfQwfncxhmy4EDOxKdoNm8CJ5AF=Mc5N6X7WQ@mail.gmail.com>
 <20191002103236.GM4106@piout.net> <CAE_wzQ9AodXUEANpDEQM+VYMVuxWmLoF0_1k-m5HdAfx+=01-A@mail.gmail.com>
In-Reply-To: <CAE_wzQ9AodXUEANpDEQM+VYMVuxWmLoF0_1k-m5HdAfx+=01-A@mail.gmail.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 3 Oct 2019 14:37:31 -0600
X-Gmail-Original-Message-ID: <CAHX4x84a1HpUvSJ6XeopJQuMZEM-Af_No2nHhi8q62eB+ZXxmA@mail.gmail.com>
Message-ID: <CAHX4x84a1HpUvSJ6XeopJQuMZEM-Af_No2nHhi8q62eB+ZXxmA@mail.gmail.com>
Subject: Re: [PATCH v3] rtc: wilco-ec: Handle reading invalid times
To:     Dmitry Torokhov <dtor@google.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 9:20 AM Dmitry Torokhov <dtor@google.com> wrote:
>
> On Wed, Oct 2, 2019 at 3:32 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 01/10/2019 13:42:24-0700, Dmitry Torokhov wrote:
> > > On Tue, Oct 1, 2019 at 12:53 PM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > >
> > > > Hi Nick,
> > > >
> > > > On 25/09/2019 14:32:09-0600, Nick Crews wrote:
> > > > > If the RTC HW returns an invalid time, the rtc_year_days()
> > > > > call would crash. This patch adds error logging in this
> > > > > situation, and removes the tm_yday and tm_wday calculations.
> > > > > These fields should not be relied upon by userspace
> > > > > according to man rtc, and thus we don't need to calculate
> > > > > them.
> > > > >
> > > > > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > > > > ---
> > > > >  drivers/rtc/rtc-wilco-ec.c | 13 +++++++++----
> > > > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > > > > index 8ad4c4e6d557..53da355d996a 100644
> > > > > --- a/drivers/rtc/rtc-wilco-ec.c
> > > > > +++ b/drivers/rtc/rtc-wilco-ec.c
> > > > > @@ -110,10 +110,15 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> > > > >       tm->tm_mday     = rtc.day;
> > > > >       tm->tm_mon      = rtc.month - 1;
> > > > >       tm->tm_year     = rtc.year + (rtc.century * 100) - 1900;
> > > > > -     tm->tm_yday     = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> > > > > -
> > > > > -     /* Don't compute day of week, we don't need it. */
> > > > > -     tm->tm_wday = -1;
> > > > > +     /* Ignore other tm fields, man rtc says userspace shouldn't use them. */
> > > > > +
> > > > > +     if (rtc_valid_tm(tm)) {
> > > > > +             dev_err(dev,
> > > > > +                      "Time from RTC is invalid: second=%u, minute=%u, hour=%u, day=%u, month=%u, year=%u, century=%u",
> > > > > +                      rtc.second, rtc.minute, rtc.hour, rtc.day, rtc.month,
> > > > > +                      rtc.year, rtc.century);
> > > >
> > > > Do you mind using %ptR? At this point you already filled the tm struct
> > > > anyway and if you print century separately, you can infer tm_year.
> > >
> > > I do not think this is a good idea: we have just established that tm
> > > does not contain valid data. Does %ptR guarantee that it handles junk
> > > better than, let's say, rtc_year_days(), and does not crash when
> > > presented with garbage?
> > >
> >
> > It is safe to use. You can also use %ptRr if you want to ensure no
> > extra operations are done on the value before printing them out.
>
> OK, I'll keeo this in mind then.

I will resend this using %ptRr, chromium is using 4.19 so I didn't see
that this was added.

>
> >
> > I'm still not convinced it is useful to have an error in dmesg when the
> > time is invalid, as long as userspace knows it is invalid. What is the
> > course of action for the end user when that happens?
>
> Report it, or, in our case, we will see it in the feedback logs.
> However I do agree that it is not the best option, even if we report
> error to userspace I am not sure if it will handle it properly. What
> userspace is supposed to do when presented with -EIO or similar?

Yes, we will be able to see this in feedback logs, which would be valuable.

>
> Nick, do we know the root cause of the EC/RTC reporting invalid time?

No, I haven't really looked into it deeply. It's not limited to the RTC
interface though, it's a problem with the EC or EC communication
in general, as I've noticed similar occasional errors with the other EC
drivers.

>
> Thanks,
> Dmitry
