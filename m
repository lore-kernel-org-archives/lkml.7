Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C20C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E10E2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfGHVX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:23:27 -0400
Received: from verein.lst.de ([213.95.11.211]:37164 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732593AbfGHVX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:23:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B5F468B05; Mon,  8 Jul 2019 23:23:25 +0200 (CEST)
Date:   Mon, 8 Jul 2019 23:23:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] m68k: don't select ARCH_HAS_DMA_PREP_COHERENT for
 nommu or coldfire
Message-ID: <20190708212325.GA17641@lst.de>
References: <20190708175101.19990-1-hch@lst.de> <CAMuHMdVrAVYWvQCh7AF1O7SRbuZb9fQp9fi0yQyZMeaOpfHyEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVrAVYWvQCh7AF1O7SRbuZb9fQp9fi0yQyZMeaOpfHyEw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 10:39:48PM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Mon, Jul 8, 2019 at 7:51 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > m68k only provides the dma_prep_coherent symbol when an mmu is enabled
> 
> arch_dma_prep_coherent
> 
> > and not on the coldfire platform.  Fix the Kconfig symbol selection
> > up to match this.
> >
> > Fixes: 69878ef47562 ("m68k: Implement arch_dma_prep_coherent()")
> 
> Do you know the SHA1 for the other commit, that causes the issue when
> combined with the above?

I think the culprit is:

commit c30700db9eaabb35e0b123301df35a6846e6b6b4
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jun 3 08:43:51 2019 +0200

    dma-direct: provide generic support for uncached kernel segments


Ad it turns out I can't just apply this fix to the dma-mapping tree
because it doesn't have the m68k changes.  So either you'll have to
queue it up, or I'll have to do secondary pull request to fix up
the first one.  Maybe it is eiter if you just send it to Linus
before I send the dma-mapping PR?
