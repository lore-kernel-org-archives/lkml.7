Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844B2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DF820820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hJcc17Pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443006AbfJRSRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:17:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39574 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390705AbfJRSRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:17:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so3222555plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=v9YW7BHNgsQ/SyyPbXQbYasZCLbj5buK6hp2Stw/kRY=;
        b=hJcc17Pd04cJA9HC+GwMAMjYVUY11jji7LMtJg0uX3pJdY5BbI2BFW0vbvi+yrWNz2
         8nDsrbt4SefCcegWAfhpV1uSHk8BJ9PXRXnyjzPdYtazh1O5lcgZhGE6zCb2lJOfdree
         xXRnqRdH7uKj9Pms/4+rIb+CNct97IEgJLAe2neoEwUUc0VcAdAotoXBAS0q7OW67pCV
         N2ARLR1P9E732WCxfon75MUVThi+EwBib+mU6HGk1+FNlVkb9cS5GbchqGqmQGfTYyMp
         mnI9CNShj6oOspxWy0WylGQJg99plx0jN7qJz+d+UeHSh6+NnqGdqu9qgxYjVnswNoBE
         wy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=v9YW7BHNgsQ/SyyPbXQbYasZCLbj5buK6hp2Stw/kRY=;
        b=Hnh0VVrzJgxYeYQTNwRulqrocrghK1zCZM7mhxS1njGPfTxEmVzmPKnRD6b5qPT6tf
         1idjCcmOiXS70NVHXsXabSV1FcjhlFYjUQmjnuE4VUPcvO9BiFN4cSgALMWU+96YyIPv
         CzlzRf+1x6sL9dLupwEaHO7aFULpYkyM31J5kOaANhbS+HcyhYzE7NUf8DczIwMUJ6y8
         kcrXzPNznt1Onn+y6k2IMSMuy/aqfqeUVVBgq4lQo51ggNrrj6wMrrSKbJ7hdMaizMzp
         u4t99PYt7vlXpTPSGmvc+Qr+c3A+vIlAX5Niz0jr1u+xp68KgrVmLxH08YSNtbuN+SvC
         pdew==
X-Gm-Message-State: APjAAAU5I6yuqoK9Uke58pnd6x3qFChNrV6mILhFcbaXM8QTE6uklb5s
        Yfi/7mAawE+kj24Q6gNWm8NE/w==
X-Google-Smtp-Source: APXvYqwAW1evszJK3zfKVU5qC+kUrzT5nkGmV8rakyUXPWbliiBzm+rVT0a7YhJdlz/GJxIQ+EvtqA==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8mr11523945plp.129.1571422651552;
        Fri, 18 Oct 2019 11:17:31 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:4083:538b:22e5:c2ac])
        by smtp.gmail.com with ESMTPSA id h8sm7654640pfo.64.2019.10.18.11.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 11:17:31 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, christianshewitt@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson-g12b-khadas-vim3: add missing frddr_a status property
In-Reply-To: <1jbluef2sd.fsf@starbuckisacylon.baylibre.com>
References: <20191018140216.4257-1-narmstrong@baylibre.com> <1jbluef2sd.fsf@starbuckisacylon.baylibre.com>
Date:   Fri, 18 Oct 2019 11:17:30 -0700
Message-ID: <7hbludc405.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Fri 18 Oct 2019 at 16:02, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
>> In the process of moving the VIM3 audio nodes to a G12B specific dtsi
>> for enabling the SM1 based VIM3L, the frddr_a status = "okay" property
>> got dropped.
>> This re-enables the frddr_a node to fix audio support.
>>
>> Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
>> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
>> index 554863429aa6..e2094575f528 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
>> @@ -152,6 +152,10 @@
>>  	clock-latency = <50000>;
>>  };
>>  
>> +&frddr_a {
>> +	status = "okay";
>> +};
>> +
>>  &frddr_b {
>>  	status = "okay";
>>  };
>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>

Queued as a fix for v5.4-rc,

Thanks,

Kevin
