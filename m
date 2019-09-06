Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D4C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E478218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HjBx0MkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbfIFIre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:47:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40753 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388846AbfIFIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:47:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so5663175wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CfSPQ11gyL7LqqJg+RfxL7pUmtUK1NuleIgsu8AI50g=;
        b=HjBx0MkBebOyrjQ51slXLTQOOyqLUMka35p52q5dCPEkOoeD78IHBI/Z9AEP4+vIcn
         OKBCX5MjwA0GrX2TYkMksZqvUEugNCv1NXQ/JTaxgrnUROcRsv0B8q/knrOWVg36nk5t
         rRVrQSgEggtShsP10h9DIhud+PuQ9d6gytfJ6ETRD8ZfsBnWDu15NZwVBLFk7U8etroK
         y0RLEA6oDQGlxCqHF7iU5DzO6Xnh8b5QT7P4XG7MpEEXNxiahCeuH1viypdP7zyyVrDJ
         os8CGeBSYPLOEilqK7Y3jAQ1lBuiGHKlx6/PHUtTReUrz2v2QtJPp8cHX3HOzoLCxcC/
         +jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CfSPQ11gyL7LqqJg+RfxL7pUmtUK1NuleIgsu8AI50g=;
        b=ZyaSIfkd9EkYoG2vkC47PW80dV3b7j87cEbQqDYYEgwfKDNQAEAL9V1jFZEf2yMG1B
         68UBYKqCTQ9cu9xASpz/hXMu//KOP6mK3ASAubXyNTHDoXpTzn0lf+AZRC63AcjzDAQx
         4axxzApHvR2flbzUnUhOznrI8yYnJDKGIccv6rr9+y+oDCt29dKJlAp2sCc6dLi42F4f
         rNzRUIR9CBMvmt6LN5VhZMTpkwYhLsP0C3jCgl2O73bVYHZCgEI3Ysq5r67c0qDV71eh
         rrwsCTR0n1YK+SoyfqPqMZDCEbiWtXl5m3Xm0Mwd2SlQ8lB7JARJHlMcvETxNV7Yll78
         VE2A==
X-Gm-Message-State: APjAAAXx8lP7WbU+569liPiVE5KjNdsxP3Bxx5QHG66U/Q2xeiL5G7m3
        YZOHm9UUn8DEXUvf2LpXqAu2+g==
X-Google-Smtp-Source: APXvYqzgyU/+indOnTNrg+U/5WDAdwju1MgsP1cT9PecaBiEJfZB6rRcN63enCexjtj7BJZDawOwAQ==
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr4964942wrp.143.1567759652033;
        Fri, 06 Sep 2019 01:47:32 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n1sm6222078wrg.67.2019.09.06.01.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 01:47:31 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: sm1: set gpio interrupt controller compatible
In-Reply-To: <7hpnkeqxxy.fsf@baylibre.com>
References: <20190902160334.14321-1-jbrunet@baylibre.com> <7hpnkeqxxy.fsf@baylibre.com>
Date:   Fri, 06 Sep 2019 10:47:30 +0200
Message-ID: <1jmufh3j6l.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 Sep 2019 at 13:40, Kevin Hilman <khilman@baylibre.com> wrote:

> Jerome Brunet <jbrunet@baylibre.com> writes:
>
>> Set the appropriate gpio interrupt controller compatible for the
>> sm1 SoC family. This newer version of the controller can now
>> trig irq on both edge of the input signal
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>
> Queued.
>
> I may do a late round for the dev cycle of v5.4, otherwise this will go
> for v5.5.

No problem

> If it goes for v5.5, it should probably have a Fixes tag, no?

Maybe, but then every change to meson-sm1.dtsi would be some kind of fix
on what is provided by meson-g12-common.dtsi.

Not sure this really qualify as a fix but I'll do as you prefer, just
let me know


>
> Kevin
>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> index 521573f3a5ba..6152e928aef2 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> @@ -134,6 +134,11 @@
>>  	power-domains = <&pwrc PWRC_SM1_ETH_ID>;
>>  };
>>  
>> +&gpio_intc {
>> +	compatible = "amlogic,meson-sm1-gpio-intc",
>> +		     "amlogic,meson-gpio-intc";
>> +};
>> +
>>  &pwrc {
>>  	compatible = "amlogic,meson-sm1-pwrc";
>>  };
>> -- 
>> 2.21.0
