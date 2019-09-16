Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096D8C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D3C20830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CFJSWEMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbfIPR5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 13:57:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33724 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfIPR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:57:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id g25so686521otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKNZtmKTuySbYvP8w0xm5HOjwNFPHAZdDNlcoO6z/s4=;
        b=CFJSWEMs8joEKGJKJWATQ2SgPQIFPRLujUYDdXO3TJjr1R0fBUwERjJm+njog34eG0
         g/dOqwt/sum69ElflFWh60xNEJJzuvdXBjdI9doHt6lVP8ME0016v/YRBVSDKqXNInwK
         UhfwS+dz/JTiyoi74Mw+P0SxZkwInYGfHP6rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKNZtmKTuySbYvP8w0xm5HOjwNFPHAZdDNlcoO6z/s4=;
        b=IIu6NwHn9Xm1qJFkqKZIr+0h0iALh800v9Qg5zvH0Mm6Ft5nWtBdkz0ETaPwHdbhj8
         MFSzemEmHg4YJypdR/vuS2oyKWgRHQK1hUPAl8FRHCav0r5M+lDXZdFz3Zp6a5CbYBrH
         PftNkltFgBONDLOpmSdUVQnBlM0wyjbqzF2p/rstX0RGlq+9prq7vlv3hrcuu+bX6Kbd
         PnxZKcJcSPPxzYbO9UJMSb5+SZyi1vIzTQ0URhPgaBAvzNBoWZAW4HHMIFhhAMBz4BRX
         CZ3DR2rrSVdAseFp1a3Ppp1eixd4tRDmcTsdyqEUCeYr0zsrQVQ6qX3JxY8aKIGChqLY
         gNXg==
X-Gm-Message-State: APjAAAXZUKSeusk7Wfe81FxjDJJvNoWbf5W4vCrUjkPHGFzd4JNabLmU
        NOwRX6LXY8vFEhPQ7ECrkPj829oBJf4=
X-Google-Smtp-Source: APXvYqyr5mtZymJlEJKFUTSxwc4X3vAvSsQCUfrkrMrdDHjUFW7z3ov8wFsebQTDhH6H6tNseXKphA==
X-Received: by 2002:a05:6830:13d6:: with SMTP id e22mr360936otq.280.1568656630254;
        Mon, 16 Sep 2019 10:57:10 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id x140sm4357346oix.42.2019.09.16.10.57.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 10:57:09 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id b2so610531otq.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:57:08 -0700 (PDT)
X-Received: by 2002:a9d:4d0d:: with SMTP id n13mr283174otf.351.1568656627845;
 Mon, 16 Sep 2019 10:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151929.780-1-ncrews@chromium.org> <20190912080953.GO21254@piout.net>
 <CAHX4x87M6opd5Ob_TRwCQ3mYgeFaV55DYiTYccM2cNX2nD3oYA@mail.gmail.com> <20190916080219.GV21254@piout.net>
In-Reply-To: <20190916080219.GV21254@piout.net>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 16 Sep 2019 11:56:56 -0600
X-Gmail-Original-Message-ID: <CAHX4x84yRmYCoXcqhPdJWcb703vFZO=u5UjWJHjVWsrH4XZo1A@mail.gmail.com>
Message-ID: <CAHX4x84yRmYCoXcqhPdJWcb703vFZO=u5UjWJHjVWsrH4XZo1A@mail.gmail.com>
Subject: Re: [PATCH] rtc: wilco-ec: Sanitize values received from RTC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 2:02 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 15/09/2019 23:44:03+0100, Nick Crews wrote:
> > Hi Alexandre, thanks for the thoughts.
> >
> > On Thu, Sep 12, 2019 at 9:09 AM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > Hi Nick,
> > >
> > > On 10/09/2019 16:19:29+0100, Nick Crews wrote:
> > > > Check that the time received from the RTC HW is valid,
> > > > otherwise the computation of rtc_year_days() in the next
> > > > line could, and sometimes does, crash the kernel.
> > > >
> > > > While we're at it, fix the license to plain "GPL".
> > > >
> > > > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > > > ---
> > > >  drivers/rtc/rtc-wilco-ec.c | 12 ++++++++++--
> > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > > > index 8ad4c4e6d557..0ccbf2dce832 100644
> > > > --- a/drivers/rtc/rtc-wilco-ec.c
> > > > +++ b/drivers/rtc/rtc-wilco-ec.c
> > > > @@ -110,8 +110,16 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> > > >       tm->tm_mday     = rtc.day;
> > > >       tm->tm_mon      = rtc.month - 1;
> > > >       tm->tm_year     = rtc.year + (rtc.century * 100) - 1900;
> > > > -     tm->tm_yday     = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> > >
> > > If your driver doesn't care about yday, userspace doesn't either. You
> > > can simply not set it.
> >
> > This driver indeed does not care about yday, so it sounds good to me
> > to simply not set it. However, I do still want to worry about the HW
> > returning some bogus time. It could be indicative of some other problem,
> > and I don't want to pass on this illegal time further up the stack. I can't
> > think of a reason why an illegal time should exist at all, we should just
> > deal with it as soon as possible. How about I remove setting yday as
> > you suggest, but still keep the rtc_valid_tm() check?
> >
>
> As rtc_valid_tm would be the last thing the driver does in the callback
> and the first thing the core does after returning from the callback,
> you'd get two calls back to back which is not useful.

Ah, I see now where the core checks that the time is valid
in interface.c. Sounds good, I'll skip the check then.

>
> > >
> > > >
> > > > +     if (rtc_valid_tm(tm)) {
> > > > +             dev_warn(dev,
> > > > +                      "Time computed from EC RTC is invalid: sec=%d, min=%d, hour=%d, mday=%d, mon=%d, year=%d",
> > > > +                      tm->tm_sec, tm->tm_min, tm->tm_hour, tm->mday,
> > > > +                      tm->mon, tm->year);
> > > > +             return -EIO;
> > > > +     }
> > > > +
> > > > +     tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> > > >       /* Don't compute day of week, we don't need it. */
> > > >       tm->tm_wday = -1;
> >
> > Following our discussion, perhaps I'll just remove this too since the
> > RTC core inits this to -1 already?
> >
>
> You can remove it.

Will do!

>
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
