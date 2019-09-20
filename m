Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E2C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD512080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="NwUzUyXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392601AbfITFvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 01:51:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44822 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392557AbfITFvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 01:51:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so7313075qth.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 22:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlvPOwDHP1C+DxH46ciGbIQ82Gp/fdmy+p/JFJtAVTI=;
        b=NwUzUyXe+el4peKjNQG4O79OvKdtXAG8r0J4SNnG7hpdxb5bj+ErhCHnYWmyZwpfrR
         yYzgALwnMwMJu8WsDBxH4j3WjHqbrCW/fchFpQkTd/gTlkJku2wHf4JyAWd8/MnooPSZ
         qdIovw70JerTxtUcOENkNn1/HzmKUPXpnvjVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlvPOwDHP1C+DxH46ciGbIQ82Gp/fdmy+p/JFJtAVTI=;
        b=At7ygweJnq3QZ6hDdfdUsbpKltkjS6hfMLLbD9Joud00o8wpP0Zp+JEb7wQL6/jHSK
         tk4ZqwhEP0M7/Vy8HFBmjm5MVPh70M+VzMNU76O7YgdV66KRZumyo/r53RTjdjKqODjX
         09wc9kOwFM5xBaAowRgekJ/5wb5inZnd+XcBxF2EPyPw3bKZ+p7pWc19UMt2sK3HN88v
         mxjfejjIU3bKQ15fwiBS8IXFJBws0w/6f588m7cKfF/F+E5da8e7UvPu/po24l4ucuMu
         nK84bGmvC5odxLgoEXqXp2SKUnCE56EyhOr5GiAud8RdnwzCwDgGSwp1ARVpNCfl2Nhc
         Iqhw==
X-Gm-Message-State: APjAAAXjfmD83v2DoVOQlvP5zdZsEAm/OUNc1Vjpnq1zjbd5ueuWR/UP
        MWsJB5f+MBZ99W7DdZ+V71nfDvtYl0s09qLXhsV4rgZN
X-Google-Smtp-Source: APXvYqw8YKLoRzDRPZmO4NDOIYrRQ0VYcNB8pOGBy4Dn4po2+LJmGgZJC1+QZHzwPn1XmvwamosioDNR5Hr2A+ZYVOY=
X-Received: by 2002:ac8:2e94:: with SMTP id h20mr1491513qta.234.1568958691283;
 Thu, 19 Sep 2019 22:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190919142654.1578823-1-arnd@arndb.de>
In-Reply-To: <20190919142654.1578823-1-arnd@arndb.de>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 20 Sep 2019 05:51:18 +0000
Message-ID: <CACPK8XcsegR5R0nkiZ-UEMgCqNMggCXjAr2N-6J1S6mEhGLrBQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: aspeed: ast2500 is ARMv6K
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 at 14:27, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Linux supports both the original ARMv6 level (early ARM1136) and ARMv6K
> (later ARM1136, ARM1176 and ARM11mpcore).
>
> ast2500 falls into the second categoy, being based on arm1176jzf-s.
> This is enabled by default when using ARCH_MULTI_V6, so we should
> not 'select CPU_V6'.
>
> Removing this will lead to more efficient use of atomic instructions.

Wow, nice find.

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-aspeed/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> index a293137f5814..163931a03136 100644
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -26,7 +26,6 @@ config MACH_ASPEED_G4
>  config MACH_ASPEED_G5
>         bool "Aspeed SoC 5th Generation"
>         depends on ARCH_MULTI_V6
> -       select CPU_V6
>         select PINCTRL_ASPEED_G5 if !CC_IS_CLANG

I can't find any trees with !CC_IS_CLANG here. Is there a problem
building our pinmux driver with Clang?

I tested with this patch:

--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -25,8 +25,8 @@ config MACH_ASPEED_G4

 config MACH_ASPEED_G5
        bool "Aspeed SoC 5th Generation"
+       # This implies ARMv6K which covers the ARM1176
        depends on ARCH_MULTI_V6
-       select CPU_V6
        select PINCTRL_ASPEED_G5
        select FTTMR010_TIMER
        help

If you want to apply that as a fix for 5.4 I would be happy with that.

Fixes: 8c2ed9bcfbeb ("arm: Add Aspeed machine")
Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
