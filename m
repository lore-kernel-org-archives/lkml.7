Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74571C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D5E22C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qL7vPBlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389000AbfGYMoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:44:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38944 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388964AbfGYMoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:44:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so34259485wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b4dDvUYUcaoedc7hESwQnb90HFz1PUes4aKbZ6RFIAI=;
        b=qL7vPBlK/NHpG6iycR8FLizvf8abUgpmI4yWcLO/wCtRtkNGDJ+soLR78PZAbWyA6q
         8yV8W8GlayV9AAi8ufsdR9vvtyZ2ev6tpVkQ/CwtVUSgYmJuxVOd88T2WKyUW1FTy8FY
         QLb4vVbp0V3nPa3O76E71goPwejCMBU+rHbOTJGhHtlcsMyrIsSyg9fSAntZk3GnJu7m
         H/ROJJ4G+y5EhMruULrt4+xc3jwgJRlNMD08Lb3yi0WqWKlf9KpqbeU0/WRVzh/wArKc
         eCsvTTyJSWjx0yTIWt8FxdRdLLJA555VrbV0JzN6k3tFgSCln3HPTO7KaM9oDrBNEiRN
         wUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b4dDvUYUcaoedc7hESwQnb90HFz1PUes4aKbZ6RFIAI=;
        b=rQpAmR/dJcgLKBMq31SDU2fWsh4HUxziiavYH3Qt2jZz/xEz1dRAiCZ//eCu1KhbPL
         /3q48M8L6gyhixoz8sUAgfJUSaiO6Q4KgxTwAgTpao1TI2ul6Msv+FSFCvACTGs0c+bD
         Ey3PjA8zEu2+xX/NXIblaC3D94vdiM1/VkWVE4sN2LffP66l0+YOIDl6vK+QRCC/xLty
         mPUfwBRtSY34zrmEes76WHDuGWAnMhcItXq0VV7dalipKAfgoDZ4I3UW/8kvTk99INhq
         yg3zSks72ywzrvb8uan6r+6f3cyLWDPTdfBjp6fDA+Z8MbnwKdvBdQaUiWaHTYirrhTJ
         9e9A==
X-Gm-Message-State: APjAAAUgEVgZY944/mgZ0CuIYMxuxgyhZdj1wymNgMuk+b+ITiH+FzrM
        MKhwTn0batk4J1jkaGyPJDBarA==
X-Google-Smtp-Source: APXvYqzEY7p6szi6Fgq7aooYpYSyCQ5B1QdXU+zpKCgz2y49Djc7L4JnFgX3xHviFk7Zg4ULnMyw4Q==
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr73668487wmd.87.1564058659005;
        Thu, 25 Jul 2019 05:44:19 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id u1sm44979830wml.14.2019.07.25.05.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 05:44:18 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:44:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] mfd: davinci_voicecodec: remove pointless
 #include
Message-ID: <20190725124408.GK23883@dell>
References: <20190722114725.3398694-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722114725.3398694-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Arnd Bergmann wrote:

> When building davinci as multiplatform, we get a build error
> in this file:
> 
> drivers/mfd/davinci_voicecodec.c:22:10: fatal error: 'mach/hardware.h' file not found
> 
> The header is only used to access the io_v2p() macro, but the
> result is already known because that comes from the resource
> a little bit earlier.
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I sent this in June, but it did not get picked up into the mfd
> tree. Sending the same one again in case it got lost.
> ---
>  drivers/mfd/davinci_voicecodec.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
