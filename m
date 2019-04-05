Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C12C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832A820651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQcHfpYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDEVnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:43:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38794 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEVnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:43:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so9173442qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lnTqhLiafZTofb6covhBpvssuceoe8w8OH3UgUU2CY4=;
        b=QQcHfpYcmfOYOgTi1vXf0wC5h877mzXr42DwFsAHm9ZNjDpHKsF6Cif3w4ixCAgn/w
         /dBwwvwjKdZqAWF6mPNSjlNqPQuiKULu+7LxY14wobo/wtycjxYwMa+ADQQhS1S7Nl6y
         QVZC4ciRg3M06dhgjMjHzgwol2GPVBR7pSUtMk3/nncholhlqhIiblQKFvSr/9eOwR8m
         Lk3SVu1KfZSnTEyzZM5OSrM/qKpJ0Cu7ngka5DIQtDtWqjyVcs4tRMU9HtDv4tx69DEc
         fYbQhSj++YMgvhYC/v0+8dxwjRU5ynycB6OLB+vbgg2dZtA6r5Sa6YKOMVgRw2pY7+NZ
         3B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lnTqhLiafZTofb6covhBpvssuceoe8w8OH3UgUU2CY4=;
        b=RY2sTz1KHs8f+2WBCg8q0IZo5SnkbNnomYPqtM3cTQdSuOeq1cHZY0lxB5qhqJB+uG
         Yrt/jpew45bxMHIyXE0R/hJe7OxztI6jXw2C/w9O7MR8jdS8CfKlNVCyxBpupsyGX8pK
         PLUdmwbIgZefdav/LeCmsKYeLZZaxUzGhecG4j4F5KmIkenMbfBlBhDP0Aw5L0tto9bn
         uSFiQbN0ETmThH36dc7B3lAKQR7d/C3zA4os1Pj7ZULMj6Bbrx/M5L0KJHbQEHsy6NMm
         n5uDHD7QnqencZjT4/4yRFkrpbameujdklYmzlxhyyjNGR+Tgxo84vDo5PtP+0abNDKg
         rv3Q==
X-Gm-Message-State: APjAAAWKAPbFMWOj1Q6LXfDhtZQEJxjS4wWJarvCPwNEIeN3oBgJYepC
        DszkXpAKMA2ay6neKys+TjYpPz4j+ehCoEjwH9xUSUWnfSg=
X-Google-Smtp-Source: APXvYqzmLlBxrM49oVTEW2A8pS/C5r1YsMA+yM/LM2BayBi5+BOrOwLV7xo941pW/13cxCRHpors2M0lSAnH5frpgGc=
X-Received: by 2002:a0c:b291:: with SMTP id r17mr12378742qve.206.1554500625825;
 Fri, 05 Apr 2019 14:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190403135403.9472-1-enric.balletbo@collabora.com>
 <CABXOdTcaHCPJ18kEJopV6BsoeVvfX66s1v_kpdatgzaqBus7Gw@mail.gmail.com>
 <CAFqH_51DiDut1ROeWtTddoK4PdbKFdbuMOGt8LaeyZXFZ2-w0w@mail.gmail.com> <CABXOdTcR7sxnESLP1skhFKaT0_o38T4o_AqZbaJz=f1DkPj0kg@mail.gmail.com>
In-Reply-To: <CABXOdTcR7sxnESLP1skhFKaT0_o38T4o_AqZbaJz=f1DkPj0kg@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 5 Apr 2019 23:43:34 +0200
Message-ID: <CAFqH_52RQqcCx-kuZqumHUA=1eVE-UcBxe7FZb1ofFsMULiwiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: Add CrOS USB PD logging driver
To:     Guenter Roeck <groeck@google.com>
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

Missatge de Guenter Roeck <groeck@google.com> del dia dv., 5 d=E2=80=99abr.
2019 a les 23:38:
>
> On Fri, Apr 5, 2019 at 2:09 PM Enric Balletbo Serra <eballetbo@gmail.com>=
 wrote:
> >
> > Hi Guenter,
> >
> > Missatge de Guenter Roeck <groeck@google.com> del dia dv., 5 d=E2=80=99=
abr.
> > 2019 a les 21:59:
> > >
> > > Hi Enric,
> > >
> > > On Wed, Apr 3, 2019 at 6:54 AM Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > > >
> > > > From: Guenter Roeck <groeck@chromium.org>
> > > >
> > > > The CrOS USB PD logging feature is logically separate functionality=
 of
> > > > the charge manager, hence has its own driver. The driver logs the e=
vent
> > > > data for the USB PD charger available in some ChromeOS Embedded
> > > > Controllers.
> > > >
> > > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > > [remove APPEND_STRING macro and minor cleanups]
> > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com=
>
> > > > ---
> > > >
> > > [ ... ]
> > >
> > > > +
> > > > +static void cros_usbpd_print_log_entry(struct ec_response_pd_log *=
r,
> > > > +                                      ktime_t tstamp)
> > > > +{
> > > [ ... ]
> > > > +
> > > > +       pr_info("PDLOG %d/%02d/%02d %02d:%02d:%02d.%03lld P%d %s\n"=
,
> > > > +               rt.tm_year + 1900, rt.tm_mon + 1, rt.tm_mday,
> > > > +               rt.tm_hour, rt.tm_min, rt.tm_sec,
> > > > +               ktime_to_ms(tstamp) % MSEC_PER_SEC,
> > >
> > > 0day rightfully complains that this introduces a 64-bit divide
> > > operation. I don't know if do_div() works here since it tries to
> > > modify the first parameter. Maybe we need an interim variable to stor=
e
> > > ktime_to_ms(tstamp). Something like
> > >
> > >     s64 temp =3D ktime_to_ms(tstamp);
> > >     ...
> > >                     do_div(temp, MSEC_PER_SEC),
> > >
> >
> > I did something similar this afternoon and pushed again for the auto
> > builders to play with.
> >
> > + div_s64_rem(ktime_to_ms(tstamp), MSEC_PER_SEC, &rem);
> >
> > Unfortunately, 0day now reports another error
> >
> > drivers/platform/chrome/cros_usbpd_logger.o: In function
> > `cros_usbpd_print_log_entry':
> > >> cros_usbpd_logger.c:(.text+0x5a0): undefined reference to `__aeabi_l=
divmod'
> >
>
> I think that may have been with the earlier version of the code. Your
> top of tree doesn't include the SHA that is reported as failing.
>

Oh right, good, thank you for telling me, I guess is time to go to bed
for me :-)

Enric

> Guenter
