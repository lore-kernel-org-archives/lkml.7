Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C5DC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9326C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfHEDZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:25:15 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:39856 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfHEDZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 23:25:15 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1huTc1-00022l-00; Mon, 05 Aug 2019 03:24:41 +0000
Date:   Sun, 4 Aug 2019 23:24:41 -0400
From:   Rich Felker <dalias@libc.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
Message-ID: <20190805032441.GO9017@brightrain.aerifal.cx>
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 07:14:23PM -0700, Guenter Roeck wrote:
> Since commit a035d552a93b ("Makefile: Globally enable fall-through
> warning"), all sh builds fail with errors such as
> 
> arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
> arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
> 
> Since this effectively disables all build and boot tests for the
> architecture, let's drop -Werror from the sh kernel Makefile until
> the problems are fixed.
> 
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Rich Felker <dalias@libc.org>

> ---
>  arch/sh/kernel/Makefile | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
> index 59673f8a3379..ef65f0625c6c 100644
> --- a/arch/sh/kernel/Makefile
> +++ b/arch/sh/kernel/Makefile
> @@ -47,5 +47,3 @@ obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
>  obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-coherent.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
> -
> -ccflags-y := -Werror
> -- 
> 2.7.4
