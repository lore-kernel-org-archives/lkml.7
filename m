Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7FBC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE652075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pNzIfW2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbfKFTSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:18:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55339 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfKFTSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:18:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2179906wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PU9cgonQbeBUlqD6smuE3HVC0qfgvpeOW/hibhDm86U=;
        b=pNzIfW2lSQa0r/h9lm3RqqX7bh074trKmxFhai4BOlXwBi3iPmBUtxEuI9KxpyeYCg
         DFxFVmbUnm2l1vmJyAdPNU1CwnyV7kcJ/fbddZ8WUTI6Bc+XVGW7X4Ebb3PfGioEivI+
         yzpD7F9urWPbI6eeLuFqYuRPlKuKCmrqQMYmUc41cR4ghL9o0bzJ3At+hVLGbGkneHox
         rAf0NakMMnk0FRzD2P7NC81JmwgWzjQYmewAzo34RaJzLO8AHi7D6sdI4PuaHlCXEkqZ
         Qyk4+41Ag2Una8+y8uxScUg923YYDbrTRMVGBY2vcRGsRGZCFy9SEsz7RgeuBaHLNCde
         Oq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PU9cgonQbeBUlqD6smuE3HVC0qfgvpeOW/hibhDm86U=;
        b=XU25NiPMI7LCjAyYzHfXKhctUZmNZtKINXm4K+L4fgU6sWz/2c8DJS/92/2ivfgWLV
         TpVkRNPZym39AcqifFMvqKwDDIUV2LvnMDZa6E4HZi1q8BxS8hmSrw6nx/+SS1hPNqEW
         faGuV5/EbQMc2m8yQsr5biAxpCEzUKOuiGh8wgvnMqGMtuiPt6W1brY6sA0xDRrKeBp0
         TJFIHuJbMCSSCDjGgQV7eTWopHhM+SntwiIQ5dLMbsjci919GKzFuz9ymOEDhp0HBOFa
         lh/GS37Ahuo7tn4/mcXlEQJB7AorKoIjfQAvVO3ciVuzcpexraSxc1efk1hv5ww4cpIX
         WVEw==
X-Gm-Message-State: APjAAAVfKxTTJ0xFIe/Hi0SiHMn+qAh5K77OCMPmCFTAZCuivDEXgmRY
        MVmiQBYCSXY/lvxO3mGGyhaXlw==
X-Google-Smtp-Source: APXvYqxkmHQPv2qjioyUcDooANq4YwZdbLDpJXqEm7lqXEUgckuPqSHnNkueWlA2awFRBwWXBUkVkg==
X-Received: by 2002:a1c:1b06:: with SMTP id b6mr3930121wmb.3.1573067891320;
        Wed, 06 Nov 2019 11:18:11 -0800 (PST)
Received: from localhost (amontpellier-652-1-71-119.w109-210.abo.wanadoo.fr. [109.210.54.119])
        by smtp.gmail.com with ESMTPSA id 200sm4974176wme.32.2019.11.06.11.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 11:18:10 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] arm64: dts: meson: new fixes following YAML bindings schemas conversion
In-Reply-To: <CAFBinCD7NzK8EphtVTx77aSQxRytm4F8JhzbJMZ1aXfaQyFVMg@mail.gmail.com>
References: <20191021142904.12401-1-narmstrong@baylibre.com> <CAFBinCD7NzK8EphtVTx77aSQxRytm4F8JhzbJMZ1aXfaQyFVMg@mail.gmail.com>
Date:   Wed, 06 Nov 2019 20:18:09 +0100
Message-ID: <7hr22k6cge.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Neil,
>
> On Mon, Oct 21, 2019 at 4:29 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> This is the first set of DT fixes following the first YAML bindings conversion
>> at [1], [2], [3] and [4] and v5.4-rc1 bindings changes.
>>
>> These are only cosmetic changes, and should not break drivers implementation
>> following the bindings.
>>
>> [1] https://patchwork.kernel.org/patch/11202077/
>> [2] https://patchwork.kernel.org/patch/11202183/
>> [3] https://patchwork.kernel.org/patch/11202207/
>> [4] https://patchwork.kernel.org/patch/11202265/
>>
>> Neil Armstrong (5):
>>   arm64: dts: meson-g12a: fix gpu irq order
>>   arm64: dts: meson-gxm: fix gpu irq order
>>   arm64: dts: meson-g12b-odroid-n2: add missing amlogic,s922x compatible
>>   arm64: dts: meson-gx: cec node should be disabled by default
>>   arm64: dts: meson-gx: fix i2c compatible
>
> for the whole series:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued for v5.5,

Thanks,

Kevin
