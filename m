Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B5AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934CE21900
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T2sBBrDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCPO0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:26:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35092 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfCPO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:26:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so6477341wrp.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=ltoa3Upv+P0qAZWyzwpPOOef5iHNrRysFUSATTIsPTM=;
        b=T2sBBrDzk53ESyl8fhj407/QWiHF7+tN1dVMh0+MPfSGoiMNG0Bt3N7B4/DJtcZ5SO
         VccBV6ZafHkTfQqMtFCte6RAua4W2GZ82viM8nJ1XedAqeL33iA2xJEEQ1iGKdBtfwAh
         LMrlmsCPoL79i6/8IEWyVbe70zBPtR82v4ieE7ArYUngICuOMRJb+IWJR/XA3UfJv+wf
         iyzrGkNGLHrlmKvbSv4iXW5znBnsHSSVw/UxEVDEjKiHwGoHSLp2/J77r15iBsliF5Ad
         Th/ktG9ohJxQctdHYvRX9mryJplLY7Yy9MwdpWHi1HfL7hYYbY6vJmxxckAR4DP0IrIe
         Fysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=ltoa3Upv+P0qAZWyzwpPOOef5iHNrRysFUSATTIsPTM=;
        b=jp8IHYHQg8zzbQ/VhhB1yZHCKbAy62UyS0EOsxPo0xKWub0h4+/MAS9hXG632/YQNZ
         T7F5sQ1t5nrictDDJ8FHTXYRfsocdQ9E4BiIIxF/ZQ2jhlsdXOW6wHfINq3Bxn1Atzls
         ljS+7t8JvtVSTYPD0J6fx3Wo0WJTken1En8Wio/a2Jlv21xku1YVdFChv8YUMG5aLjij
         /TiwOJaZ8ODdH+P8l7854ytreF0T29OKDU27sUQmqcM5vIfzxAyxy4I1BXWNg18Cgo98
         D35BsQ/JE6g2YtqLw6QMmxdLU/Bc5IEKD+oclv57ycc/jqGW/9UoiNQOHngLlzm8sFnz
         K5fA==
X-Gm-Message-State: APjAAAXQfybCg7mCEXMPr835R1Gm6d2Azgj/OlQErWYB0GhdixER67qQ
        te+4/7c1X21c75FAGS3t84teHw==
X-Google-Smtp-Source: APXvYqxJyd8JDPQX+cmqgIRxJ2EMiZxWvPTWmtR8krzWrbe90k4wG5XmLH33lAwo/lo9BfLuF8jS7Q==
X-Received: by 2002:adf:cd87:: with SMTP id q7mr6434159wrj.92.1552746397157;
        Sat, 16 Mar 2019 07:26:37 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id e5sm2922034wrh.71.2019.03.16.07.26.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Mar 2019 07:26:36 -0700 (PDT)
Message-ID: <5C8D079B.5020803@baylibre.com>
Date:   Sat, 16 Mar 2019 15:26:35 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/9] arm64: dts: meson: g12a: Add AO Clock + Reset Controller
 support
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-2-narmstrong@baylibre.com> <CAFBinCCF81Af=5F19NT337Tfx+oQzx7-zFu2063z7wSfU3qfjQ@mail.gmail.com>
In-Reply-To: <CAFBinCCF81Af=5F19NT337Tfx+oQzx7-zFu2063z7wSfU3qfjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 15/03/2019 22:07, Martin Blumenstingl a écrit :
> Hi Neil,
> 
> On Thu, Mar 7, 2019 at 4:14 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add nodes and properties for the AO Clocks and Resets.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> index 191d31db9853..0eb5220da82c 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> @@ -122,6 +122,23 @@
>>                         #size-cells = <2>;
>>                         ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
>>
>> +                       rti: sys-ctrl@0 {
>> +                               compatible = "amlogic,meson-gx-ao-sysctrl",
>> +                                            "simple-mfd", "syscon";
>> +                               reg = <0x0 0x0 0x0 0x1000>;
>> +                               #address-cells = <2>;
>> +                               #size-cells = <2>;
>> +                               ranges = <0x0 0x0 0x0 0x0 0x0 0x1000>;
> is this supposed to be 0x1000 (GX uses 0x100 here)?
> my understanding is that G12A has the AO CEC at aobus + 0x100, so
> using a size of 0x1000 would make it overlap


Hmm, Let me check

Neil

> 
> 
> Regards
> Martin
> 
