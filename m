Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3446C19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 00:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98C6206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 00:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbfHBAdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 20:33:09 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57248 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfHBAdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 20:33:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id EA18729708;
        Thu,  1 Aug 2019 20:33:06 -0400 (EDT)
Date:   Fri, 2 Aug 2019 10:33:06 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Greg Ungerer <gerg@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Prevent some compiler warnings in coldfire
 builds
In-Reply-To: <9ec2190f5be1c4e676a803901200364578662b6d.1564704625.git.fthain@telegraphics.com.au>
Message-ID: <alpine.LNX.2.21.1908021030090.26@nippy.intranet>
References: <9ec2190f5be1c4e676a803901200364578662b6d.1564704625.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc'd to Coldfire maintainer.]

On Fri, 2 Aug 2019, Finn Thain wrote:

> Since commit d3b41b6bb49e ("m68k: Dispatch nvram_ops calls to Atari or
> Mac functions"), Coldfire builds generate compiler warnings due to the
> unconditional inclusion of asm/atarihw.h and asm/macintosh.h.
> 
> The inclusion of asm/atarihw.h causes warnings like this:
> 
> In file included from ./arch/m68k/include/asm/atarihw.h:25:0,
>                  from arch/m68k/kernel/setup_mm.c:41,
>                  from arch/m68k/kernel/setup.c:3:
> ./arch/m68k/include/asm/raw_io.h:39:0: warning: "__raw_readb" redefined
>  #define __raw_readb in_8
> 
> In file included from ./arch/m68k/include/asm/io.h:6:0,
>                  from arch/m68k/kernel/setup_mm.c:36,
>                  from arch/m68k/kernel/setup.c:3:
> ./arch/m68k/include/asm/io_no.h:16:0: note: this is the location of the previous definition
>  #define __raw_readb(addr) \
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
>                  from arch/m68k/kernel/setup.c:3:
> ./arch/m68k/include/asm/macintosh.h:19:35: warning: 'struct irq_data' declared inside parameter list will not be visible outside of this definition or declaration
>  extern void mac_irq_enable(struct irq_data *data);
>                                    ^~~~~~~~
> ...
> 
> This issue is resolved by adding the missing linux/irq.h include.
> 
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  arch/m68k/include/asm/atarihw.h   | 9 ---------
>  arch/m68k/include/asm/io_mm.h     | 6 +++++-
>  arch/m68k/include/asm/macintosh.h | 1 +
>  3 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/atarihw.h b/arch/m68k/include/asm/atarihw.h
> index 533008262b69..5e5601c382b8 100644
> --- a/arch/m68k/include/asm/atarihw.h
> +++ b/arch/m68k/include/asm/atarihw.h
> @@ -22,7 +22,6 @@
>  
>  #include <linux/types.h>
>  #include <asm/bootinfo-atari.h>
> -#include <asm/raw_io.h>
>  #include <asm/kmap.h>
>  
>  extern u_long atari_mch_cookie;
> @@ -132,14 +131,6 @@ extern struct atari_hw_present atari_hw_present;
>   */
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
>  #include <linux/mm.h>
>  #include <asm/cacheflush.h>
>  
> diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
> index 6c03ca5bc436..819f611dccf2 100644
> --- a/arch/m68k/include/asm/io_mm.h
> +++ b/arch/m68k/include/asm/io_mm.h
> @@ -29,7 +29,11 @@
>  #include <asm-generic/iomap.h>
>  
>  #ifdef CONFIG_ATARI
> -#include <asm/atarihw.h>
> +#define atari_readb   raw_inb
> +#define atari_writeb  raw_outb
> +
> +#define atari_inb_p   raw_inb
> +#define atari_outb_p  raw_outb
>  #endif
>  
>  
> diff --git a/arch/m68k/include/asm/macintosh.h b/arch/m68k/include/asm/macintosh.h
> index 8f0698bca3dc..8a43babcf53a 100644
> --- a/arch/m68k/include/asm/macintosh.h
> +++ b/arch/m68k/include/asm/macintosh.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/seq_file.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  
>  #include <asm/bootinfo-mac.h>
>  
> 
