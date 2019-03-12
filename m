Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16252147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MVB27H+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfCLVPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:15:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42433 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfCLVPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:15:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id n74so2715880pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=xgREfe6VYhgvZSNFi6AtU15uCjA8bty6jN0rAL1RU+0=;
        b=MVB27H+zeXEwu/DhsDBGTXUoUhiiBS7TClAd41aNTwTBWv6o8k9uVKOK1GLoWiBClk
         7VmRipAmQ6bgKm7PotWJRpqUOXVUWdOtuCCFBr2gn4UX12qWQE6toC9aOPMDzeSZl4dE
         ufhSl0JVlzDJ3U5bBN0x+ji3rXqO+okBI2wM2U6b21okqJgOu49f00Niq47dBYUa/W91
         gA+X6etSafjNluKFEGdgw6waL2/QvYN3vtr97jq+s5uoeJGL16YbwixFGtQ4g9di/Ydk
         ufitDCGTFhFxznlpX+oNlzA1GVm1GDaRRwtCbnFtH89Rhrp0aWTWsZa1wDLSypRPEudM
         I/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xgREfe6VYhgvZSNFi6AtU15uCjA8bty6jN0rAL1RU+0=;
        b=SeP4ZE1fvKxm0DJFSBoIZdXl1IsA+wPkDO+O3JHQZ1iWFnmJKhRYze5iKBEnFRFZwJ
         y+g3roSsosbhp1dfIX43IgQ6pcSHancnKaAUnj4oLlpYNWPXPKoQr04WkWSFqU4y8EST
         4I6RBDW6elyQ039l/Zg6DBndzriJuxOnlfuyvPXOmd17DfU7NrnpWSVK8z1L14WMurOr
         LOYMk5EfpBG9TyjC0daDiWrLDnKgbazHkN9BVDCpxJo/7GJWpo7Z84FsWLRrlff3Ec8E
         FNXTHksfbgol2wFjxSwkk93gYrFt9GoyCqcLF/Pau8HRJMqFdr8THoGmvBVBHI/3B7xW
         VtgQ==
X-Gm-Message-State: APjAAAUsLhqNj6UVZU2+bd3WO3d/usjgJG/kVcvVommR28xNoslvULOQ
        AuKfI2oWh5tninrM8fhU3LMQPg==
X-Google-Smtp-Source: APXvYqzQAO+a0aGGXg3ufBju27TDB3RPu0Hbk7EqB73YliMbXittcdO8huOaB1f4CuYmUHu/vu4x2A==
X-Received: by 2002:a63:c804:: with SMTP id z4mr11389231pgg.228.1552425341054;
        Tue, 12 Mar 2019 14:15:41 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:1daf:3f96:9f7f:33ba])
        by smtp.googlemail.com with ESMTPSA id f4sm12146957pgq.94.2019.03.12.14.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 14:15:40 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] arm64: dts: meson: g12a: add uart_ao_a pinctrl
In-Reply-To: <244fba9a-31ab-a75c-3de2-a66638a9d36d@baylibre.com>
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-5-narmstrong@baylibre.com> <244fba9a-31ab-a75c-3de2-a66638a9d36d@baylibre.com>
Date:   Tue, 12 Mar 2019 14:15:39 -0700
Message-ID: <7h36nru744.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 07/03/2019 16:13, Neil Armstrong wrote:
>> From: Jerome Brunet <jbrunet@baylibre.com>
>> 
>> Add the always on UART pinctrl setting to the g12a soc DT and
>> use it for the u200 reference design
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../arm64/boot/dts/amlogic/meson-g12a-u200.dts |  2 ++
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi    | 18 ++++++++++++++++++
>>  2 files changed, 20 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> index c44dbdddf2cf..f2afd0bf3e28 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> @@ -25,5 +25,7 @@
>>  
>>  &uart_AO {
>>  	status = "okay";
>> +	pinctrl-0 = <&uart_ao_a_pins>;
>> +	pinctrl-names = "default";
>>  };
>>  
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> index c141cc7f6b09..f8f055c49f9a 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> @@ -177,6 +177,24 @@
>>  						#gpio-cells = <2>;
>>  						gpio-ranges = <&ao_pinctrl 0 0 15>;
>>  					};
>> +
>> +					uart_ao_a_pins: uart_a_ao {
>> +						mux {
>> +							groups = "uart_ao_a_tx",
>> +								 "uart_ao_a_rx";
>> +							function = "uart_ao_a";
>> +							bias-disable;
>> +						};
>> +					};
>> +
>> +					uart_ao_a_cts_rts_pins: uart_ao_a_cts_rts {
>> +						mux {
>> +							groups = "uart_ao_a_cts",
>> +								 "uart_ao_a_rts";
>> +							function = "uart_ao_a";
>> +							bias-disable;
>> +						};
>> +					};
>>  				};
>>  			};
>>  
>> 
>
> Will move this out of this patchset to the boards patchset

I assume you meant you'd move the first hunk, the one that modifies the
u200 board to the other series, but keep this hunk in this series?

Kevin

