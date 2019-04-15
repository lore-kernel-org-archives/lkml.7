Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0154BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ED12075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa4FP18a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfDOQML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:12:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41500 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfDOQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:12:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id g6so11236283edc.8;
        Mon, 15 Apr 2019 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mfR67O5uzhL+W/kXKjgRK+h5z0stG4aLMzE9rLCaSq8=;
        b=Pa4FP18aCYBhzUXu2XjNKs/oVZXE2oLwsAfV7jMTCdOLP49806h4Coc+nM/W9Vt8NP
         rwRLynhfrjIn4Z3WNbUg6Jt/x5upHLJQ8Hv/vngT+WtNpKl+xid7PbRHh2108Cs3R9+n
         O3PArttb9+0jIxmd5TVrw+dPgi/WRIIsATN1UQqRvsEgza3I/tZ4Pgex+uMRR+2HMejt
         4InA33r9hvYYgeiluyIt4pmfRdsuu47YbTcf8ssyHU1AX+ZZWLiDMvzKpf0luaI2FQZz
         4Q7Q3xH7tuZjkquSF8PqYbrVONfmtb7qLtOfAgxyP44zbQh1aTIbC+DQYmT7ybrFjIY+
         g7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfR67O5uzhL+W/kXKjgRK+h5z0stG4aLMzE9rLCaSq8=;
        b=YAHJVHpCPg0b3qkVlPo35zYdvACeLkKqwji/JBcqYcjMiSf+OQaWw4tZ9XvG2wrCVa
         q5br5Yf282i8CU147HcNLf2lYigy/N5glhFwftqOKJ+OIz4ZFGJl+uu2L/4f/h1YIPrW
         rbQGM9KY6PjO3FlbtxSKVzNZYC4tVg2IIJqWKh1Gwq7awmxM/C8ReFfVndufoBNt2dYI
         lyktrFaNQg7fl4u8D7dpd+eouK1zR0GtmQWcUviaxM/hA3z4QDYx+CdRSCOhsm9TPBRu
         y+epRoge4iN4j2DbKX8HRGfNP+38GW41EHQGUhArb+TRkeFvRb9T/I2rj77f6cVhPm3T
         xdkw==
X-Gm-Message-State: APjAAAW6tBqukhiG2vewXTfFFYQMjdNt4HKVa+XsJpE4Wihbb3Egvg7s
        w9e/Btn/78mWMa2bxyYf5Ug=
X-Google-Smtp-Source: APXvYqz1DwAQSX/GFh3COJel1OdmJib8l9US29q0JS6adOO/Bi2PmX9Be9UghKvTSeqA+fLbPsfrXg==
X-Received: by 2002:a50:9052:: with SMTP id z18mr9214097edz.256.1555344728991;
        Mon, 15 Apr 2019 09:12:08 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id i12sm9249007ejp.57.2019.04.15.09.12.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Apr 2019 09:12:08 -0700 (PDT)
Date:   Mon, 15 Apr 2019 09:12:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] s390: boot, purgatory: pass $(CLANG_FLAGS) where
 needed
Message-ID: <20190415161206.GA6928@archlinux-i9>
References: <20190415083605.2560074-1-arnd@arndb.de>
 <20190415083605.2560074-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415083605.2560074-2-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:35:52AM +0200, Arnd Bergmann wrote:
> The purgatory and boot Makefiles do not inherit the original cflags,
> so clang falls back to the default target architecture when building it,
> typically this would be x86 when cross-compiling.
> 
> Add $(CLANG_FLAGS) everywhere so we pass the correct --target=s390x-linux
> option when cross-compiling.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/s390/Makefile           | 4 ++--
>  arch/s390/purgatory/Makefile | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 9c079a506325..9a228786e34f 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -17,9 +17,9 @@ KBUILD_CFLAGS_MODULE += -fPIC
>  KBUILD_AFLAGS	+= -m64
>  KBUILD_CFLAGS	+= -m64
>  aflags_dwarf	:= -Wa,-gdwarf-2
> -KBUILD_AFLAGS_DECOMPRESSOR := -m64 -D__ASSEMBLY__
> +KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
>  KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
> -KBUILD_CFLAGS_DECOMPRESSOR := -m64 -O2
> +KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
>  KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index ce6a3f75065b..ecd0b3847fef 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -22,6 +22,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
>  KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
>  KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
>  KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
> +KBUILD_CFLAGS += $(CLANG_FLAGS)
>  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
>  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
>  
> -- 
> 2.20.0
> 
