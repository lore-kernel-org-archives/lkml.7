Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD74C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FBB208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfFLPBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:01:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41390 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfFLPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:01:21 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so13177869ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 08:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=shuAyQ1I56gj94KbjmRqaQ587FUaZO/1wGxqCAR2L5g=;
        b=jasr/6eNBT3Wy2jHPCQOQsFkc+rf0C3zTbErwqYuQkh1Gn06FKv94qkrmv1fUV6ixO
         Jw3KCQjCB/vQbNW7RrN4tV7k9yeVVbtOrk1hW/eHMMxfVJokG8CYSxALkfZsuDGFB6MB
         6J/dTIupA3tjx3ioJTaH3CuEovbEu5mxWMAzMlaJODNCvJlGQVf5MinWJt7g4077ZmCt
         /RQjWKq+9Ollm6zQjqMAwsm9r5MRK30ngnAA0AuAsCpzwNqzK+ywYc50gjQLPGzkali3
         zVuoQuSMoh4HF27CBEdAOP/taPqTP4x6c+5uh9zYX2kAgm07tbwPdrD5gkc991KKCF6A
         Sixg==
X-Gm-Message-State: APjAAAXg9AFbbFpgJgHyiiCT2vac2xlZUstd9BBdVuQdfuDGW1X3C/db
        HhOwg1t5WoiD1zKtOkawpnThcA==
X-Google-Smtp-Source: APXvYqxvIw+gJmjqKDyUCtIwpfzNKI1enkSa94j5cWvjhBtpZNh9a80WqyvkTu1WUeUpW3gtHtseKQ==
X-Received: by 2002:a5e:820a:: with SMTP id l10mr33701840iom.283.1560351680686;
        Wed, 12 Jun 2019 08:01:20 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id n7sm5939759ioo.79.2019.06.12.08.01.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 08:01:19 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:01:15 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus
 width when tuning
Message-ID: <20190612150115.GA27989@google.com>
References: <20190610185354.35310-1-rrangel@chromium.org>
 <CAPDyKFppNgL_kZPV-QS6ZiJErde5ea8Nj-sQTy_vXhW9jfXhpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFppNgL_kZPV-QS6ZiJErde5ea8Nj-sQTy_vXhW9jfXhpg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 03:36:25PM +0200, Ulf Hansson wrote:
> On Mon, 10 Jun 2019 at 20:54, Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > sdhci_send_tuning uses mmc->ios.bus_width to determine the block size.
> > Without this patch the block size would be set incorrectly when the
> > bus_width == 8 which results in tuning failing.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> >
> >  drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> > index b29bf4e7dcb48..dd21315922c87 100644
> > --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> > +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> > @@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >          */
> >         if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> >                 current_bus_width = mmc->ios.bus_width;
> > +               mmc->ios.bus_width = MMC_BUS_WIDTH_4;
> 
> This looks wrong.
> 
> mmc->ios.bus_width is not supposed to be updated by a host driver, but
I guess I left this part out: The O2Micro controller only supports
tuning at 4-bits. So the host driver needs to change the bus width while
tuning and then set it back when done. Ideally I would have used
`mmc_set_bus_width()`, but that is a core only function.

If `sdhci_send_tuning()` didn't rely on mmc->ios.bus_width to determine
the bus width, but instead read the HOST_CONTROL register then this
patch wouldn't be needed.
> rather the value should only be read.
> 
> >                 sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
> >         }
> >
> > @@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >
> >         sdhci_end_tuning(host);
> >
> > -       if (current_bus_width == MMC_BUS_WIDTH_8)
> > +       if (current_bus_width == MMC_BUS_WIDTH_8) {
> > +               mmc->ios.bus_width = MMC_BUS_WIDTH_8;
> 
> Ditto.
> 
> >                 sdhci_set_bus_width(host, current_bus_width);
> > +       }
> >
> >         host->flags &= ~SDHCI_HS400_TUNING;
> >         return 0;
> > --
> > 2.22.0.rc2.383.gf4fbbf30c2-goog
> >
> 
> Kind regards
> Uffe
Thanks for the review!
