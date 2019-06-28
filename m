Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4548C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54E52086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfF1HNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:13:00 -0400
Received: from verein.lst.de ([213.95.11.210]:45777 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfF1HNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:13:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 71D4B68D04; Fri, 28 Jun 2019 09:12:57 +0200 (CEST)
Date:   Fri, 28 Jun 2019 09:12:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sh: clkfwk: don't pass void pointers to ioread*
Message-ID: <20190628071257.GA28615@lst.de>
References: <20190628062524.5436-1-hch@lst.de> <CAMuHMdVpvu+xzfh3Qee-Yz2H3YDc6CVUocKTwLTUG8gUOQPeGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVpvu+xzfh3Qee-Yz2H3YDc6CVUocKTwLTUG8gUOQPeGA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 09:01:40AM +0200, Geert Uytterhoeven wrote:
> This is due to include/asm-generic/io.h and include/asm-generic/iomap.h
> using different prototypes, right?
> 
> include/asm-generic/io.h:static inline u8 ioread8(const volatile void
> __iomem *addr)
> include/asm-generic/io.h:static inline u16 ioread16(const volatile
> void __iomem *addr)
> include/asm-generic/io.h:static inline u32 ioread32(const volatile
> void __iomem *addr)
> include/asm-generic/io.h:static inline u64 ioread64(const volatile
> void __iomem *addr)
> 
> include/asm-generic/iomap.h:extern unsigned int ioread8(void __iomem *);
> include/asm-generic/iomap.h:extern unsigned int ioread16(void __iomem *);
> include/asm-generic/iomap.h:extern unsigned int ioread32(void __iomem *);
> include/asm-generic/iomap.h:extern u64 ioread64(void __iomem *);
> 
> Wouldn't it be better to fix include/asm-generic/iomap.h and lib/iomap.c
> instead?

Oh, I didn't even notice we had this declared by different files..
