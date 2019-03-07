Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D570C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF622064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1MU/6RI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfCGPg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:36:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47012 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:36:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id f2so13809852edy.13;
        Thu, 07 Mar 2019 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7FMCMEKfEnbJpETgr0p4VyI+09oL5xnXo+j4oOwHufA=;
        b=q1MU/6RIxopvCXzN1fOt1gQnU8HF8NLvKWL1aCrN/xp+CY1zpP5ECX9ez5gmQkjEHo
         uhzGESXKaPtOihyNkiND7parnW3hx9+Eg60dGgMTwwbCgDtxuuIElMKd8JRH7nkDqd7k
         woULA9+NgV6tmo6owMYuBFZQIVl72L6i8dthboIUmgzKhwHd7pbwYdJvFHI2P+dkeirv
         SFSO1ywjda8LxOi0qbdchEG1dRB8VgJe4n9MCPGzMsQCDtsC34lJWtm1QJ7dwfLE5F/q
         K+R0a6WfkxHFwFGw9+KCytBOmyuiPl5SVIuPO+4Vj0P3RGvyZEbe3GQ4ZEQLn2Nv/OKE
         +2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7FMCMEKfEnbJpETgr0p4VyI+09oL5xnXo+j4oOwHufA=;
        b=l8WrZRruDm98XFcXFMmCY499lmzeKj4KtS+KW03JZGuMC6yCsC+IiVvUcl2B2E8t+1
         3+YdS4kO3BP86CalvTL8+HaAWNhBXwqDVbMSdhFYxU/sxJgQqIWk3Y3SNoSjE8Sr8Zbk
         09WwVfBjdlyEzDCN2FtoY9NC6qegKloxA0kxw7d1JQGmuBAC4pr0GV9mP2lVvJaGVzAZ
         fCLXKwjR0PE/r+RNKqtM8HqTs5DpmxiYXBfxl40SK6PoPfez8IY/sxvDPBi2nTT7KlvU
         HAeu7xk0EyhvPRlka+rNx75JO8ibYLG79iztPNBuaptewT+YLSXJ3oLTI88JnoSMJaJf
         rJJg==
X-Gm-Message-State: APjAAAXTXuNLcfmtaS5rQhjjdPq6VeDbRWIvHqxgYhb467vY5J4OJW36
        DseMnNECzmk/Xq/1q7tfkpH26O21qoH7/A==
X-Google-Smtp-Source: APXvYqzBsQwbN1JdIYmThWlIv0QFdeqRBftJ5hBIYkOkZxdcDA5XCwT4GyTUdGVepNO3H7gQbGIPDQ==
X-Received: by 2002:a50:ad4b:: with SMTP id z11mr28082610edc.157.1551972983594;
        Thu, 07 Mar 2019 07:36:23 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id q46sm1408266edd.0.2019.03.07.07.36.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:36:22 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:36:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2: remove incorrect __init annotation
Message-ID: <20190307153620.GK20201@archlinux-ryzen>
References: <20190307103557.1688556-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307103557.1688556-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:35:50AM +0100, Arnd Bergmann wrote:
> omap3xxx_prm_enable_io_wakeup() is marked __init, but its caller is not, so
> we get a warning with clang-8:
> 
> WARNING: vmlinux.o(.text+0x343c8): Section mismatch in reference from the function omap3xxx_prm_late_init() to the function .init.text:omap3xxx_prm_enable_io_wakeup()
> The function omap3xxx_prm_late_init() references
> the function __init omap3xxx_prm_enable_io_wakeup().
> This is often because omap3xxx_prm_late_init lacks a __init
> annotation or the annotation of omap3xxx_prm_enable_io_wakeup is wrong.
> 
> When building with gcc, omap3xxx_prm_enable_io_wakeup() is always
> inlined, so we never noticed in the past.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/arm/mach-omap2/prm3xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
> index 05858f966f7d..dfa65fc2c82b 100644
> --- a/arch/arm/mach-omap2/prm3xxx.c
> +++ b/arch/arm/mach-omap2/prm3xxx.c
> @@ -433,7 +433,7 @@ static void omap3_prm_reconfigure_io_chain(void)
>   * registers, and omap3xxx_prm_reconfigure_io_chain() must be called.
>   * No return value.
>   */
> -static void __init omap3xxx_prm_enable_io_wakeup(void)
> +static void omap3xxx_prm_enable_io_wakeup(void)
>  {
>  	if (prm_features & PRM_HAS_IO_WAKEUP)
>  		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
> -- 
> 2.20.0
> 
