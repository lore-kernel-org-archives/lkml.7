Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151E4C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE72423427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfH3QHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:07:10 -0400
Received: from verein.lst.de ([213.95.11.211]:56912 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbfH3QHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:07:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D5BB227A8A; Fri, 30 Aug 2019 18:07:05 +0200 (CEST)
Date:   Fri, 30 Aug 2019 18:07:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/26] openrisc: map as uncached in ioremap
Message-ID: <20190830160705.GF26887@lst.de>
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-6-hch@lst.de> <20190823135539.GC24874@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823135539.GC24874@lianli.shorne-pla.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 10:55:39PM +0900, Stafford Horne wrote:
> On Sat, Aug 17, 2019 at 09:32:32AM +0200, Christoph Hellwig wrote:
> > Openrisc is the only architecture not mapping ioremap as uncached,
> > which has been the default since the Linux 2.6.x days.  Switch it
> > over to implement uncached semantics by default.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/openrisc/include/asm/io.h      | 20 +++-----------------
> >  arch/openrisc/include/asm/pgtable.h |  2 +-
> >  arch/openrisc/mm/ioremap.c          |  8 ++++----
> >  3 files changed, 8 insertions(+), 22 deletions(-)
> 
> Acked-by: Stafford Horne <shorne@gmail.com>

Can you send this one to Linus for 5.4?  That would help with the
possibility to remove ioremap_nocache after that.
