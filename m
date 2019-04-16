Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72249218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="weiOap0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfDPTBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:01:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37284 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPTBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:01:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so10866510pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JjKjlAh6nXxaI77IalZgHFwuGMAQ1dUUJW+n8kgkchA=;
        b=weiOap0wETK3URoZ3gB9iY1HvaLmuWvlOgd2JRAWkiYwSrk8eYOz01lSQKtu+1NLTE
         vDpGI18PD+cEFz2qLQnjDvgdFU2kSi+5ERpMYbVBqT6WQXJkRMtXTWJTh4loXgDy/z0s
         vaud26XTDOy6S3i7Pu/LAs9/Bs24pqHnYJDPJG1ZN1C+OmO+i3lXk6KUNSmxYP0uH/VT
         EpwUwpDCbVmCSaB4Ovv0V2J0tSDxVrW6Y8Qyh+9FyiubZ06KtsPnUvBDC9Y2mVbwKdVc
         E7x44hmTZ/tv5FOiCcBkgH5uxV+tJndy0JG2BNRvtbQ33dLhUAAQ70wPvvVUvT266lF1
         Mzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JjKjlAh6nXxaI77IalZgHFwuGMAQ1dUUJW+n8kgkchA=;
        b=JO4z9kOj1Vtf//Dr5QYqaMZtcuXj9gpQJSMdV5eHZ2TKQJtrmocCkpS3ZjSVHx+2hs
         Mzvo8KURWiFc+RomyW47gPrT4/Ah3tDJ8CcFkEpyfyDf0aPc1XrbuIQB5PVJRdHwSPKD
         ZYGDunOST/r1n3A23pfdDCm1BSXdXNfNdjQwrnfYTqe3t+1j4JX13cm6h6VDE5hz0zCI
         wu1JqiCvnVeOf0S0Dh3lfC0enatI0jtzkRRTeXvsrs4T9NdAWvjJO4CxTcswKOKgS48e
         4uttgtRkhtx4G12tYLx4Rnw5WF8aeH2lt1zpxi/i+gVUZGE50dYwcugCVZz8HqiKl8ZE
         kC2A==
X-Gm-Message-State: APjAAAX/dNs/ibxbywQOnf33TEDsqAa5OSoaepK+YM8sLEwjcu0vcm5C
        zQ1b6S9oflWI8v7lra5s4PBV9w==
X-Google-Smtp-Source: APXvYqyQhjqvViAPOX+VaJxDS6fn0AGOzQMbz/Onhxz8k2K/WJC7xYmGsyQbvKSrxDomwIjmve9msQ==
X-Received: by 2002:a63:c112:: with SMTP id w18mr79326612pgf.200.1555441313986;
        Tue, 16 Apr 2019 12:01:53 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c45e:7ed8:c242:3563])
        by smtp.googlemail.com with ESMTPSA id 10sm94248745pft.100.2019.04.16.12.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 12:01:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianxin.pan@amlogic.com, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/3] Meson8b: add support for the RTC on EC-100 and Odroid-C1
In-Reply-To: <20190413163423.15149-1-martin.blumenstingl@googlemail.com>
References: <20190413163423.15149-1-martin.blumenstingl@googlemail.com>
Date:   Tue, 16 Apr 2019 12:01:52 -0700
Message-ID: <7hr2a1ojtr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This adds support for the RTC on the Meson8b EC-100 and Odroid-C1
> boards. Example kernel log snippet while booting my EC-100:
>   [    5.713750] meson-rtc c8100740.rtc: setting system clock to 2019-04-13T16:21:48 UTC (1555172508)
>
> I am only 99% sure about the naming of the clock in patch 2 and 3.
> The public S805 datasheet from Hardkernel shows (on page 24 for example)
> that clk81 can use "XTAL/32khz" as clock input. That "XTAL/32khz" clock
> is described as a mux between 24MHz (our main XTAL) and 32kHz ("that
> other XTAL").
> I believe that this other 32kHz XTAL is NOT the RTC32K crystal because:
> - schematics of the EC-100 and Odroid-C1 clearly show that the SoC input
>   for the RTC32K clock is labeled RTC32K_XI / RTC32K_XO
> - GPIOAO_6 has a CLK_32KIN function (shows in EC-100 and Odroid-C1
>   schematics as well as the public S805 datasheet)
> - Always On domain PWR_CNTL0[11:10] (public S805 datasheet page 19)
>   describes it as "Alternate 32khz input clock select from GPIO pad"
>
> Thus I believe that the naming of the RTC32K clock is correct, but I
> wanted to point out that I'm only 99% (instead of 100%) sure.
> Jianxin, please let me know if you disagree with my findings.

99% confidence is higher than we normally have, so that's fine by me. :)
And, we can fix if we get any updated info from Jianxin.

Thanks for the detailed description.

Queuing for v5.2,

Kevin
