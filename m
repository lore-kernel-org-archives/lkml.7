Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B95C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47472189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfGDIyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:54:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44635 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfGDIyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:54:13 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hixVF-0004h8-53; Thu, 04 Jul 2019 10:54:05 +0200
Message-ID: <1562230444.6641.2.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] reset: imx7: Add support for i.MX8MM SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Anson.Huang@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, daniel.baluta@nxp.com, ping.bai@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Date:   Thu, 04 Jul 2019 10:54:04 +0200
In-Reply-To: <20190701093944.5540-1-Anson.Huang@nxp.com>
References: <20190701093944.5540-1-Anson.Huang@nxp.com>
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

Hi Anson,

On Mon, 2019-07-01 at 17:39 +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> i.MX8MM SoC has a subset of i.MX8MQ IP block variant, it can reuse
> the i.MX8MQ reset controller driver and just skip those non-existing
> IP blocks, add support for i.MX8MM SoC reset control.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/reset/reset-imx7.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index 3ecd770..941131f 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -207,6 +207,26 @@ static int imx8mq_reset_set(struct reset_controller_dev *rcdev,
>  	const unsigned int bit = imx7src->signals[id].bit;
>  	unsigned int value = assert ? bit : 0;
>  
> +	if (of_machine_is_compatible("fsl,imx8mm")) {

This should be checked once during probe, not in every reset_set, if
this check has to be made at all. On i.MX8MM these unused reset controls
are not going to be hooked up via phandle, so this function should never
be called with the values that are filtered out here anyway.
And in case somebody makes an error in the device tree, does writing 1
to the reserved bits on i.MX8MM have any negative side effects at all?
Or are these bits just not hooked up? If this is no problem, I assume
this patch is not needed at all.

The correct way to protect against DT writers hooking up the non-
existing reset lines would be to replace rcdev.of_xlate with a version
that returns -EINVAL for them on i.MX8MM. Also in that case I'd check
the reset-controller compatible, not the machine compatible.

> +		switch (id) {
> +		case IMX8MQ_RESET_HDMI_PHY_APB_RESET:
> +		case IMX8MQ_RESET_PCIEPHY2: /* fallthrough */
> +		case IMX8MQ_RESET_PCIEPHY2_PERST: /* fallthrough */
> +		case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN: /* fallthrough */
> +		case IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF: /* fallthrough */
> +		case IMX8MQ_RESET_MIPI_CSI1_CORE_RESET: /* fallthrough */
> +		case IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET: /* fallthrough */
> +		case IMX8MQ_RESET_MIPI_CSI1_ESC_RESET: /* fallthrough */
> +		case IMX8MQ_RESET_MIPI_CSI2_CORE_RESET: /* fallthrough */
> +		case IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET: /* fallthrough */
> +		case IMX8MQ_RESET_MIPI_CSI2_ESC_RESET: /* fallthrough */
> +		case IMX8MQ_RESET_DDRC2_PHY_RESET: /* fallthrough */
> +		case IMX8MQ_RESET_DDRC2_CORE_RESET: /* fallthrough */
> +		case IMX8MQ_RESET_DDRC2_PRST: /* fallthrough */

I think it would make sense to add IMX8MM_RESET_* defines for all but
these, to avoid confusion when reading the imx8mm.dtsi

regards
Philipp
