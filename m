Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867A4C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BADB20856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UXoszbvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfEVIT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:19:26 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46488 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfEVITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:19:24 -0400
Received: by mail-wr1-f44.google.com with SMTP id r7so1163042wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rUpKlEA8tIPKK8DZFrMHr5Vjc8RluFtQBZi76sNv0Nw=;
        b=UXoszbvJM03D2fO8JaH10+Y2L1hYJRwOOpnoH1N5Zi66NdpPRff2wG1w6iCox+3s+/
         IHe8Nj3QpK/ykyafi4FxPJw0jBc/Bg2WGHg3/2HYKHM5BGwjDTThynsITGnOjNfDKgcx
         foyYTga5Gnbq7bpry9cAOQM6xKRWEbMliuTFCiBZD/H81KRPPyV3HI3IyNoGzKNrSINW
         dLhH+pPyBYR3r3hhy2jHkxy1HhSQnjH8Ex0FgYAfmYl/HECfK0atOc2m1ult4PrZEQPt
         TW6DS62Q9wNgJSvQqJ8WgCUP2z4d2tq5S4zGfWprBbjfAI2rbVPGeLnXXuPbAANohttM
         vYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rUpKlEA8tIPKK8DZFrMHr5Vjc8RluFtQBZi76sNv0Nw=;
        b=aNlcmu5WVk+cwDtclN4AIfdOATj8T7beH/EKCNtRqi4/qn7OWwwdlZu+oL+R0VysRH
         uN37NHMO4fuBnabOWxN/u5uJcVpnm4RI1nh5Cv4lDNqKqap2vZJu5ErX0iQtG+jKWAZn
         g14bmtCN6dMbgRdAnxIuMA4IEFHgDXVlrXbxe1RsCKw4xXftWh/mr+ioXkvLQY/MrZUX
         XpFDtrMUp5eyR7ftN4siXphj6xtVogZzOnA4NHhWSSuHBfhEKkJ8UI1/RsQYlJSKZ8xk
         mO6USAp8xlUm19cABnic/zgI3zfhW6Tfygy0cFh3bZlhO4gmrA165dvMr1694f+lRvwR
         1MzQ==
X-Gm-Message-State: APjAAAU78NDc3BCtSJbBUtjEu9ASapVK2BTlHKS3KfG577H//Vn++eQD
        vU5wcjojZJnRMEIfm33+2EuU8A==
X-Google-Smtp-Source: APXvYqzZ6kcXy3QXJ6HHUvi4u9okO0GxA5BtrwhIImIvuySrgAeQodOTKF1Zc0E9Uk6blNHWCB/nGA==
X-Received: by 2002:adf:dccf:: with SMTP id x15mr7656464wrm.139.1558513161988;
        Wed, 22 May 2019 01:19:21 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id n2sm1933129wro.13.2019.05.22.01.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 01:19:21 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] arm64: dts: meson: Add minimal support for
 Odroid-N2
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190521151952.2779-1-narmstrong@baylibre.com>
 <20190521151952.2779-4-narmstrong@baylibre.com>
 <CAFBinCDzvroNfzhZHhDdvc+VR1eQNg5JMJ7F9=++hdWKcEXSOw@mail.gmail.com>
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
Message-ID: <f7020818-5824-f998-6ebd-303014abd34d@baylibre.com>
Date:   Wed, 22 May 2019 10:19:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCDzvroNfzhZHhDdvc+VR1eQNg5JMJ7F9=++hdWKcEXSOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 20:01, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, May 21, 2019 at 5:20 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> +       hub_5v: regulator-hub_5v {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "HUB_5V";
>> +               regulator-min-microvolt = <5000000>;
>> +               regulator-max-microvolt = <5000000>;
>> +               vin-supply = <&vcc_5v>;
>> +
>> +               gpio = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
> I missed this in the review of v1:
> according to the schematics GPIOH_5 is routed to GL3523 (soldered down
> USB hub) CHIP_EN signal.
> The datasheet [0] mentions that this will "Disable whole chip and keep
> hub in lowest power state (standby mode)"

In the v1, we didn't have the schematics, so it was all a wild guess.

> 
> do you know if this is a similar case as GPIOH_4 (USB hub reset line,
> we configure this using a gpio-hog)?


We have 3 signals for USB :
- GPIOH_5: goes to CHIP_EN to CHIPENABLE to the Hub
- GPIOH_4: goes to RST_N to RESETJ to the Hub
- GPIOH_6: goes to PWREN for the OTG connector PWREN

As you said, the datasheet mentions : "
Disable whole chip and keep hub in lowest power state (standby mode
"

I modeled it as a regulator since when enabled it actually enables the
power on the USB3 ports using the post-Hub VBUSCTRL signal.

Since I can't model these post-hub power enable signals, I can only
model the hub CHIPENABLE as a regulator to handle power.
I can't model the hub as a device subnode inside the dwc3 since
when CHIPENABLE is low, it won't appear...

We could model it as a Hog, but we won't be able to power down
the usb3 ports.

> 
> [...]
>> +&ext_mdio {
>> +       external_phy: ethernet-phy@0 {
>> +               /* Realtek RTL8211F (0x001cc916) */
>> +               reg = <0>;
>> +               max-speed = <1000>;
>> +               eee-broken-1000t;
> are we in the same situation that we have on the X96 Max where network
> dies without eee-broken-1000t?

I assume, let me run more tests to be sure.

> 
> [...]
>> +&usb2_phy0 {
>> +       phy-supply = <&usb_pwr_en>;
> is usb_pwr_en really the phy-supply or is it the vbus-supply of the
> USB top control block (&usb node)?
You're right, now we have the schematics, it's not the phy supply.

I'll move it to vbus-supply since it's connected to the pwrenable
of the otg port.

> 
> if these three questions are answered then you can add my:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I'll ask you to review the next version before !!!

Thanks.
Neil

> 
> 
> Regards
> Martin
> 
> 
> [0] https://datasheet.lcsc.com/szlcsc/GL3523-OV3S1_C157363.pdf
> 

