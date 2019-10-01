Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52772ECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2251520842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzMFMc3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfJAUmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 16:42:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33615 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfJAUmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 16:42:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so10998709lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hwZCi70c7qhfFOhnj+Rn4JUCNKdVNtJE8cMrdBeUh0=;
        b=NzMFMc3/fGFF6QjZ2ONoOmmIwcx7onZkZM1S8iWw7sw83fbtDDJP2tUlsNzLSb+49R
         7Sno3jQijk47mtbzvwyyXy/mGq339rgAKN8s/OzrTkGUO9k4LqfdDmtGJrjuOUOy0/b6
         N0I+hcR9ofFqZGdWF9CN4OaRHJSHqWAN+WCWnR5v8CR7a57uTJMWbwrMZKG+ojsXp5d2
         0hU7863GJMYkIqP48c79/W1+KhvRA6hJc1E3TMi79lL75nh38d8aR0tf5ja0n/CEMfjZ
         FaoFO5oAx99PhJ19Yo0q9BcaIYUKwNUSHnZZg3s48rU6E9be2H/bwALuh+LcU9rlCUZE
         2vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hwZCi70c7qhfFOhnj+Rn4JUCNKdVNtJE8cMrdBeUh0=;
        b=Y0YodWXB1HwvS/xzRxwIyb/X3mNXuFKB1sPcl16barVt4gnXgNlD9XjBgp/dHioVz7
         PGn29ZQXvV0B3rRbjmJrnmGEE9jFE7UVw5R1SD97jLFwqPLeNeHfCh+M5JLTvmZjvkiE
         i2efvo76AOqXRgCc9PNC01LI4NEtzW7oDVQGMXwica7rZuVDpKSpvL99CLT6+aytkkMB
         MSyR+0AmqzJkMFBFH1CA+5JnjFfxONlf83fXRtRxA+G137iQBbY0jbiOYRbXFUB2eQ7P
         l2lq242IteJrH0NsgqAASB0OtscEfUMISPXFODMj1MUar0O97lCksbAl2jv/Y9IoGedU
         D86A==
X-Gm-Message-State: APjAAAW4f3v9B8k9lDIQKuSmtaBiMFvuh9LPhGn2Sxbzb6DKBT7VJQvY
        4BcGb3e3J0X6BLlAQ1BHV24XdIUEJPLvO8Q0Wo9bKw==
X-Google-Smtp-Source: APXvYqzg88pOOovnALHaEkRUf8c7S1vddZhPLUe9z8R9u4pZOtR8+L1B92hkrdlhGxiMBSlrIVqUpAwnJmUmdC7qo1I=
X-Received: by 2002:ac2:46d2:: with SMTP id p18mr16217488lfo.140.1569962556369;
 Tue, 01 Oct 2019 13:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190925203209.79941-1-ncrews@chromium.org> <20191001195342.GH4106@piout.net>
In-Reply-To: <20191001195342.GH4106@piout.net>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Tue, 1 Oct 2019 13:42:24 -0700
Message-ID: <CAE_wzQ8ugGgRsjfQwfncxhmy4EDOxKdoNm8CJ5AF=Mc5N6X7WQ@mail.gmail.com>
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

On Tue, Oct 1, 2019 at 12:53 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi Nick,
>
> On 25/09/2019 14:32:09-0600, Nick Crews wrote:
> > If the RTC HW returns an invalid time, the rtc_year_days()
> > call would crash. This patch adds error logging in this
> > situation, and removes the tm_yday and tm_wday calculations.
> > These fields should not be relied upon by userspace
> > according to man rtc, and thus we don't need to calculate
> > them.
> >
> > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > ---
> >  drivers/rtc/rtc-wilco-ec.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > index 8ad4c4e6d557..53da355d996a 100644
> > --- a/drivers/rtc/rtc-wilco-ec.c
> > +++ b/drivers/rtc/rtc-wilco-ec.c
> > @@ -110,10 +110,15 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> >       tm->tm_mday     = rtc.day;
> >       tm->tm_mon      = rtc.month - 1;
> >       tm->tm_year     = rtc.year + (rtc.century * 100) - 1900;
> > -     tm->tm_yday     = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> > -
> > -     /* Don't compute day of week, we don't need it. */
> > -     tm->tm_wday = -1;
> > +     /* Ignore other tm fields, man rtc says userspace shouldn't use them. */
> > +
> > +     if (rtc_valid_tm(tm)) {
> > +             dev_err(dev,
> > +                      "Time from RTC is invalid: second=%u, minute=%u, hour=%u, day=%u, month=%u, year=%u, century=%u",
> > +                      rtc.second, rtc.minute, rtc.hour, rtc.day, rtc.month,
> > +                      rtc.year, rtc.century);
>
> Do you mind using %ptR? At this point you already filled the tm struct
> anyway and if you print century separately, you can infer tm_year.

I do not think this is a good idea: we have just established that tm
does not contain valid data. Does %ptR guarantee that it handles junk
better than, let's say, rtc_year_days(), and does not crash when
presented with garbage?

Thanks,
Dmitry
