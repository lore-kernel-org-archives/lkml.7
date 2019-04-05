Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EAAC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F78221855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgQClfbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDEVit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:38:49 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37246 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEVit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:38:49 -0400
Received: by mail-yw1-f68.google.com with SMTP id w66so2853778ywd.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DcRMZeDdbz/Vn7XzjGtqY9Ho+sibtKCgzgCk9+Tui54=;
        b=DgQClfbePKtbzaYAhGgF+HcqkKHLPhPlbFodmAS0ksJdlivPW+y9/8/eT6gcVnUwZZ
         Pd4x9RG80wmrNeDmbnvaxQeH/gihkvSf45uvr07wMIUk0Hb3USgCQtDoDxYKDOdJsfX5
         bgOKOgabDrLFJSPbJpSR0M9BEm2cjrg/d8jWOEc6gBIaFh3zQVA2sV9NcZ7/K7jIZE9k
         Uhm/4DuqIOqA4zoubkHJ42whcc+KTR/xINV0npYVFknSGkGlToBvqTm9Fcp+SH7voxJp
         wx1Av1AknJC9kyxNegFcVegAOD/Iqt4ccgcgnVncO87x9dQYWbPvrbYVON5CBGdWR6w7
         b2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DcRMZeDdbz/Vn7XzjGtqY9Ho+sibtKCgzgCk9+Tui54=;
        b=DekWy4y9mGi2JPxbJe3l/E49V+MSwSNrr6oMhR4WsWHd+ZzF+elsHQqU+EVHlw3xJD
         26lBLsqQPMN+w/oY16MgByis51nT+OxCAtBQ0OYnkgB/p+WN4I3z9Pm0Q5PL1n5FyFkP
         5Oo0SAo0N50QHD9VOVDKbCLrFjsE9ZY2KiiRICElTgql3CWXe1kfCfQ8JAd4EWPPC2HI
         UA05l/YEGgmgtgNieTx5/Sb/PcC4Kk0rd/ACfy60thIRvkZB3cdacAKPPWIyPZLz2GQk
         8Ic0QKDx19KD8qVqjBVZlICdZxgEgUyQrmOxcKiA75qu3f4wcJxWIy2NzcKraX14A1OT
         nmRw==
X-Gm-Message-State: APjAAAVb/ncicbsRd5SRFsrRYG80olDqH4G4U5xYoxIzAoAy4GUWNCyg
        buqnTsNEC9bcTFQIfb7raYM/AFcZUt7yLUryNjdp9A==
X-Google-Smtp-Source: APXvYqyNL+es0KPiIHnDZ0+GaUnkqr/3mqNXVBOjjfB6YUYNX4x8MFp5hwP+onUsTk86b9u6SkKHAb1LauGHT4d58P0=
X-Received: by 2002:a0d:e1d4:: with SMTP id k203mr12523889ywe.34.1554500328017;
 Fri, 05 Apr 2019 14:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190403135403.9472-1-enric.balletbo@collabora.com>
 <CABXOdTcaHCPJ18kEJopV6BsoeVvfX66s1v_kpdatgzaqBus7Gw@mail.gmail.com> <CAFqH_51DiDut1ROeWtTddoK4PdbKFdbuMOGt8LaeyZXFZ2-w0w@mail.gmail.com>
In-Reply-To: <CAFqH_51DiDut1ROeWtTddoK4PdbKFdbuMOGt8LaeyZXFZ2-w0w@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 5 Apr 2019 14:38:36 -0700
Message-ID: <CABXOdTcR7sxnESLP1skhFKaT0_o38T4o_AqZbaJz=f1DkPj0kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: Add CrOS USB PD logging driver
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, jflat@chromium.org,
        kernel@collabora.com, Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 2:09 PM Enric Balletbo Serra <eballetbo@gmail.com> w=
rote:
>
> Hi Guenter,
>
> Missatge de Guenter Roeck <groeck@google.com> del dia dv., 5 d=E2=80=99ab=
r.
> 2019 a les 21:59:
> >
> > Hi Enric,
> >
> > On Wed, Apr 3, 2019 at 6:54 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > >
> > > From: Guenter Roeck <groeck@chromium.org>
> > >
> > > The CrOS USB PD logging feature is logically separate functionality o=
f
> > > the charge manager, hence has its own driver. The driver logs the eve=
nt
> > > data for the USB PD charger available in some ChromeOS Embedded
> > > Controllers.
> > >
> > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > [remove APPEND_STRING macro and minor cleanups]
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > >
> > [ ... ]
> >
> > > +
> > > +static void cros_usbpd_print_log_entry(struct ec_response_pd_log *r,
> > > +                                      ktime_t tstamp)
> > > +{
> > [ ... ]
> > > +
> > > +       pr_info("PDLOG %d/%02d/%02d %02d:%02d:%02d.%03lld P%d %s\n",
> > > +               rt.tm_year + 1900, rt.tm_mon + 1, rt.tm_mday,
> > > +               rt.tm_hour, rt.tm_min, rt.tm_sec,
> > > +               ktime_to_ms(tstamp) % MSEC_PER_SEC,
> >
> > 0day rightfully complains that this introduces a 64-bit divide
> > operation. I don't know if do_div() works here since it tries to
> > modify the first parameter. Maybe we need an interim variable to store
> > ktime_to_ms(tstamp). Something like
> >
> >     s64 temp =3D ktime_to_ms(tstamp);
> >     ...
> >                     do_div(temp, MSEC_PER_SEC),
> >
>
> I did something similar this afternoon and pushed again for the auto
> builders to play with.
>
> + div_s64_rem(ktime_to_ms(tstamp), MSEC_PER_SEC, &rem);
>
> Unfortunately, 0day now reports another error
>
> drivers/platform/chrome/cros_usbpd_logger.o: In function
> `cros_usbpd_print_log_entry':
> >> cros_usbpd_logger.c:(.text+0x5a0): undefined reference to `__aeabi_ldi=
vmod'
>

I think that may have been with the earlier version of the code. Your
top of tree doesn't include the SHA that is reported as failing.

Guenter
