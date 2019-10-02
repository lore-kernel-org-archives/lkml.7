Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78115C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D82321920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+HZAJr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfJBPUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:20:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33202 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfJBPUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:20:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so13071147lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cm5y6/ru/C9I2VSusEbg3+NWiE1oNKxKWJ8nI5eVPpE=;
        b=e+HZAJr8AzekfpjpvDICihE65P2buZXwIBxjnPwoZjUaa8DYIlZ411wS9EH2Wqx+L0
         3IIG8qyNstNMWhX7MV1QihCRQKoZXXMGKTs4PWndclmhIsERWI2BlCQHgmm887jK/X4s
         4LSh6oyFIbqiC5xhJtc71w2JGJd98PVfXjNlCN6GVR9bIWfwprqsxKpAl4Dh1GDOm4Uf
         KkFqAdqcObzoSOtmU6zUaXmwXz8h65j2MURhjZuxBvLZTZfX1GtpcYV+ZEof01IIQYYx
         E0dhPukf1KSSEJqO6kaaFkc1egOnoliejLLs3Culpb7JQAQvhqu/uJ4ixkijBLwVqoor
         bBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cm5y6/ru/C9I2VSusEbg3+NWiE1oNKxKWJ8nI5eVPpE=;
        b=UPpu/0gMPSFCgbfT8MxI8gFDQIKRR7HGk5wmPjfvkrj5MxhnMAb8x6LETIAzseGLfb
         mqiNY6DNjs9gslgccp1Gl/g10e3PNl1CKY3V4Qi5C3pLl57KjsVsIxUAqNo3WadgCQr5
         5sV24FqXPSyf2RvQxGMfGg2z7QPtrpVHZlzc+pc5pe3gzi6TbTMbaLGCfCo8hx9wi7GG
         uqy4Srm1lqaMlrg99ar9wZsQW1yowrPQqJTlIFHy64+W7EKT0Q5PKNSAO36NI65JZ04Q
         wE4drXOe+UDfqwhW+tuP6MZM3sySVvpy/USQuZAYOFJGlS4CzBHNjx+EVPbK2Aw5ipB7
         +7hg==
X-Gm-Message-State: APjAAAUddh93lhwFli7OVGZAQRH+nyLCC6N/qQ0IJNBGpkNtHBWVRuGX
        coItZ8RCiLDkNWyTwbSQ8yuHANgIGVJpyg/cdhpCsA==
X-Google-Smtp-Source: APXvYqx7gWDvkA6xvZrimGK8XznLipqzN+AmU8yulSOEUx6+7QMOXqK5DEy91JhesL1ch8MperNChxT0leTXt1RiHYQ=
X-Received: by 2002:ac2:4114:: with SMTP id b20mr2720783lfi.19.1570029645385;
 Wed, 02 Oct 2019 08:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190925203209.79941-1-ncrews@chromium.org> <20191001195342.GH4106@piout.net>
 <CAE_wzQ8ugGgRsjfQwfncxhmy4EDOxKdoNm8CJ5AF=Mc5N6X7WQ@mail.gmail.com> <20191002103236.GM4106@piout.net>
In-Reply-To: <20191002103236.GM4106@piout.net>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Wed, 2 Oct 2019 08:20:34 -0700
Message-ID: <CAE_wzQ9AodXUEANpDEQM+VYMVuxWmLoF0_1k-m5HdAfx+=01-A@mail.gmail.com>
Subject: Re: [PATCH v3] rtc: wilco-ec: Handle reading invalid times
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nick Crews <ncrews@chromium.org>,
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

On Wed, Oct 2, 2019 at 3:32 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 01/10/2019 13:42:24-0700, Dmitry Torokhov wrote:
> > On Tue, Oct 1, 2019 at 12:53 PM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > Hi Nick,
> > >
> > > On 25/09/2019 14:32:09-0600, Nick Crews wrote:
> > > > If the RTC HW returns an invalid time, the rtc_year_days()
> > > > call would crash. This patch adds error logging in this
> > > > situation, and removes the tm_yday and tm_wday calculations.
> > > > These fields should not be relied upon by userspace
> > > > according to man rtc, and thus we don't need to calculate
> > > > them.
> > > >
> > > > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > > > ---
> > > >  drivers/rtc/rtc-wilco-ec.c | 13 +++++++++----
> > > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > > > index 8ad4c4e6d557..53da355d996a 100644
> > > > --- a/drivers/rtc/rtc-wilco-ec.c
> > > > +++ b/drivers/rtc/rtc-wilco-ec.c
> > > > @@ -110,10 +110,15 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> > > >       tm->tm_mday     = rtc.day;
> > > >       tm->tm_mon      = rtc.month - 1;
> > > >       tm->tm_year     = rtc.year + (rtc.century * 100) - 1900;
> > > > -     tm->tm_yday     = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> > > > -
> > > > -     /* Don't compute day of week, we don't need it. */
> > > > -     tm->tm_wday = -1;
> > > > +     /* Ignore other tm fields, man rtc says userspace shouldn't use them. */
> > > > +
> > > > +     if (rtc_valid_tm(tm)) {
> > > > +             dev_err(dev,
> > > > +                      "Time from RTC is invalid: second=%u, minute=%u, hour=%u, day=%u, month=%u, year=%u, century=%u",
> > > > +                      rtc.second, rtc.minute, rtc.hour, rtc.day, rtc.month,
> > > > +                      rtc.year, rtc.century);
> > >
> > > Do you mind using %ptR? At this point you already filled the tm struct
> > > anyway and if you print century separately, you can infer tm_year.
> >
> > I do not think this is a good idea: we have just established that tm
> > does not contain valid data. Does %ptR guarantee that it handles junk
> > better than, let's say, rtc_year_days(), and does not crash when
> > presented with garbage?
> >
>
> It is safe to use. You can also use %ptRr if you want to ensure no
> extra operations are done on the value before printing them out.

OK, I'll keeo this in mind then.

>
> I'm still not convinced it is useful to have an error in dmesg when the
> time is invalid, as long as userspace knows it is invalid. What is the
> course of action for the end user when that happens?

Report it, or, in our case, we will see it in the feedback logs.
However I do agree that it is not the best option, even if we report
error to userspace I am not sure if it will handle it properly. What
userspace is supposed to do when presented with -EIO or similar?

Nick, do we know the root cause of the EC/RTC reporting invalid time?

Thanks,
Dmitry
