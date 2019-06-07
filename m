Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18561C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DE620657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfFGQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:06:01 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39248 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbfFGQGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:06:00 -0400
Received: by mail-it1-f195.google.com with SMTP id j204so3525790ite.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3d+sQkEUGswx0vi5iVQTFhUmyzvsMxjPwViajnHm94=;
        b=RJw1+0L4j2ciyw+5+V/HgPDYiPz1Pxh53gGKprihxqNLcPdts3fIgBbOuP+p6GYijM
         yCWQ0Gsg39FUHpf9xCPQy/nzCgGSIelbDwQKKi5IaXCSu8fKgVwX0UP0A+HnMSdGPNta
         Thjt0bQN1fy7kSeVaDIIAsim6kXxJZs2foyU8iWCAtj21SowVhdbptQ1MG3gUkz901gU
         bs1Yqg3AjQRzMGG1BWKxH+wV6UJvJPKmIMoWQ/CUDu5J09FAZ3pA4qGCkYyNWrxlruTW
         6+KlQFf0RojZVU4OsE0Q9/qxrWDlXGlkKltrNpPwvIl+jxN+RZUTvUp2n2k+Wv2JsoRC
         7d0Q==
X-Gm-Message-State: APjAAAXBUDQWaBJdz+L0zOJHN80PyCMnpYWPKgPVUYXK/+ZHR+++zN4d
        /zBa7+gftj0GBzoKC3DJhrLYRQ==
X-Google-Smtp-Source: APXvYqwF0Ie7SjNm5AsRiGim8s114cLjEq8mr0mOZS0lzBD7gtSici+z3EIDb5xRPoeRpCLpm0++zA==
X-Received: by 2002:a02:1649:: with SMTP id a70mr36654081jaa.116.1559923559090;
        Fri, 07 Jun 2019 09:05:59 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id z202sm1146392itb.2.2019.06.07.09.05.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 09:05:58 -0700 (PDT)
Date:   Fri, 7 Jun 2019 10:05:53 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Message-ID: <20190607160553.GA185100@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 09:38:20AM +0200, Ulf Hansson wrote:
> On Wed, 1 May 2019 at 19:55, Raul E Rangel <rrangel@chromium.org> wrote:

First off, thanks for the review.

> >
> > There is a race condition between resetting the SDHCI controller and
> > disconnecting the card.
> >
> > For example:
> > 0) Card is connected and transferring data
> > 1) mmc_sd_reset is called to reset the controller due to a data error
> 
> I assume you refer to mmc_sd_hw_reset()? In that case, I think you
> have interpreted the purpose of mmc_sd_hw_reset() slightly wrong. It's
> responsibility is to reset the SD-card and not the host/controller.
You are correct. I was looking at a 4.14 kernel where it's called
mmc_sd_reset. 4.19 and above call it mmc_sd_hw_reset.

All I was trying to convey here was that a block error will eventually
call sdhci_set_ios with SOFT_RESET_ALL via:
mmc_blk_reset
mmc_hw_reset
mmc_sd_hw_reset
mmc_power_cycle
mmc_power_off
mmc_set_initial_state
sdhci_set_ios
sdhci_reinit
sdhci_init
sdhci_do_reset(host, SDHCI_RESET_ALL);

> 
> Whether there some additional "reset" of the controller needed, that
> is assumed by the core, to be managed via the ->set_ios() callback for
> the host.
> 
> > 2) sdhci_set_ios calls sdhci_do_reset
> > 3) SOFT_RESET_ALL is toggled which clears the IRQs the controller has
> > configured.
> > 4) Wait for SOFT_RESET_ALL to clear
> > 5) CD logic notices card is gone and CARD_PRESENT goes low, but since the
> >    IRQs are not configured a CARD_REMOVED interrupt is never raised.
> > 6) IRQs are enabled again
> > 7) mmc layer never notices the device is disconnected. The SDHCI layer
> >    will keep returning -ENOMEDIUM. This results in a card that is always
> >    present and not functional.
> 
> This sounds like host specific problems, which most likely should be
> fixed in host driver, solely. Unless I am missing something, of
> course.

So in sdhci_do_reset we call the reset callback which is typically
sdhci_reset. sdhci_reset can wait for up to 100ms waiting for the
controller to reset. If SDHCI_RESET_ALL was passed as the flag, the
controller will clear the IRQ mask. If during that 100ms the card is
removed there is no notification to the MMC system that the card was
removed. So it seems like the card is always present.

> >  drivers/mmc/core/sd.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index 265e1aeeb9d8..9206c4297d66 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -1242,7 +1242,27 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
> >
> >  static int mmc_sd_hw_reset(struct mmc_host *host)
> >  {
> > +       int present;
> >         mmc_power_cycle(host, host->card->ocr);
> > +
> > +       present = host->ops->get_cd(host);
> > +
> > +       /* The card status could have changed while resetting. */
> > +       if ((mmc_card_removed(host->card) && present) ||
> > +           (!mmc_card_removed(host->card) && !present)) {
> > +               pr_info("%s: card status changed during reset\n",
> > +                      mmc_hostname(host));
> > +               host->ops->card_event(host);
> > +               mmc_detect_change(host, 0);
> > +       }
> > +
> > +       /* Don't perform unnecessary transactions if the card is missing. */
> > +       if (!present) {
> > +               pr_info("%s: card was removed during reset\n",
> > +                       mmc_hostname(host));
> > +               return -ENOMEDIUM;
> > +       }
> > +
> 
> When doing a  mmc_hw_reset() (which ends up calling mmc_sd_hw_reset()
> in case of SD cards), we are making a final attempt to make the card
> functional again, via a power cycle and a re-init of it.
> 
> In this path, we don't care whether the card is removed, as that
> should have been detected already when the block layer calls
> mmc_detect_card_removed().

mmc_detect_card_removed has the guard `host->detect_change` to
prevent it from checking the card status again. So maybe the fix to the
missing interrupt/race condition is to set `host->detect_change = 1`
from sdhci_do_reset after calling the reset handler. This way there will
always be a single poll after a full reset so the correct card status can
be detected?

> 
> >         return mmc_sd_init_card(host, host->card->ocr, host->card);
> >  }
> >
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
> 
> Kind regards
> Uffe
>
Thanks again for the review!

