Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CFBC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F4621783
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LxYbLPVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502155AbfIWRU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:20:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37311 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407395AbfIWRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:20:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id k32so12838845otc.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3yXbds+KWz7AvWD5TWTm/1vwliD4GfchZEVwGqijOTs=;
        b=LxYbLPVbZKfHIcJpS+oUJCXvGteRaVLbkSEV1wPbzWPMGoxPC1ppu3Q9S7QH27l8KI
         bH7aC4nxya3YAQgOCDxz1Ws+LTztWF0MZ8X6wloU7WRkiGwtv/YSHmE9C1XfgkmGMQNo
         Uyx8wXaqfl6IxtIVA750fPHz5eAH6KBY156F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3yXbds+KWz7AvWD5TWTm/1vwliD4GfchZEVwGqijOTs=;
        b=XKlLpuUHKMNs4h4bFg6yeAtm5C3H6oGIt/bQWK5YeGteZkoUMUEPQkq92GPV2PwjW4
         JqFdcxZxO5H1wve1tsuLIiUFKCFAIh56N3SRqmEQdx20v93TOYfd6AlRXk50gKExIWMK
         Hds3Sv2nrbIbumI74blWsQMTskq2iszN1kQFuY58Y26+32yd/YBjxyw2eLfqNJeWpsTk
         W3FMm8zTHChnuFBCHVRJg/BRiPzUFq1Rw0nsZQENI4bb9DKjINSldjzNpbm/LSArx6HI
         0GWJiUyRbH5l98ie5AVufaAo/MJOeCji8+7Hu1vQJESCrNXnO9+slmvvDKoY25TJr3XW
         4C7w==
X-Gm-Message-State: APjAAAV5XksRENuM1nF7hbP+BT/hfWD9YMScxee1D0YE3FbBmNnopQc6
        5LLTafP3dB5glQp1NzpDRU5+KGBDos8=
X-Google-Smtp-Source: APXvYqx/ex1JS+NRaPEYGhCTtTYmduiFUmVVwdlFQIuKzAReSwOPcqlnmIVpO4XRHcvU4tgHyO99Tg==
X-Received: by 2002:a05:6830:2059:: with SMTP id f25mr733995otp.137.1569259255040;
        Mon, 23 Sep 2019 10:20:55 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id r19sm3828877ota.79.2019.09.23.10.20.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 10:20:54 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id g13so12817915otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:20:54 -0700 (PDT)
X-Received: by 2002:a9d:621a:: with SMTP id g26mr790118otj.236.1569259253904;
 Mon, 23 Sep 2019 10:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190916181215.501-1-ncrews@chromium.org> <20190922161306.GA1999@bug>
 <20190922190542.GC3185@piout.net>
In-Reply-To: <20190922190542.GC3185@piout.net>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 23 Sep 2019 11:20:42 -0600
X-Gmail-Original-Message-ID: <CAHX4x876iDn_6Q1+p1SNMncHJezSUQysfM+py0gjD2ytMKBj=w@mail.gmail.com>
Message-ID: <CAHX4x876iDn_6Q1+p1SNMncHJezSUQysfM+py0gjD2ytMKBj=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rtc: wilco-ec: Remove yday and wday calculations
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Benson Leung <bleung@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 1:05 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 22/09/2019 18:13:06+0200, Pavel Machek wrote:
> > On Mon 2019-09-16 12:12:15, Nick Crews wrote:
> > > The tm_yday and tm_wday fields are not used by userspace,
> > > so since they aren't needed within the driver, don't
> > > bother calculating them. This is especially needed since
> > > the rtc_year_days() call was crashing if the HW returned
> > > an invalid time.
> > >
> > > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > > ---
> > >  drivers/rtc/rtc-wilco-ec.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > > index 8ad4c4e6d557..e84faa268caf 100644
> > > --- a/drivers/rtc/rtc-wilco-ec.c
> > > +++ b/drivers/rtc/rtc-wilco-ec.c
> > > @@ -110,10 +110,6 @@ static int wilco_ec_rtc_read(struct device *dev,=
 struct rtc_time *tm)
> > >     tm->tm_mday     =3D rtc.day;
> > >     tm->tm_mon      =3D rtc.month - 1;
> > >     tm->tm_year     =3D rtc.year + (rtc.century * 100) - 1900;
> > > -   tm->tm_yday     =3D rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm=
_year);
> > > -
> > > -   /* Don't compute day of week, we don't need it. */
> > > -   tm->tm_wday =3D -1;
> > >
> > >     return 0;
> >
> > Are you sure? It would be bad to pass unititialized memory to userspace=
...
> >
>
> This problem doesn't exist because userspace is passing the memory, not
> the other way around.
>
> > If userspace does not need those fields, why are they there?
> >
>
> This is coming from struct tm, it is part of C89 but I think I was not
> born when this decision was made. man rtc properly reports that those
> fields are unused and no userspace tools are actually making use of
> them. Nobody cares about the broken down representation of the time.
> What is done is use the ioctl then mktime to have a UNIX timestamp.
>
> "The mktime function ignores the specified contents of the tm_wday,
> tm_yday, tm_gmtoff, and tm_zone members of the broken-down time
> structure. It uses the values of the other components to determine the
> calendar time; it=E2=80=99s permissible for these components to have
> unnormalized values outside their normal ranges. The last thing that
> mktime does is adjust the components of the brokentime structure,
> including the members that were initially ignored."

This is very non-obvious and I only knew this from talking to you,
Alexandre. Perhaps we should add this note to the RTC core,
such as in the description for rtc_class_ops?

For this patch, do you want me to make any further changes?

Thanks,
Nick

>
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
