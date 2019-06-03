Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51793C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24849280BE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfFCM0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:26:12 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:51190
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfFCM0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:26:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id EAFA53FE8A;
        Mon,  3 Jun 2019 14:26:09 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4GK9oelX-c2g; Mon,  3 Jun 2019 14:26:09 +0200 (CEST)
Received: from jerusalem (host64-211-dynamic.48-82-r.retail.telecomitalia.it [82.48.211.64])
        by sysam.it (Postfix) with ESMTPSA id 708F83ED96;
        Mon,  3 Jun 2019 14:26:09 +0200 (CEST)
Date:   Mon, 3 Jun 2019 14:26:08 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: io: Fix io{read,write}{16,32}be() for Coldfire
 peripherals
Message-ID: <20190603122608.GA21347@jerusalem>
References: <20190429081937.7544-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429081937.7544-1-geert@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg (and all),

couldn't seen any follow up on this patch. I tested it and at least
for mcf5441x it works properly and solves all issues.

Do you think it may be accepted as an initial fix ?

Regards,
Angelo

On Mon, Apr 29, 2019 at 10:19:37AM +0200, Geert Uytterhoeven wrote:
> The generic definitions of mmio_{read,write}{16,32}be() in lib/iomap.c
> assume that the {read,write}[wl]() I/O accessors always use little
> endian accesses, and swap the result.
> 
> However, the Coldfire versions of the {read,write}[wl]() I/O accessors are
> special, in that they use native big endian instead of little endian for
> accesses to the on-SoC peripheral block, thus violating the assumption.
> 
> Fix this by providing our own variants, using the raw accessors,
> reinstating the old behavior.  This is fine on m68k, as no special
> barriers are needed, and also avoids swapping data twice.
> 
> Reported-by: Angelo Dureghello <angelo@sysam.it>
> Fixes: aecc787c06f4300f ("iomap: Use non-raw io functions for io{read|write}XXbe")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> This can be reverted later, after this oddity of the Coldfire I/O
> support has been fixed, and drivers have been updated.
> ---
>  arch/m68k/include/asm/io.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
> index aabe6420ead2a599..d47e7384681ab1cd 100644
> --- a/arch/m68k/include/asm/io.h
> +++ b/arch/m68k/include/asm/io.h
> @@ -8,6 +8,12 @@
>  #include <asm/io_mm.h>
>  #endif
>  
> +#define mmio_read16be(addr)		__raw_readw(addr)
> +#define mmio_read32be(addr)		__raw_readl(addr)
> +
> +#define mmio_write16be(val, port)	__raw_writew((val), (port))
> +#define mmio_write32be(val, port)	__raw_writel((val), (port))
> +
>  #include <asm-generic/io.h>
>  
>  #endif /* _M68K_IO_H */
> -- 
> 2.17.1
> 
