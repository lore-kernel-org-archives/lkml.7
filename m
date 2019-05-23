Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3B5C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D4921773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ggWF1rOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfEWQOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:14:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41602 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfEWQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:13:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so3497870pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=aRONL6lUSP8ySgexr3N6TwqdyB5aYrx+k7X7nWH0u7g=;
        b=ggWF1rOFU/L+bItrGYOrJMFIMeJBMy1WrRcSsr/WIBe/SB8eNQTLknryHkreR5tByW
         lsdj3s7N2iF3ZDqzrgDKd43KkU+Pp7q9FmJ1bkqWQFr8iPV8+Yz+spKDbDMSLJFvjANm
         clswCgsoDvvQhg0gmadmjdbo1953N4JsWXfxRagJfIxprFe+KcKANt6T8950sS7EYiZB
         0KN8NFVK5S8mFMZJogjBrFskvYWQGNqp3MpQS98Ba1ppmifq1k3Vu0iGVIUan9sHb2fv
         DeS79O4YsObFSplomEdYGoLwhlj0RUtaf3oCSV81fgKrm2gTW8VqIGBn6z+BWYOlPneP
         7YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aRONL6lUSP8ySgexr3N6TwqdyB5aYrx+k7X7nWH0u7g=;
        b=Ex+gWulTurFg3ft4gecIL2ZOI/mYXj36iJUz++gjSFqWKMKAHvU7Q+K4nbglaO5hAR
         gOs0emb3/DwDWEU18ieUDl/lUNN3i76S31eRwOdZMofubikpqg5R+BPL7sdHVnYDpfBe
         W1pRoAPWwNWRlGnRwuYQon4Rys6T0FbtBumg6e2D/AVUGywI7q3/l8/b2x6nkdH/qVEh
         CO5FYOHG5w5S36uEj6waByenUzU+iWh2+cHMAzsWExL6leAwJrk7noKZinpt56vgxkDV
         ESOvmxjMFoHWGLWJ17jwLa0GijhZzMLxDE6Al/7VatWDbFZL8E6IRSOkpPgB6puZ1GNw
         KXQw==
X-Gm-Message-State: APjAAAVlW8GnhzIZzCiMX6iWgoB0Lk9oDkSYim349IXZIutuelEkwS9Z
        hXH9il0/u354HjQGJKyMICHF0g==
X-Google-Smtp-Source: APXvYqwfbn9vU6s+/np/lHKs6WpigAe5sHs/aZok+lBA7/xt8Mml6cW1UHNizjxuvC6Fg0TkrO0QyQ==
X-Received: by 2002:a63:5107:: with SMTP id f7mr11171884pgb.198.1558628039057;
        Thu, 23 May 2019 09:13:59 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id c5sm30795748pgh.86.2019.05.23.09.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 09:13:58 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: meson: g12a: Add hwrng node
In-Reply-To: <f4a1f115-d886-ddf3-c4fc-ea995f10a434@baylibre.com>
References: <20190520134817.25435-1-narmstrong@baylibre.com> <20190520134817.25435-4-narmstrong@baylibre.com> <CAFBinCD6wJnYd3-E=kS6WCZLFebV9JYk-GybBxoMA8qQqGfSHw@mail.gmail.com> <f4a1f115-d886-ddf3-c4fc-ea995f10a434@baylibre.com>
Date:   Thu, 23 May 2019 09:13:57 -0700
Message-ID: <7hblzt408q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 20/05/2019 19:45, Martin Blumenstingl wrote:
>> Hi Neil,
>> 
>> On Mon, May 20, 2019 at 3:49 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>
>>> The Amlogic G12A has the hwrng module in an unknown "EFUSE" bus.
>>>
>>> The hwrng is not enabled on the vendor G12A DTs, but is enabled on
>>> next generation SM1 SoC family sharing the exact same memory mapping.
>>>
>>> Let's add the "EFUSE" bus and the hwrng node.
>>>
>>> This hwrng has been checked with the rng-tools rngtest FIPS tool :
>>> rngtest: starting FIPS tests...
>>> rngtest: bits received from input: 1630240032
>>> rngtest: FIPS 140-2 successes: 81436
>>> rngtest: FIPS 140-2 failures: 76
>>> rngtest: FIPS 140-2(2001-10-10) Monobit: 10
>>> rngtest: FIPS 140-2(2001-10-10) Poker: 6
>>> rngtest: FIPS 140-2(2001-10-10) Runs: 26
>>> rngtest: FIPS 140-2(2001-10-10) Long run: 34
>>> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
>>> rngtest: input channel speed: (min=3.784; avg=5687.521; max=19073.486)Mibits/s
>>> rngtest: FIPS tests speed: (min=47.684; avg=52.348; max=52.835)Mibits/s
>>> rngtest: Program run time: 30000987 microseconds
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>>> index 8fcdd12f684a..19ef6a467d63 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>>> @@ -197,6 +197,19 @@
>>>                                 };
>>>                         };
>>>
>>> +                       apb_efuse: bus@30000 {
>>> +                               compatible = "simple-bus";
>>> +                               reg = <0x0 0x30000 0x0 0x1000>;
>> the public S922X datasheet lists the range as FF630000 - FF631FFF
>> that translates to a size of 0x2000, which the vendor kernel
>> (kernel/aml-4.9/arch/arm64/boot/dts/amlogic/mesong12a.dtsi from
>> buildroot-openlinux-A113-201901) seems to use as well:
>>   io_efuse_base{
>>     reg = <0x0 0xff630000 0x0 0x2000>;
>>   };
>> 
>> where did you take the size from?
>
> Another typo, it's 0x2000.
>
>> 
>>> +                               #address-cells = <2>;
>>> +                               #size-cells = <2>;
>>> +                               ranges = <0x0 0x0 0x0 0x30000 0x0 0x1000>;
>> (see reg property above)
>> 
>>> +
>>> +                               hwrng: rng {
>> this should be rng@218
>
> Exact.
>

Will wait for v2 on this one,

Kevin
