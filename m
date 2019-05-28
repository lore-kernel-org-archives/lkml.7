Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D76C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA5C208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFegaMLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfE1Thb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:37:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41585 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfE1Thb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:37:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so6969714pgp.8;
        Tue, 28 May 2019 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aKMw0jpMSDE1hzsk49QyAKgqiMvWHfkv6ygCDAosNH4=;
        b=uFegaMLssf2rbiFIb8NzkeR+NSvXGcyYrsDsE0CJucxzneR+uANXvl81orClsVsRHa
         Bi7A+BegE1khio4eba9KbYXCJOztP/H5JAJNCZnfLykPsEMyaJtGju6xSHXqPeJc8Thh
         Ru61skC0bkpO1cSfbq4pBBjzH4XJiFUhcWjgT4iu6WAvnNE9ZUykextFlcI1huwGG7n8
         5ZkD1ZkgZNwc6eoY+bAjgL8BBlwX8jDmq8QcQLLkMwTiN7LM5z1Cbig6IIcCaM7sUIqh
         gYnk8hmiOJmKP6bsuicNZRuzEKOni9YKo0oJNGBhph5QZUfP8tfr4yaEuEoTV4++lHIl
         Fqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aKMw0jpMSDE1hzsk49QyAKgqiMvWHfkv6ygCDAosNH4=;
        b=YxjWtxCGeh8zxjgVEkesnf5sYt17IZNGLceSDty1AwXg4x1UVDhih7PYIh7NuAN7s9
         +8IAxzWP2xNRNNNzsJ0vxMazyrujQW4Pjb67LgMrHQi4zdUGp34rF5cu207fwDK/RZM+
         8YYzialbJ1rnpaUizp0MRawqQ9ApnnwNtsGzJlOf2Z6O7DGMBLX8UByi/HD2vh17aoDb
         Pp5Ax0kMq0O3u+9ta2xizWMCfVqzUPylj06LhKuWsbtIYA0jRpR8LsaUt28os+uY4r5W
         ZbFzikvAjdIZuXu/rwJOrFc89/2e4DxtJPUaRHUfjsaybxqeuKv+b+GgTPAKSY7ssp6o
         xsSQ==
X-Gm-Message-State: APjAAAXoS9ErsmBZY31AclMHn8j/rZvhV1ZfbTjr13r9rL3/yIv47/QD
        FvTH70xMdGjKblJysdIl1iY6ZjWz
X-Google-Smtp-Source: APXvYqxTaLr9KDWr1Byq1MFmx5+WoIFTiWeza4qn9qIABx+JPHksIU0nXUkvNneFVZ3Mat7IbTUhBQ==
X-Received: by 2002:a63:d70b:: with SMTP id d11mr132454763pgg.178.1559072250766;
        Tue, 28 May 2019 12:37:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 184sm16791852pfa.48.2019.05.28.12.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 12:37:29 -0700 (PDT)
Date:   Tue, 28 May 2019 12:37:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>, od@zcrc.me,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] watchdog: jz4740: Switch to SPDX license identifier
Message-ID: <20190528193729.GD24853@roeck-us.net>
References: <20190521155313.19326-1-paul@crapouillou.net>
 <20190521155313.19326-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521155313.19326-4-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 05:53:13PM +0200, Paul Cercueil wrote:
> Use a SPDX license identifier instead of a wall of text.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/jz4740_wdt.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index f970a7a53084..c5b369152e70 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -1,16 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *  Copyright (C) 2010, Paul Cercueil <paul@crapouillou.net>
>   *  JZ4740 Watchdog driver
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under  the terms of the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - *
>   */
>  
>  #include <linux/mfd/ingenic-tcu.h>
> -- 
> 2.21.0.593.g511ec345e18
> 
