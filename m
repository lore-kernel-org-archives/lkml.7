Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E975C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA853206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx1fZQI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfEMX3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:29:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40134 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEMX3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:29:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id j12so19226174eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 16:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VLmuiK2x214buFhNi8OJWdBB57B0vN2ujFxtEwttig4=;
        b=Xx1fZQI/rXwMk0DNEqY6HTpnrV0we9BxygLROkRRl5cZQTB26deou5ZOsHzCvYx1/C
         i2TVMR2iMmukWTaajQI6iNTvJaF5JHuZmTlAOC+GNyFY+w9c2vrKU6hzB4S9xuYJbWuL
         fsKn6zzk6sCtPvgZjI3iCIZedBkWlWJ0cMx22LzdSBNgiO6cABgPZtTJeGk2JN5hPMMC
         w0lIkZAGiKeORlvON7+rD6kw8y1olPaZof20qZYMcxV+3X8StEeSz0AhVFIT0pHNzwzK
         +jtSYi8V/qWdB7xZYr5RJt9m/1jiANR19MggCDUrU4IGLTbzemqbCQTaprbv3zpjvldT
         3E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VLmuiK2x214buFhNi8OJWdBB57B0vN2ujFxtEwttig4=;
        b=PA6Pg4WRMA29iiE3S4ac4qriNDY3YiuyOQ7e/BlnJdLk3+O2lE5kq6WRBLCweoPGxD
         JuPMwy2AdMkcQiG3uPZs23weT7r7FqjFT2pkuieTpgAjv5IVY9IMRTc7I6WKhqZaPqMT
         riQlQ129te6EtjOABwZPvj7kzu2kBFqd/uzUcUto7YwSQxiN5bQLRsW0gCfui3TCPhaV
         D+1zZK4S/Ioq+n9LgfqUQzkYhJi2DYYnDRP6Lj3Dtvq2uFjZrpM27rKB/+++TVV2CnRR
         utb1GwckOAPaQO2ei+CVlc5gVbCRvpYJEiUvH6UwovDSQ7GBxescEDTTL6xyMHDJUuag
         7b6g==
X-Gm-Message-State: APjAAAWQu+RQu12PMX744PfiSqDaJo3vb21ijxFLrZEu2kSHJ9U/dg7I
        T5qgHezT7bVVN9QbkjYxXJM=
X-Google-Smtp-Source: APXvYqxawMnpBISgLje6SFjg6qRJQc01qR3XlBp+sSIU+0r7yKb1YyuB6Reik9qT2gOQOddQvVSeXA==
X-Received: by 2002:a17:906:aacb:: with SMTP id kt11mr10380582ejb.246.1557790153389;
        Mon, 13 May 2019 16:29:13 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id dc1sm1984448ejb.14.2019.05.13.16.29.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 16:29:12 -0700 (PDT)
Date:   Mon, 13 May 2019 16:29:10 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     keescook@chromium.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathanchance@gmail.com>,
        Jordan Rupprect <rupprecht@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: support llvm-objcopy
Message-ID: <20190513232910.GA30209@archlinux-i9>
References: <20190513222109.110020-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513222109.110020-1-ndesaulniers@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 03:21:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
> llvm-objcopy: error: --set-section-flags=.text conflicts with
> --rename-section=.text=.rodata
> 
> Rather than support setting flags then renaming sections vs renaming
> then setting flags, it's simpler to just change both at the same time
> via --rename-section.
> 
> This can be verified with:
> $ readelf -S drivers/misc/lkdtm/rodata_objcopy.o
> ...
> Section Headers:
>   [Nr] Name              Type             Address           Offset
>        Size              EntSize          Flags  Link  Info  Align
> ...
>   [ 1] .rodata           PROGBITS         0000000000000000  00000040
>        0000000000000004  0000000000000000   A       0     0     4
> ...
> 
> Which shows in the Flags field that .text is now renamed .rodata, the
> append flag A is set, and the section is not flagged as writeable W.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/448
> Reported-by: Nathan Chancellor <nathanchance@gmail.com>

This should be natechancellor@gmail.com (although I think I do own that
email, just haven't been into it for 10+ years...)

> Suggested-by: Jordan Rupprect <rupprecht@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  drivers/misc/lkdtm/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> index 951c984de61a..89dee2a9d88c 100644
> --- a/drivers/misc/lkdtm/Makefile
> +++ b/drivers/misc/lkdtm/Makefile
> @@ -15,8 +15,7 @@ KCOV_INSTRUMENT_rodata.o	:= n
>  
>  OBJCOPYFLAGS :=
>  OBJCOPYFLAGS_rodata_objcopy.o	:= \
> -			--set-section-flags .text=alloc,readonly \
> -			--rename-section .text=.rodata
> +			--rename-section .text=.rodata,alloc,readonly
>  targets += rodata.o rodata_objcopy.o
>  $(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
>  	$(call if_changed,objcopy)
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

I ran this script to see if there was any change for GNU objcopy and it
looks like .rodata's type gets changed, is this intentional? Otherwise,
this works for llvm-objcopy like you show.

-----------

1c1
< There are 11 section headers, starting at offset 0x240:
---
> There are 11 section headers, starting at offset 0x230:
8c8
<   [ 1] .rodata           PROGBITS         0000000000000000  00000040
---
>   [ 1] .rodata           NOBITS           0000000000000000  00000040
10c10

-----------

#!/bin/bash

TMP1=$(mktemp)
TMP2=$(mktemp)

git checkout next-20190513

make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=out mrproper allyesconfig drivers/misc/lkdtm/
readelf -S out/drivers/misc/lkdtm/rodata_objcopy.o > ${TMP1}

curl -LSs https://lore.kernel.org/lkml/20190513222109.110020-1-ndesaulniers@google.com/raw | git am -3

make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=out mrproper allyesconfig drivers/misc/lkdtm/
readelf -S out/drivers/misc/lkdtm/rodata_objcopy.o > ${TMP2}

diff ${TMP1} ${TMP2}
