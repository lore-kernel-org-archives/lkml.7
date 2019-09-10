Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6D3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8162084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfIJHsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:48:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbfIJHsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:48:23 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i7asq-0002ke-3N; Tue, 10 Sep 2019 09:48:16 +0200
Message-ID: <1568101695.3062.1.camel@pengutronix.de>
Subject: Re: [PATCH] reset: uniphier-glue: Add Pro5 USB3 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Date:   Tue, 10 Sep 2019 09:48:15 +0200
In-Reply-To: <1568080527-1767-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1568080527-1767-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kunihiko,

On Tue, 2019-09-10 at 10:55 +0900, Kunihiko Hayashi wrote:
> Pro5 SoC has same scheme of USB3 reset as Pro4, so the data for Pro5 is
> equivalent to Pro4.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

If it is exactly the same, you could keep using the same compatible:

> ---
>  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 5 +++--
>  drivers/reset/reset-uniphier-glue.c                        | 4 ++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> index ea00517..e320a8c 100644
> --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> @@ -130,6 +130,7 @@ this layer. These clocks and resets should be described in each property.
>  Required properties:
>  - compatible: Should be
>      "socionext,uniphier-pro4-usb3-reset" - for Pro4 SoC USB3
> +    "socionext,uniphier-pro5-usb3-reset" - for Pro5 SoC USB3

+    "socionext,uniphier-pro5-usb3-reset", "socionext,uniphier-pro4-usb3-reset" - for Pro5 SoC USB3

[...]
> diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-uniphier-glue.c
> index a45923f..2b188b3bb 100644
> --- a/drivers/reset/reset-uniphier-glue.c
> +++ b/drivers/reset/reset-uniphier-glue.c
> @@ -141,6 +141,10 @@ static const struct of_device_id uniphier_glue_reset_match[] = {
>  		.data = &uniphier_pro4_data,
>  	},
>  	{
> +		.compatible = "socionext,uniphier-pro5-usb3-reset",
> +		.data = &uniphier_pro4_data,
> +	},
> +	{
>  		.compatible = "socionext,uniphier-pxs2-usb3-reset",
>  		.data = &uniphier_pxs2_data,
>  	},

And this change would not be necessary.

regards
Philipp
