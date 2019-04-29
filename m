Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE2AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345762084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qyP9cbaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfD2L2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:28:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51654 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2L2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:28:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3TBRIIN117261;
        Mon, 29 Apr 2019 06:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556537238;
        bh=a+x+/nPRMlKw5EveKCxlbdn8CCxZMXGPNGFgU8VSsWA=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=qyP9cbaIP90UdXbkUo96l4vHkj77yrzUhS0DkhQGe3KqUXM1BQH4r+iZjWH+lNn6M
         NnBImA8+D1mJMZ2ITWUJuN9VIbj9pU2DJj5h2ueBAD4rMDHTlfOhftfwgerH+g0nEj
         qDrTjbyIIZTOTQJZ8GcrXXQYYTZZLO8BdQXC95uk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3TBRHjo122088
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Apr 2019 06:27:17 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 29
 Apr 2019 06:27:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 29 Apr 2019 06:27:17 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3TBRFvH073635;
        Mon, 29 Apr 2019 06:27:16 -0500
Subject: Re: [alsa-devel] [PATCH] ASoC: tlv320aic3x: Add support for high
 power analog output
To:     Saravanan Sekar <sravanhome@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20190427194005.7308-1-sravanhome@gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <507b9ee8-2505-8014-114e-563dc5995e8f@ti.com>
Date:   Mon, 29 Apr 2019 14:27:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427194005.7308-1-sravanhome@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/04/2019 22.40, Saravanan Sekar wrote:
> Add support to power and output level control for the analog high power
> output drivers HPOUT and HPCOM.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  sound/soc/codecs/tlv320aic3x.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
> index 516d17cb2182..d4bafac802eb 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -419,6 +419,12 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
>  	/* Pop reduction */
>  	SOC_ENUM("Output Driver Power-On time", aic3x_poweron_time_enum),
>  	SOC_ENUM("Output Driver Ramp-up step", aic3x_rampup_step_enum),
> +
> +	/* Analog HPOUT, HPCOM power and output level controls */
> +	SOC_DOUBLE_R("Analog output power control", HPROUT_CTRL,
> +			HPRCOM_CTRL, 0, 1, 0),

bit 0 of HPROUT_CTRL and HPRCOM_CTRL is handled by DAPM:
"Right HP Out"
"Right HP Com"

> +	SOC_DOUBLE_R("Analog output level control", HPROUT_CTRL,
> +			HPRCOM_CTRL, 4, 9, 0),

and this will modify the HPR and HPRCOM (right channels) only.

You should add two controls:

/* HP/HPCOM volumes. From 0 to 9 dB in 1 dB steps */
static DECLARE_TLV_DB_SCALE(hp_tlv, 0, 100, 0);

SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL, 4, 9,
0, hp_tlv);

SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTRL, 4,
9, 0, hp_tlv);


>  };
>  
>  /* For other than tlv320aic3104 */
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
