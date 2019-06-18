Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A5FC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024DA2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="yGFZ4yE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfFRLA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:00:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32960 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRLA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:00:26 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so28829204iop.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaUfQSe+T4PXrUh+yjDH7J9YyQk9TYH+wIjQcd4C0mc=;
        b=yGFZ4yE2r9iiiOX/b/1l1cS8T4RP7RmwpYwvoN0pX8eO6/FG/A/lK54vD9VAHkPo64
         K4o3Av5VNGUe2K/m9DRpu4QjqbN8RytMx1y9iBO3Qhyje+JjShVpJBmTXKczis601gxS
         GjeHDYJpp9lGQM6Qn6Q9U27iczkM2CIXZm8BfKSz2Di8dPRMaS94xGKnptqhxN5dzv0I
         OMaahuzBHUqjddIUUFwqLeTVNSNnbobMPe4ppXDe253vY/BZs+7UvGsp5Dsge2LRSwbl
         0HVlM+8Tf/mb/lZAqWmZcfU+3sXWt9GY6FjhEkeOoloCdijrvdXqB1xjORt4hCG5zl5R
         +5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaUfQSe+T4PXrUh+yjDH7J9YyQk9TYH+wIjQcd4C0mc=;
        b=UZGYHHrz87g1pq9Zquvz+hN0c58sfGeknerWL5xl6C/n4DkRAhjnM1uSz8qCWf419O
         A7TZL4ALF8/jpngJGI73c1MHyb5Mf69GELnqnd0JsSFPxbkqKDL86OXYgY42dDpnMquv
         FXI4HM1wP948KhfL8I1XL6ki37XE2xCnoOC+jOKiIZOEmbgppn/NOg1nB7I0P1uBks9Q
         ZO9pI5qU2jgY9CF/7XZTyZ558FUYHYJtYEicweqE0/njxAessfyY0w+81DGJ0Q3J/M+l
         ObFQ3OFwDZftxsaZXU06UBGN0aljqwCGXQUk+E/UYkXot+kv/fiCLV5Jbn5HvxG2JCGx
         w+cw==
X-Gm-Message-State: APjAAAXGN2PvwwsoDrXBEZhMtmnyul+O4sNv6BtLuLVitCcZoL1DWXyo
        +QqjGs4Uwn633STUefcuTEr5udFvZVjJjVTbHmcviQ==
X-Google-Smtp-Source: APXvYqzeoST4FgKipJrRZ7jKQsTY7JIuBYyvJQNh1cSbscvXOHK1EAwHRDXsATV7nI72tqRnIzkcKeO4lNL52R+FSN4=
X-Received: by 2002:a5d:915a:: with SMTP id y26mr2712336ioq.207.1560855625832;
 Tue, 18 Jun 2019 04:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122449.457744-1-arnd@arndb.de> <20190617122449.457744-3-arnd@arndb.de>
In-Reply-To: <20190617122449.457744-3-arnd@arndb.de>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 18 Jun 2019 12:00:14 +0100
Message-ID: <CAOesGMgUvT87UzNLM=CpjB6nnuwPGn4+cK85ZW8nPUyOzkse6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: ixp4xx: include irqs.h where needed
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 1:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Multiple ixp4xx specific files require macros from irqs.h that
> were moved out from mach/irqs.h, e.g.:
>
> arch/arm/mach-ixp4xx/vulcan-pci.c:41:19: error: this function declaration is not a prototype [-Werror,-Wstrict-prototypes]
> arch/arm/mach-ixp4xx/vulcan-pci.c:49:10: error: implicit declaration of function 'IXP4XX_GPIO_IRQ' [-Werror,-Wimplicit-function-declaration]
>                 return IXP4XX_GPIO_IRQ(INTA);
>
> Include this header in all files that failed to build because of
> that.
>
> Fixes: dc8ef8cd3a05 ("ARM: ixp4xx: Convert to SPARSE_IRQ")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to arm/fixes. Thanks!


-Olof
