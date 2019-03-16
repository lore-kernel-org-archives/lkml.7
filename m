Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28996218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h9uX+Bdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfCPOcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:32:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54521 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfCPOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:32:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so9172836wmj.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=uM5tAop2OPme9hYP9yOk1ThL7VG9jv/gw/8ehbY3v+0=;
        b=h9uX+BdxjoBkxFziaWqySYh6fRZsJlA852PPY82irYq7hzjQnIyK9wWa+Qj2krbUa+
         HZ4lTCsBaSFRUdZYj8LUArrvAVMEgIEjWnwJWsXiWUMFlSg8H3qZHQhfrpddO8kzpGWn
         poh/6KjTH2rQEFJguqhkvQLSDQWt3sBda14JdIJPOS/cQI6fIe1YadTf4MaiiUuWAcRf
         9CQbJ/ZRZ/bD7f+rwtXe1mXKfBJE7alzAm4nChIL9UEvSK4mT7V0bkFBRiETMWJ+racq
         P+GhBSIB52rHENgQv7bSpizHjLF8gOAORk2MnkAfB4Vu8DOO4jSR6VcPoiT4fQJheJOq
         lncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=uM5tAop2OPme9hYP9yOk1ThL7VG9jv/gw/8ehbY3v+0=;
        b=GE8f5ODub+7Umb1iGTTMVa8WD2iMAi8HIq9Fd+xQYH9rFbCBc3RDNFKhug9u3Rp0L+
         WYVHmp0KRdgNLzAbqU+DJfjqLkFxSsuilhxjN6PQl3/2Tvq4z5RPHREKNCuRpWanvfBL
         Q2wsYoM/o+YhSJwshE1i9NuouGn5MADTKWYYJaw39zkPkWk48+i0cs5tz3uQZV+UiXBO
         I46MHdA27dTw6UVl8k8xUPqUVT5y/GMnGFciKdhyAiOuK+AutosY2JAgaLQVcZeV2k7V
         h5qGt86HiglvukTxyJZ9ZGTfx6MLgwp4AT5dF9MWx90iJCVhN05VLG975ILXchUQfhT0
         +i8Q==
X-Gm-Message-State: APjAAAWwQP8H38jIXmUNyNRdvVpWHwZFmu9sf9Pg+bDa9qWbMJBi3/11
        kKBgUf9CuAX5f0Ahv40xNhgDSA==
X-Google-Smtp-Source: APXvYqwugntDU0EKeDzg2jT28P8NnpFuKq84eqFRZtXH3UBU07CUE71aHZrqRywZIttnXkpvk3AVqA==
X-Received: by 2002:a1c:7a1a:: with SMTP id v26mr5261549wmc.129.1552746719636;
        Sat, 16 Mar 2019 07:31:59 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id f10sm3245827wml.23.2019.03.16.07.31.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Mar 2019 07:31:58 -0700 (PDT)
Message-ID: <5C8D08DE.7070203@baylibre.com>
Date:   Sat, 16 Mar 2019 15:31:58 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] arm64: dts: meson: g12a: add reset controller
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-6-narmstrong@baylibre.com> <CAFBinCBt290Qabw98SpiON3xG0ihMEDNzwDDTrBo6QYbA5QjMQ@mail.gmail.com>
In-Reply-To: <CAFBinCBt290Qabw98SpiON3xG0ihMEDNzwDDTrBo6QYbA5QjMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/03/2019 22:31, Martin Blumenstingl a écrit :
> Hi Neil and Jerome,
> 
> On Thu, Mar 7, 2019 at 4:14 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> From: Jerome Brunet <jbrunet@baylibre.com>
>>
>> Add the reset controller device of g12a SoC family
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> index f8f055c49f9a..2a700bb45d04 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> @@ -245,6 +245,13 @@
>>                         #size-cells = <2>;
>>                         ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
>>
>> +                       reset: reset-controller@1004 {
>> +                               compatible = "amlogic,meson-g12a-reset",
>> +                                            "amlogic,meson-axg-reset";
>> +                               reg = <0x0 0x1004 0x0 0x9c>;
>> +                               #reset-cells = <1>;
>> +                       };
> I tried to compare this with what is publicly available in
> buildroot_openlinux_kernel_4.9_fbdev_20180706 - unfortunately this is
> harder than I thought:
> the buildroot kernel doesn't define the reset controller in mesong12a.dtsi
> 
> so I tried to follow the code in the HDMITX driver instead:
> kernel/aml-4.9/drivers/amlogic/media/vout/hdmitx/hdmi_tx_20/hw/hw_txlx.c
> uses P_RESET0_REGISTER and P_RESET2_REGISTER
> these are defined in
> kernel/aml-4.9/drivers/amlogic/media/vout/hdmitx/hdmi_tx_20/hw/txlx_reg.h
> using:
>> #define RESET_CBUS_REG_IDX 5
>> #define BASE_REG_OFFSET 24
>> #define RESET_CBUS_REG_ADDR(reg) \
>>    ((RESET_CBUS_REG_IDX << BASE_REG_OFFSET) + (reg << 2))
>>
>> #define RESET0_REGISTER 0x01
>> #define P_RESET0_REGISTER RESET_CBUS_REG_ADDR(RESET0_REGISTER)
> 
> when I do the maths:
> (5 << 24) + (0x01 << 2) = 0x5000004
> 
> The GX SoCs have the reset controller at cbus + 0x4404
> however, the offset may have changed in G12A because the SAR ADC
> offset also changed (just one example).
> 
> Do you have any hint how to verify the CBUS offset (0x1004) of the
> reset controller?

You can find base the address found in the G12A DT for the usb2 phy :
https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/arch/arm64/boot/dts/amlogic/mesong12a.dtsi#L379

Neil

> 
> 
> Regards
> Martin
> 
