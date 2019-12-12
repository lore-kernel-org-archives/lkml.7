Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF34FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916C3206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="USc9YNRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfLLKmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:42:23 -0500
Received: from mail1.perex.cz ([77.48.224.245]:43076 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfLLKmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:42:23 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Dec 2019 05:42:22 EST
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7D1ECA003F;
        Thu, 12 Dec 2019 11:36:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 7D1ECA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1576146986; bh=YtTaENPq9i4RKmnvPYc5L3nsNLdbKw7vKEt54nHQbGI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=USc9YNRCsV7vZpdI3NBwrO18EULFynImYU0yxKpMDDo84nWb/UQUxHU15JQDZbvWo
         UKoeC6tehU870BYiTN8tbMtb5Kle0QmBQfrqVmQEOYiDlSflATNe+0FmIQdGu1mXfh
         fZpLfcpHG+LSnmTewAmG6QVz0NwielNKhbkMAqd8=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu, 12 Dec 2019 11:36:17 +0100 (CET)
Subject: Re: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
To:     Jeff Chang <richtek.jeff.chang@gmail.com>, lgirdwood@gmail.com
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeff_chang@richtek.com
References: <1576141937-13199-1-git-send-email-richtek.jeff.chang@gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <02c25504-dec5-4026-6e2b-d3763e70663a@perex.cz>
Date:   Thu, 12 Dec 2019 11:36:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1576141937-13199-1-git-send-email-richtek.jeff.chang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 12. 12. 19 v 10:12 Jeff Chang napsal(a):
> +static const struct snd_kcontrol_new mt6660_component_snd_controls[] = {
> +	SOC_SINGLE_EXT_TLV("Digital Volume", MT6660_REG_VOL_CTRL, 0, 255,
> +			   1, snd_soc_get_volsw, mt6660_component_put_volsw,
> +			   vol_ctl_tlv),
> +	SOC_SINGLE_EXT("WDT Switch", MT6660_REG_WDT_CTRL, 7, 1, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("Hard_Clip Switch", MT6660_REG_HCLIP_CTRL, 8, 1, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("Clip Switch", MT6660_REG_SPS_CTRL, 0, 1, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("BoostMode", MT6660_REG_BST_CTRL, 0, 3, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("DRE Switch", MT6660_REG_DRE_CTRL, 0, 1, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("DC_Protect Switch",
> +		MT6660_REG_DC_PROTECT_CTRL, 3, 1, 0,
> +		snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("audio input selection", MT6660_REG_DATAO_SEL, 6, 3, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("Data Output Left Channel Selection",
> +		       MT6660_REG_DATAO_SEL, 3, 7, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("Data Output Right Channel Selection",
> +		       MT6660_REG_DATAO_SEL, 0, 7, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	/* for debug purpose */
> +	SOC_SINGLE_EXT("HPF_AUD_IN Switch", MT6660_REG_HPF_CTRL, 0, 1, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("AUD_LOOP_BACK Switch", MT6660_REG_PATH_BYPASS, 4, 1, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("Mute Switch", MT6660_REG_SYSTEM_CTRL, 1, 1, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("Bypass CS Comp Switch", MT6660_REG_PATH_BYPASS, 2, 1, 0,
> +		       snd_soc_get_volsw, mt6660_component_put_volsw),
> +	SOC_SINGLE_EXT("T0_SEL", MT6660_REG_CALI_T0, 0, 7, 0,
> +		       snd_soc_get_volsw, NULL),
> +	SOC_SINGLE_EXT("Chip_Rev", SND_SOC_NOPM, 0, 16, 0,
> +		       mt6660_component_get_volsw, NULL),

The control names looks really strange like always for the ASoC tree. We 
should talk about a standardization here. At least unify spaces, underscores 
and such characters and abbreviations.

					Thanks,
						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
