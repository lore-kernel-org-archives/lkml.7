Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A43C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624B82184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZddLOuw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfCTIPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:15:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33405 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfCTIPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:15:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so6272083wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L0ixkEdkBEk+eNeH1NJz9csDEavMIawOqPOlhfYtYDI=;
        b=ZddLOuw09cZX+Ozx/LjO+Ds0KrY64gCtYXnPJ34HJKxBGn4K0TF9rKa+nHvdEJGpN3
         9+Ek1xfRUYqLinB1KpNa11eeqs1MaGjxy1FYYFp/xTpPIa/tKoHowHaHj32AiwESgA/I
         C5+yJW78snr1xX9m4o2zFhV2d3SEO4ltkT550zJqUiz3mBcPlVKSsB0QJdrMmwTKkS1W
         RF+wxVR+7RvndHlpBZXmeK08ZIKd9cl2Tft1q0Jr4+N4acTndRBXtC2tXjMTzc8lNZxV
         79ul4TTTDbYVAMAX8m5TnE3SBvtwoM/ff0D9AcfwWW1x2LzGlRwyTCGRVtQ5WOQyFm0a
         6Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L0ixkEdkBEk+eNeH1NJz9csDEavMIawOqPOlhfYtYDI=;
        b=LYV+2hSFT7Y8aEdvBNUJ3SF6Anw6hGhY4vuFMcxTQo1x54zM/pU8CMF/N/q78mRkdB
         WnV5HjP+WscrafPyqvKp1Hb8zMLQ0/kc3LipWg5nUY853ytcQUgbo3oTad32NfQvx9uU
         LyKrUQltz8wwo/vHnon1O3GUvIgW+fDo7Ikp5kgALfZbKriLn76pte67HJ9Qo8XZC0iN
         cgcxnPQ4h6r6mQW1afPCdq2W3WlQgXg8hv5rPNax5nNv+1Q+ORv6TpxYVSQWNkKCvgGj
         JMP+8RPRklEVCwrOLkf4/U3pBjgnzA/Z3ZVV242djsznQbG+0Et6cB75O4uS3cCQtL1s
         SsRA==
X-Gm-Message-State: APjAAAXcXetf84n+1HDmE7Fk0o82TOL8ue5iUfGf9Ogp3TOy/RVbxNdP
        Mavq2HeRCC2FRtu0auBENPuO2t0ZlK01VzOl
X-Google-Smtp-Source: APXvYqwsHqTnPlD54XECr0hk0Qq58rNYC3Ozy1Rzg+72wihJSRCwdBE4S0arUv5EanOIfbi6DD4b+w==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr7100611wmb.73.1553069702367;
        Wed, 20 Mar 2019 01:15:02 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id b134sm3717694wmd.26.2019.03.20.01.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 01:15:01 -0700 (PDT)
Subject: Re: [PATCH 2/4] clk: meson: meson8b: use a sparate clock table for
 Meson8m2
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190319215121.29340-1-martin.blumenstingl@googlemail.com>
 <20190319215121.29340-3-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
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
Message-ID: <1d52f584-1a5d-8b0d-ecd0-8c041f2b9c18@baylibre.com>
Date:   Wed, 20 Mar 2019 09:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319215121.29340-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a typo in the subject "s/sparate/separate/" !

On 19/03/2019 22:51, Martin Blumenstingl wrote:
> Meson8, Meson8b and Meson8m2 implement a similar clock controller.
> However, there are a few differences between the three actual IP blocks.
> 
> One example where Meson8m2 differs from Meson8b is the VPU clock setup:
> - the VPU input mux can choose between "fclk_div4", "fclk_div3",
>   "fclk_div5" and "fclk_div7" on Meson8b
> - however, on Meson8m2 it can choose between "fclk_div4", "fclk_div3",
>   "fclk_div5" and "gp_pll" (GP_PLL only exists on Meson8m2, it's the
>   predecessor of the GP0_PLL clock on GXBB/GXL/GXM))

By curiosity, what is the default (maximum) setup ? On GX & G12A, fclk_div3 is the default/max setup.

> 
> Add a separate clk_hw_onecell_data table for Meson8m2 so these
> differences can be implemented in our clock controller driver. For now
> meson8m2_hw_onecell_data is a clone of our existing
> meson8b_hw_onecell_data.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 193 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 192 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 576ad42252d0..c9e6ec67d649 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -2157,6 +2157,192 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
>  	.num = CLK_NR_CLKS,
>  };
>  
> +static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
> +	.hws = {
> +		[CLKID_XTAL] = &meson8b_xtal.hw,
> +		[CLKID_PLL_FIXED] = &meson8b_fixed_pll.hw,
> +		[CLKID_PLL_VID] = &meson8b_vid_pll.hw,
> +		[CLKID_PLL_SYS] = &meson8b_sys_pll.hw,
> +		[CLKID_FCLK_DIV2] = &meson8b_fclk_div2.hw,
> +		[CLKID_FCLK_DIV3] = &meson8b_fclk_div3.hw,
> +		[CLKID_FCLK_DIV4] = &meson8b_fclk_div4.hw,
> +		[CLKID_FCLK_DIV5] = &meson8b_fclk_div5.hw,
> +		[CLKID_FCLK_DIV7] = &meson8b_fclk_div7.hw,
> +		[CLKID_CPUCLK] = &meson8b_cpu_clk.hw,
> +		[CLKID_MPEG_SEL] = &meson8b_mpeg_clk_sel.hw,
> +		[CLKID_MPEG_DIV] = &meson8b_mpeg_clk_div.hw,
> +		[CLKID_CLK81] = &meson8b_clk81.hw,
> +		[CLKID_DDR]		    = &meson8b_ddr.hw,
> +		[CLKID_DOS]		    = &meson8b_dos.hw,
> +		[CLKID_ISA]		    = &meson8b_isa.hw,
> +		[CLKID_PL301]		    = &meson8b_pl301.hw,
> +		[CLKID_PERIPHS]		    = &meson8b_periphs.hw,
> +		[CLKID_SPICC]		    = &meson8b_spicc.hw,
> +		[CLKID_I2C]		    = &meson8b_i2c.hw,
> +		[CLKID_SAR_ADC]		    = &meson8b_sar_adc.hw,
> +		[CLKID_SMART_CARD]	    = &meson8b_smart_card.hw,
> +		[CLKID_RNG0]		    = &meson8b_rng0.hw,
> +		[CLKID_UART0]		    = &meson8b_uart0.hw,
> +		[CLKID_SDHC]		    = &meson8b_sdhc.hw,
> +		[CLKID_STREAM]		    = &meson8b_stream.hw,
> +		[CLKID_ASYNC_FIFO]	    = &meson8b_async_fifo.hw,
> +		[CLKID_SDIO]		    = &meson8b_sdio.hw,
> +		[CLKID_ABUF]		    = &meson8b_abuf.hw,
> +		[CLKID_HIU_IFACE]	    = &meson8b_hiu_iface.hw,
> +		[CLKID_ASSIST_MISC]	    = &meson8b_assist_misc.hw,
> +		[CLKID_SPI]		    = &meson8b_spi.hw,
> +		[CLKID_I2S_SPDIF]	    = &meson8b_i2s_spdif.hw,
> +		[CLKID_ETH]		    = &meson8b_eth.hw,
> +		[CLKID_DEMUX]		    = &meson8b_demux.hw,
> +		[CLKID_AIU_GLUE]	    = &meson8b_aiu_glue.hw,
> +		[CLKID_IEC958]		    = &meson8b_iec958.hw,
> +		[CLKID_I2S_OUT]		    = &meson8b_i2s_out.hw,
> +		[CLKID_AMCLK]		    = &meson8b_amclk.hw,
> +		[CLKID_AIFIFO2]		    = &meson8b_aififo2.hw,
> +		[CLKID_MIXER]		    = &meson8b_mixer.hw,
> +		[CLKID_MIXER_IFACE]	    = &meson8b_mixer_iface.hw,
> +		[CLKID_ADC]		    = &meson8b_adc.hw,
> +		[CLKID_BLKMV]		    = &meson8b_blkmv.hw,
> +		[CLKID_AIU]		    = &meson8b_aiu.hw,
> +		[CLKID_UART1]		    = &meson8b_uart1.hw,
> +		[CLKID_G2D]		    = &meson8b_g2d.hw,
> +		[CLKID_USB0]		    = &meson8b_usb0.hw,
> +		[CLKID_USB1]		    = &meson8b_usb1.hw,
> +		[CLKID_RESET]		    = &meson8b_reset.hw,
> +		[CLKID_NAND]		    = &meson8b_nand.hw,
> +		[CLKID_DOS_PARSER]	    = &meson8b_dos_parser.hw,
> +		[CLKID_USB]		    = &meson8b_usb.hw,
> +		[CLKID_VDIN1]		    = &meson8b_vdin1.hw,
> +		[CLKID_AHB_ARB0]	    = &meson8b_ahb_arb0.hw,
> +		[CLKID_EFUSE]		    = &meson8b_efuse.hw,
> +		[CLKID_BOOT_ROM]	    = &meson8b_boot_rom.hw,
> +		[CLKID_AHB_DATA_BUS]	    = &meson8b_ahb_data_bus.hw,
> +		[CLKID_AHB_CTRL_BUS]	    = &meson8b_ahb_ctrl_bus.hw,
> +		[CLKID_HDMI_INTR_SYNC]	    = &meson8b_hdmi_intr_sync.hw,
> +		[CLKID_HDMI_PCLK]	    = &meson8b_hdmi_pclk.hw,
> +		[CLKID_USB1_DDR_BRIDGE]	    = &meson8b_usb1_ddr_bridge.hw,
> +		[CLKID_USB0_DDR_BRIDGE]	    = &meson8b_usb0_ddr_bridge.hw,
> +		[CLKID_MMC_PCLK]	    = &meson8b_mmc_pclk.hw,
> +		[CLKID_DVIN]		    = &meson8b_dvin.hw,
> +		[CLKID_UART2]		    = &meson8b_uart2.hw,
> +		[CLKID_SANA]		    = &meson8b_sana.hw,
> +		[CLKID_VPU_INTR]	    = &meson8b_vpu_intr.hw,
> +		[CLKID_SEC_AHB_AHB3_BRIDGE] = &meson8b_sec_ahb_ahb3_bridge.hw,
> +		[CLKID_CLK81_A9]	    = &meson8b_clk81_a9.hw,
> +		[CLKID_VCLK2_VENCI0]	    = &meson8b_vclk2_venci0.hw,
> +		[CLKID_VCLK2_VENCI1]	    = &meson8b_vclk2_venci1.hw,
> +		[CLKID_VCLK2_VENCP0]	    = &meson8b_vclk2_vencp0.hw,
> +		[CLKID_VCLK2_VENCP1]	    = &meson8b_vclk2_vencp1.hw,
> +		[CLKID_GCLK_VENCI_INT]	    = &meson8b_gclk_venci_int.hw,
> +		[CLKID_GCLK_VENCP_INT]	    = &meson8b_gclk_vencp_int.hw,
> +		[CLKID_DAC_CLK]		    = &meson8b_dac_clk.hw,
> +		[CLKID_AOCLK_GATE]	    = &meson8b_aoclk_gate.hw,
> +		[CLKID_IEC958_GATE]	    = &meson8b_iec958_gate.hw,
> +		[CLKID_ENC480P]		    = &meson8b_enc480p.hw,
> +		[CLKID_RNG1]		    = &meson8b_rng1.hw,
> +		[CLKID_GCLK_VENCL_INT]	    = &meson8b_gclk_vencl_int.hw,
> +		[CLKID_VCLK2_VENCLMCC]	    = &meson8b_vclk2_venclmcc.hw,
> +		[CLKID_VCLK2_VENCL]	    = &meson8b_vclk2_vencl.hw,
> +		[CLKID_VCLK2_OTHER]	    = &meson8b_vclk2_other.hw,
> +		[CLKID_EDP]		    = &meson8b_edp.hw,
> +		[CLKID_AO_MEDIA_CPU]	    = &meson8b_ao_media_cpu.hw,
> +		[CLKID_AO_AHB_SRAM]	    = &meson8b_ao_ahb_sram.hw,
> +		[CLKID_AO_AHB_BUS]	    = &meson8b_ao_ahb_bus.hw,
> +		[CLKID_AO_IFACE]	    = &meson8b_ao_iface.hw,
> +		[CLKID_MPLL0]		    = &meson8b_mpll0.hw,
> +		[CLKID_MPLL1]		    = &meson8b_mpll1.hw,
> +		[CLKID_MPLL2]		    = &meson8b_mpll2.hw,
> +		[CLKID_MPLL0_DIV]	    = &meson8b_mpll0_div.hw,
> +		[CLKID_MPLL1_DIV]	    = &meson8b_mpll1_div.hw,
> +		[CLKID_MPLL2_DIV]	    = &meson8b_mpll2_div.hw,
> +		[CLKID_CPU_IN_SEL]	    = &meson8b_cpu_in_sel.hw,
> +		[CLKID_CPU_IN_DIV2]	    = &meson8b_cpu_in_div2.hw,
> +		[CLKID_CPU_IN_DIV3]	    = &meson8b_cpu_in_div3.hw,
> +		[CLKID_CPU_SCALE_DIV]	    = &meson8b_cpu_scale_div.hw,
> +		[CLKID_CPU_SCALE_OUT_SEL]   = &meson8b_cpu_scale_out_sel.hw,
> +		[CLKID_MPLL_PREDIV]	    = &meson8b_mpll_prediv.hw,
> +		[CLKID_FCLK_DIV2_DIV]	    = &meson8b_fclk_div2_div.hw,
> +		[CLKID_FCLK_DIV3_DIV]	    = &meson8b_fclk_div3_div.hw,
> +		[CLKID_FCLK_DIV4_DIV]	    = &meson8b_fclk_div4_div.hw,
> +		[CLKID_FCLK_DIV5_DIV]	    = &meson8b_fclk_div5_div.hw,
> +		[CLKID_FCLK_DIV7_DIV]	    = &meson8b_fclk_div7_div.hw,
> +		[CLKID_NAND_SEL]	    = &meson8b_nand_clk_sel.hw,
> +		[CLKID_NAND_DIV]	    = &meson8b_nand_clk_div.hw,
> +		[CLKID_NAND_CLK]	    = &meson8b_nand_clk_gate.hw,
> +		[CLKID_PLL_FIXED_DCO]	    = &meson8b_fixed_pll_dco.hw,
> +		[CLKID_HDMI_PLL_DCO]	    = &meson8b_hdmi_pll_dco.hw,
> +		[CLKID_PLL_SYS_DCO]	    = &meson8b_sys_pll_dco.hw,
> +		[CLKID_CPU_CLK_DIV2]	    = &meson8b_cpu_clk_div2.hw,
> +		[CLKID_CPU_CLK_DIV3]	    = &meson8b_cpu_clk_div3.hw,
> +		[CLKID_CPU_CLK_DIV4]	    = &meson8b_cpu_clk_div4.hw,
> +		[CLKID_CPU_CLK_DIV5]	    = &meson8b_cpu_clk_div5.hw,
> +		[CLKID_CPU_CLK_DIV6]	    = &meson8b_cpu_clk_div6.hw,
> +		[CLKID_CPU_CLK_DIV7]	    = &meson8b_cpu_clk_div7.hw,
> +		[CLKID_CPU_CLK_DIV8]	    = &meson8b_cpu_clk_div8.hw,
> +		[CLKID_APB_SEL]		    = &meson8b_apb_clk_sel.hw,
> +		[CLKID_APB]		    = &meson8b_apb_clk_gate.hw,
> +		[CLKID_PERIPH_SEL]	    = &meson8b_periph_clk_sel.hw,
> +		[CLKID_PERIPH]		    = &meson8b_periph_clk_gate.hw,
> +		[CLKID_AXI_SEL]		    = &meson8b_axi_clk_sel.hw,
> +		[CLKID_AXI]		    = &meson8b_axi_clk_gate.hw,
> +		[CLKID_L2_DRAM_SEL]	    = &meson8b_l2_dram_clk_sel.hw,
> +		[CLKID_L2_DRAM]		    = &meson8b_l2_dram_clk_gate.hw,
> +		[CLKID_HDMI_PLL_LVDS_OUT]   = &meson8b_hdmi_pll_lvds_out.hw,
> +		[CLKID_HDMI_PLL_HDMI_OUT]   = &meson8b_hdmi_pll_hdmi_out.hw,
> +		[CLKID_VID_PLL_IN_SEL]	    = &meson8b_vid_pll_in_sel.hw,
> +		[CLKID_VID_PLL_IN_EN]	    = &meson8b_vid_pll_in_en.hw,
> +		[CLKID_VID_PLL_PRE_DIV]	    = &meson8b_vid_pll_pre_div.hw,
> +		[CLKID_VID_PLL_POST_DIV]    = &meson8b_vid_pll_post_div.hw,
> +		[CLKID_VID_PLL_FINAL_DIV]   = &meson8b_vid_pll_final_div.hw,
> +		[CLKID_VCLK_IN_SEL]	    = &meson8b_vclk_in_sel.hw,
> +		[CLKID_VCLK_IN_EN]	    = &meson8b_vclk_in_en.hw,
> +		[CLKID_VCLK_DIV1]	    = &meson8b_vclk_div1_gate.hw,
> +		[CLKID_VCLK_DIV2_DIV]	    = &meson8b_vclk_div2_div.hw,
> +		[CLKID_VCLK_DIV2]	    = &meson8b_vclk_div2_div_gate.hw,
> +		[CLKID_VCLK_DIV4_DIV]	    = &meson8b_vclk_div4_div.hw,
> +		[CLKID_VCLK_DIV4]	    = &meson8b_vclk_div4_div_gate.hw,
> +		[CLKID_VCLK_DIV6_DIV]	    = &meson8b_vclk_div6_div.hw,
> +		[CLKID_VCLK_DIV6]	    = &meson8b_vclk_div6_div_gate.hw,
> +		[CLKID_VCLK_DIV12_DIV]	    = &meson8b_vclk_div12_div.hw,
> +		[CLKID_VCLK_DIV12]	    = &meson8b_vclk_div12_div_gate.hw,
> +		[CLKID_VCLK2_IN_SEL]	    = &meson8b_vclk2_in_sel.hw,
> +		[CLKID_VCLK2_IN_EN]	    = &meson8b_vclk2_clk_in_en.hw,
> +		[CLKID_VCLK2_DIV1]	    = &meson8b_vclk2_div1_gate.hw,
> +		[CLKID_VCLK2_DIV2_DIV]	    = &meson8b_vclk2_div2_div.hw,
> +		[CLKID_VCLK2_DIV2]	    = &meson8b_vclk2_div2_div_gate.hw,
> +		[CLKID_VCLK2_DIV4_DIV]	    = &meson8b_vclk2_div4_div.hw,
> +		[CLKID_VCLK2_DIV4]	    = &meson8b_vclk2_div4_div_gate.hw,
> +		[CLKID_VCLK2_DIV6_DIV]	    = &meson8b_vclk2_div6_div.hw,
> +		[CLKID_VCLK2_DIV6]	    = &meson8b_vclk2_div6_div_gate.hw,
> +		[CLKID_VCLK2_DIV12_DIV]	    = &meson8b_vclk2_div12_div.hw,
> +		[CLKID_VCLK2_DIV12]	    = &meson8b_vclk2_div12_div_gate.hw,
> +		[CLKID_CTS_ENCT_SEL]	    = &meson8b_cts_enct_sel.hw,
> +		[CLKID_CTS_ENCT]	    = &meson8b_cts_enct.hw,
> +		[CLKID_CTS_ENCP_SEL]	    = &meson8b_cts_encp_sel.hw,
> +		[CLKID_CTS_ENCP]	    = &meson8b_cts_encp.hw,
> +		[CLKID_CTS_ENCI_SEL]	    = &meson8b_cts_enci_sel.hw,
> +		[CLKID_CTS_ENCI]	    = &meson8b_cts_enci.hw,
> +		[CLKID_HDMI_TX_PIXEL_SEL]   = &meson8b_hdmi_tx_pixel_sel.hw,
> +		[CLKID_HDMI_TX_PIXEL]	    = &meson8b_hdmi_tx_pixel.hw,
> +		[CLKID_CTS_ENCL_SEL]	    = &meson8b_cts_encl_sel.hw,
> +		[CLKID_CTS_ENCL]	    = &meson8b_cts_encl.hw,
> +		[CLKID_CTS_VDAC0_SEL]	    = &meson8b_cts_vdac0_sel.hw,
> +		[CLKID_CTS_VDAC0]	    = &meson8b_cts_vdac0.hw,
> +		[CLKID_HDMI_SYS_SEL]	    = &meson8b_hdmi_sys_sel.hw,
> +		[CLKID_HDMI_SYS_DIV]	    = &meson8b_hdmi_sys_div.hw,
> +		[CLKID_HDMI_SYS]	    = &meson8b_hdmi_sys.hw,
> +		[CLKID_MALI_0_SEL]	    = &meson8b_mali_0_sel.hw,
> +		[CLKID_MALI_0_DIV]	    = &meson8b_mali_0_div.hw,
> +		[CLKID_MALI_0]		    = &meson8b_mali_0.hw,
> +		[CLKID_MALI_1_SEL]	    = &meson8b_mali_1_sel.hw,
> +		[CLKID_MALI_1_DIV]	    = &meson8b_mali_1_div.hw,
> +		[CLKID_MALI_1]		    = &meson8b_mali_1.hw,
> +		[CLKID_MALI]		    = &meson8b_mali.hw,
> +		[CLK_NR_CLKS]		    = NULL,
> +	},
> +	.num = CLK_NR_CLKS,
> +};
> +
>  static struct clk_regmap *const meson8b_clk_regmaps[] = {
>  	&meson8b_clk81,
>  	&meson8b_ddr,
> @@ -2558,9 +2744,14 @@ static void __init meson8b_clkc_init(struct device_node *np)
>  	return meson8b_clkc_init_common(np, &meson8b_hw_onecell_data);
>  }
>  
> +static void __init meson8m2_clkc_init(struct device_node *np)
> +{
> +	return meson8b_clkc_init_common(np, &meson8m2_hw_onecell_data);
> +}
> +
>  CLK_OF_DECLARE_DRIVER(meson8_clkc, "amlogic,meson8-clkc",
>  		      meson8_clkc_init);
>  CLK_OF_DECLARE_DRIVER(meson8b_clkc, "amlogic,meson8b-clkc",
>  		      meson8b_clkc_init);
>  CLK_OF_DECLARE_DRIVER(meson8m2_clkc, "amlogic,meson8m2-clkc",
> -		      meson8b_clkc_init);
> +		      meson8m2_clkc_init);
> 

Apart the typo in the subject,
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
