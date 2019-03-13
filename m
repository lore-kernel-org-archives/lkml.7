Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4BBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C42E2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RBZ8cx6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfCMJwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:52:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33570 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfCMJwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:52:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id i8so1228803wrm.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yDLnEYy93fym2sEKjStAVCO2WivwOr+S/wWA31qqUkk=;
        b=RBZ8cx6Iz2eOwOtElgFpZiIrIDLU9iEbEZ9E3Gi3xc2dY6bhQG3jvWXGWRXJihIied
         gcFLxx/m0RsimehMMSJMtEor6Fx5RBaLdLQliV8czmPSyj36J8r7GqhIxvV3oPBFA3NQ
         KzfU4xclQqBlYoxK8rN5joFE1TPiDXOZOFqKtefogG/dOLQvxU4gIcNjxhEZbhn4IPM0
         kcXDNazhFYHWPzRh5FVnNQd6cQI1vveuwqRIHNA3YMNvok41onfKVTDeUCNhUwg42T6u
         6C24bnm1cXM5fxYrHYQdjniMfK2lazIzvnERcYw9zXOfjCZ61czbxcAJK5g1rs11lP5z
         Givw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yDLnEYy93fym2sEKjStAVCO2WivwOr+S/wWA31qqUkk=;
        b=Gqi59i3+z9qvBK1HoeJLzAluWr8gvsbG990wJI+fT8HV0XLmd0AmtjKFT09wobnVhK
         waRO8kikaMLU/Nyt7Ffnr7PffrLmS95EUyVh7AWUPBViAYffUXws17CUawvkEilsMeYI
         YXHsae1WJkSXlUM8Q/iIYH6LcruIezCmyZeBAhKY/3aHz6lhYa4eHERehXV2EZH/18l8
         qfLzYHkqlmWP/Tok73MSvYLzD5nv3qB2pQfB3ChxGAsOadyWuLOok2HsvuvCLHADIWQH
         f1PeMjMH9SyNwsoeljaQUtdTEwxNuliY6EwEDbPdKX+gN05kJ7+L7tPSx74NFIaE2YPP
         NafQ==
X-Gm-Message-State: APjAAAUqWi+M/uOmRtpDAijPexyRY5ogsc5P8XGjtI8zwM83D+wWr25B
        RVabHYvVF7opOsi4fGqslkEAIOAdhTuNbfIj
X-Google-Smtp-Source: APXvYqzkbRX0Lg1Pa+BhNVMfDhbhomdJ5pVKObqJqsRMHhLjOxEgy+kd7sbPtR4gEFcoUYVMf/gHrA==
X-Received: by 2002:adf:a382:: with SMTP id l2mr17759042wrb.79.1552470728717;
        Wed, 13 Mar 2019 02:52:08 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y3sm2082947wrh.18.2019.03.13.02.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 02:52:08 -0700 (PDT)
Subject: Re: [PATCH 4/9] arm64: dts: meson: g12a: add uart_ao_a pinctrl
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190307151342.7381-1-narmstrong@baylibre.com>
 <20190307151342.7381-5-narmstrong@baylibre.com>
 <244fba9a-31ab-a75c-3de2-a66638a9d36d@baylibre.com>
 <7h36nru744.fsf@baylibre.com>
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
Message-ID: <8e3f4e1a-3252-9e63-1c95-4d1441cedad3@baylibre.com>
Date:   Wed, 13 Mar 2019 10:52:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <7h36nru744.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2019 22:15, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> On 07/03/2019 16:13, Neil Armstrong wrote:
>>> From: Jerome Brunet <jbrunet@baylibre.com>
>>>
>>> Add the always on UART pinctrl setting to the g12a soc DT and
>>> use it for the u200 reference design
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  .../arm64/boot/dts/amlogic/meson-g12a-u200.dts |  2 ++
>>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi    | 18 ++++++++++++++++++
>>>  2 files changed, 20 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>>> index c44dbdddf2cf..f2afd0bf3e28 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>>> @@ -25,5 +25,7 @@
>>>  
>>>  &uart_AO {
>>>  	status = "okay";
>>> +	pinctrl-0 = <&uart_ao_a_pins>;
>>> +	pinctrl-names = "default";
>>>  };
>>>  
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>>> index c141cc7f6b09..f8f055c49f9a 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>>> @@ -177,6 +177,24 @@
>>>  						#gpio-cells = <2>;
>>>  						gpio-ranges = <&ao_pinctrl 0 0 15>;
>>>  					};
>>> +
>>> +					uart_ao_a_pins: uart_a_ao {
>>> +						mux {
>>> +							groups = "uart_ao_a_tx",
>>> +								 "uart_ao_a_rx";
>>> +							function = "uart_ao_a";
>>> +							bias-disable;
>>> +						};
>>> +					};
>>> +
>>> +					uart_ao_a_cts_rts_pins: uart_ao_a_cts_rts {
>>> +						mux {
>>> +							groups = "uart_ao_a_cts",
>>> +								 "uart_ao_a_rts";
>>> +							function = "uart_ao_a";
>>> +							bias-disable;
>>> +						};
>>> +					};
>>>  				};
>>>  			};
>>>  
>>>
>>
>> Will move this out of this patchset to the boards patchset
> 
> I assume you meant you'd move the first hunk, the one that modifies the
> u200 board to the other series, but keep this hunk in this series?

Yep I will remove the board chunk in the v2 of this patchset.

Neil

> 
> Kevin
> 

