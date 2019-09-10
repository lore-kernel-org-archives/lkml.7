Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F0021019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391183AbfIJL4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:56:45 -0400
Received: from mx.socionext.com ([202.248.49.38]:18767 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388099AbfIJL4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:43 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Sep 2019 20:56:41 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 723BB605F8;
        Tue, 10 Sep 2019 20:56:41 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 10 Sep 2019 20:56:41 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 4F5B740357;
        Tue, 10 Sep 2019 20:56:41 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 24B391204AA;
        Tue, 10 Sep 2019 20:56:41 +0900 (JST)
Date:   Tue, 10 Sep 2019 20:56:40 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] reset: uniphier-glue: Add Pro5 USB3 support
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <1568101695.3062.1.camel@pengutronix.de>
References: <1568080527-1767-1-git-send-email-hayashi.kunihiko@socionext.com> <1568101695.3062.1.camel@pengutronix.de>
Message-Id: <20190910205640.6ABD.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Tue, 10 Sep 2019 09:48:15 +0200 <p.zabel@pengutronix.de> wrote:

> Hi Kunihiko,
> 
> On Tue, 2019-09-10 at 10:55 +0900, Kunihiko Hayashi wrote:
> > Pro5 SoC has same scheme of USB3 reset as Pro4, so the data for Pro5 is
> > equivalent to Pro4.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> If it is exactly the same, you could keep using the same compatible:

This driver is derived from reset-simple, so the method to control reset
in the glue block is the same for each SoC.

And both Pro4 and Pro5 need same parent clock and reset, so the data for
these SoCs refer same parent clock names and parent reset names.

However, since the glue block itself can be different, I think that
compatible string should be distinguished for each SoC.

For example, "pxs2-usb3-reset", "ld20-usb3-reset" and "pxs3-usb-reset"
in this driver are distinguished for the same reason.

Thank you,

> 
> > ---
> >  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 5 +++--
> >  drivers/reset/reset-uniphier-glue.c                        | 4 ++++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > index ea00517..e320a8c 100644
> > --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > @@ -130,6 +130,7 @@ this layer. These clocks and resets should be described in each property.
> >  Required properties:
> >  - compatible: Should be
> >      "socionext,uniphier-pro4-usb3-reset" - for Pro4 SoC USB3
> > +    "socionext,uniphier-pro5-usb3-reset" - for Pro5 SoC USB3
> 
> +    "socionext,uniphier-pro5-usb3-reset", "socionext,uniphier-pro4-usb3-reset" - for Pro5 SoC USB3
> 
> [...]
> > diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-uniphier-glue.c
> > index a45923f..2b188b3bb 100644
> > --- a/drivers/reset/reset-uniphier-glue.c
> > +++ b/drivers/reset/reset-uniphier-glue.c
> > @@ -141,6 +141,10 @@ static const struct of_device_id uniphier_glue_reset_match[] = {
> >  		.data = &uniphier_pro4_data,
> >  	},
> >  	{
> > +		.compatible = "socionext,uniphier-pro5-usb3-reset",
> > +		.data = &uniphier_pro4_data,
> > +	},
> > +	{
> >  		.compatible = "socionext,uniphier-pxs2-usb3-reset",
> >  		.data = &uniphier_pxs2_data,
> >  	},
> 
> And this change would not be necessary.
> 
> regards
> Philipp

---
Best Regards,
Kunihiko Hayashi


