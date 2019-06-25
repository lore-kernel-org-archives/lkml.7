Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C59C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD12820644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfFYHrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:47:23 -0400
Received: from verein.lst.de ([213.95.11.211]:60463 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfFYHrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:47:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3C8A768B02; Tue, 25 Jun 2019 09:46:50 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:46:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] MIPS: use the generic get_user_pages_fast code
Message-ID: <20190625074649.GD30815@lst.de>
References: <20190611144102.8848-1-hch@lst.de> <20190611144102.8848-5-hch@lst.de> <20190621140542.GO19891@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621140542.GO19891@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:05:42AM -0300, Jason Gunthorpe wrote:
> Today this check is only being done on the get_user_pages_fast() -
> after this patch it is also done for __get_user_pages_fast().
> 
> Which means __get_user_pages_fast is now non-functional on a range of
> MIPS CPUs, but that seems OK as far as I can tell, so:

> However, looks to me like this patch is also a bug fix for this:

Yes.

> > -	pgdp = pgd_offset(mm, addr);
> > -	do {
> > -		pgd_t pgd = *pgdp;
> > -
> > -		next = pgd_addr_end(addr, end);
> > -		if (pgd_none(pgd))
> > -			goto slow;
> > -		if (!gup_pud_range(pgd, addr, next, gup_flags & FOLL_WRITE,
> > -				   pages, &nr))
> 
> This is different too, the core code has a p4d layer, but I see that
> whole thing gets NOP'd by the compiler as mips uses pgtable-nop4d.h -
> right?

Exactly.
