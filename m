Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A163C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F3C2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfF1HBw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:01:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33599 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF1HBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:01:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so4985807otl.0;
        Fri, 28 Jun 2019 00:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zlZpE9LmGhqv48mxr7/2bVMdXVTGxykVqjh/t5YjPCI=;
        b=NFFVk2HNBax52+upeq3xonSJMgKB8Kpm/au3TCBLYzjuP4CD2IioWSYqBKplFFmRGy
         cB7i8BJccPmqmOBPDc8GKYG2pDWlbXr437/dbNmnZVVGfeog+AsSjzK3RYwdvJSLrtmJ
         cL1rG8Xh+PsMNJftiyzPjTbYrDQrfDAdGnmpECJe6Yb/uo9ptZnSrHIwWWun44VoQJCY
         FCUHYny7s2KCepSP1q5+MO+AZ3JxERf6qky7zUKzaUG0OoYe1UjitEAoPmr3ZUHhUI1/
         q9lnb13V6KKQD9glWB1tmL197ihHC1fqYjUaP3N9+ZIUJ9/zCf7/rydZrqKgEI+0pgy1
         aHPA==
X-Gm-Message-State: APjAAAXEjp9BmaL1Im12xJZwfXVSdxiHXVNgiDtknE0DPlUffe6sn8YH
        NdqUQiIfOHqUUvMJePFBbukEiofqTmbfAUipMjMwsCJR
X-Google-Smtp-Source: APXvYqzqoUBD6q8szLRC5iJdI0leNvVkfzt+kKuwQGrkds7jBjLnB3ZMmJkcDe7lIupd/oYgTtjGRNVsw0ZezSKHVp0=
X-Received: by 2002:a9d:69ce:: with SMTP id v14mr7008388oto.39.1561705311819;
 Fri, 28 Jun 2019 00:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190628062524.5436-1-hch@lst.de>
In-Reply-To: <20190628062524.5436-1-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Jun 2019 09:01:40 +0200
Message-ID: <CAMuHMdVpvu+xzfh3Qee-Yz2H3YDc6CVUocKTwLTUG8gUOQPeGA@mail.gmail.com>
Subject: Re: [PATCH] sh: clkfwk: don't pass void pointers to ioread*
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Jun 28, 2019 at 8:25 AM Christoph Hellwig <hch@lst.de> wrote:
> Passing pointers with a const attrіbute to the ioread* functions
> causes a lot of compiler warnings, so remove the extra attributes.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> ---
>  drivers/sh/clk/cpg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
> index eeb028b9cdb3..4f3d99d37809 100644
> --- a/drivers/sh/clk/cpg.c
> +++ b/drivers/sh/clk/cpg.c
> @@ -36,17 +36,17 @@ static void sh_clk_write(int value, struct clk *clk)
>                 iowrite32(value, clk->mapped_reg);
>  }
>
> -static unsigned int r8(const void __iomem *addr)
> +static unsigned int r8(void __iomem *addr)

This is due to include/asm-generic/io.h and include/asm-generic/iomap.h
using different prototypes, right?

include/asm-generic/io.h:static inline u8 ioread8(const volatile void
__iomem *addr)
include/asm-generic/io.h:static inline u16 ioread16(const volatile
void __iomem *addr)
include/asm-generic/io.h:static inline u32 ioread32(const volatile
void __iomem *addr)
include/asm-generic/io.h:static inline u64 ioread64(const volatile
void __iomem *addr)

include/asm-generic/iomap.h:extern unsigned int ioread8(void __iomem *);
include/asm-generic/iomap.h:extern unsigned int ioread16(void __iomem *);
include/asm-generic/iomap.h:extern unsigned int ioread32(void __iomem *);
include/asm-generic/iomap.h:extern u64 ioread64(void __iomem *);

Wouldn't it be better to fix include/asm-generic/iomap.h and lib/iomap.c
instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
