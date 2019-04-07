Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DDCC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EE620883
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hSRdVvj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDGWVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:21:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35264 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfDGWU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:20:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id t4so9499734ljc.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u+knILwqONfTtrEbzP1i0u78HwzBda5GqrFsEzNbHPQ=;
        b=hSRdVvj5oBE9U5X4lQsFlQ4k1i6PJv4ij4UK2HTdsbIHYJnu9FQkpUWxamv4pi6D3k
         aJW1PfHEvMDDal4cK8Ovcj29bfVXpV8GvyFPa0OjG9LqcgXsZ9ygrU0LxAbnwwmsz//f
         /lIu/EJnhV6h9OIHDVOPH0ZoGMXUM+x1jzOrDqL293WTpIZG7o2AQAB/EFSnGf4Nc1A3
         5Fnt9H6wooi45UZe+SEaSCQ4vvwLIN6EdnZM67OXSNaJVAlx/+34EsPWVVVxTr1MJL3O
         ZIAvljtDze5mFkVj/iFfQrSsnsywbxbM/Jvfe0gw8SiRl5qK0mFDjenBbjsDjFJ88D9W
         hVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u+knILwqONfTtrEbzP1i0u78HwzBda5GqrFsEzNbHPQ=;
        b=DhHfsBg+ZQSipnVeQTdpxWHqUgz9oSF5YTV/q2YGZn/bzusws/cDJLh7WYd35vyESR
         3l8ryGZLDRX/It0OFU80BniApwV39sL44E6Qh403uG8PqRSh3B8b7HiygncAzLbzaA8i
         tyboRS5MkCm7UBg5HWdUuxTgWs6nm0Vf711ki8pdUizpw+CFsW9xNA0gi07SkcWklgN+
         EskqPUqaRitPdF+pmX5CbIqtVJ+ZaNFxdWTZEknmTFFpqhk4Lj9jrPYKuWi7qthwfhsD
         0Do+6udU82lUi3tbfHCEQU+IPzFNmJ8eMG6f6h7ngS52ctj9mBv7/fOXCSCJJibCLyVe
         FxRg==
X-Gm-Message-State: APjAAAVqfkj7uMDYPZjlGgFOplbNMctNgiN+NbZ7I6B/PJRWO/EwTG7t
        kYmaPgQurQQcfd7e2BsfisS2Mw==
X-Google-Smtp-Source: APXvYqwMZxO3i1uQTRQsSuF4q1SphJuYCgZO5jDR6BYnOU8GcmWa/RlK7vb4rP/F9a1XiWDrzaZNcw==
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr13565346lji.163.1554675656654;
        Sun, 07 Apr 2019 15:20:56 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id f15sm6138442ljm.47.2019.04.07.15.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 15:20:55 -0700 (PDT)
Date:   Sun, 7 Apr 2019 15:20:12 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>, arm@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: iop: don't use using 64-bit DMA masks
Message-ID: <20190407222012.cqbo64w6mmtdfr6i@localhost>
References: <20190325155101.3544731-1-arnd@arndb.de>
 <20190325155101.3544731-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325155101.3544731-2-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:50:43PM +0100, Arnd Bergmann wrote:
> clang warns about statically defined DMA masks from the DMA_BIT_MASK
> macro with length 64:
> 
>  arch/arm/mach-iop13xx/setup.c:303:35: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>  static u64 iop13xx_adma_dmamask = DMA_BIT_MASK(64);
>                                   ^~~~~~~~~~~~~~~~
>  include/linux/dma-mapping.h:141:54: note: expanded from macro 'DMA_BIT_MASK'
>  #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>                                                       ^ ~~~
> 
> The ones in iop shouldn't really be 64 bit masks, so changing them
> to what the driver can support avoids the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Applied to fixes.


-Olof
