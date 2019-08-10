Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9DEC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F314F2166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trJX+/kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfHJMyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 08:54:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38341 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfHJMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:54:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id m12so7432342plt.5;
        Sat, 10 Aug 2019 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xGOG7CIt4Bldag/tVJzgtpFcyqFmnN0FNJ0/M8Kuw3I=;
        b=trJX+/kdGJheAbsSuKEUv9xcYOXQJVboGWLdxBays/B5EMU75ntxUavFHJJtmqdJPe
         ZOW3VSHpCRGLGGrugDTX4hUU9VkV5TE7XAdwBUfpO9hawsey6xsApnK4FYjYjCztEQNj
         DBvi/VaZvWcWIIoJ6nkfSvi8uX+A/jqeLxe8jk1NiHLrd3aKmU3QqNQD5vCL/lpk6iU6
         53+H1A1VyT+0HtWI3BkBdiM5/5JnE4e3tqqcDIpS6eYHpo4TQriMAjuizh3gwYbUQHX8
         FvBFH/jsqB2H22LRT84UH0bDjW6ldfUqQjUdwVbA8t3xhRFGlZa9GXwajJVmw6fSwLoY
         tE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xGOG7CIt4Bldag/tVJzgtpFcyqFmnN0FNJ0/M8Kuw3I=;
        b=iuPeCmpO5kYufbq6s9jvxl5wztZYCIrBvf3TsQAZwMYjC5JrnmvCCciZFdFHqXKM30
         abefGiX5IuYd1tC2BCKMEqhxUPaDjdwsaajaz3rDU99+0QZrrcaDOwn1nvn2xS6aSkKv
         jU6MbWUzqe6n9urVnZMt63OIDhaCMQ4khmQnWKLEXitHBHIMlJXqh358WwAFSLQv/UcZ
         Ogs1fUXctxuoAcUa/pxBvvBj3JUR1zWxTwh+o6v+zdG8oTQAc5RU+HMQFLGDMZCh82cJ
         784qviR6QRLsy7lqhlo6PeqDdP+GZrroZVpwHSYrn/u2OcO5bAyvsQVtUnWV95wgSstQ
         XHnA==
X-Gm-Message-State: APjAAAVcAA6JUl5J+jj6+HSgHHEUqd+NMyx+ljqkdc4frtWtTx+EQOOX
        VmWIRwqbNcZC0Z4f37GX8xTswf9Z
X-Google-Smtp-Source: APXvYqyOaKlZmVKKyXoUgChncyuwNfKOOdKlkBcfSRZxMyMhTFtwbfbTET10LfEa0L7wWmirdGHYuw==
X-Received: by 2002:a17:902:be15:: with SMTP id r21mr23253252pls.293.1565441657662;
        Sat, 10 Aug 2019 05:54:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s11sm106867672pgv.13.2019.08.10.05.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 05:54:17 -0700 (PDT)
Date:   Sat, 10 Aug 2019 05:54:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] sh: kernel: disassemble: Mark expected switch
 fall-throughs
Message-ID: <20190810125416.GB19990@roeck-us.net>
References: <20190810052442.GA21354@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810052442.GA21354@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 12:24:42AM -0500, Gustavo A. R. Silva wrote:
> Remove logically dead code and mark switch cases where we are expecting
> to fall through.
> 
> Fix the following warnings (Building: defconfig sh):
> 
> arch/sh/kernel/disassemble.c:478:8: warning: this statement may fall
> through [-Wimplicit-fallthrough=]
> arch/sh/kernel/disassemble.c:487:8: warning: this statement may fall
> through [-Wimplicit-fallthrough=]
> arch/sh/kernel/disassemble.c:496:8: warning: this statement may fall
> through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
>  - Remove logically dead code. Pointed out by Joe Perches.
> 
> NOTE: If no one cares, I'll apply this to my tree and queue it up
>       for 5.3-rc4.
> 
>  arch/sh/kernel/disassemble.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/kernel/disassemble.c b/arch/sh/kernel/disassemble.c
> index defebf1a9c8a..845543780cc5 100644
> --- a/arch/sh/kernel/disassemble.c
> +++ b/arch/sh/kernel/disassemble.c
> @@ -475,8 +475,6 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>  				printk("dbr");
>  				break;
>  			case FD_REG_N:
> -				if (0)
> -					goto d_reg_n;
>  			case F_REG_N:
>  				printk("fr%d", rn);
>  				break;
> @@ -488,7 +486,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>  					printk("xd%d", rn & ~1);
>  					break;
>  				}
> -			d_reg_n:
> +				/* else, fall through */
>  			case D_REG_N:
>  				printk("dr%d", rn);
>  				break;
> @@ -497,6 +495,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>  					printk("xd%d", rm & ~1);
>  					break;
>  				}
> +				/* else, fall through */
>  			case D_REG_M:
>  				printk("dr%d", rm);
>  				break;
> -- 
> 2.22.0
> 
