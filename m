Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AD2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110A720835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcEhNr1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfCDRtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:49:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44009 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfCDRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:49:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so3528544pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s6EqDjj0yRCyBvMeVDts+AesvYCH59RyMlVKQloXQ9g=;
        b=ZcEhNr1hiEqqZlu0cNQIRQ3rJOGW60/0ZHeG5Wn+BsiXNW2KCxVhKhD+X/vzJEP+19
         XztbCMHNy/qb09UKqTnuul5r7pWCKRrtfvw0riO3Vp4VfIhsvQPfGuBtEOCk0Ts7OS7i
         HskygOb8zAiv6J1BoOPX6XqzLKBGoS8R2nDTsoaE8Z1v3aT8kBTB7M4oHFHMwC03NIvh
         U/20iK5IcOPk0+CGPHLJ3TacbrLhySeYWdum3PYdOOa4rYs8bnmsr5OTCLMMgMrG51gv
         IaHZZYsr6f4sqIqxSNiNiP+jkt/cjMEB8EmGJQGX9uMPqDNo8sj/TqA4Q4ck/be22tcu
         9eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s6EqDjj0yRCyBvMeVDts+AesvYCH59RyMlVKQloXQ9g=;
        b=TMu3nJrjgOlhm8mWHVy8KjBmt/71OcHmRfV0D21UeBqIegVW5k5AKSvZ5HItffD/hU
         Akz13DFQtK7enSW+K9+18Hwa2wtJLUNMS6huazPuEJjKoDMdahNaC5oEggdnzv9h7iVD
         K9kFHbee9W2mK8I9H7ieJm44MopQHFVmN4I5anS6USDCUvo6cQaKO3gWC+D3q0GqKGvh
         VJQvIMdDuGAbgDeZfGY75x+13MBrKx4BjMkvw6zeWe+AcsoER4tJZXocuyRfEVjQIFFj
         wmSmrAlgFHjKNv7REWHX+Y+EScxthqf+7kvuACLVsPvyBbKVgQNemuY87IOV1Z6JVdyb
         Yraw==
X-Gm-Message-State: AHQUAuY7jHU2+ssLtOD7f2NmnsAtFR8Mtie+/X+6YLj1AE5YACKOHBNF
        JvZRHyzuJk+Wjn6iaG+F0sM=
X-Google-Smtp-Source: AHgI3IbeubnSIlijvAeCxtsVcbG0YfAa5S6KieiurbIRtjcrpeYYNrprcWIHRQo/uqkfSwkvyhSDLQ==
X-Received: by 2002:aa7:9286:: with SMTP id j6mr20806953pfa.47.1551721749127;
        Mon, 04 Mar 2019 09:49:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5sm8290733pgv.12.2019.03.04.09.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 09:49:08 -0800 (PST)
Date:   Mon, 4 Mar 2019 09:49:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: AMD: Configure master codec on all
 playback/capture cases
Message-ID: <20190304174907.GA25016@roeck-us.net>
References: <20190215070539.22150-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215070539.22150-1-akshu.agrawal@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 07:06:15AM +0000, Agrawal, Akshu wrote:
> In the system design da7219 is the master codec and clocks are
> generated by it.
> Bclk is to be generated at the required rate for other codecs used when
> da7219 is acting only as clock master. For this call hw_params of da7219
> during playback/capture on non da7219 codecs.
> 
> Being able to set bclk at lower rate also fixes noise issue observed on
> some dmics.
> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  sound/soc/amd/acp-da7219-max98357a.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
> index a5daad973ce5..ad327415290a 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -45,6 +45,7 @@
>  #define CZ_PLAT_CLK 48000000
>  #define DUAL_CHANNEL		2
>  
> +static struct snd_soc_dai *codec_dai;
>  static struct snd_soc_jack cz_jack;
>  static struct clk *da7219_dai_clk;
>  extern int bt_uart_enable;
> @@ -53,8 +54,10 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	int ret;
>  	struct snd_soc_card *card = rtd->card;
> -	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> -	struct snd_soc_component *component = codec_dai->component;
> +	struct snd_soc_component *component;
> +
> +	codec_dai = rtd->codec_dai;
> +	component = codec_dai->component;
>  
>  	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
>  
> @@ -255,6 +258,16 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
>  	da7219_clk_disable();
>  }
>  
> +static static int cz_da7219_hw_params(struct snd_pcm_substream *substream,

s/static static/static/

gcc doesn't like the double static (at least neither gcc 6.5.0 nor 8.1.0
do), and it doesn't seem to be syntactically correct (even though,
oddly enough, clang accepts it w/o error message).

Guenter

> +				    struct snd_pcm_hw_params *params)
> +{
> +	/* da7219 Codec is clock master so setup as per the needs */
> +	if (codec_dai->driver->ops->hw_params)
> +		return codec_dai->driver->ops->hw_params(substream, params,
> +							 codec_dai);
> +	return 0;
> +}
> +
>  static const struct snd_soc_ops cz_da7219_play_ops = {
>  	.startup = cz_da7219_play_startup,
>  	.shutdown = cz_da7219_shutdown,
> @@ -268,16 +281,19 @@ static const struct snd_soc_ops cz_da7219_cap_ops = {
>  static const struct snd_soc_ops cz_max_play_ops = {
>  	.startup = cz_max_startup,
>  	.shutdown = cz_max_shutdown,
> +	.hw_params = cz_da7219_hw_params,
>  };
>  
>  static const struct snd_soc_ops cz_dmic0_cap_ops = {
>  	.startup = cz_dmic0_startup,
>  	.shutdown = cz_dmic_shutdown,
> +	.hw_params = cz_da7219_hw_params,
>  };
>  
>  static const struct snd_soc_ops cz_dmic1_cap_ops = {
>  	.startup = cz_dmic1_startup,
>  	.shutdown = cz_dmic_shutdown,
> +	.hw_params = cz_da7219_hw_params,
>  };
>  
>  static struct snd_soc_dai_link cz_dai_7219_98357[] = {
