Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8108EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519122081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bwqQJBj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCGNJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:09:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41986 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfCGNJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:09:29 -0500
Received: by mail-lf1-f65.google.com with SMTP id p1so11620711lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 05:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/b2Zdm57Szsj2ukPz7AmhKLfltbMhhF3RLiVc/mgVts=;
        b=bwqQJBj44sEsWMMDpXCeCiVCWpCQGG5pxymzB3Zbh77MVgZLUrsXFFDDub6CG/NbGr
         fTDWeFmhUEtzClnqSm7GB+Z4QAUOwVIUDnPHoPForYnBYZnFv1OVqayLABwrqpUq8TeK
         cEa63AzxCQnL0Z0R7Xioc9UNpg5HHbfjeMtfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/b2Zdm57Szsj2ukPz7AmhKLfltbMhhF3RLiVc/mgVts=;
        b=fgNAqmlvYl7+QErpdAISfXQ4LYRhOcnXKfe7x5SDWIHchGCUSzSTfiDndx1UlsukCF
         BfE4IBIqCalh8Vi68XzOn3l33W0SKQ/hzU+5hmcBGuI9YydiATDr8esLwRYSTcEFd1iU
         gDGS0v0oZJj7B0Nh1Dj4eD21JjMxqi/snGU2pYbKsfwy/Og4Hyx3IBh4vuBqLWAKCidk
         XKV14sPUJmNoAkDwkSphdPQHNz34Ftp8AUgOU8hriG52x276TQT+Q2iTFoIJu33yv47A
         b00Y5vN53ixakS/S2h+0t80z0vLWOydso6YbB6XPUa09Zu9bK/sUIvT24J21Evr1U/P1
         QsdA==
X-Gm-Message-State: APjAAAV8XCErlyU+2FU+5WRps8GtIEuh2oBUI6TVJhMlmVj18AuXBeAi
        F1Z+Sd9bvqJY3B0e9NgOq0XIiOxb/RayR96y
X-Google-Smtp-Source: APXvYqyLN8OBnhN8f+63LPJlSIa5Hn/vqUrL1u0/44TgBuXp+t0weCW/ll0KMRPlCfaro30VTd1sag==
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr6910871lfc.1.1551964167081;
        Thu, 07 Mar 2019 05:09:27 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 16sm823520ljv.66.2019.03.07.05.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 05:09:26 -0800 (PST)
Subject: Re: [PATCH] spi: work around clang bug in SPI_BPW_RANGE_MASK()
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190307105619.2780591-1-arnd@arndb.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <bc0e18db-9606-6f11-facf-2ca593118ef1@rasmusvillemoes.dk>
Date:   Thu, 7 Mar 2019 14:09:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190307105619.2780591-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2019 11.56, Arnd Bergmann wrote:
> Clang-8 evaluates both sides of a ?: expression to check for
> valid arithmetic even in the side that is never taken. This
> results in a build warning:
> 
> drivers/spi/spi-sh-msiof.c:1052:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>         .bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32),
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change it to shift one less than we want, and then shift one
> more bit afterwards. This should give the correct result for
> all valid input, since it has to be in the range 1..32 anyway.

Why not use GENMASK which is provided by the same header that #defines BIT?

Rasmus
