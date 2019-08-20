Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499E8C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D412064A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NLMiPJMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfHTR0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:26:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHTR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PeDiA2PJoiVzWMd8z0SSPQVZ1TUnorKfJ5pi4QQ5XHA=; b=NLMiPJMwoo1sgK07WC6S4AT3n
        BSQEFtSik6WtzPk16YY7ml01GFKIZV13XUbnlKXIIZOrRox6n8FoDRmZ4+pRNV2+XJ3aEYWthRAic
        SvIoNHa5ZX8UjUNg7osTsC/e9VSPqeInLNYi3cVTGuGuKoUNN66X9aiaPmreE2J0tt8IpvIzEBoDN
        NtZApH+De7jPQIDaS/XGjsbErclA9QIpbBUuSDl22z/6DhKrzF86czfskWc18jZYi7IYOTpNcEO1u
        T1G4dvI1Ft4obl2l7Z2WYUKRFKmSiDTMwAimJANn1d2YHqfHmkESiQlNJyknqJrq66WYAHyYrSPdk
        0X4MV+EQg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i07tt-0004yW-EF; Tue, 20 Aug 2019 17:26:29 +0000
Date:   Tue, 20 Aug 2019 10:26:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mmap.c: extract __vma_unlink_list as counter part
 for __vma_link_list
Message-ID: <20190820172629.GB4949@bombadil.infradead.org>
References: <20190814021755.1977-1-richardw.yang@linux.intel.com>
 <20190814021755.1977-3-richardw.yang@linux.intel.com>
 <20190814051611.GA1958@infradead.org>
 <20190814065703.GA6433@richard>
 <2c5cdffd-f405-23b8-98f5-37b95ca9b027@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5cdffd-f405-23b8-98f5-37b95ca9b027@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 11:19:37AM +0200, Vlastimil Babka wrote:
> On 8/14/19 8:57 AM, Wei Yang wrote:
> > On Tue, Aug 13, 2019 at 10:16:11PM -0700, Christoph Hellwig wrote:
> >>Btw, is there any good reason we don't use a list_head for vma linkage?
> > 
> > Not sure, maybe there is some historical reason?
> 
> Seems it was single-linked until 2010 commit 297c5eee3724 ("mm: make the vma
> list be doubly linked") and I guess it was just simpler to add the vm_prev link.
> 
> Conversion to list_head might be an interesting project for some "advanced
> beginner" in the kernel :)

I'm working to get rid of vm_prev and vm_next, so it would probably be
wasted effort.
