Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882DFC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677C020859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfFJQc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:32:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42141 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfFJQc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:32:58 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so7366586ior.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 09:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+rDyplpIMLliH3w59yd4vRnaeCxcSiQQqnil4s0ePgk=;
        b=KXWai1Ot+HU+trLVzKcGvNU0xoCQpI/iuYTyCEAx7b9GTyXmKipr0c+DaPNAHpSe/j
         v8lz2zBLbOYpF5jZPIMD/X/mn4kaLOSKrC2gZgvfL0ocNBO6Ax+pREyImkUsYRS90UZE
         VqRJDzvSrx6Veh4mb2wqpdm1SpnPqFFmcpf0Zx6OyKo+ij7cedX4SN13VCrtDKjDML4R
         bgLXQbfXZTapRyIqa1XYihoPn81YzxLUKukg5gPwz4cFGj/kZig2xf4uFWndNldcAd5u
         M0P66ZB5OJnAqTKJn04BOg73SreMnSj7yDmMam8CgcMWtw6k6w/XShR5wEoytwyoXVVH
         DtUQ==
X-Gm-Message-State: APjAAAUfvi3m/xxTyrhlNM+Px/1Ek+ufpRNmFGd7kesWWlFReeaQ/A2p
        ngsWgGO6uax2p7QmcxqvftCXntcl/zhjEQ==
X-Google-Smtp-Source: APXvYqwJKyTxlm4jKug1+euyo0SUssWwHfgNUpOoFY93M9klio+EPBaFrZ/FtkKi7oeD6HO4kGvpOQ==
X-Received: by 2002:a5e:8618:: with SMTP id z24mr42520311ioj.174.1560184377625;
        Mon, 10 Jun 2019 09:32:57 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id w23sm3937448ioa.51.2019.06.10.09.32.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 09:32:56 -0700 (PDT)
Date:   Mon, 10 Jun 2019 10:32:52 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Message-ID: <20190610163252.GA227032@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 06:17:31PM +0200, Ulf Hansson wrote:
> + Adrian
> 
> On Fri, 7 Jun 2019 at 18:05, Raul Rangel <rrangel@chromium.org> wrote:
> >
> > On Tue, May 28, 2019 at 09:38:20AM +0200, Ulf Hansson wrote:
> > > On Wed, 1 May 2019 at 19:55, Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > First off, thanks for the review.
> >
> > > >
> > > > There is a race condition between resetting the SDHCI controller and
> > > > disconnecting the card.
> > > >
> > > > For example:
> > > > 0) Card is connected and transferring data
> > > > 1) mmc_sd_reset is called to reset the controller due to a data error
> > >
> > > I assume you refer to mmc_sd_hw_reset()? In that case, I think you
> > > have interpreted the purpose of mmc_sd_hw_reset() slightly wrong. It's
> > > responsibility is to reset the SD-card and not the host/controller.
> > You are correct. I was looking at a 4.14 kernel where it's called
> > mmc_sd_reset. 4.19 and above call it mmc_sd_hw_reset.
> >
> > All I was trying to convey here was that a block error will eventually
> > call sdhci_set_ios with SOFT_RESET_ALL via:
> > mmc_blk_reset
> > mmc_hw_reset
> > mmc_sd_hw_reset
> > mmc_power_cycle
> > mmc_power_off
> > mmc_set_initial_state
> > sdhci_set_ios
> > sdhci_reinit
> > sdhci_init
> > sdhci_do_reset(host, SDHCI_RESET_ALL);
> >
> > >
> > > Whether there some additional "reset" of the controller needed, that
> > > is assumed by the core, to be managed via the ->set_ios() callback for
> > > the host.
> > >
> > > > 2) sdhci_set_ios calls sdhci_do_reset
> > > > 3) SOFT_RESET_ALL is toggled which clears the IRQs the controller has
> > > > configured.
> > > > 4) Wait for SOFT_RESET_ALL to clear
> > > > 5) CD logic notices card is gone and CARD_PRESENT goes low, but since the
> > > >    IRQs are not configured a CARD_REMOVED interrupt is never raised.
> > > > 6) IRQs are enabled again
> > > > 7) mmc layer never notices the device is disconnected. The SDHCI layer
> > > >    will keep returning -ENOMEDIUM. This results in a card that is always
> > > >    present and not functional.
> > >
> > > This sounds like host specific problems, which most likely should be
> > > fixed in host driver, solely. Unless I am missing something, of
> > > course.
> >
> > So in sdhci_do_reset we call the reset callback which is typically
> > sdhci_reset. sdhci_reset can wait for up to 100ms waiting for the
> > controller to reset. If SDHCI_RESET_ALL was passed as the flag, the
> > controller will clear the IRQ mask. If during that 100ms the card is
> > removed there is no notification to the MMC system that the card was
> > removed. So it seems like the card is always present.
> 
> So you are saying that the problem occurs when the card is removed
> during this 100ms period?
Exactly. Thought I think most controllers reset fast enough to where
that window is very small. But for this AMD controller we need to do a
full reset which takes a while, so we can see the problem.

> 
> I assume there a way for sdhci to re-validate whether the card has
> been removed during this period, right?
I'll let Adrian chime in here.

> >
> > > >  drivers/mmc/core/sd.c | 20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > > index 265e1aeeb9d8..9206c4297d66 100644
> > > > --- a/drivers/mmc/core/sd.c
> > > > +++ b/drivers/mmc/core/sd.c
> > > > @@ -1242,7 +1242,27 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
> > > >
> > > >  static int mmc_sd_hw_reset(struct mmc_host *host)
> > > >  {
> > > > +       int present;
> > > >         mmc_power_cycle(host, host->card->ocr);
> > > > +
> > > > +       present = host->ops->get_cd(host);
> > > > +
> > > > +       /* The card status could have changed while resetting. */
> > > > +       if ((mmc_card_removed(host->card) && present) ||
> > > > +           (!mmc_card_removed(host->card) && !present)) {
> > > > +               pr_info("%s: card status changed during reset\n",
> > > > +                      mmc_hostname(host));
> > > > +               host->ops->card_event(host);
> > > > +               mmc_detect_change(host, 0);
> > > > +       }
> > > > +
> > > > +       /* Don't perform unnecessary transactions if the card is missing. */
> > > > +       if (!present) {
> > > > +               pr_info("%s: card was removed during reset\n",
> > > > +                       mmc_hostname(host));
> > > > +               return -ENOMEDIUM;
> > > > +       }
> > > > +
> > >
> > > When doing a  mmc_hw_reset() (which ends up calling mmc_sd_hw_reset()
> > > in case of SD cards), we are making a final attempt to make the card
> > > functional again, via a power cycle and a re-init of it.
> > >
> > > In this path, we don't care whether the card is removed, as that
> > > should have been detected already when the block layer calls
> > > mmc_detect_card_removed().
> >
> > mmc_detect_card_removed has the guard `host->detect_change` to
> > prevent it from checking the card status again. So maybe the fix to the
> > missing interrupt/race condition is to set `host->detect_change = 1`
> > from sdhci_do_reset after calling the reset handler. This way there will
> > always be a single poll after a full reset so the correct card status can
> > be detected?
> 
> It sounds like you should call mmc_detect_change(), after the reset to
> let the core check for cards that may have been removed/inserted.
> 
> Would that work?
Yeah, I could add `mmc_detect_change()` to the AMD SDHCI patch. I just
thought it would be better to fix the potential race condition at a
higher level. Though I'm happy to move it to the AMD patch. Let me know.

Thanks
> 
> [...]
> 
> Kind regards
> Uffe
