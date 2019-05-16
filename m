Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78BDC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B294A2087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEPOXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:23:52 -0400
Received: from verein.lst.de ([213.95.11.211]:59774 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPOXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:23:50 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BB4EF68B02; Thu, 16 May 2019 16:23:27 +0200 (CEST)
Date:   Thu, 16 May 2019 16:23:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Bad virt_to_phys since commit 54c7a8916a887f35
Message-ID: <20190516142327.GA23471@lst.de>
References: <20190516133820.GA43059@lakrids.cambridge.arm.com> <20190516134105.GB43059@lakrids.cambridge.arm.com> <20190516141314.GF19122@rapoport-lnx> <20190516142119.GD43059@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516142119.GD43059@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 03:21:19PM +0100, Mark Rutland wrote:
> >  void __weak free_initrd_mem(unsigned long start, unsigned long end)
> >  {
> > +       if (!start)
> > +               return;
> > +
> >         free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
> >                         "initrd");
> >  }
> 
> I think this should work, given Steven's patch checks the same thing.
> 
> I don't have a preference as to which patch should be taken, so I'll
> leave that to Christoph.

We still have plenty of architectures not using the generic
free_initrd_mem, so checking it in the caller gives us better
coverage.
