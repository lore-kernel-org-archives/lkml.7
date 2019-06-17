Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E1C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF542084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSKgPa+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfFQK1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:27:36 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35687 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfFQK1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:27:36 -0400
Received: by mail-vs1-f67.google.com with SMTP id u124so5780913vsu.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWYb/Zh5hR4Y7Z2Mo5OPcDpLlMaQ11WAB0Gr9F/KJhg=;
        b=LSKgPa+g+7DNCTbJpH0qUKpqawRvh/d++pJCCC3PW2h79/pExl40sygxXzgnDpQWkn
         VrncjhJxwr+F9HKSEOpAuqGErhxy67QcYSBzifLw9Qtiqz9Vku+y3jPmMEfTn7xNB4je
         gbW3HG/sob9VeRsps7Jl51cNKl97xJZ0U3rPZ1gJIOWiXRPc46ONPsvOt0q5NsLjmstL
         gxuxdbVg9GJXojm/yUAOupJOLUaPvG0yLOFmlnoPp4CrhyPLBzsMvJyGDSSix+Uko42u
         1vEov6oXmwIr6cQ0kUVPPIFvcHAPWdWEoGDjMrvMrp3+eQ5CnzavFi1PUciqGe7GLK9N
         WKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWYb/Zh5hR4Y7Z2Mo5OPcDpLlMaQ11WAB0Gr9F/KJhg=;
        b=cXhLYUtBVAjwSCpAZOPfRiHAmUi/V9UP1I+9GpTECM4xuoNYROLYQ/41g36p0YWGmh
         tpRjYWQr/0hlMB9Mic6K5ixKOYlpB+9neq7cdR1334/VDKnDu2MW05euD0+aZrESQqBy
         IpVls8trRamjnUONvNXMo2yHDsBNnfHThgov/fMYhvklqdT63hyx7cSbgipz5sZmjIzc
         ndzpZapky9qu+SYkWYKoogsqV8EfaUI34eRqzART2c8cuSeQQJww+UFVtJ/My8qxdqkj
         A+XDonWZHZKvfspSF3YBxvclwJ8seNQcOqsqrgSvs91Ulfp0TtsWpDVVS6dvZu6hI1Af
         c4sw==
X-Gm-Message-State: APjAAAVgb0BLW54jnLOA+z+dKY7S7dvBFt/IIsqz+14v09QB3sGUXKll
        NnHX33ojsnYQKPL2LC1uRUO6w3Np33iMDkvWRc/4yg==
X-Google-Smtp-Source: APXvYqxUAcAXM6xLg+Lo5Ist0BqPaEgRA+MmyQ2AckTZ5gFI5x+e6SeG5DpkiSpMd5BqKaXv3Mp0QLkcRk87WVreyVI=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr25970572vsp.165.1560767255165;
 Mon, 17 Jun 2019 03:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190610185354.35310-1-rrangel@chromium.org> <CAPDyKFppNgL_kZPV-QS6ZiJErde5ea8Nj-sQTy_vXhW9jfXhpg@mail.gmail.com>
 <20190612150115.GA27989@google.com>
In-Reply-To: <20190612150115.GA27989@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 12:26:59 +0200
Message-ID: <CAPDyKFro3vHMMPHpVOSqiyFgtJsqmyzK11hipCGpDYFARyN+hg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus
 width when tuning
To:     Raul Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 at 17:01, Raul Rangel <rrangel@chromium.org> wrote:
>
> On Wed, Jun 12, 2019 at 03:36:25PM +0200, Ulf Hansson wrote:
> > On Mon, 10 Jun 2019 at 20:54, Raul E Rangel <rrangel@chromium.org> wrote:
> > >
> > > sdhci_send_tuning uses mmc->ios.bus_width to determine the block size.
> > > Without this patch the block size would be set incorrectly when the
> > > bus_width == 8 which results in tuning failing.
> > >
> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > > ---
> > >
> > >  drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> > > index b29bf4e7dcb48..dd21315922c87 100644
> > > --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> > > +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> > > @@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
> > >          */
> > >         if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> > >                 current_bus_width = mmc->ios.bus_width;
> > > +               mmc->ios.bus_width = MMC_BUS_WIDTH_4;
> >
> > This looks wrong.
> >
> > mmc->ios.bus_width is not supposed to be updated by a host driver, but
> I guess I left this part out: The O2Micro controller only supports
> tuning at 4-bits. So the host driver needs to change the bus width while
> tuning and then set it back when done.

Thanks for clarifying. Please add that information to the changelog
and a minor comment in the code as well.

> Ideally I would have used
> `mmc_set_bus_width()`, but that is a core only function.

Well, that function also calls mmc_set_ios(), which is not what you
want, or is it?

>
> If `sdhci_send_tuning()` didn't rely on mmc->ios.bus_width to determine
> the bus width, but instead read the HOST_CONTROL register then this
> patch wouldn't be needed.

Could you elaborate on that. Perhaps there are variants that have a
similar constraint and in such case, this solution could possibly help
them as well.

> > rather the value should only be read.
> >
> > >                 sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
> > >         }
> > >
> > > @@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
> > >
> > >         sdhci_end_tuning(host);
> > >
> > > -       if (current_bus_width == MMC_BUS_WIDTH_8)
> > > +       if (current_bus_width == MMC_BUS_WIDTH_8) {
> > > +               mmc->ios.bus_width = MMC_BUS_WIDTH_8;
> >
> > Ditto.
> >
> > >                 sdhci_set_bus_width(host, current_bus_width);
> > > +       }
> > >
> > >         host->flags &= ~SDHCI_HS400_TUNING;
> > >         return 0;
> > > --
> > > 2.22.0.rc2.383.gf4fbbf30c2-goog
> > >
> >

Kind regards
Uffe
