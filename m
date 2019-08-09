Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C789C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1611920B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405825AbfHIIJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:09:49 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:10925 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfHIIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:09:48 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Ez9pOIoZtFKff6baimLMQ7mQcJ9pgBWUaVIIB2RVIgaHjXa3kQxxtK7N9FMXfXQjTI7XnES4Ad
 7Cv1xrEwpteMPfkUvfJlWPJ4672GAzNv5MeyWfjdaqo+MX1BUji0dJQcdwlHFq21NEalhVz+Rl
 4I+U9k/K+gXUu6BmJh5mVaMBQeW8xq47tfR7OjRyaPODZhRsRTdjRMPg/FgE9XoTP043uQP66c
 fe+70ju+qxz08yIO00997hczI11wr/Q/P94+tQLpg3rxetFRQeuSyqYCdrkUE1qUaOmm8RK93u
 qto=
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="45983219"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2019 01:09:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 9 Aug 2019 01:09:47 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 9 Aug 2019 01:09:47 -0700
Date:   Fri, 9 Aug 2019 10:08:43 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <Eugen.Hristev@microchip.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
Message-ID: <20190809080842.zl4ytbjyt54bj6ta@M43218.corp.atmel.com>
Mail-Followup-To: Ulf Hansson <ulf.hansson@linaro.org>,
        Eugen.Hristev@microchip.com,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <CAPDyKFrUr8_VP1JLRk48zR8_p1Y62wKLBnS0iTgdhUSArwD49Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrUr8_VP1JLRk48zR8_p1Y62wKLBnS0iTgdhUSArwD49Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 05:23:00PM +0200, Ulf Hansson wrote:
> On Thu, 8 Aug 2019 at 10:35, <Eugen.Hristev@microchip.com> wrote:
> >
> > From: Eugen Hristev <eugen.hristev@microchip.com>
> >
> > HS200 is not implemented in the driver, but the controller claims it
> > through caps.
> > Remove it via quirk.
> > Without this quirk, the mmc core will try to enable hs200, which will fail,
> > and the eMMC initialization will fail.
> >
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Should this be applied as a fix and possibly tagged for stable?
> 
> In such case, do you have a specific commit that it fixes?

I think so, I would say:
Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
Cc: stable@vger.kernel.org #v4.4 and later

It doesn't apply on 4.4 but resolution is trivial.

Regards

Ludovic

> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/mmc/host/sdhci-of-at91.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> > index 57fe3b2..3a8c6d8 100644
> > --- a/drivers/mmc/host/sdhci-of-at91.c
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > @@ -370,6 +370,9 @@ static int sdhci_at91_probe(struct platform_device *pdev)
> >         pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> >         pm_runtime_use_autosuspend(&pdev->dev);
> >
> > +       /* HS200 is broken at this moment */
> > +       host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
> > +
> >         ret = sdhci_add_host(host);
> >         if (ret)
> >                 goto pm_runtime_disable;
> > --
> > 2.7.4
> >
