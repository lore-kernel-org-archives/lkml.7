Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2201C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6EB2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="c7WKFpCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfD1UTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 16:19:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40236 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfD1UTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 16:19:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id o16so6338661lfl.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CTKqHAreMncZ1h7jPsWtfNHB4etyOtY+dEoamFuIONY=;
        b=c7WKFpCJKWKACqQjuN6+QisDaRfN+IhstozIANrOLGKSX9t088Pd+TJ0TYSEQEUBy4
         9S0QUaM1sh+ydbjwwTTGA2+uSZ8hfN02UN4Q+DUMe588EixH55YWZuDwkvlB5AAvpO9p
         u92Z3P24mMpodmk+mfALJQvxc/SMyGAmZj32lSHufdV+OlBqO9ikPZXO9EaMS5QS7JZH
         qcDuUYEYbIrY94ozz42Oe5j/TU0rjkKDIv+/313hLkPQcLGbPemdP88b4jd1liJb3ndf
         ybbZbPL5qleI6UvLg3ET28KtBqJkZvCggP0d34eegklnHUvJ7O7+qll1m6QAahwX7jsH
         WJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTKqHAreMncZ1h7jPsWtfNHB4etyOtY+dEoamFuIONY=;
        b=BoTNaQrBiJFyP+96oB4O0Tsf5LT4Y2yNAFn9kmHxubhzBJe/krWm8cxhgt/WIIF/df
         mpQnZd8pubjyJsAYTBuAoqzi8Ij30uE21u+G9p3qQaKelsz5a/C5qqENY3LdbGkag9T0
         1KLD/TpE1Y94jimlxRL9aRAdAQLXMBYFqDHP6Vy5hRibGTKcybpChlNH2jL+kcl96FYG
         AxRt+Wgs1BNn7TWeKOGnOiAv91R+dlaGEOQ04ItV1ENqFVNiwdeVOCilyJECFBHtBFrI
         gHpFb3NCxEpdv0L9xw2h9KIHh5zXEovKTeJ6hOOaSTA5KQ05f3V3oejkCOT4qYFdCeGl
         qqSg==
X-Gm-Message-State: APjAAAX84WYlf3jjSdF1inlA0xMaP+EjiTJsJ6prG17rDeJIe3wnjAQT
        2Kgi0MhvMSSe1+996AbWtodn2Q==
X-Google-Smtp-Source: APXvYqzb+UuqHeoCVQGdxxsf48KDNCdx59QYYBrzj/0hrbNxadzY6bfAuPdIbvgkgs1n9/fqqUe+fg==
X-Received: by 2002:a19:428c:: with SMTP id p134mr31867733lfa.108.1556482763081;
        Sun, 28 Apr 2019 13:19:23 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id t9sm4108314lfk.20.2019.04.28.13.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 13:19:21 -0700 (PDT)
Date:   Sun, 28 Apr 2019 12:29:36 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/3] ARM: dts: exynos: Changes for v5.2
Message-ID: <20190428192936.ybxa437r3jznxgbv@localhost>
References: <20190414154805.10188-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414154805.10188-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 05:48:03PM +0200, Krzysztof Kozlowski wrote:
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.2
> 
> for you to fetch changes up to 8cc76b1c75722196fb3d7ffe67cbfeb721a7b0e3:
> 
>   ARM: dts: exynos: Remove console argument from bootargs (2019-04-10 18:13:31 +0200)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v5.2
> 
> 1. Use proper ADC on Exynos4412.
> 2. Extend the Exynos5420 Arndale Octa board with: CPU cooling maps,
>    unused regulators, ADC and UHS-I SD card support.  Beside that adjust
>    regulators to proper level and add always-on when needed.
> 3. Extend the Exynos5260: high speed I2C and proper external interrupts.
>    Also fix shared external interrupt line and use better PLL for MMC
>    clocks.
> 4. Fix audio recording (broken around v5.1) and microphone recording
>    (since v4.14) on Exynos5422 Odroid XU3 boards.
> 5. Minor cleanups (stdout-path and bootargs).

Merged, thanks!


-Olof
