Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C23DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F51233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dXwoG37I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfH2M5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:57:49 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:50688 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726973AbfH2M5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:57:49 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TCrtnE000665;
        Thu, 29 Aug 2019 07:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=TQ3TMtp/iVN8jVyxMAXRF8eu1q+LaHl+FWh4c6ikS5Y=;
 b=dXwoG37IKhGwQ3l81efh/n//YpQEWe2sG+1XN11QAw7zt8ruCLWFZfKQnYtciO40LBfv
 +i2gghCGPLcABgGKZ+JyTH8AgOmV3tIfj8Z3ONcXPX3Js1QGeowKQDkCMuEPvBmgVnDI
 zKqu0sRk+0foNeYb82899hjKOwEbNdodL5EFyh149HBlGUKYWwTPhXArZtHzb2vPhWhr
 zyvDPQ5+05LcYUxgOLwU/m4gtLUS9Und51fG+8dB36YmKPCfs/nD71PCQREe3lE8Jt7M
 nJejtpnx4gnf6RMQVdSZQeW/RambIGjcHCuaQmBv18hGl2Fs1j6tWI7P2+YDlCAlERag Uw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2uk1nk0etc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Aug 2019 07:57:29 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 29 Aug
 2019 13:57:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 29 Aug 2019 13:57:27 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9E8772A9;
        Thu, 29 Aug 2019 12:57:27 +0000 (UTC)
Date:   Thu, 29 Aug 2019 12:57:27 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: wm8904: use common FLL code
Message-ID: <20190829125340.GH10308@ediswmail.ad.cirrus.com>
References: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
 <1136f2dcc822821afda9f9533f40637647929bdf.1566734630.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1136f2dcc822821afda9f9533f40637647929bdf.1566734630.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908290142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 02:17:35PM +0200, Michał Mirosław wrote:
> Rework FLL handling to use common code introduced earlier.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---

Apologies for the slight delay in getting around to looking at
this one, been quite busy and its a lot to go through.

>  sound/soc/atmel/atmel_wm8904.c |  11 +-
>  sound/soc/codecs/Kconfig       |   1 +
>  sound/soc/codecs/wm8904.c      | 476 ++++++++++-----------------------
>  sound/soc/codecs/wm8904.h      |   5 -
>  4 files changed, 140 insertions(+), 353 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
> index 776b27d3686e..b77ea2495efe 100644
> --- a/sound/soc/atmel/atmel_wm8904.c
> +++ b/sound/soc/atmel/atmel_wm8904.c
> @@ -30,20 +30,11 @@ static int atmel_asoc_wm8904_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>  	int ret;
>  
> -	ret = snd_soc_dai_set_pll(codec_dai, WM8904_FLL_MCLK, WM8904_FLL_MCLK,
> -		32768, params_rate(params) * 256);
> -	if (ret < 0) {
> -		pr_err("%s - failed to set wm8904 codec PLL.", __func__);
> -		return ret;
> -	}
> -

As per my last comment it would be better to move the existing
functionality of the driver over to the new library, then make
actual functional changes in a separate patch. Clearly we have
changed how the driver works here, since we no longer need to set
the FLL.

This both makes review easier and proves that the new library
approach can support the existing functionality of the driver.

> +static int wm8904_prepare_sysclk(struct wm8904_priv *priv)
> +{
> +	int err;
> +
> +	switch (priv->sysclk_src) {
> +	case WM8904_CLK_MCLK:
> +		err = clk_set_rate(priv->mclk, priv->mclk_rate);
> +		if (!err)
> +			err = clk_prepare_enable(priv->mclk);
> +		break;
> +
> +	case WM8904_CLK_FLL:
> +		err = wm_fll_enable(&priv->fll);
> +		break;
> +

Given the FLL can be sourced from the MCLK pin why is the mclk
clock never enabled in the FLL case?

> @@ -356,11 +429,18 @@ static int wm8904_configure_clocking(struct snd_soc_component *component)
>  		wm8904->sysclk_rate = rate;
>  	}
>  
> -	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_0, WM8904_MCLK_DIV,
> -			    clock0);
> -
> +	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_0,
> +				      WM8904_MCLK_DIV, clock0);

Appreciate this is probably a good formatting change but
with a large hard to review patch its better to keep unrelated
changes out of it to easy review.

> @@ -1382,8 +1445,8 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
>  		}
>  	}
>  	wm8904->bclk = (wm8904->sysclk_rate * 10) / bclk_divs[best].div;
> -	dev_dbg(component->dev, "Selected BCLK_DIV of %d for %dHz BCLK\n",
> -		bclk_divs[best].div, wm8904->bclk);
> +	dev_dbg(component->dev, "Selected BCLK_DIV of %d.%d for %dHz BCLK\n",
> +		bclk_divs[best].div / 10, bclk_divs[best].div % 10,  wm8904->bclk);

This is a nice tidy up as well but would also be nice to not have
it in this patch.

> @@ -1937,7 +1715,6 @@ static const struct snd_soc_dai_ops wm8904_dai_ops = {
>  	.set_sysclk = wm8904_set_sysclk,
>  	.set_fmt = wm8904_set_fmt,
>  	.set_tdm_slot = wm8904_set_tdm_slot,
> -	.set_pll = wm8904_set_fll,

I am not keen on the way we are removing the ability to set the
FLL source, there may be out of tree users using this and to my
knowledge it is features that work at the moment so removing it
seems like a step backwards.

> +static const struct wm_fll_desc wm8904_fll_desc = {
> +	.ctl_offset = WM8904_FLL_CONTROL_1,
> +	.int_offset = WM8904_INTERRUPT_STATUS,
> +	.int_mask = WM8904_FLL_LOCK_EINT_MASK,
> +	.nco_reg0 = WM8904_FLL_NCO_TEST_0,
> +	.nco_reg1 = WM8904_FLL_NCO_TEST_1,
> +	.clk_ref_map = { FLL_REF_MCLK, FLL_REF_BCLK, FLL_REF_FSCLK, /* reserved */ 0 },

Minor nit, but would probably look nice to split this across a
couple of lines and would keep us under the 80 char line limit.

.clk_ref_map = {
....
},

> @@ -2165,6 +1951,19 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
>  	/* Can leave the device powered off until we need it */
> +	wm8904_disable_sysclk(wm8904);

How come this is now enabled during probe?

I trimmed down the CC list, for the next version I would suggest
using a similar list, this one was a little over sized.

Thanks,
Charles
