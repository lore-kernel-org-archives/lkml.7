Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D3BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AA020883
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="TohQLwLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDGWU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:20:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44762 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfDGWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:20:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id v71so7977498lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 15:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=onYIOM34G9coWioEeYsBH/DmUFxEfLZhAZui1Bc6idA=;
        b=TohQLwLWZs1z5PSx9NzLmPmJNW7CApYD6ZFG45UWCCpmzJtV3CH+XAb5REiQBAU7T+
         G7UAy8JPNp/+tOuKdGP45wP5+Ekw8oxNaJjzGEo+uglRacRSzX+31g69FoOHvqTO4DXS
         UG9goOoTsMfM0uXezTeVP8DIKlUd2lDbnEljQtpJK4IFi4UD3hFODDBblW4kHDRnFQR2
         QFkskQ+QOKJ/pw/VwS7+fiwksZNEQuclRVQolNVwLe7V6N6C8neecZX31inueTBahRku
         +HGw/C17LdrxRxF3t5xbGYrByAAgiz8TNpaGDjGupkvP2Jzh6z8gmqq2ka9Ifk9d/iUj
         kH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=onYIOM34G9coWioEeYsBH/DmUFxEfLZhAZui1Bc6idA=;
        b=YU2HlEpVvUCEuEQK0g6CV9Snu1aNyvkprdFN4ZY7FpG5WWvyXX8c3mzyz66pSZPcjx
         ScsocNGZjYD509yOXbfzqWAHChlq+cD4Ppt+Ij/SPYq7QXNg7tJneONtvCjdFYKyCXif
         1zTMVOg4YUxNEQlY4In3pV17BFHh5L3HikRNxqt5+eZ+NAwxvKdS5kpPJ2yQJUEf25x3
         tIvUf9ddThGm7tbHeuj4CEVg3NGrIWSne2wuUdXf3thvk0MBd56T3CV0Y6j3h/2SLRY7
         SvxQEIbeOcblXFCFQJwZPlEEIRZtyeHRevbq8AJ9WVtzqIONBWrUMBzAPpaOgcdbkNHW
         fZGA==
X-Gm-Message-State: APjAAAVDyLlepn+boxVUCd3wI94RteLLLbumHp6ZCJcGLKZbzK+JVfNT
        QZ1d41DPkOhCQNmgiTtEuimSVQ==
X-Google-Smtp-Source: APXvYqz0FbOz7CwPgBetUByhpzGoGAT72N4AWtiYMydjCnqLX0YcymOWV2g799XoyzOvQCmvDdLtgg==
X-Received: by 2002:ac2:554a:: with SMTP id l10mr7871324lfk.49.1554675654708;
        Sun, 07 Apr 2019 15:20:54 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id v4sm3011946ljh.40.2019.04.07.15.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 15:20:53 -0700 (PDT)
Date:   Sun, 7 Apr 2019 15:20:00 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>, arm@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: orion: don't use using 64-bit DMA masks
Message-ID: <20190407222000.pljbqastxrnwfjmp@localhost>
References: <20190325155101.3544731-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325155101.3544731-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:50:42PM +0100, Arnd Bergmann wrote:
> clang warns about statically defined DMA masks from the DMA_BIT_MASK
> macro with length 64:
> 
> arch/arm/plat-orion/common.c:625:29: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>                 .coherent_dma_mask      = DMA_BIT_MASK(64),
>                                           ^~~~~~~~~~~~~~~~
> include/linux/dma-mapping.h:141:54: note: expanded from macro 'DMA_BIT_MASK'
>  #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> 
> The ones in orion shouldn't really be 64 bit masks, so changing them
> to what the driver can support avoids the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to fixes.


-Olof
