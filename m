Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ED5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F142206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfCKLiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:38:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42029 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfCKLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:37:59 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h3JFg-0006Kv-EB; Mon, 11 Mar 2019 12:37:52 +0100
Message-ID: <1552304271.2453.12.camel@pengutronix.de>
Subject: Re: [PATCH] clk: imx6q: remove unsupported pll4_audio_div
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Eric Nelson <eric@nelint.com>, linux-clk@vger.kernel.org
Cc:     anson.huang@nxp.com, clement.peron@devialet.com,
        colin.didier@devialet.com, devicetree@vger.kernel.org,
        festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, sboyd@kernel.org, shawnguo@kernel.org,
        tiny.windzz@gmail.com
Date:   Mon, 11 Mar 2019 12:37:51 +0100
In-Reply-To: <1552259930-27786-1-git-send-email-eric@nelint.com>
References: <1552259930-27786-1-git-send-email-eric@nelint.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Am Sonntag, den 10.03.2019, 16:18 -0700 schrieb Eric Nelson:
> The pll4_audio_div attempted to reflect one bit of a two-bit
> divisor (AUDIO_DIV_LSB) in the CCM_ANALOG_MISC2 register.
> 
> Unfortunately, this divisor is non-functional at least on the
> latest silicon revisions and has been removed from the reference
> manual.
> 
> This is discussed in this NXP Community thread:
> 
>     https://community.nxp.com/thread/462806
> 
> Remove the definition of pll4_audio_div to reflect this and
> reparent the ssi, cko1, and ESAI/ASRC/SPDIF clocks to the
> pll4_post_div clock.
> 
> > Signed-off-by: Eric Nelson <eric@nelint.com>
> ---
>  drivers/clk/imx/clk-imx6q.c               |   7 +-
>  include/dt-bindings/clock/imx6qdl-clock.h | 127 +++++++++++++++---------------
>  2 files changed, 66 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> index 708e7c5..56d6ebb 100644
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> > @@ -32,7 +32,7 @@ static const char *periph2_clk2_sels[]	= { "pll3_usb_otg", "pll2_bus", };
> >  static const char *periph_sels[]	= { "periph_pre", "periph_clk2", };
> >  static const char *periph2_sels[]	= { "periph2_pre", "periph2_clk2", };
> >  static const char *axi_sels[]		= { "periph", "pll2_pfd2_396m", "periph", "pll3_pfd1_540m", };
> > -static const char *audio_sels[]	= { "pll4_audio_div", "pll3_pfd2_508m", "pll3_pfd3_454m", "pll3_usb_otg", };
> > +static const char *audio_sels[]	= { "pll4_post_div", "pll3_pfd2_508m", "pll3_pfd3_454m", "pll3_usb_otg", };
> >  static const char *gpu_axi_sels[]	= { "axi", "ahb", };
> >  static const char *pre_axi_sels[]	= { "axi", "ahb", };
> >  static const char *gpu2d_core_sels[]	= { "axi", "pll3_usb_otg", "pll2_pfd0_352m", "pll2_pfd2_396m", };
> > @@ -52,7 +52,7 @@ static const char *ipu2_di0_sels_2[]	= { "ipu2_di0_pre", "dummy", "dummy", "ldb_
> >  static const char *ipu2_di1_sels_2[]	= { "ipu2_di1_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf", };
> >  static const char *hsi_tx_sels[]	= { "pll3_120m", "pll2_pfd2_396m", };
> >  static const char *pcie_axi_sels[]	= { "axi", "ahb", };
> > -static const char *ssi_sels[]		= { "pll3_pfd2_508m", "pll3_pfd3_454m", "pll4_audio_div", };
> > +static const char *ssi_sels[]		= { "pll3_pfd2_508m", "pll3_pfd3_454m", "pll4_post_div", };
> >  static const char *usdhc_sels[]	= { "pll2_pfd2_396m", "pll2_pfd0_352m", };
> >  static const char *enfc_sels[]	= { "pll2_pfd0_352m", "pll2_bus", "pll3_usb_otg", "pll2_pfd2_396m", };
>  static const char *enfc_sels_2[] = {"pll2_pfd0_352m", "pll2_bus", "pll3_usb_otg", "pll2_pfd2_396m", "pll3_pfd3_454m", "dummy", };
> @@ -66,7 +66,7 @@ static const char *ecspi_sels[] = { "pll3_60m", "osc", };
>  static const char *can_sels[] = { "pll3_60m", "osc", "pll3_80m", };
> >  static const char *cko1_sels[]	= { "pll3_usb_otg", "pll2_bus", "pll1_sys", "pll5_video_div",
> >  				    "video_27m", "axi", "enfc", "ipu1_di0", "ipu1_di1", "ipu2_di0",
> > -				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_audio_div", };
> > +				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_post_div", };
>  static const char *cko2_sels[] = {
> >  	"mmdc_ch0_axi", "mmdc_ch1_axi", "usdhc4", "usdhc1",
> >  	"gpu2d_axi", "dummy", "ecspi_root", "gpu3d_axi",
> @@ -607,7 +607,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
> >  	}
>  
> >  	clk[IMX6QDL_CLK_PLL4_POST_DIV] = clk_register_divider_table(NULL, "pll4_post_div", "pll4_audio", CLK_SET_RATE_PARENT, base + 0x70, 19, 2, 0, post_div_table, &imx_ccm_lock);
> > -	clk[IMX6QDL_CLK_PLL4_AUDIO_DIV] = clk_register_divider(NULL, "pll4_audio_div", "pll4_post_div", CLK_SET_RATE_PARENT, base + 0x170, 15, 1, 0, &imx_ccm_lock);
> >  	clk[IMX6QDL_CLK_PLL5_POST_DIV] = clk_register_divider_table(NULL, "pll5_post_div", "pll5_video", CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_div_table, &imx_ccm_lock);
> >  	clk[IMX6QDL_CLK_PLL5_VIDEO_DIV] = clk_register_divider_table(NULL, "pll5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, video_div_table, &imx_ccm_lock);
>  
> diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
> index b3cef29..dea23a9 100644
> --- a/include/dt-bindings/clock/imx6qdl-clock.h
> +++ b/include/dt-bindings/clock/imx6qdl-clock.h
> @@ -213,69 +213,68 @@
> >  #define IMX6QDL_CLK_CKO2			200
> >  #define IMX6QDL_CLK_CKO				201
> >  #define IMX6QDL_CLK_VDOA			202
> > -#define IMX6QDL_CLK_PLL4_AUDIO_DIV		203
> > -#define IMX6QDL_CLK_LVDS1_SEL			204
> > -#define IMX6QDL_CLK_LVDS2_SEL			205
> > -#define IMX6QDL_CLK_LVDS1_GATE			206
> > -#define IMX6QDL_CLK_LVDS2_GATE			207
> > -#define IMX6QDL_CLK_ESAI_IPG			208
> > -#define IMX6QDL_CLK_ESAI_MEM			209
> > -#define IMX6QDL_CLK_ASRC_IPG			210
> > -#define IMX6QDL_CLK_ASRC_MEM			211
> > -#define IMX6QDL_CLK_LVDS1_IN			212
> > -#define IMX6QDL_CLK_LVDS2_IN			213
> > -#define IMX6QDL_CLK_ANACLK1			214
> > -#define IMX6QDL_CLK_ANACLK2			215
> > -#define IMX6QDL_PLL1_BYPASS_SRC			216
> > -#define IMX6QDL_PLL2_BYPASS_SRC			217
> > -#define IMX6QDL_PLL3_BYPASS_SRC			218
> > -#define IMX6QDL_PLL4_BYPASS_SRC			219
> > -#define IMX6QDL_PLL5_BYPASS_SRC			220
> > -#define IMX6QDL_PLL6_BYPASS_SRC			221
> > -#define IMX6QDL_PLL7_BYPASS_SRC			222
> > -#define IMX6QDL_CLK_PLL1			223
> > -#define IMX6QDL_CLK_PLL2			224
> > -#define IMX6QDL_CLK_PLL3			225
> > -#define IMX6QDL_CLK_PLL4			226
> > -#define IMX6QDL_CLK_PLL5			227
> > -#define IMX6QDL_CLK_PLL6			228
> > -#define IMX6QDL_CLK_PLL7			229
> > -#define IMX6QDL_PLL1_BYPASS			230
> > -#define IMX6QDL_PLL2_BYPASS			231
> > -#define IMX6QDL_PLL3_BYPASS			232
> > -#define IMX6QDL_PLL4_BYPASS			233
> > -#define IMX6QDL_PLL5_BYPASS			234
> > -#define IMX6QDL_PLL6_BYPASS			235
> > -#define IMX6QDL_PLL7_BYPASS			236
> > -#define IMX6QDL_CLK_GPT_3M			237
> > -#define IMX6QDL_CLK_VIDEO_27M			238
> > -#define IMX6QDL_CLK_MIPI_CORE_CFG		239
> > -#define IMX6QDL_CLK_MIPI_IPG			240
> > -#define IMX6QDL_CLK_CAAM_MEM			241
> > -#define IMX6QDL_CLK_CAAM_ACLK			242
> > -#define IMX6QDL_CLK_CAAM_IPG			243
> > -#define IMX6QDL_CLK_SPDIF_GCLK			244
> > -#define IMX6QDL_CLK_UART_SEL			245
> > -#define IMX6QDL_CLK_IPG_PER_SEL			246
> > -#define IMX6QDL_CLK_ECSPI_SEL			247
> > -#define IMX6QDL_CLK_CAN_SEL			248
> > -#define IMX6QDL_CLK_MMDC_CH1_AXI_CG		249
> > -#define IMX6QDL_CLK_PRE0			250
> > -#define IMX6QDL_CLK_PRE1			251
> > -#define IMX6QDL_CLK_PRE2			252
> > -#define IMX6QDL_CLK_PRE3			253
> > -#define IMX6QDL_CLK_PRG0_AXI			254
> > -#define IMX6QDL_CLK_PRG1_AXI			255
> > -#define IMX6QDL_CLK_PRG0_APB			256
> > -#define IMX6QDL_CLK_PRG1_APB			257
> > -#define IMX6QDL_CLK_PRE_AXI			258
> > -#define IMX6QDL_CLK_MLB_SEL			259
> > -#define IMX6QDL_CLK_MLB_PODF			260
> > -#define IMX6QDL_CLK_EPIT1			261
> > -#define IMX6QDL_CLK_EPIT2			262
> > -#define IMX6QDL_CLK_MMDC_P0_IPG			263
> > -#define IMX6QDL_CLK_DCIC1			264
> > -#define IMX6QDL_CLK_DCIC2			265
> > -#define IMX6QDL_CLK_END				266
> > +#define IMX6QDL_CLK_LVDS1_SEL			203
> > +#define IMX6QDL_CLK_LVDS2_SEL			204
> > +#define IMX6QDL_CLK_LVDS1_GATE			205
> > +#define IMX6QDL_CLK_LVDS2_GATE			206
> > +#define IMX6QDL_CLK_ESAI_IPG			207
> > +#define IMX6QDL_CLK_ESAI_MEM			208
> > +#define IMX6QDL_CLK_ASRC_IPG			209
> > +#define IMX6QDL_CLK_ASRC_MEM			210
> > +#define IMX6QDL_CLK_LVDS1_IN			211
> > +#define IMX6QDL_CLK_LVDS2_IN			212
> > +#define IMX6QDL_CLK_ANACLK1			213
> > +#define IMX6QDL_CLK_ANACLK2			214
> > +#define IMX6QDL_PLL1_BYPASS_SRC			215
> > +#define IMX6QDL_PLL2_BYPASS_SRC			216
> > +#define IMX6QDL_PLL3_BYPASS_SRC			217
> > +#define IMX6QDL_PLL4_BYPASS_SRC			218
> > +#define IMX6QDL_PLL5_BYPASS_SRC			219
> > +#define IMX6QDL_PLL6_BYPASS_SRC			220
> > +#define IMX6QDL_PLL7_BYPASS_SRC			221
> > +#define IMX6QDL_CLK_PLL1			222
> > +#define IMX6QDL_CLK_PLL2			223
> > +#define IMX6QDL_CLK_PLL3			224
> > +#define IMX6QDL_CLK_PLL4			225
> > +#define IMX6QDL_CLK_PLL5			226
> > +#define IMX6QDL_CLK_PLL6			227
> > +#define IMX6QDL_CLK_PLL7			228
> > +#define IMX6QDL_PLL1_BYPASS			229
> > +#define IMX6QDL_PLL2_BYPASS			230
> > +#define IMX6QDL_PLL3_BYPASS			231
> > +#define IMX6QDL_PLL4_BYPASS			232
> > +#define IMX6QDL_PLL5_BYPASS			233
> > +#define IMX6QDL_PLL6_BYPASS			234
> > +#define IMX6QDL_PLL7_BYPASS			235
> > +#define IMX6QDL_CLK_GPT_3M			236
> > +#define IMX6QDL_CLK_VIDEO_27M			237
> > +#define IMX6QDL_CLK_MIPI_CORE_CFG		238
> > +#define IMX6QDL_CLK_MIPI_IPG			239
> > +#define IMX6QDL_CLK_CAAM_MEM			240
> > +#define IMX6QDL_CLK_CAAM_ACLK			241
> > +#define IMX6QDL_CLK_CAAM_IPG			242
> > +#define IMX6QDL_CLK_SPDIF_GCLK			243
> > +#define IMX6QDL_CLK_UART_SEL			244
> > +#define IMX6QDL_CLK_IPG_PER_SEL			245
> > +#define IMX6QDL_CLK_ECSPI_SEL			246
> > +#define IMX6QDL_CLK_CAN_SEL			247
> > +#define IMX6QDL_CLK_MMDC_CH1_AXI_CG		248
> > +#define IMX6QDL_CLK_PRE0			249
> > +#define IMX6QDL_CLK_PRE1			250
> > +#define IMX6QDL_CLK_PRE2			251
> > +#define IMX6QDL_CLK_PRE3			252
> > +#define IMX6QDL_CLK_PRG0_AXI			253
> > +#define IMX6QDL_CLK_PRG1_AXI			254
> > +#define IMX6QDL_CLK_PRG0_APB			255
> > +#define IMX6QDL_CLK_PRG1_APB			256
> > +#define IMX6QDL_CLK_PRE_AXI			257
> > +#define IMX6QDL_CLK_MLB_SEL			258
> > +#define IMX6QDL_CLK_MLB_PODF			259
> > +#define IMX6QDL_CLK_EPIT1			260
> > +#define IMX6QDL_CLK_EPIT2			261
> > +#define IMX6QDL_CLK_MMDC_P0_IPG			262
> > +#define IMX6QDL_CLK_DCIC1			263
> > +#define IMX6QDL_CLK_DCIC2			264
> > +#define IMX6QDL_CLK_END				265

You can not renumber the DT clock defines, as this breaks DT backward
compatibility. You can however remove IMX6QDL_CLK_PLL4_AUDIO_DIV and
leave a hole in the numbers, maybe with a comment about why it exists.

Regards,
Lucas

