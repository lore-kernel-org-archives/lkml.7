Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53447C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1C72184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfCTKqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:46:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52965 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:46:25 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1h6Yjn-0000Qn-K5; Wed, 20 Mar 2019 11:46:23 +0100
Message-ID: <1553078780.7071.8.camel@pengutronix.de>
Subject: Re: [PATCH v1 4/6] reset: hi6220: Add support for AO reset
 controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Peter Griffin <peter.griffin@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, xuwei5@hisilicon.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     john.stultz@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        yuq825@gmail.com
Date:   Wed, 20 Mar 2019 11:46:20 +0100
In-Reply-To: <1552937931-23050-5-git-send-email-peter.griffin@linaro.org>
References: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org>
         <1552937931-23050-5-git-send-email-peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
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

Hi Peter,

On Mon, 2019-03-18 at 19:38 +0000, Peter Griffin wrote:
> This is required to bring Mali450 gpu out of reset.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/reset/hisilicon/hi6220_reset.c | 51 +++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
> index d5e5229..0cd5f92 100644
> --- a/drivers/reset/hisilicon/hi6220_reset.c
> +++ b/drivers/reset/hisilicon/hi6220_reset.c
> @@ -36,6 +36,7 @@
>  enum hi6220_reset_ctrl_type {
>  	PERIPHERAL,
>  	MEDIA,
> +	AO,
>  };
>  
>  struct hi6220_reset_data {
> @@ -95,6 +96,47 @@ static const struct reset_control_ops hi6220_media_reset_ops = {
>  	.deassert = hi6220_media_deassert,
>  };
>  
> +#define AO_SCTRL_SC_PW_CLKEN0     0x800
> +#define AO_SCTRL_SC_PW_CLKDIS0    0x804
> +
> +#define AO_SCTRL_SC_PW_RSTEN0     0x810
> +#define AO_SCTRL_SC_PW_RSTDIS0    0x814
> +
> +#define AO_SCTRL_SC_PW_ISOEN0     0x820
> +#define AO_SCTRL_SC_PW_ISODIS0    0x824
> +#define AO_MAX_INDEX              12
> +
> +static int hi6220_ao_assert(struct reset_controller_dev *rc_dev,
> +			       unsigned long idx)
> +{
> +	struct hi6220_reset_data *data = to_reset_data(rc_dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret;
> +
> +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTEN0, BIT(idx));
> +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_ISOEN0, BIT(idx));
> +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_CLKDIS0, BIT(idx));

What if two regmap_writes return a different error code? Better check
for ret and return individually. Also, no need to issue two more writes
if the first one failed.

> +	return ret;
> +}
> +
> +static int hi6220_ao_deassert(struct reset_controller_dev *rc_dev,
> +				 unsigned long idx)
> +{
> +	struct hi6220_reset_data *data = to_reset_data(rc_dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret;
> +
> +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTDIS0, BIT(idx));
> +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_ISODIS0, BIT(idx));
> +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_CLKEN0, BIT(idx));

Same as above. Otherwise this looks fine. With this fixed, I could pick
up patches 2, 4, and 5.

regards
Philipp
