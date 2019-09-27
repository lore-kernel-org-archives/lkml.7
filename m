Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA7BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD08207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vTC4rSku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfI0Jh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:37:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38254 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfI0Jh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:37:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so5435756wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sltibnJ8nkDtijWbV1eSswoW2gtP+V0oSElkPb/A7o0=;
        b=vTC4rSkur2vv2DkU2/kistQe06iWdLYgl7W9FTv3hBPkyOPYySgm4XvuseNXhPZFZ0
         4ifAsvNwrYG47pftA7448Jhl5n5TP4/deO3yV0LHq8ZytQFKyLRTUyyKyDQ3cYZCoa3c
         VgY/FSMqZQz8OIAP50mceLoovZzVX9Stxfg6MTqy/DueWGQ8GIk0kROYxLgOq2XXBbvX
         jdEYf6AEnE8eJuByDF31Zd/xwb96u64p2+PxgRbhwailchXdTfOrm955j8spgGFoIr01
         84JSHuzEcVr3GMmlwm4RyJAll1alqzcvHRyxNhqnNab/3oqkeokP731YIuaVCHxBLr0p
         RB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sltibnJ8nkDtijWbV1eSswoW2gtP+V0oSElkPb/A7o0=;
        b=ZJlRWwWVrnkVdTZq3yVDIlOxh3PcM0WDFjWzQiSz8ZzGaCsM83xL1O4l5BttoM8Ygk
         US/AY9eczdBsiJonRFMxTpyz/ZzmNx3qjeYwhgT9GvCJrwGxXubRKAS4avCIkuM/GD3c
         Tzh7YOVKxEfDsLDTzL559E3+exWN751LOBOYCH/3L5GtXWiBGiD3RYwuxklrF1cJuDUS
         Vc+8Jtu7o3cGZQufmEtT2Hf8K93iRWzTLxnfTU9xTK6JjviUjwiow3uhzbxMXL1+OEbk
         eQFTO1vkmM9IzhK4EvC9bnAeWH/KRMarSUGyc45kvaWe2xbQW6bKw7VNazj/spzD/aS+
         FTtw==
X-Gm-Message-State: APjAAAV+BUA+r7bAnqUibLCfWS6tHtCxZAJWWzSKc/zTlSofs0Upry9b
        t2BCUsKX/6EmGeIe5xZzxJu+fMk1aRSoCw==
X-Google-Smtp-Source: APXvYqwBHZ7IKj7YEIW+3FVomdDMqJwBUw+TCMkcF27xNEXJ0w3z3s7E6Uwa8/Xqp1AH4M6wBIaNiw==
X-Received: by 2002:a1c:5444:: with SMTP id p4mr6591228wmi.69.1569577042037;
        Fri, 27 Sep 2019 02:37:22 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id j1sm4531453wrg.24.2019.09.27.02.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 02:37:21 -0700 (PDT)
Subject: Re: [PATCH 6/7] clk: meson: axg-audio: provide clk top signal name
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190924153356.24103-1-jbrunet@baylibre.com>
 <20190924153356.24103-7-jbrunet@baylibre.com>
 <b328b0c7-9449-172d-a1ed-7449023ff516@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 mQENBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAG0KE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT6JATsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIW5AQ0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAYkBHwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8guQINBFYnf6QBEADQ+wBYa+X2n/xIQz/RUoGHf84Jm+yTqRT43t7sO48/cBW9vAn9
 GNwnJ3HRJWKATW0ZXrCr40ES/JqM1fUTfiFDB3VMdWpEfwOAT1zXS+0rX8yljgsWR1UvqyEP
 3xN0M/40Zk+rdmZKaZS8VQaXbveaiWMEmY7sBV3QvgOzB7UF2It1HwoCon5Y+PvyE3CguhBd
 9iq5iEampkMIkbA3FFCpQFI5Ai3BywkLzbA3ZtnMXR8Qt9gFZtyXvFQrB+/6hDzEPnBGZOOx
 zkd/iIX59SxBuS38LMlhPPycbFNmtauOC0DNpXCv9ACgC9tFw3exER/xQgSpDVc4vrL2Cacr
 wmQp1k9E0W+9pk/l8S1jcHx03hgCxPtQLOIyEu9iIJb27TjcXNjiInd7Uea195NldIrndD+x
 58/yU3X70qVY+eWbqzpdlwF1KRm6uV0ZOQhEhbi0FfKKgsYFgBIBchGqSOBsCbL35f9hK/JC
 6LnGDtSHeJs+jd9/qJj4WqF3x8i0sncQ/gszSajdhnWrxraG3b7/9ldMLpKo/OoihfLaCxtv
 xYmtw8TGhlMaiOxjDrohmY1z7f3rf6njskoIXUO0nabun1nPAiV1dpjleg60s3OmVQeEpr3a
 K7gR1ljkemJzM9NUoRROPaT7nMlNYQL+IwuthJd6XQqwzp1jRTGG26J97wARAQABiQM+BBgB
 AgAJBQJWJ3+kAhsCAikJEBaat7Gkz/iuwV0gBBkBAgAGBQJWJ3+kAAoJEHfc29rIyEnRk6MQ
 AJDo0nxsadLpYB26FALZsWlN74rnFXth5dQVQ7SkipmyFWZhFL8fQ9OiIoxWhM6rSg9+C1w+
 n45eByMg2b8H3mmQmyWztdI95OxSREKwbaXVapCcZnv52JRjlc3DoiiHqTZML5x1Z7lQ1T3F
 8o9sKrbFO1WQw1+Nc91+MU0MGN0jtfZ0Tvn/ouEZrSXCE4K3oDGtj3AdC764yZVq6CPigCgs
 6Ex80k6QlzCdVP3RKsnPO2xQXXPgyJPJlpD8bHHHW7OLfoR9DaBNympfcbQJeekQrTvyoASw
 EOTPKE6CVWrcQIztUp0WFTdRGgMK0cZB3Xfe6sOp24PQTHAKGtjTHNP/THomkH24Fum9K3iM
 /4Wh4V2eqGEgpdeSp5K+LdaNyNgaqzMOtt4HYk86LYLSHfFXywdlbGrY9+TqiJ+ZVW4trmui
 NIJCOku8SYansq34QzYM0x3UFRwff+45zNBEVzctSnremg1mVgrzOfXU8rt+4N1b2MxorPF8
 619aCwVP7U16qNSBaqiAJr4e5SNEnoAq18+1Gp8QsFG0ARY8xp+qaKBByWES7lRi3QbqAKZf
 yOHS6gmYo9gBmuAhc65/VtHMJtxwjpUeN4Bcs9HUpDMDVHdfeRa73wM+wY5potfQ5zkSp0Jp
 bxnv/cRBH6+c43stTffprd//4Hgz+nJcCgZKtCYIAPkUxABC85ID2CidzbraErVACmRoizhT
 KR2OiqSLW2x4xdmSiFNcIWkWJB6Qdri0Fzs2dHe8etD1HYaht1ZhZ810s7QOL7JwypO8dscN
 KTEkyoTGn6cWj0CX+PeP4xp8AR8ot4d0BhtUY34UPzjE1/xyrQFAdnLd0PP4wXxdIUuRs0+n
 WLY9Aou/vC1LAdlaGsoTVzJ2gX4fkKQIWhX0WVk41BSFeDKQ3RQ2pnuzwedLO94Bf6X0G48O
 VsbXrP9BZ6snXyHfebPnno/te5XRqZTL9aJOytB/1iUna+1MAwBxGFPvqeEUUyT+gx1l3Acl
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <1cd21d60-5ded-2f70-3c99-02b70f996870@baylibre.com>
Date:   Fri, 27 Sep 2019 11:37:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b328b0c7-9449-172d-a1ed-7449023ff516@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2019 11:14, Neil Armstrong wrote:
> On 24/09/2019 17:33, Jerome Brunet wrote:
>> The peripheral clock on the sm1 goes through some muxes
>> and dividers before reaching the audio gates. To model that,
>> without repeating our self too much, the "top" clock signal
>> is introduced and will serve as a the parent of the gates.
>>
>> On the axg and g12a, the top clock is just a pass-through to
>> the audio peripheral clock provided by the main controller.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/clk/meson/axg-audio.c | 19 ++++++++++++++++---
>>  drivers/clk/meson/axg-audio.h |  3 ++-
>>  2 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
>> index ce8836776d1c..a8ccdbaecae2 100644
>> --- a/drivers/clk/meson/axg-audio.c
>> +++ b/drivers/clk/meson/axg-audio.c
>> @@ -74,9 +74,7 @@
>>  	.hw.init = &(struct clk_init_data) {				\
>>  		.name = "aud_"#_name,					\
>>  		.ops = &clk_regmap_gate_ops,				\
>> -		.parent_data = &(const struct clk_parent_data) {	\
>> -			.fw_name = "pclk",				\
>> -		},							\
>> +		.parent_names = (const char *[]){ "aud_top" },		\
>>  		.num_parents = 1,					\
>>  	},								\
>>  }
>> @@ -504,6 +502,19 @@ static struct clk_regmap tdmout_c_lrclk =
>>  	AUD_TDM_LRLCK(out_c, AUDIO_CLK_TDMOUT_C_CTRL);
>>  
>>  /* AXG/G12A Clocks */
>> +
>> +static struct clk_hw axg_aud_top = {
>> +	.init = &(struct clk_init_data) {
>> +		/* Provide aud_top signal name on axg and g12a */
>> +		.name = "aud_top",
>> +		.ops = &(const struct clk_ops) {},
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "pclk",
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>>  static struct clk_regmap mst_a_mclk_sel =
>>  	AUD_MST_MCLK_MUX(mst_a_mclk, AUDIO_MCLK_A_CTRL);
>>  static struct clk_regmap mst_b_mclk_sel =
>> @@ -691,6 +702,7 @@ static struct clk_hw_onecell_data axg_audio_hw_onecell_data = {
>>  		[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
>>  		[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
>>  		[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
>> +		[AUD_CLKID_TOP]			= &axg_aud_top,
>>  		[NR_CLKS] = NULL,
>>  	},
>>  	.num = NR_CLKS,
>> @@ -835,6 +847,7 @@ static struct clk_hw_onecell_data g12a_audio_hw_onecell_data = {
>>  		[AUD_CLKID_TDM_SCLK_PAD0]	= &g12a_tdm_sclk_pad_0.hw,
>>  		[AUD_CLKID_TDM_SCLK_PAD1]	= &g12a_tdm_sclk_pad_1.hw,
>>  		[AUD_CLKID_TDM_SCLK_PAD2]	= &g12a_tdm_sclk_pad_2.hw,
>> +		[AUD_CLKID_TOP]			= &axg_aud_top,
>>  		[NR_CLKS] = NULL,
>>  	},
>>  	.num = NR_CLKS,
>> diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
>> index c00e28b2e1a9..a4956837f597 100644
>> --- a/drivers/clk/meson/axg-audio.h
>> +++ b/drivers/clk/meson/axg-audio.h
>> @@ -116,9 +116,10 @@
>>  #define AUD_CLKID_SPDIFOUT_B_CLK_SEL	153
>>  #define AUD_CLKID_SPDIFOUT_B_CLK_DIV	154
>>  
>> +
> 
> AUD_CLKID_TOP seems to be missing here

Oh, yes it was exposed, do you need to it to be exposed since it's dummy for G12A ?

Neil

> 
> 
>>  /* include the CLKIDs which are part of the DT bindings */
>>  #include <dt-bindings/clock/axg-audio-clkc.h>
>>  
>> -#define NR_CLKS	163
>> +#define NR_CLKS	164
>>  
>>  #endif /*__AXG_AUDIO_CLKC_H */
>>
> 

