Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8CAC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01752082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439818AbfFLObG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:31:06 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51676 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437584AbfFLObG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:31:06 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,366,1557212400"; 
   d="scan'208";a="37046409"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2019 07:30:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Jun 2019 07:30:17 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 12 Jun 2019 07:30:16 -0700
Date:   Wed, 12 Jun 2019 16:29:17 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>
CC:     Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: generated: Truncate divisor to
 GENERATED_MAX_DIV + 1
Message-ID: <20190612142917.sbpks6nhf7fy6rk6@M43218.corp.atmel.com>
Mail-Followup-To: Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190610151712.16572-1-codrin.ciubotariu@microchip.com>
 <7306f2c5-e035-31d1-194e-6b4afb6a61c1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7306f2c5-e035-31d1-194e-6b4afb6a61c1@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 03:54:00PM +0200, Nicolas Ferre - M43238 wrote:
> On 10/06/2019 at 17:20, Codrin Ciubotariu - M19940 wrote:
> > From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> > 
> > In clk_generated_determine_rate(), if the divisor is greater than
> > GENERATED_MAX_DIV + 1, then the wrong best_rate will be returned.
> > If clk_generated_set_rate() will be called later with this wrong
> > rate, it will return -EINVAL, so the generated clock won't change
> > its value. Do no let the divisor be greater than GENERATED_MAX_DIV + 1.
> > 
> > Fixes: 8c7aa6328947 ("clk: at91: clk-generated: remove useless divisor loop")
> > Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> Yes:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

Ludovic

> 
> Thanks for having fixed this Codrin. Best regards,
>    Nicolas
> 
> > ---
> >   drivers/clk/at91/clk-generated.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> > index 5f18847965c1..290cffe35deb 100644
> > --- a/drivers/clk/at91/clk-generated.c
> > +++ b/drivers/clk/at91/clk-generated.c
> > @@ -146,6 +146,8 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
> >   			continue;
> >   
> >   		div = DIV_ROUND_CLOSEST(parent_rate, req->rate);
> > +		if (div > GENERATED_MAX_DIV + 1)
> > +			div = GENERATED_MAX_DIV + 1;
> >   
> >   		clk_generated_best_diff(req, parent, parent_rate, div,
> >   					&best_diff, &best_rate);
> > 
> 
> 
> -- 
> Nicolas Ferre
