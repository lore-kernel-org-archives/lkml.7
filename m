Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F913C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA4121655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dzeo1u9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLTTgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:36:00 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33102 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTTgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:36:00 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so9183441qto.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 11:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6ccQDi1F9SPbcPBXhrPvQY95LBc5kJhF17D3pnjjDvU=;
        b=dzeo1u9lXJAwfs3L4kdz9fc21Io6Hve8ECQKPAi4L6/gQvOc6Uz/5vD1BqxwlD7qUC
         04vL5BKOLAUlWUAxeGx5hkMEiu2qXO4uyIMW+TsVMVSYJRGTaZsBMFgE2dpyDvJPgHyb
         TENcNgpO7OF//s1sajTWTR3aELFVgXjX7bNJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6ccQDi1F9SPbcPBXhrPvQY95LBc5kJhF17D3pnjjDvU=;
        b=pHmO/pebOXO/ZJynuof8IXJQQULRlbWaEcVKT2xcFVCdjh36hs9p0yLIw/XLrPjN4Z
         Y/3PmFivOFfTCTjB9MHA13CXTYbggJ0QYUS7vcMn2BagjSvtyE0172FR1vQxHPsnlUPV
         5FBPrJO2YpNtbemt5MizmmDqqnbtS51tDbxv5bWIY/jtbS+VDqEXmLMDheeEO/eTUGU1
         ftzn/Ch5Hm0bjgjY9Qexf9BZn/vNJHVH9fHScx2LfrD52obQmdB2T+bm951eQP7VIg+P
         pxdV23i1DlbCafEF5nYL+jkJ+FFsUB2PXOJ8eKJxjGt3jjaftBhQV1nWZo252ZTWyySW
         GRxw==
X-Gm-Message-State: APjAAAWfMZFV38riWIoz6DP1NiS9DU1VwcqULSayrzdE5Y/xF3uXlQQD
        fOOyYDgywAtM/v2uyhuD4ECp0R6qJgY8aHA6ZtGEzA==
X-Google-Smtp-Source: APXvYqwqq2ZP022vPEMoI8NimGYtJK2qQ9JDC10HfvpGkzkmjuzJ0DgEoz+I72XV8pRfVgRQhVvwTxyQYPYKEW/0MDI=
X-Received: by 2002:ac8:5457:: with SMTP id d23mr12606355qtq.93.1576870558756;
 Fri, 20 Dec 2019 11:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20191219201340.196259-1-pmalani@chromium.org> <20191219201340.196259-2-pmalani@chromium.org>
 <f3d6267e-2429-e5a0-2a0e-60cab5bb1bb9@collabora.com> <20191220105252.GR18955@dell>
In-Reply-To: <20191220105252.GR18955@dell>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 20 Dec 2019 11:35:47 -0800
Message-ID: <CACeCKadb7tadNEWg-0=8c_km3XXB25JA=rj1UBiFdWMDj37fYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: cros_ec: Add usbpd-notify to usbpd_charger
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 2:52 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 20 Dec 2019, Enric Balletbo i Serra wrote:
>
> > Hi Prashant,
> >
> > This should be [PATCH v3 2/2]. All the patches in the series should hav=
e the
> > same version otherwise makes difficult to follow.
> >
> > Thanks,
> >  Enric
> >
> > On 19/12/19 21:13, Prashant Malani wrote:
> > > Add the cros-usbpd-notify driver as a cell for the cros_usbpd_charger
> > > subdevice on non-ACPI platforms.
> > >
> > > This driver allows other cros-ec devices to receive PD event
> > > notifications from the Chrome OS Embedded Controller (EC) via a
> > > notification chain.
> > >
> > > Change-Id: I4c062d261fa1a504b43b0a0c0a98a661829593b9
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >  drivers/mfd/cros_ec_dev.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > > index c4b977a5dd966..1dde480f35b93 100644
> > > --- a/drivers/mfd/cros_ec_dev.c
> > > +++ b/drivers/mfd/cros_ec_dev.c
> > > @@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cell=
s[] =3D {
> > >  static const struct mfd_cell cros_usbpd_charger_cells[] =3D {
> > >     { .name =3D "cros-usbpd-charger", },
> > >     { .name =3D "cros-usbpd-logger", },
> > > +#ifndef CONFIG_ACPI
> > > +   { .name =3D "cros-usbpd-notify", },
> > > +#endif
>
> We don't want #iferry all over our c-files.  If you *have* to rely on
> Kconfig configurations, split this out into a separate cell and use
> IS_ENABLED().
Done. Thanks.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
