Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53639C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248912182B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="NAFslq//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfF0Cdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:33:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40553 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfF0Cdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:33:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id a21so638098ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QsUYJ0OixGvyGAqGjBHbqvL3FB6Bz7WIPxlK8Bq4u5w=;
        b=NAFslq//TWZ2W+oopBubsqoa2BPr60n5Uj9J50JGDr4Kkr6fRmHugqxnjlVcxVPieI
         AauNsl1vc7rn6ds5sc8Rjp8jfNAuE53Aa9QZ7YVjueWHYAgNGWhZQYOTcW6FmjzmFHlj
         hLojqogqtp71w9KWWQIAIq60LAKW1O1/UMvxNPpXWkppOUqpe5P0wJBVW6fmPj2ARYXR
         ADBBcT42pEjlyebqv9Xk4Rn87VkzvJsHGrSfaqQH+AIDa7MamyA9CWR4OT2YdacSa3WN
         my1XzRBDNQMx/VW7jTJW7DVouQIYBhALjGUix56/lH8pQEcT04DPF9qQuP+fuTyoi0Ph
         DAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsUYJ0OixGvyGAqGjBHbqvL3FB6Bz7WIPxlK8Bq4u5w=;
        b=WyW7/FpEWMPxgq6U3Q5buzuWKKfYUOsjkmbbXFjnVDDaYl7QvdvPsDscP09wGqSy/+
         WgeaSc/svw+bAYAxdgs3sjsbnmBT4IM08IoQMj8JJO7w0iHBYLFVsP+IxWTD65FAYu/e
         DJaYoxr/S+SdnKwCrh8iSOagyr4/iuBpalaJXUbJXGprvIV2TEG3DhQcH0blw2lWivbZ
         Bl9i/VM6oTk/4n1dnBf4mwm6mNyum72eJkjfsH5A2ZUp7kwHVVbLlKrie5nIhtMkDjCA
         dIhhqj+FU1I4FlRogdQAzSYbAFMcM+2/AybmSsjCLrAPPECmQWktrZ+6J0fIG1E8nN7W
         sAQw==
X-Gm-Message-State: APjAAAU2+0bGF+pRqoX3TNYj7DZ9phbHnYskLyjZ4/WJWemgkl4Ljhcn
        SE120Ra4OWdsjUjTcEwvSGUASQ==
X-Google-Smtp-Source: APXvYqyh/a8j2yzQL0dk+k7+Q3KUqRAVUal00aYaGppig+X9K+BfCpTOWR8X2romBAWvRn/+S0Bzbg==
X-Received: by 2002:a2e:7619:: with SMTP id r25mr841109ljc.199.1561602830482;
        Wed, 26 Jun 2019 19:33:50 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id v15sm107799lfd.53.2019.06.26.19.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 19:33:49 -0700 (PDT)
Date:   Wed, 26 Jun 2019 19:22:02 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v5.3
Message-ID: <20190627022202.hyukmqxmxjxw3bu6@localhost>
References: <CAK7LNASNhp2o9kboRMJ66UJy5Z+T28K6CHO_=c02MaGoFyy-5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASNhp2o9kboRMJ66UJy5Z+T28K6CHO_=c02MaGoFyy-5Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 12:19:17AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Please pull UniPhier DT updates (32bit) for the v5.3 MW.
> 
> Thanks.
> 
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt-v5.3
> 
> for you to fetch changes up to bc8841f0c1e6945fd7fde6faad3300d1b08abd86:
> 
>   ARM: dts: uniphier: update to new Denali NAND binding (2019-06-26
> 00:06:50 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v5.3
> 
> - Migrate to the new binding for the Denali NAND controller

Merged, thanks!


-Olof
