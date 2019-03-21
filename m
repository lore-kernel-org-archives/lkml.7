Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE00EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77160218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB2KJH3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfCUO51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:57:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34129 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfCUO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:57:27 -0400
Received: by mail-io1-f67.google.com with SMTP id n11so5488783ioh.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjsgt6Aqx7oH5BwvLrgL99/8MiP+6Zvi5IilPlGVJxQ=;
        b=XB2KJH3J2gCjf1pZZg24jMYLdSBPwkQzILEi/FejQu6Pf7/CJub42d0qOR/sV3eLgT
         TPdVFGWgqaboLi5fgCHrwFewBAiK8qbwWCRneASoDm4T03O9yeXvgMwwUXpXrvIlrL21
         sRTKLYq3Ts1rz9Gq6EyLAADRORbSz/IBEpnnioRo9Aa05ncNBDtD3Ho7hLzdZjNxNvN5
         aKzgMZ3Jsv8PMBHcr5nE2+g5X/0n/PX9Vo1ejKUvjXXeyNIgNN3enKtjA3LnTEUxd5JG
         7gvZIFAYULr1WZSHXJA4R0wx5LN3ZRfIjjXNhXnz0PVKDyVoxBuTGuuj3AhbGy4jb/nS
         OiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjsgt6Aqx7oH5BwvLrgL99/8MiP+6Zvi5IilPlGVJxQ=;
        b=ExDtPIZTO1fRXWIuur54NsutjlKRwzwBStJN/YNAv4Juio4tkZYxDJg531MAHk7ziM
         l1jckVM2VAMe9nzw9deB2W7N+dDHl9FJ3QQ47vpjVTQ+m4WAHGs1ggJ/nF6i++J84nUD
         bSFKDT2CKmytyKWSL65dlRW3EuHXXvIjNUOBBT3hLBhyAArICInwnYwNjZsWYGFVrmJl
         MN3EuFgpWTbXy5z16zt/rIjF4QvsqBMi2F9atnFXy5W9DkEchwLr3ISHZFwqwFQx7ezw
         X8QHtzPUzluuDSAmeh2pfxa18ZJHgT3Vcg/CIRqTChZYmCp7vNx/1qsCOfkI4YTiDJ2y
         Yuzg==
X-Gm-Message-State: APjAAAXY5FbnzmvC5Lfa70fwQkGyEXpAwpsbUM5vZ0VkjShAGLtINMnv
        tqeAr66BqFQKrsP0yaddA0CAaZruRPK4MxbJioc=
X-Google-Smtp-Source: APXvYqzxRS1kXY2xaoZBXAGZ+OMQz+oaLnMosAKZOnpL9u3TFqvMg5uCXwWpAmzAXmpTJWygII57Ts3nFbOgPEwytZI=
X-Received: by 2002:a5e:a505:: with SMTP id 5mr3231808iog.28.1553180246564;
 Thu, 21 Mar 2019 07:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190321140747.10927-1-thirtythreeforty@gmail.com>
In-Reply-To: <20190321140747.10927-1-thirtythreeforty@gmail.com>
From:   George Hilliard <thirtythreeforty@gmail.com>
Date:   Thu, 21 Mar 2019 08:57:15 -0600
Message-ID: <CACmrr9jTF8RpYh5aztwgNpzC10otnd2UWokyKZX84W+yyODi0w@mail.gmail.com>
Subject: Re: [PATCH] mips: ralink: allow zboot
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I just thought about this: do I need to do a `make
olddefconfig` for all the ralink-based defconfigs to let them choose a
default compression method?  (I'm somewhat new to kernel
contributions, sorry if this is obvious.)

Thanks,
George

On Thu, Mar 21, 2019 at 8:08 AM George Hilliard
<thirtythreeforty@gmail.com> wrote:
>
> Architecturally, there's nothing preventing compressed images from
> working.  Bootloaders built with support for the various compression
> methods can decompress and run the kernel.  In practice, many
> bootloaders do not support compressed images, but kernels for those
> boards should just not be compressed.
>
> Tested on an MT7688 with U-Boot doing LZMA decompression of uImage.
>
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 4a5f5b0ee9a9..b286fbbd9699 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -619,6 +619,7 @@ config RALINK
>         select SYS_SUPPORTS_32BIT_KERNEL
>         select SYS_SUPPORTS_LITTLE_ENDIAN
>         select SYS_SUPPORTS_MIPS16
> +       select SYS_SUPPORTS_ZBOOT
>         select SYS_HAS_EARLY_PRINTK
>         select CLKDEV_LOOKUP
>         select ARCH_HAS_RESET_CONTROLLER
> --
> 2.21.0
>
