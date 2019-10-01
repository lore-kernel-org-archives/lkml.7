Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438CDC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C4621924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uDaO3rwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfJAMKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:10:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38087 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfJAMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:10:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so2969450wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cYQgryQtcttftZL6/wJXoMl96NTmf85NfPPjrmIragM=;
        b=uDaO3rwtHnU5uH17sJi98/r4wqiFgvj9b3D+U6QGTioNvqYCys3EZxjCGi+PXvwQpY
         XcCe/+XtyXye+C5HcwthU30VVaylMCm4QNOZ2HNpJadJsh6D2qT+aS3Xwlc8zyiR2GUw
         hzwG7gVImRfPMpOwvuhf+KBoaJNaBLQ3qYBHbclJai/PBxbqmEUqSu2OfUudQF5/Yp4e
         AfWU2ryangBYT39pwCnDFTbILi4/yrJvY9z9BeZR3wntS5QrxdE5Veg53oncHSG35FA+
         t5kMdHhyZjjBPR4PbcRaBroVKd2b9zq+Zwhd2bTuaiMxgGZzOj53k6SYx2dySXtKGcOC
         CKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cYQgryQtcttftZL6/wJXoMl96NTmf85NfPPjrmIragM=;
        b=qZI2G1hk+p4sSgrMLNtgdpZyDRiVT/NKHkLxwHhROtAF/dbhlBA5ivZbu6Z/px7wP/
         gErxwbNaUbkQQovuAUZg6EEVkJIjUHz3nCTRmOBNETJPJF1TaNQUML8IO4Sv/ijkjUyJ
         /VM7dDteyzsYAlLliIolJyzvQXnzH88SBr3Ker78Hpcz/rydkiOallrPWu2BPm/zNNcA
         DK6T1xrHAy02gkqKJ9/sJGS8MyPAfMd/IQYvq35/IoivfQvGfD/03opraTi2CkZJB4/8
         LMMF3/7b+3Kn0Yzh5fV4SmBNe1FDdI2JlAoby+LCTa2QSrEfKk+5U3AFlOztvbxui5Tt
         5wKA==
X-Gm-Message-State: APjAAAWPRaZaEG4GDUgdKjE6j+WFH3zl/B9xyV3WUgd0lUJl3MDqi3y8
        dnRzoyvaoMmNFgHndCbhvdKzr8Vaqus=
X-Google-Smtp-Source: APXvYqyoLMLvX5XGrEEVWlh7TsDUEm6iZ7hNmtfFhg4JKnQi6wn4iPYaMz+gbQwY6xC/hPCdOKUgYA==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr3628913wmi.142.1569931826069;
        Tue, 01 Oct 2019 05:10:26 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b194sm2989977wmg.46.2019.10.01.05.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 05:10:25 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] clk: meson: axg-audio: provide clk top signal name
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191001115511.17357-1-jbrunet@baylibre.com>
 <20191001115511.17357-7-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <c02924d7-e27d-164b-73c1-214163e83d41@baylibre.com>
Date:   Tue, 1 Oct 2019 14:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001115511.17357-7-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2019 13:55, Jerome Brunet wrote:
> The peripheral clock on the sm1 goes through some muxes
> and dividers before reaching the audio gates. To model that,
> without repeating our self too much, the "top" clock signal
> is introduced and will serve as a the parent of the gates.
> 
> On the axg and g12a, the top clock is just a pass-through to
> the audio peripheral clock provided by the main controller.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg-audio.c | 18 +++++++++++++++---
>  drivers/clk/meson/axg-audio.h |  3 ++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index ce8836776d1c..1a4c50a29ad7 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -74,9 +74,7 @@
>  	.hw.init = &(struct clk_init_data) {				\
>  		.name = "aud_"#_name,					\
>  		.ops = &clk_regmap_gate_ops,				\
> -		.parent_data = &(const struct clk_parent_data) {	\
> -			.fw_name = "pclk",				\
> -		},							\
> +		.parent_names = (const char *[]){ "aud_top" },		\
>  		.num_parents = 1,					\
>  	},								\
>  }
> @@ -504,6 +502,18 @@ static struct clk_regmap tdmout_c_lrclk =
>  	AUD_TDM_LRLCK(out_c, AUDIO_CLK_TDMOUT_C_CTRL);
>  
>  /* AXG/G12A Clocks */
> +static struct clk_hw axg_aud_top = {
> +	.init = &(struct clk_init_data) {
> +		/* Provide aud_top signal name on axg and g12a */
> +		.name = "aud_top",
> +		.ops = &(const struct clk_ops) {},
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "pclk",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
>  static struct clk_regmap mst_a_mclk_sel =
>  	AUD_MST_MCLK_MUX(mst_a_mclk, AUDIO_MCLK_A_CTRL);
>  static struct clk_regmap mst_b_mclk_sel =
> @@ -691,6 +701,7 @@ static struct clk_hw_onecell_data axg_audio_hw_onecell_data = {
>  		[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
>  		[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
>  		[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
> +		[AUD_CLKID_TOP]			= &axg_aud_top,
>  		[NR_CLKS] = NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -835,6 +846,7 @@ static struct clk_hw_onecell_data g12a_audio_hw_onecell_data = {
>  		[AUD_CLKID_TDM_SCLK_PAD0]	= &g12a_tdm_sclk_pad_0.hw,
>  		[AUD_CLKID_TDM_SCLK_PAD1]	= &g12a_tdm_sclk_pad_1.hw,
>  		[AUD_CLKID_TDM_SCLK_PAD2]	= &g12a_tdm_sclk_pad_2.hw,
> +		[AUD_CLKID_TOP]			= &axg_aud_top,
>  		[NR_CLKS] = NULL,
>  	},
>  	.num = NR_CLKS,
> diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
> index c00e28b2e1a9..a4956837f597 100644
> --- a/drivers/clk/meson/axg-audio.h
> +++ b/drivers/clk/meson/axg-audio.h
> @@ -116,9 +116,10 @@
>  #define AUD_CLKID_SPDIFOUT_B_CLK_SEL	153
>  #define AUD_CLKID_SPDIFOUT_B_CLK_DIV	154
>  
> +
>  /* include the CLKIDs which are part of the DT bindings */
>  #include <dt-bindings/clock/axg-audio-clkc.h>
>  
> -#define NR_CLKS	163
> +#define NR_CLKS	164
>  
>  #endif /*__AXG_AUDIO_CLKC_H */
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
