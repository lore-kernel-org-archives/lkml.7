Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A366DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7696E2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvM8GedZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfJUJca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:32:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32819 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:32:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so4315311wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d5bdX8xeuW9qs28DpqOcFZGihG4/KfD6OFklKeD5tNY=;
        b=GvM8GedZ070Ew4R5fuWq9/BrMuHCOCcn1gvw4apY1gGPcMk5I3A9JaCWc9MKsJOs8F
         D4rd9PQm15UZ3NVtH6TYpmo6V73jFuD50Emr7tMcLy3eekQjFZ+caBjHx1he6NtmABO3
         fJEDi3vo8ORhUNNThiBupAi3zRa+Tai4KU7SAU58M9kZ1bVyneQVoIW/c8UvxLfpRqPZ
         ELmDI6Heall1c2P73/5Y+xc8StwPd7WykFxWp9RlSV6BAAVQZPr4JSxTgDMQJ/Yhvm1F
         7SDeOztFGTOw2F7WG18EpTVy881H0a6DQhOlGcNBPASAKtk1B0v5tCwRTR9Boysq/LTB
         rUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d5bdX8xeuW9qs28DpqOcFZGihG4/KfD6OFklKeD5tNY=;
        b=lGZwfgnpdxpFhDhaGC1VUoHlMEcM/TSueVBGZ2Q7dhG43aMDJoTx7JP48c4NsQyNkZ
         QSEcPGuWMLYlFIQTteF/HirNiBs/N4NkpB8MsKgqKwf47BmbswvGbNxk8npsU0lExMbI
         82J1OaQdI5nQFvUmU10ttF8MxR7tftfwdK4Rwl6xIduB2DdCU5XFEwwsYQnkojpVqF5R
         iNJ8BRNcZ72QLjT/pHrzSS0jtfkO2JNdwXhi8TOk7useZDbmaFoUiCjpFfoLkYhg6VDg
         UDpDYTR9ZYiadEcjzNJFj6jsFllJ4fZG/jsPmmDb2OHZ2THr+8rllZA3Hh+cIV7EYmWx
         zR1A==
X-Gm-Message-State: APjAAAVObHBf6fUJG+8ImXwVbjIjIOtyfitCuQzu7AsST45N0sKD4xFd
        3wuclrbukjjusdKZxYDjn99C+2Y72y0=
X-Google-Smtp-Source: APXvYqz73fCx504enzShzr5TeqfdSYt+cbgtZUgqC7BWiCCPlAuDB0lzryLp5L6I99ZiK2mLcCGgjw==
X-Received: by 2002:a5d:4d85:: with SMTP id b5mr4598892wru.248.1571650346232;
        Mon, 21 Oct 2019 02:32:26 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a2sm1604111wrv.39.2019.10.21.02.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 02:32:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] ASoC: msm8916-wcd-analog: Fix RX1 selection in RDAC2
 MUX
To:     Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20191020153007.206070-1-stephan@gerhold.net>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b23e4ca0-467c-00da-9abe-1f9ff1ffbc91@linaro.org>
Date:   Mon, 21 Oct 2019 10:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191020153007.206070-1-stephan@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/10/2019 16:30, Stephan Gerhold wrote:
> According to the PM8916 Hardware Register Description,
> CDC_D_CDC_CONN_HPHR_DAC_CTL has only a single bit (RX_SEL)
> to switch between RX1 (0) and RX2 (1). It is not possible to
> disable it entirely to achieve the "ZERO" state.
> 
> However, at the moment the "RDAC2 MUX" mixer defines three possible
> values ("ZERO", "RX2" and "RX1"). Setting the mixer to "ZERO"
> actually configures it to RX1. Setting the mixer to "RX1" has
> (seemingly) no effect.
> 
> Remove "ZERO" and replace it with "RX1" to fix this.
> 
> Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Thanks for the patch, Nice catch!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> ---
>   sound/soc/codecs/msm8916-wcd-analog.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> index 667e9f73aba3..e3d311fb510e 100644
> --- a/sound/soc/codecs/msm8916-wcd-analog.c
> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -306,7 +306,7 @@ struct pm8916_wcd_analog_priv {
>   };
>   
>   static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
> -static const char *const rdac2_mux_text[] = { "ZERO", "RX2", "RX1" };
> +static const char *const rdac2_mux_text[] = { "RX1", "RX2" };
>   static const char *const hph_text[] = { "ZERO", "Switch", };
>   
>   static const struct soc_enum hph_enum = SOC_ENUM_SINGLE_VIRT(
> @@ -321,7 +321,7 @@ static const struct soc_enum adc2_enum = SOC_ENUM_SINGLE_VIRT(
>   
>   /* RDAC2 MUX */
>   static const struct soc_enum rdac2_mux_enum = SOC_ENUM_SINGLE(
> -			CDC_D_CDC_CONN_HPHR_DAC_CTL, 0, 3, rdac2_mux_text);
> +			CDC_D_CDC_CONN_HPHR_DAC_CTL, 0, 2, rdac2_mux_text);
>   
>   static const struct snd_kcontrol_new spkr_switch[] = {
>   	SOC_DAPM_SINGLE("Switch", CDC_A_SPKR_DAC_CTL, 7, 1, 0)
> 
