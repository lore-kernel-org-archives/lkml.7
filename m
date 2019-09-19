Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E96C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7077121924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z95ybOiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390067AbfISL4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:56:46 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35256 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388771AbfISL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:56:46 -0400
Received: by mail-ua1-f67.google.com with SMTP id n63so964253uan.2;
        Thu, 19 Sep 2019 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5z5u0o7PbQVY4AiWOVq68ozptawOh6Ts0gi7RJ8q+vc=;
        b=Z95ybOizbHlFYWAPfDhf0TXuaP4IpO+79JGGupMcSCwPlnvldsXaVpcVhuZ63Z/KlO
         RsgQ5bomH78tVFurWCQg+L83jek3Eb7aiYGtbgBNawt5U55K2+tSmCcO3b5UhVw80+NO
         ho3uTnpnaAmk49RmnBcDbRenxBvwCdy91hPhBZKOCseBPjt0Ttk3RHZZC74vU2rcRuUk
         Ll6UaI2wG4c7nBdSYnZSiP3o0SyTrib5O1eChdNeYWS11MCY1GG7k6HtHJSUtFG8KXal
         abp2tYNnSilQ4fPrOIlA//c/YjgVLxkkNpisjz61EzwkqMp3M92yxZlDyAaZD/F4zlTb
         UKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5z5u0o7PbQVY4AiWOVq68ozptawOh6Ts0gi7RJ8q+vc=;
        b=a3tnCf8vzcXEAPjOK04+CNm4MdRpFKhrZFKC0qz17hTVSlaiCbAhhsD1W6EdMyCbdx
         LFkK3b8y9tAzxIG9ihqeLbZy+CF8Rzi0qZiVbIDu8e2bwqB7SXlLbplwKlgnRAcSizZN
         63964t7eT80YqbzNkzH4W/NblIV0s2Iq2AoUFzulNrSiAiwn6/Ei2N21McSjQwHMdRFo
         46B0yiPEvHJ1RgVK105MceUDUnb2FFU8LSvd0jHKYbqWrXP0mWr6hfKoAIlO5YnPyIZ3
         y2HHliyAPX0uFR0URyPvLEearjnrqgEfELCZ6YKUejusi34uJFQKbzTp2pbfGrfNpYB4
         bCkQ==
X-Gm-Message-State: APjAAAXxl+X3iVjXzxOfiZAUyis8Kn4JLUDXFwyU0Ww/Kbj7bx78mfJ0
        FWOZPflYGpcsFieAzpuhK1y9bd2HnLSSL3KkLI4=
X-Google-Smtp-Source: APXvYqxKATzXSuOngJ1GS37vVqVjID3FljIjWDx4H4TM0nY6yDDgsOmCGP2jzJhWk9wmDDAjQAZ9nIDtwOUseh2uA3A=
X-Received: by 2002:ab0:240f:: with SMTP id f15mr4747430uan.103.1568894205232;
 Thu, 19 Sep 2019 04:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190903115114.33053-1-alcooperx@gmail.com> <CAPDyKFqaNBH3Thwy1O+KXkcsgM2gMrm9zNGYWH8vVP+Y2vSLdA@mail.gmail.com>
In-Reply-To: <CAPDyKFqaNBH3Thwy1O+KXkcsgM2gMrm9zNGYWH8vVP+Y2vSLdA@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Thu, 19 Sep 2019 07:57:45 -0400
Message-ID: <CAOGqxeUJD7eQxRnH1rep=m2+Ga5DDF=uWMsc_j2NZgC+EnZqsg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix incorrect switch to HS mode
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does correct the sequence of switching to HS400 but it might be
safest to just add this to the latest until it gets a little testing
to make sure it doesn't expose some bug in existing controllers.

Thanks
Al

On Tue, Sep 3, 2019 at 10:52 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 3 Sep 2019 at 13:51, Al Cooper <alcooperx@gmail.com> wrote:
> >
> > When switching from any MMC speed mode that requires 1.8v
> > (HS200, HS400 and HS400ES) to High Speed (HS) mode, the system
> > ends up configured for SDR12 with a 50MHz clock which is an illegal
> > mode.
> >
> > This happens because the SDHCI_CTRL_VDD_180 bit in the
> > SDHCI_HOST_CONTROL2 register is left set and when this bit is
> > set, the speed mode is controlled by the SDHCI_CTRL_UHS field
> > in the SDHCI_HOST_CONTROL2 register. The SDHCI_CTRL_UHS field
> > will end up being set to 0 (SDR12) by sdhci_set_uhs_signaling()
> > because there is no UHS mode being set.
> >
> > The fix is to change sdhci_set_uhs_signaling() to set the
> > SDHCI_CTRL_UHS field to SDR25 (which is the same as HS) for
> > any switch to HS mode.
> >
> > This was found on a new eMMC controller that does strict checking
> > of the speed mode and the corresponding clock rate. It caused the
> > switch to HS400 mode to fail because part of the sequence to switch
> > to HS400 requires a switch from HS200 to HS before going to HS400.
> >
> > This fix was suggested by Adrian Hunter
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
>
> Should this be applied for fixes and tagged for stable you think?
>
> Kind regards
> Uffe
>
> > ---
> >  drivers/mmc/host/sdhci.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 61d845fe0b97..068149640ecd 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1858,7 +1858,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
> >                 ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> >         else if (timing == MMC_TIMING_UHS_SDR12)
> >                 ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> > -       else if (timing == MMC_TIMING_UHS_SDR25)
> > +       else if (timing == MMC_TIMING_SD_HS ||
> > +                timing == MMC_TIMING_MMC_HS ||
> > +                timing == MMC_TIMING_UHS_SDR25)
> >                 ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
> >         else if (timing == MMC_TIMING_UHS_SDR50)
> >                 ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> > --
> > 2.17.1
> >
