Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E81AFA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D562064B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YaFT1Q5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbfJQAWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 20:22:25 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40523 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388756AbfJQAWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 20:22:24 -0400
Received: by mail-il1-f196.google.com with SMTP id o16so285035ilq.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 17:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssXZYIfbBoFlq5o8fLFe5texKrdyJMrZYOXv4r4D2eM=;
        b=YaFT1Q5meCXdX8c6PZ7iRxWAGR3vsMIrZ4+0Y3+B6CPkpxiLnnwfpPv58dvBDfyB+J
         5KIa35vr8kmEsKqso7MTr5vdDzYVfXdtCbpprTk3yX+Lg6zsTkplbzXvre1UnbJI6hDe
         PVkqbLvb1vrKxIFOxfVSIPBrqSFlFyecIo8f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssXZYIfbBoFlq5o8fLFe5texKrdyJMrZYOXv4r4D2eM=;
        b=LP1yzELU9SdHkYamUcAMBGw9PVMBqK0pzT2tD20g0N9e5kSOOX2ipLeNIDJHTFdEoU
         ex5xzosT2L/2odNzS1ja0hyNgP4xWXpAfE694M9cyMiiq4jTvU7U2KOhR1EI76corfCQ
         f6Hg2284DQn0eFpR2qM/CIcygFLydrnFuJuxuWB79ItlWtndGdduh7UR3hF02tcfhA4E
         h1rRxeAF57XLQmMWchI7W7y+hWBE7gZKjIbL1v2RzwpEzauCELHNN4UIw5Xm4aPvSHbX
         B2eIrKhqqB3tIFcEDwvT0UDRU/VA0SVl1VAmoaK116zpwWY5H8afUMTnn/9MFP7na5dZ
         h/+A==
X-Gm-Message-State: APjAAAXLsc1puvVyig/Bk7SzXUSNomQ+jeCOMkm0io4y4P/bBhOLxfHV
        ZE9tf63woLFfwEEeqqjAwspfdDYB5xc=
X-Google-Smtp-Source: APXvYqxCFCN6we2AUqkh7z9c6bk+Veyx64PGuXk8VbGuB4vWx5CllmKApLOcmEr8GM3mOwqgV2xvew==
X-Received: by 2002:a92:d084:: with SMTP id h4mr732677ilh.300.1571271743325;
        Wed, 16 Oct 2019 17:22:23 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id l82sm284666ilh.23.2019.10.16.17.22.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 17:22:22 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id l12so295065ilq.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 17:22:21 -0700 (PDT)
X-Received: by 2002:a92:819c:: with SMTP id q28mr703756ilk.269.1571271741101;
 Wed, 16 Oct 2019 17:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190722193939.125578-1-dianders@chromium.org>
 <20190722193939.125578-2-dianders@chromium.org> <CAPDyKFpKWo4n+nmBXVcDc4TNzFV3vc+3aeKcu_nKaB=hj=RKUQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpKWo4n+nmBXVcDc4TNzFV3vc+3aeKcu_nKaB=hj=RKUQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Oct 2019 17:22:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WTKy3PmMSCbjKA_Ro_MP+dFE89oCzi_Bs7YeCrcD+3Xg@mail.gmail.com>
Message-ID: <CAD=FV=WTKy3PmMSCbjKA_Ro_MP+dFE89oCzi_Bs7YeCrcD+3Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: Add sdio_trigger_replug() API
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Andreas Fenkart <afenkart@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        netdev <netdev@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Xinming Hu <huxinming820@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 10, 2019 at 7:11 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 22 Jul 2019 at 21:41, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > When using Marvell WiFi SDIO cards, it is not uncommon for Linux WiFi
> > driver to fully lose the communication channel to the firmware running
> > on the card.  Presumably the firmware on the card has a bug or two in
> > it and occasionally crashes.
> >
> > The Marvell WiFi driver attempts to recover from this problem.
> > Specifically the driver has the function mwifiex_sdio_card_reset()
> > which is called when communcation problems are found.  That function
> > attempts to reset the state of things by utilizing the mmc_hw_reset()
> > function.
> >
> > The current solution is a bit complex because the Marvell WiFi driver
> > needs to manually deinit and reinit the WiFi driver around the reset
> > call.  This means it's going through a bunch of code paths that aren't
> > normally tested.  However, complexity isn't our only problem.  The
> > other (bigger) problem is that Marvell WiFi cards are often combo
> > WiFi/Bluetooth cards and Bluetooth runs on a second SDIO func.  While
> > the WiFi driver knows that it should re-init its own state around the
> > mmc_hw_reset() call there is no good way to inform the Bluetooth
> > driver.  That means that in Linux today when you reset the Marvell
> > WiFi driver you lose all Bluetooth communication.  Doh!
>
> Thanks for a nice description to the problem!
>
> In principle it makes mmc_hw_reset() quite questionable to use for
> SDIO func drivers, at all. However, let's consider that for later.

Yeah, unless you somehow knew that your card would only have one function.


> > One way to fix the above problems is to leverage a more standard way
> > to reset the Marvell WiFi card where we go through the same code paths
> > as card unplug and the card plug.  In this patch we introduce a new
> > API call for doing just that: sdio_trigger_replug().  This API call
> > will trigger an unplug of the SDIO card followed by a plug of the
> > card.  As part of this the card will be nicely reset.
>
> I have been thinking back and forth on this, exploring various
> options, perhaps adding some callbacks that the core could invoke to
> inform the SDIO func drivers of what is going on.
>
> Although, in the end this boils done to complexity and I think your
> approach is simply the most superior in regards to this. However, I
> think there is a few things that we can do to even further simply your
> approach, let me comment on the code below.

Right.  Unplugging / re-plugging is sorta gross / inelegant, but it is
definitely simpler and nice that it doesn't add so many new code
paths.  For cases where you're just trying to re-init things with a
hammer it works pretty well.


> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> > Changes in v2:
> > - s/routnine/routine (Brian Norris, Matthias Kaehlcke).
> > - s/contining/containing (Matthias Kaehlcke).
> > - Add Matthias Reviewed-by tag.
> >
> >  drivers/mmc/core/core.c       | 28 ++++++++++++++++++++++++++--
> >  drivers/mmc/core/sdio_io.c    | 20 ++++++++++++++++++++
> >  include/linux/mmc/host.h      | 15 ++++++++++++++-
> >  include/linux/mmc/sdio_func.h |  2 ++
> >  4 files changed, 62 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 221127324709..5da365b1fdb4 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2161,6 +2161,12 @@ int mmc_sw_reset(struct mmc_host *host)
> >  }
> >  EXPORT_SYMBOL(mmc_sw_reset);
> >
> > +void mmc_trigger_replug(struct mmc_host *host)
> > +{
> > +       host->trigger_replug_state = MMC_REPLUG_STATE_UNPLUG;
> > +       _mmc_detect_change(host, 0, false);
> > +}
> > +
> >  static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
> >  {
> >         host->f_init = freq;
> > @@ -2214,6 +2220,11 @@ int _mmc_detect_card_removed(struct mmc_host *host)
> >         if (!host->card || mmc_card_removed(host->card))
> >                 return 1;
> >
> > +       if (host->trigger_replug_state == MMC_REPLUG_STATE_UNPLUG) {
> > +               mmc_card_set_removed(host->card);
> > +               return 1;
>
> Do you really need to set state of the card to "removed"?
>
> If I understand correctly, what you need is to allow mmc_rescan() to
> run a second time, in particular for non removable cards.
>
> In that path, mmc_rescan should find the card being non-functional,
> thus it should remove it and then try to re-initialize it again. Etc.
>
> Do you want me to send a patch to show you what I mean!?

If you don't mind, that would probably be easiest.  I've totally
swapped out all of the implementation details of this from my brain
now, but if I saw a patch from you it would be easy for me to analyze
it and test it.

Thanks!

-Doug
