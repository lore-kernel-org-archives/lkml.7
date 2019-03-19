Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E004C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147972075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bu0tP29A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfCSI3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:29:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35529 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:29:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id f8so806751wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ctJZHSds0hf4vzWO8bdqiZY60BC3vzw8UB+A+5HMctw=;
        b=bu0tP29AS/2YT1h8+qCXzsmm0O9gio1tAJPzgFsZst3ebeckplW2KLTrNsV0bBebB0
         m/UPCDB1Q0ZpXNpKoDrYGHs+FpWk3CY2PN+8OFGKNB6wFezNDIoQdIfacKfkJxGwWZnh
         ydyR7z7HUvDVVRlyJQ9tQEohLMlPPjZAz9gcM9z+VzfbNvCyvMU86hCWAnKc+z2b9LHu
         0YGXzYst/xye5DgJ+pWUffb05/ExPXykmyiIn6Bl75TiaGc89zqzftsglKWycopuvu9g
         6Y5t8FjLSIHRWK0C9PIu0XKSC8XGzdR1XAwjyx2tThI+FNYytO7NoY+9KgYMxxdZJvuZ
         YiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ctJZHSds0hf4vzWO8bdqiZY60BC3vzw8UB+A+5HMctw=;
        b=oKv+bZ32PiQnM8Cw+6iWHL2hk+2ADr1OpYH7ZO4o9+m6W6+aq51EGS6cpfSLWoFr5Q
         3Ka1P7XFJp4TZxluMKKUea4O6ytV3ASqj+Zofk/1Mqs0cDCtMdrhlQcU6ryygbUpF0c8
         jsk05LRA9UptPY/cNj5gUopPAEmVBqExS9kkdN4GzOEsEP/VYoj1nfV4N6NUu5T/alGe
         8yL6XKeT1y8UU5axaYMvmFiHUQ1fhWa4ADPf6px+anEpkzaX47FGhmp40zrfFMX3MeJC
         Ore0lRW9oqGaxb0yo8OEoW44VK3Uo0MLouNerw/+EbUxNW+nNraSiur2ImbiMSqvhssu
         v1ZQ==
X-Gm-Message-State: APjAAAX+GVXV+uA/CEIbvuUxcmN4sUG+Zf9VFL0Ve7Ij9sgESyAkCNJ1
        8szzz19bjU8bU8Tds2kVECqM6Q==
X-Google-Smtp-Source: APXvYqxEnweyymg82jk1eHa+OC+OD8j+/BNpUmOYH6SFr8CKLp1PmqywCvgKfC4Qg3cMBQGzHIE+KQ==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr2364498wmc.63.1552984144606;
        Tue, 19 Mar 2019 01:29:04 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id b134sm3865654wmd.26.2019.03.19.01.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 01:29:04 -0700 (PDT)
Subject: Re: [PATCH v2 06/11] arm64: dts: meson-g12a-x96-max: add regulators
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190318100458.5619-1-narmstrong@baylibre.com>
 <20190318100458.5619-7-narmstrong@baylibre.com>
 <CAFBinCCSKh145--5EAPQyJjbuefRgWm57G+05so28-WiZjqNYg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <c13bc57b-82ea-8f48-75a7-417941b08a11@baylibre.com>
Date:   Tue, 19 Mar 2019 09:29:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCCSKh145--5EAPQyJjbuefRgWm57G+05so28-WiZjqNYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2019 21:13, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, Mar 18, 2019 at 11:06 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> From: Guillaume La Roque <glaroque@baylibre.com>
>>
>> Add system regulators for the X96 Max Set-Top-Box.
>>
>> Still missing
>> * VDD_EE (0.8V - PWM controlled)
>> * VDD_CPU (PWM controlled)
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 67 +++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>> index 0edbd00b358f..5c37930b09e2 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> [...]
>> +       vcc_5v: regulator-vcc_5v {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "VCC_5V";
>> +               regulator-min-microvolt = <5000000>;
>> +               regulator-max-microvolt = <5000000>;
>> +               vin-supply = <&dc_in>;
>> +
>> +               gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
>> +               enable-active-high;
> is there any way to test whether this GPIO is the right one?
> I couldn't find a reference to a GPIOH_8 regulator in
> buildroot_openlinux_kernel_4.9_fbdev_20180706

The x96 is based on the U212 reference design, and the GPIOH_8 controls the 5V_EN signal,
but you are right, it's the wrong polarity here, it should be enable-active-low instead.
(FYI The SEI510 does not use this at all, 5V is always enabled)

The schematics describes :
VCC5V_EN (GPIOH_8-Hiz OD): 5V_EN
L: Enable
Hiz: Disable

FYI, the GPIOH_8 is Open-Drain only, this means this pin cannot pull to TTL 1, only to TTL 0
or set as input. We need to add a way to describe this in the pinctrl driver somehow....

I will send a fix on v3

I didn't notice because I power the board using a Type-A to Type-A connector,
and the 5V from the USB port bypasses this regulator...

Neil

> 
> 
> Regards
> Martin
> 

