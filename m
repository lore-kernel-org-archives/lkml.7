Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C654C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05A4218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VbT/KzUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCPOmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:42:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44386 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfCPOmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:42:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so12427312wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=CJUlkJDOJ1hL7l6oYVtamwToI2/atdgivGlg/bzyu8A=;
        b=VbT/KzUgYUsL4L9VJisEp2Q4k5zipxHYCTlfN0lSckJDemm2F5n5TRIxk6SP7dblHR
         dEY4GtqoYnosze/Y55WHm17gkeX70ti3oeLmpCg6U/H/dJAOsDjCfj7JbMlMMZyGkPFF
         i7SMD+SUaCVsZVSO/PLeflll6U347Id89hCdmKp/ApunkhV0YHcjzz7dcDkXKoThsIHb
         ohcbFHAGTkuHvupM1dnao7xyCzp2DaUDtd6JIQq2jQ97/zRCj76ZuoNYPaOlBVWwqlU4
         bWVdb5dqPr4p7oFGbuXyhQZHDJl+lZ6qxFmHLISYa16amQ8a9MtFDBQ9cQIgKfVqFlJt
         5+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=CJUlkJDOJ1hL7l6oYVtamwToI2/atdgivGlg/bzyu8A=;
        b=JdpMctlcAxaEE5aWZjG2WEfr1A/vyedAm4U5fPuQNfvRDcs1UkWYfUaRA/w/cbpeeR
         ZVIeTvt/EWweAGWiQH060JL9/NlySc7xbkmfTahQWK6XtAmlG4u0imersS017sUaqb5b
         GYX8DPOPlm/DUmMvPDvLVPsb7pdPWu140gNcXUKCqaDzNdy1y6KxkjRIlbeRop+ms3P2
         EP312LEk99MlxJyXQGB3b/nRuYLaU6DtaFCGhlBtnm7O+37I/efHMQ7dMGq9bPltnMlP
         cbzcc8x90jSAD42PYUzB+eg9vWhNRX9+V5u0QsoBdZZE9r0m2scnnTaeYeT4QtNbLkqJ
         3MPA==
X-Gm-Message-State: APjAAAVGWy2Z4QQSELO+KVUSut8yKpMwhJiX2efp/l1Fq/WB/jSeYfdk
        Pcqu478PQAHSm8Y2eFl+mCuwyg==
X-Google-Smtp-Source: APXvYqzuseoDAzIcxVKjEJJUkJAuA43Wpyy7J27ZIt7Tek3l7Lo5AwUT7+G5JFN21JOVC9kpf/UtdQ==
X-Received: by 2002:adf:dc4d:: with SMTP id m13mr6353436wrj.330.1552747351291;
        Sat, 16 Mar 2019 07:42:31 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id f7sm3841701wru.3.2019.03.16.07.42.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Mar 2019 07:42:30 -0700 (PDT)
Message-ID: <5C8D0B55.90200@baylibre.com>
Date:   Sat, 16 Mar 2019 15:42:29 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/11] arm64: dts: meson-g12a-x96-max: Enable BT Module
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-8-narmstrong@baylibre.com> <CAFBinCCbu54hvATKpQ+DxZ6g-FCJ_7Gty2v3HMWJWNFDbwwKwQ@mail.gmail.com>
In-Reply-To: <CAFBinCCbu54hvATKpQ+DxZ6g-FCJ_7Gty2v3HMWJWNFDbwwKwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/03/2019 22:48, Martin Blumenstingl a écrit :
> Hi Neil,
> 
> On Mon, Mar 11, 2019 at 10:57 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Enable the Bluetooth Module on the X96 Max Set-Top-Box.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> I didn't have time to test this yet but it looks sane to me, so:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>> index 21e5de48613e..61606601fb4f 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>> @@ -88,6 +88,18 @@
>>         };
>>  };
>>
>> +&uart_A {
>> +       status = "okay";
>> +       pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
>> +       pinctrl-names = "default";
>> +       uart-has-rtscts;
>> +
>> +       bluetooth {
>> +               compatible = "brcm,bcm43438-bt";
>> +               shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> you could add:
>   host-wakeup-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
> (at least according to the output of /sys/kernel/debug/gpio and the
> .dtb on my X96 Max)

Will add !

> 
> 
> Regards
> Martin
> 
