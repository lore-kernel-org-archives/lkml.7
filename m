Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A94C4321B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E14E20673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SzihAGca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbfFKMdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:33:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40424 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfFKMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:33:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so12831089wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DvikrMBwh9tftYU3dRCC1yJiv8IUHz4wGcpoKbApB0A=;
        b=SzihAGcave6PcRHaptIfqetvYX2s/CIsqZx4gGmhOkRcqD3r6E3yVhD0MwYTg6JyxN
         Ff9Azg842+7V7Eai50NIu+lriYWLYTPBlftbbRJpwrcbLCnH6DuubjPVVN9+/oqGvFkU
         tZLcQIrjhccq4nF28oJUdBI2ouNCpCurYD2a5W1zgycAmBFSSRUpqE6Tm2kU4tEeiNEV
         yyUIG1maTEhQMr/mzjilwiUjfDFhA6M2BgRovVDP01hpqVu5JseG3dhjYbct+zZV0ZmC
         x/9m97bjmTANsKa1n5D/iKp5YKRlyHUkejHCFHLyyAdu0Uhqx5LIgPiIM8AlBBDtDOC7
         QIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DvikrMBwh9tftYU3dRCC1yJiv8IUHz4wGcpoKbApB0A=;
        b=KMLxinK+7uX3+TgClhXw2+A/6UZTBZ3BqbaMmLG/7T9xPoex08zi5t/7hE5n9l8fB2
         /mFd9y4gGFntbuqk6RrSN+xpWcPe7HmM77mVqGUUfd1/QlJ2W4o41k0K4hGKMlw0REjL
         w3NFzuHliotjUc6vlLukfs/laiUkQWBoZHYrjhV8QI5ZOhF3kf84vIb+/oxK/PpFcspp
         LSt2BSx/6JPT3bAhYdIr+d5Du4BggxBgSDM8WT68LoXzXw0XvYlTW2DI24xIYtTmPMnl
         8XcMIgnDWRFA0pg8UdP9JKuNO1mg5GDIqIOEPxEoiMerTlmwLSe/W5AXLfSlu8wu3b6S
         1xtg==
X-Gm-Message-State: APjAAAWIkn/oM3MNA6ogXqviqJ4kqzt+TP5Xsb1VVkQ+dIq5FQBHKc/R
        iPbq8qb0v2R4tYSroh8lAihetw==
X-Google-Smtp-Source: APXvYqxKyUgIOeO42Kn0nHkZYiOxQ1QsohML52m1DvilPZ1AePnj8NznUOj0MKLMxd2jVLtQMThCnA==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr2772546wrn.168.1560256428217;
        Tue, 11 Jun 2019 05:33:48 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y17sm29500399wrg.18.2019.06.11.05.33.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 05:33:47 -0700 (PDT)
Message-ID: <6ff3ed67f7bd0903bacb8d975816e780a3907dc1.camel@baylibre.com>
Subject: Re: [PATCH 0/4] 32-bit Meson: audio clock support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        narmstrong@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Jun 2019 14:33:46 +0200
In-Reply-To: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
References: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-20 at 22:03 +0200, Martin Blumenstingl wrote:
> The audio clocks on the 32-bit Meson8, Meson8b and Meson8m2 are
> (probably) identical to the ones on GXBB, GXL and GXM.
> 
> The first piece of evidence is that Amlogic's vendor kernel is using
> the same basic driver (just slightly modified) for the 32-bit SoCs [0]
> and 64-bit SoCs [1].
> 
> Then there's buildroot-openlinux-A113-201901 which ships
> kernel/aml-4.9/drivers/amlogic/clk/m8b/clk_misc.c. It contains the same
> registers and bits (just slightly different naming) than the mainline
> GXBB/GXL/GXM clock driver.
> 
> There is no working mainline ALSA driver for this yet so I am not 100%
> sure that everything is correct. However, due to the evidence listed
> above I'm sure that the basics are correct so this is a good starting
> point.
> 
> 
> [0] https://github.com/endlessm/linux-meson/tree/d6e13c220931110fe676ede6da69fc61a7cb04b6/sound/soc/aml/m8
> [1] https://github.com/khadas/linux/tree/1bd6972cd0093725c0b1dc87f6546648bbb22452/sound/soc/aml/m8
> 
> 
> Martin Blumenstingl (4):
>   dt-bindings: clock: meson8b: add the audio clocks
>   clk: meson: meson8b: add the cts_amclk clocks
>   clk: meson: meson8b: add the cts_mclk_i958 clocks
>   clk: meson: meson8b: add the cts_i958 clock
> 
>  drivers/clk/meson/meson8b.c              | 154 +++++++++++++++++++++++
>  drivers/clk/meson/meson8b.h              |   8 +-
>  include/dt-bindings/clock/meson8b-clkc.h |   3 +
>  3 files changed, 164 insertions(+), 1 deletion(-)
> 

Applied
Thx

