Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C92421903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HShqtnHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCPOk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:40:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36989 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:40:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15so12460609wro.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=kZtPyGv3piHGTEPU4vYi+v8Hf0ZG/pFYCfiuoXCBihw=;
        b=HShqtnHbGuCCgCo1puPdNXB8SXviGvSVKIfiLn/yuO9Q6hv/33Opfgf+WQ9vSp9gQL
         FzpyV4X8k3sKIgL1HRNiYdMGxOluEhfDI5d9JIJwCz946vaV56RH/fprWKH/a9oZ9mE2
         WfAs4CUVzgKsUOKPHe1NHe04t1dJH8ym66NIRoat6XmFcMrlfWM//ivDpHig8OjOIC8r
         mBt5bP+ezFPRImnDOH9U8hI2WzcxeesSFieWsLOK+G/yy8ACqhfoLUwOXZnSGd2LhoY0
         STKbogJiHoxj7uOg3DDJYKYI4yEhY/tGv/PU0dMGU5ErDE/u7k781OlEZk1JbFaQyRC4
         2/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=kZtPyGv3piHGTEPU4vYi+v8Hf0ZG/pFYCfiuoXCBihw=;
        b=JmonWw+N5H11zdYf1cHYCSYhpAmqSnUpRcNWFPp7fcIPvzInWv54WlFqG5A6AzncM7
         lLlz4C7pR0cyTQ7ar2FEWbnQSnGv6mzQT6ZzHYQkxhGXkxZJxJc575BFXc8c/hp0/eYK
         cxI9LZG6ZFEsgmBIEZirA+XigvotbVQr3lBlg4J8XcLQq4OzLAvM+OFJUEmal62FYJNW
         ZKsHm4btpCTYt1oTCpVc/KQcTq/y9IAC8jv3nvTWZNJ8M1SBIIoonG2DMbMSonWJUmP6
         +Run3Cw7Upo8jQRfAailqgrTSHGcUDTyn3LZhbovN5baH7uyK6HPXu7D3LCCNuiRJSLQ
         i/UQ==
X-Gm-Message-State: APjAAAVOg83sDUU+g88GvkNQW8CSlcDais5cFdgtpuAbeYnGN1WB4nqW
        4GojtoayAeMa/0RRXC+OPOMTCA==
X-Google-Smtp-Source: APXvYqyRHd8f8YmeeSJEpz5UzV8ASz+zBVO0fsnhCoYAu4liDXxG4fdTvxZHzkJUs/BT7SWuQ7ecgw==
X-Received: by 2002:a5d:6252:: with SMTP id m18mr5795078wrv.199.1552747254481;
        Sat, 16 Mar 2019 07:40:54 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id z12sm4388781wrt.10.2019.03.16.07.40.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Mar 2019 07:40:53 -0700 (PDT)
Message-ID: <5C8D0AF5.5040101@baylibre.com>
Date:   Sat, 16 Mar 2019 15:40:53 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 04/11] arm64: dts: meson-g12a-u200: add regulators
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-5-narmstrong@baylibre.com> <CAFBinCCiV21kB38SXqVYMmQ5YkK2MxXKhiTJrVP3jOCLDtuBBg@mail.gmail.com>
In-Reply-To: <CAFBinCCiV21kB38SXqVYMmQ5YkK2MxXKhiTJrVP3jOCLDtuBBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

Le 15/03/2019 23:01, Martin Blumenstingl a écrit :
> Hi Neil,
> 
> On Mon, Mar 11, 2019 at 10:57 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> From: Jerome Brunet <jbrunet@baylibre.com>
>>
>> Add system regulators for the S905D2 U200 reference design.
> I find the hint in the meson-g12a-sei510 regulators patch very good:
>   Still missing
>   * VDD_EE (0.8V - PWM controlled)
>   * VDD_CPU(PWM controlled)
>   * VDDQ1_5

I will add the same comment here

> 
> VDD_EE and VDD_CPU are *probably* going to be very similar across all
> boards (Meson8b uses two slightly different PWM regulators on all
> boards supported by mainline, but the basic concept is always the
> same)

Not necessarily, it can change, it used to change across GXBB boards, but
seems to be more coherent across GXL/GXM/G12A ref designs and derivative
boards, but it can still change if the HW designer decides to be creative !

> I'm not sure if VDDQ1_5 is specific to the SEI510 board though.

I think VDDQ1_5 is specific to SEI510, will check on the schematics

> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../boot/dts/amlogic/meson-g12a-u200.dts      | 79 +++++++++++++++++++
>>  1 file changed, 79 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> index f2afd0bf3e28..17696f356ff2 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> @@ -14,13 +14,92 @@
>>         aliases {
>>                 serial0 = &uart_AO;
>>         };
>> +
>>         chosen {
>>                 stdout-path = "serial0:115200n8";
>>         };
>> +
>>         memory@0 {
>>                 device_type = "memory";
>>                 reg = <0x0 0x0 0x0 0x40000000>;
>>         };
> there are two unrelated whitespace changes above.
> please clean them up if you have to re-send this for whatever reason

Yep, will cleanup

> 
> 
> Regards
> Martin
> 
