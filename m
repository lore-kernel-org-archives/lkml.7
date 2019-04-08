Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021AFC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB2C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUlOgWV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfDHWDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:03:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46054 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfDHWDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:03:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id f19so6074372edw.12;
        Mon, 08 Apr 2019 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZSmvBT5XuDzX43COpYbrgBxQNOyj1ueYz4Ya7JsnWU0=;
        b=HUlOgWV8OH+Ty/erteazIeXlckg5jcwMSC4kQtlq+08+hK6jCOp7ppsW2ojPm9R+lk
         xfhkbexo6EXkBDTKWmRyRWgjfbyBGz7qcBqE6k5UwCMkpsArMwPqBFpbjeyTF1+8OOqo
         KhJhT5a9itOJmrO/9svZO2O07gl+IMrmZ70xuiem3GdFCbb7/3va18EXEvax6dcZrW+y
         PMY6Bat2E+5qvkGh6bd4b0kmNoD4t3J4I8EYejAuMEl3NUcRxFZVh7p1hrNpzH+Vk6BJ
         z74f/GNFkat5fpytk0UNUjMlfpyXJayC20bFtInA1cC0NjtTQyaS4tHvckNW2SiZPQpR
         vMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZSmvBT5XuDzX43COpYbrgBxQNOyj1ueYz4Ya7JsnWU0=;
        b=ej6MJ4JiOxamZNUR/Ef6PUD0fKBerFHOop3vA49peDjTYeDSRhwrZJwddJ+DGjciTn
         EnMt6sY1pyOayUQF43tyAG6gR9yb8DY/FxAoJ71YVDmb7vrUvwfsUABFpfSKj9fXxVz4
         zXHjds6QVCZdWmVeGVpGmY4T7UG1frF92XPx2HNFTtFGTk6jo/PPie06v4hoA7bUGnZW
         q/gMQ+DFobp7NmX7tHXUjGIwugW+tSMmeXUSUmAl5NCQ9o08dQF8Odglps+gfr5LTR8P
         HXn9KCoHmt9ij3avBQvFK1CB+9ZEnbyiD0dSUbS0Yod7fflzjE4UMEIZKfl7iW61t3nV
         b5zw==
X-Gm-Message-State: APjAAAWLno9ZyTgYUVrW2KMXRGLBMeBTzIh897iR3VFDykITx9Llkk9S
        SMEEnDQfS3ShpusXLCA2dd4=
X-Google-Smtp-Source: APXvYqysV7uD3Yrv8He67Q0ECtHHZsnGqVNFc8waDaCdXTujL20Lu4ZgSvULyhPnVgBx1rKOh+uyZg==
X-Received: by 2002:a17:906:f91:: with SMTP id q17mr17786595ejj.63.1554760995548;
        Mon, 08 Apr 2019 15:03:15 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id k18sm1327892eds.65.2019.04.08.15.03.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 15:03:14 -0700 (PDT)
Date:   Mon, 8 Apr 2019 15:03:12 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-s390@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] s390: purgatory: pass --target option to clang
Message-ID: <20190408220312.GA18333@archlinux-i9>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408212648.2407234-3-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:26:16PM +0200, Arnd Bergmann wrote:
> The purgatory Makefile does not inherit the original cflags,
> so clang falls back to the default target architecture when
> building it, typically this would be x86 when cross-compiling.
> 
> Pass --target=s390x-linux to all compilers that understand
> this option.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/purgatory/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index ce6a3f75065b..3a14b968cec3 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -22,6 +22,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
>  KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
>  KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
>  KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
> +KBUILD_CFLAGS += $(call cc-option,--target=s390x-linux)
>  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
>  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
>  
> -- 
> 2.20.0
> 

Would

ifdef CONFIG_CC_IS_CLANG
KBUILD_CFLAGS += --target=s390x-linux
endif

be a little clearer (and save a cc-option call)?

Otherwise, makes sense.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
