Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD71A21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tbq3zm4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfCOHrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:47:51 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40316 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfCOHrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:47:51 -0400
Received: by mail-wm1-f42.google.com with SMTP id u10so2479680wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1oL7RnZO8+AFuhvhzRJT8mP3U3+fqn98o+Y9Koq5ivU=;
        b=tbq3zm4rJ9IgccsYOx8a+pbcxlr/7B0jAeGdrcY9Gsy/bGVNqFprzaKqaiCewmaI6d
         lWUUQAxLMSmvm2AHliCIXXWQ81HKmuMFtGsmmEQfVEKlaxpaTI4JNUN+UB9fi5Qp3cSa
         XzruFYiSQmkgz8hpERiwJLl8htMvqqf9te2SagclwlQ5DrjXgfvP77ensr1JwGr6dJ0w
         Myi/KX4QY6bBLjQNifQLsQjFZZizqE9vy1JrhTjeWB+o1w9x6A+kgAQ9ueKT9e796sS5
         xZ0attAUXsi31EAZuVIPei1hicV1a2rhBiYKnFKlC/5NJ0aynwoLIirnS8FM0u+7ZfH1
         fFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1oL7RnZO8+AFuhvhzRJT8mP3U3+fqn98o+Y9Koq5ivU=;
        b=sFh1w3cmxV6croIUg/YDV2OJvRqBplNsNgtI8rrlReJHpNFhWgMthL+8H+2i4qY3ya
         Elc3Tc2XGyjkTwpXF21eWUu62gDg8NuPo+cI2HvHEf8PygLFn63o+bb+qK0R7VGoyqLB
         sNHhIjwYsn6Z1iZ2XbF9/MIvwco0YFLlA8XSOU1OwRFdx0jgu3mcJVWxatYCENkyeYLv
         EhsYoiU6ifyj4HMnJ1bkAnvm1KyTNKfQD1kbxnGDvYb4OCPPhApsEeBcmNFok/9J50ZR
         3VsaMWomdVI/iCjNscy5H1ktwgVlKHYs97u8PwwDXWANQ6TQEQZ3QYNmS5DIcJ0jVrYj
         ej6g==
X-Gm-Message-State: APjAAAVoR93oN9vPIBVmVj1pXEBW0y5MIMXgXDdaGA5rcxkUZhsnJbpM
        9T/JVO/P31WydmWiBmM6nmIPEw==
X-Google-Smtp-Source: APXvYqzoDRiHwpOha/91tZxmNf/WAJkWwYyH0d4EcOvNXZiLY7Q4sEl2hhINmORJTWjNlXu7jiimog==
X-Received: by 2002:a1c:f610:: with SMTP id w16mr1057052wmc.42.1552636068223;
        Fri, 15 Mar 2019 00:47:48 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x17sm3017247wrd.95.2019.03.15.00.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 00:47:47 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling
 support
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        linux-amlogic@lists.infradead.org, Huicong Xu <xhc@rock-chips.com>
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
 <1549022873-40549-2-git-send-email-narmstrong@baylibre.com>
 <CAL_JsqLa1QNYTo+Yj-5fC4k8C1bd+V8qi5LiHgLA_qZY+Gy5cg@mail.gmail.com>
 <36800d4e-0bb7-378c-e512-5ae02406865b@baylibre.com>
 <CAL_Jsq+-q3+PtU6zS-dLSy3Gx+xOzquLyuW3n3ey6iRT3tw9KA@mail.gmail.com>
 <6e0f70a4-8e12-7000-bc5d-de5093d173c5@baylibre.com>
 <CAL_JsqL+R_wyzQ9UB37N4jwD8na301+=B9x6+z1LSMdKer88qg@mail.gmail.com>
 <5C8AB489.3000202@baylibre.com>
 <CAL_JsqK1_qXKBuSY6X9XG9AOdTP=tfNAtuJaSA_ONhVm-2kysQ@mail.gmail.com>
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
Message-ID: <132a815f-85a6-ad89-bd2c-830855aebdf8@baylibre.com>
Date:   Fri, 15 Mar 2019 08:47:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK1_qXKBuSY6X9XG9AOdTP=tfNAtuJaSA_ONhVm-2kysQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 14/03/2019 21:14, Rob Herring wrote:
> On Thu, Mar 14, 2019 at 3:07 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>

[...]

> 
> Here's with edid-decode:
> 
> EDID version: 1.3
> Manufacturer: CYX Model 101 Serial Number 16843009
> Made in week 28 of 2018
> Digital display
> Maximum image size: 22 cm x 13 cm
> Gamma: 2.20
> DPMS levels: Off
> Undefined display color type
> Default (sRGB) color space is primary color space
> First detailed timing is preferred timing
> Display x,y Chromaticity:
>   Red:   0.6455, 0.3300
>   Green: 0.3095, 0.6171
>   Blue:  0.1523, 0.0732
>   White: 0.3134, 0.3291
> Established timings supported:
>   640x480@60Hz 4:3 HorFreq: 31469 Hz Clock: 25.175 MHz
>   800x600@60Hz 4:3 HorFreq: 37900 Hz Clock: 40.000 MHz
>   1024x768@60Hz 4:3 HorFreq: 48400 Hz Clock: 65.000 MHz
> Standard timings supported:
>   1920x1080@60Hz 16:9
>   1920x1080@60Hz 16:9
>   1920x1080@60Hz 16:9
>   1440x900@60Hz 16:10 HorFreq: 55500 Hz Clock: 88.750 MHz
>   1400x1050@60Hz 4:3 HorFreq: 64700 Hz Clock: 101.000 MHz
>   1280x1024@60Hz 5:4 HorFreq: 64000 Hz Clock: 108.000 MHz
>   1280x960@60Hz 4:3 HorFreq: 60000 Hz Clock: 108.000 MHz
>   1280x720@60Hz 16:9
> Detailed mode: Clock 267.810 MHz, 220 mm x 130 mm
>                2560 2608 2640 2720 hborder 0
>                1600 1603 1608 1641 vborder 0
>                +hsync +vsync
>                VertFreq: 59 Hz, HorFreq: 98459 Hz
> Monitor name: CYS-R101
> Serial number:
> Monitor ranges (bare limits): 48-75Hz V, 30-102kHz H, max dotclock 190MHz
> Has 1 extension blocks
> Checksum: 0x8b (valid)
> 
> CTA extension block
> Extension version: 3
> 58 bytes of CTA data
>   Video data block
>     VIC  16 1920x1080@60Hz 16:9  HorFreq: 67500 Hz Clock: 148.500 MHz
>     VIC   5 1920x1080i@60Hz 16:9  HorFreq: 33750 Hz Clock: 74.250 MHz
>     VIC   4 1280x720@60Hz 16:9  HorFreq: 45000 Hz Clock: 74.250 MHz
>     VIC  31 1920x1080@50Hz 16:9  HorFreq: 56250 Hz Clock: 148.500 MHz
>   Audio data block
>     Linear PCM, max channels 2
>       Supported sample rates (kHz): 48 44.1 32
>       Supported sample sizes (bits): 24 20 16
>   Speaker allocation data block
>     Speaker map:
>       FL/FR - Front Left/Right
>   Vendor-specific data block, OUI 000c03 (HDMI)
>     Source physical address 1.0.0.0
>     DC_36bit
>     DC_30bit
>     DC_Y444
>     Maximum TMDS clock: 340MHz
>   Vendor-specific data block, OUI c45dd8 (HDMI Forum)
>     Version: 1
>     Maximum TMDS Character Rate: 340MHz
>     SCDC Present
>     Supports 10-bits/component Deep Color 4:2:0 Pixel Encoding
>   Vendor-specific data block, OUI 00001a
>   Extended tag: YCbCr 4:2:0 capability map data block
>     VSD Index 17
>     VSD Index 18
>   Extended tag: Colorimetry data block
>     BT2020YCC
>     BT2020RGB
>   Extended tag: Video capability data block
>     YCbCr quantization: Selectable (via AVI YQ) (1)
>     RGB quantization: Selectable (via AVI Q) (1)
>     PT scan behaviour: Support both over- and underscan (3)
>     IT scan behaviour: Support both over- and underscan (3)
>     CE scan behaviour: Support both over- and underscan (3)
>   Extended tag: HDR static metadata data block
>     Electro optical transfer functions:
>       Traditional gamma - SDR luminance range
>       SMPTE ST2084
>     Supported static metadata descriptors:
>       Static metadata type 1
>     Desired content max luminance: 89 (343.724 cd/m^2)
>     Desired content max frame-average luminance: 89 (343.724 cd/m^2)
>     Desired content min luminance: 73 (0.282 cd/m^2)
> Underscans PC formats by default
> Basic audio support
> Supports YCbCr 4:4:4
> Supports YCbCr 4:2:2
> 1 native detailed modes
> Detailed mode: Clock 54.000 MHz, 220 mm x 130 mm
>                2560 2608 2640 2720 hborder 0
>                1440 1443 1448 1481 vborder 0
>                +hsync +vsync side by side interleaved
>                VertFreq: 13 Hz, HorFreq: 19852 Hz
> Checksum: 0x3c (valid)
> 


Thanks for the parsed edid.

I think we have multiple issues :
- This EDID is severely broken, SCDC support doesn't make sense because
"Maximum TMDS Character Rate: 340MHz" and "Supports scrambling for <= 340 Mcsc" is not present
Same for 4:2:0, the IDs in the "YCbCr 4:2:0 capability map data block" refers
to invalid modes 17 & 18 in a mode table containing only 4 entries.
- DW-HDMI should not care if SCDC is present, Max TMDS <= 340MHz and low_rates is not present
- In any case, the SoC should not freeze in this situation, so either the
HDMI_FC_SCRAMBLER_CTRL or HDMI_MC_SWRSTZ writes makes the SoC freeze or
the drm_scdc_set_scrambling() containing i2c write fails, anyway this is
the root issue.

This will need 3 steps :
- an entry in the EDID quirk table to disable SCDC and 420 for this monitor
- a fix in dw-hdmi to ignore this SCDC setup
- an investigation to find why and where the SoC did freeze

Rob, could you give the Commercial name of the display for the EDID quirk table ?

Thanks,

Neil


