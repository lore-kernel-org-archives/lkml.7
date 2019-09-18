Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A0C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB1421925
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Bt+O0T7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfIRMjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:39:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43652 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIRMjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:39:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so6717189wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=95Hn3vPKkFfiEhTsyaC6yK6iZ0/sBJCmVCTbc9IUbFI=;
        b=Bt+O0T7+/zZtxFhOTZCmHV4KBj7kAMLbRKVZFlBEuj/UJXpgWaRjBBDjKVPBR+FPpG
         gs8QN8ajCWzf1ObO+qWjr2Y8NBOCQgocwVbqFLwjdQw1lwI2tJTavClGWprHc/Sj/gds
         A7GWRDJUNRXaNpMp8wmBHWczthXfkINOw8Sgv0GJ6k5kwEhBJaF1xCieW4V6jDb3cFqW
         02nnhIXoHQQ9rGI8EBPL3C4+tP1liJgpFoXON8IpBZlOjBIqpfGBk5ikEwJ+3PHz8sTe
         gPf/oCufzoOJO3XdysfWJYHtEj4MkYZ3zezBH7L6Pp3QM6+uFpqPLKwGZkyKaha7y7DI
         gY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=95Hn3vPKkFfiEhTsyaC6yK6iZ0/sBJCmVCTbc9IUbFI=;
        b=L9xN94Bcsso7VWuFAOosrDGYYBkufPM1idkJcHXXqD8/kpXHHt/J8Kn4CMI3RS9Iba
         W9InguwuZTsDKPb4IRiGqooTEDj6x3MsMyguYVZNfhqGtpd1KoZc5YBZsG80INgygsxa
         i8YM1sG5S4VvqcqlpHNgxKHDeEXg3anoSbRHJx1/HnprWnKMUw6xxQYnnXYYLns6Or7E
         1RvRgtZClZPZFMTf+/iVRwk/1q3RUTMCls0DaF7e07RWzaznYBoABYxXua8lTqsAZTGP
         Tr7cjJkFLmr+gq81qYZmW133ntrJuEZbwWZcuD0Sxun+deMWXQ80z5E2fIfzo3GbB6Kd
         rDqA==
X-Gm-Message-State: APjAAAVgUBgPRjKRbIrMa+HZ2zT5a1oHXR2WKE+yPwWW2MVLZJxwnDf7
        jUYf6KIeT6Wo2iLaoGBdMK9hyg==
X-Google-Smtp-Source: APXvYqy1Yv0CSd98/sYCGClYE/YNtt1gQT/PQpw+NKu7BMtngQIQcoy0B2kt/Y0yw9KtpueF5SPZig==
X-Received: by 2002:adf:df91:: with SMTP id z17mr2773260wrl.116.1568810344552;
        Wed, 18 Sep 2019 05:39:04 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v64sm3062976wmf.12.2019.09.18.05.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 05:39:03 -0700 (PDT)
Subject: Re: [PATCH 2/3] dt-bindings: reset: add bindings for the Meson-A1 SoC
 Reset Controller
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1568808746-1153-1-git-send-email-xingyu.chen@amlogic.com>
 <1568808746-1153-3-git-send-email-xingyu.chen@amlogic.com>
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
Message-ID: <d99786ec-7635-67e5-3e47-738ce131b634@baylibre.com>
Date:   Wed, 18 Sep 2019 14:39:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568808746-1153-3-git-send-email-xingyu.chen@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/09/2019 14:12, Xingyu Chen wrote:
> Add DT bindings for the Meson-A1 SoC Reset Controller include file,
> and also slightly update documentation.
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../bindings/reset/amlogic,meson-reset.txt         |  4 +-

The reset bindings has been moved to yaml, either rebase on linux-next or wait for v5.4-rc1 :
https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/refs/tags/next-20190917/Documentation/devicetree/bindings/reset/amlogic%2Cmeson-reset.yaml

Neil

>  include/dt-bindings/reset/amlogic,meson-a1-reset.h | 59 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
> index 28ef6c2..011151a 100644
> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
> @@ -5,8 +5,8 @@ Please also refer to reset.txt in this directory for common reset
>  controller binding usage.
>  
>  Required properties:
> -- compatible: Should be "amlogic,meson8b-reset", "amlogic,meson-gxbb-reset" or
> -	"amlogic,meson-axg-reset".
> +- compatible: Should be "amlogic,meson8b-reset", "amlogic,meson-gxbb-reset",
> +	"amlogic,meson-axg-reset" or "amlogic,meson-a1-reset".
>  - reg: should contain the register address base
>  - #reset-cells: 1, see below
>  
> diff --git a/include/dt-bindings/reset/amlogic,meson-a1-reset.h b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
> new file mode 100644
> index 00000000..8d76a47
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> + *
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
> + *
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
> +
> +/* RESET0 */
> +#define RESET_AM2AXI_VAD		1
> +#define RESET_PSRAM			4
> +#define RESET_PAD_CTRL			5
> +#define RESET_TEMP_SENSOR		7
> +#define RESET_AM2AXI_DEV		8
> +#define RESET_SPICC_A			10
> +#define RESET_MSR_CLK			11
> +#define RESET_AUDIO			12
> +#define RESET_ANALOG_CTRL		13
> +#define RESET_SAR_ADC			14
> +#define RESET_AUDIO_VAD			15
> +#define RESET_CEC			16
> +#define RESET_PWM_EF			17
> +#define RESET_PWM_CD			18
> +#define RESET_PWM_AB			19
> +#define RESET_IR_CTRL			21
> +#define RESET_I2C_S_A			22
> +#define RESET_I2C_M_D			24
> +#define RESET_I2C_M_C			25
> +#define RESET_I2C_M_B			26
> +#define RESET_I2C_M_A			27
> +#define RESET_I2C_PROD_AHB		28
> +#define RESET_I2C_PROD			29
> +
> +/* RESET1 */
> +#define RESET_ACODEC			32
> +#define RESET_DMA			33
> +#define RESET_SD_EMMC_A			34
> +#define RESET_USBCTRL			36
> +#define RESET_USBPHY			38
> +#define RESET_RSA			42
> +#define RESET_DMC			43
> +#define RESET_IRQ_CTRL			45
> +#define RESET_NIC_VAD			47
> +#define RESET_NIC_AXI			48
> +#define RESET_RAMA			49
> +#define RESET_RAMB			50
> +#define RESET_ROM			53
> +#define RESET_SPIFC			54
> +#define RESET_GIC			55
> +#define RESET_UART_C			56
> +#define RESET_UART_B			57
> +#define RESET_UART_A			58
> +#define RESET_OSC_RING			59
> +
> +/* RESET2 Reserved */
> +
> +#endif
> 

