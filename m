Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F170CC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B285B20880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opNi5P09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390844AbfHBXgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:36:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36669 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388400AbfHBXgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:36:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so36760829pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qUss61uErCv45l6U5vMW/dNDvgWLW+8JpQICeZFcraM=;
        b=opNi5P09MxsE+vav+3iC9q9f+8JyZWly3jBOYMwBH7/jzZOPNqgbw3ZBnJoxiYVWy/
         ADLFS1F8nZrqcMc/ZFiss4V/EfjGtGY0Ir0T928i32sIxtGOHIFzvQ6bqbZtqh92OOAp
         KqtAJFfDGc9dlQ7Ok9JbnuH5BoQk8g78VPRI2qNKGH2mhsN/8zoNSm1wu/3vJJo5GGmr
         +PgOZcWZ6I8AG/HE9Q0a61LYp0sHB7a3lQYKTYgVAHNQCyG4w32/URdSiNh3SWbY0bEE
         9B9vuN6t1s9tQ6824DJQ42CmXh7pyKhaeEyefvebyhWgUA9iMm3JBv5VDW4eVTuQjbfa
         oXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qUss61uErCv45l6U5vMW/dNDvgWLW+8JpQICeZFcraM=;
        b=QxlGyYlySWhoA/WFaVPIm+i7yzp5KkOZxUGQlk5YtYwf6+9I4KxAaA/nDt4uDpWGTO
         uxKrtA9Zkb8HlSCQb9fHqZrRf0cNgbLOLinInGjq0oG+hks2awSDMWQ72DuppHAEWEyP
         0/GU7ADFU0lt4ku7i2DCGEYNg6LHbANs7TIKmpGHc2q7jQLCdpBnPdMXXRDbsPMWdJ4C
         YVpMc+LlZVX8itZ8C5mxDho/0SRIK6RhxGkrxjJ5uXTkW4TSzrT9PTugfvLTOhVuTPm9
         NXWo8T3Benc4CcafYeb7JX0Yc4tiXvjre4ozUsonZ+xpgKAT1j5hQqDnxCv1es5/rC+S
         6dhA==
X-Gm-Message-State: APjAAAV1Nq7srSbb8St1BEVAc/C80SKlZI+U+RdKwhj25fjhz3plYTu9
        3W1uzinFrfWP1KnPn7+rLRdSpb6E
X-Google-Smtp-Source: APXvYqzDF0llQk2e4hhPyuPJbcmSPlotnucj+ud6EVs/2cMJ2smGONRKJKv/bl9eBHE1gGjYVgdGag==
X-Received: by 2002:a17:90a:9a83:: with SMTP id e3mr6485379pjp.105.1564789011564;
        Fri, 02 Aug 2019 16:36:51 -0700 (PDT)
Received: from [192.168.0.106] (124-169-192-12.dyn.iinet.net.au. [124.169.192.12])
        by smtp.gmail.com with ESMTPSA id i74sm23703182pje.16.2019.08.02.16.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 16:36:51 -0700 (PDT)
From:   Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] m68k: Prevent some compiler warnings in coldfire builds
To:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <9ec2190f5be1c4e676a803901200364578662b6d.1564704625.git.fthain@telegraphics.com.au>
Message-ID: <fd5ccd89-987a-3d4b-5c49-9068abadf81d@linux-m68k.org>
Date:   Sat, 3 Aug 2019 09:36:45 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9ec2190f5be1c4e676a803901200364578662b6d.1564704625.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On 2/8/19 10:10 am, Finn Thain wrote:
> Since commit d3b41b6bb49e ("m68k: Dispatch nvram_ops calls to Atari or
> Mac functions"), Coldfire builds generate compiler warnings due to the
> unconditional inclusion of asm/atarihw.h and asm/macintosh.h.
> 
> The inclusion of asm/atarihw.h causes warnings like this:
> 
> In file included from ./arch/m68k/include/asm/atarihw.h:25:0,
>                   from arch/m68k/kernel/setup_mm.c:41,
>                   from arch/m68k/kernel/setup.c:3:
> ./arch/m68k/include/asm/raw_io.h:39:0: warning: "__raw_readb" redefined
>   #define __raw_readb in_8
> 
> In file included from ./arch/m68k/include/asm/io.h:6:0,
>                   from arch/m68k/kernel/setup_mm.c:36,
>                   from arch/m68k/kernel/setup.c:3:
> ./arch/m68k/include/asm/io_no.h:16:0: note: this is the location of the previous definition
>   #define __raw_readb(addr) \
> ...
> 
> This issue is resolved by dropping the asm/raw_io.h include. It turns out
> that asm/io_mm.h already includes that header file.
> 
> Moving the relevant macro definitions helps to clarify this dependency
> and make it safe to include asm/atarihw.h.
> 
> The other warnings look like this:
> 
> In file included from arch/m68k/kernel/setup_mm.c:48:0,
>                   from arch/m68k/kernel/setup.c:3:
> ./arch/m68k/include/asm/macintosh.h:19:35: warning: 'struct irq_data' declared inside parameter list will not be visible outside of this definition or declaration
>   extern void mac_irq_enable(struct irq_data *data);
>                                     ^~~~~~~~
> ...
> 
> This issue is resolved by adding the missing linux/irq.h include.
> 
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>   arch/m68k/include/asm/atarihw.h   | 9 ---------
>   arch/m68k/include/asm/io_mm.h     | 6 +++++-
>   arch/m68k/include/asm/macintosh.h | 1 +
>   3 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/atarihw.h b/arch/m68k/include/asm/atarihw.h
> index 533008262b69..5e5601c382b8 100644
> --- a/arch/m68k/include/asm/atarihw.h
> +++ b/arch/m68k/include/asm/atarihw.h
> @@ -22,7 +22,6 @@
>   
>   #include <linux/types.h>
>   #include <asm/bootinfo-atari.h>
> -#include <asm/raw_io.h>
>   #include <asm/kmap.h>
>   
>   extern u_long atari_mch_cookie;
> @@ -132,14 +131,6 @@ extern struct atari_hw_present atari_hw_present;
>    */
>   
>   
> -#define atari_readb   raw_inb
> -#define atari_writeb  raw_outb
> -
> -#define atari_inb_p   raw_inb
> -#define atari_outb_p  raw_outb
> -
> -
> -
>   #include <linux/mm.h>
>   #include <asm/cacheflush.h>
>   
> diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
> index 6c03ca5bc436..819f611dccf2 100644
> --- a/arch/m68k/include/asm/io_mm.h
> +++ b/arch/m68k/include/asm/io_mm.h
> @@ -29,7 +29,11 @@
>   #include <asm-generic/iomap.h>
>   
>   #ifdef CONFIG_ATARI
> -#include <asm/atarihw.h>
> +#define atari_readb   raw_inb
> +#define atari_writeb  raw_outb
> +
> +#define atari_inb_p   raw_inb
> +#define atari_outb_p  raw_outb
>   #endif
>   
>   
> diff --git a/arch/m68k/include/asm/macintosh.h b/arch/m68k/include/asm/macintosh.h
> index 8f0698bca3dc..8a43babcf53a 100644
> --- a/arch/m68k/include/asm/macintosh.h
> +++ b/arch/m68k/include/asm/macintosh.h
> @@ -4,6 +4,7 @@
>   
>   #include <linux/seq_file.h>
>   #include <linux/interrupt.h>
> +#include <linux/irq.h>
>   
>   #include <asm/bootinfo-mac.h>
>   

Looks good to me:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Geert: I can take this via the m68knommu tree if you like?
Or if you want to pick it up then no problem.

Regards
Greg


