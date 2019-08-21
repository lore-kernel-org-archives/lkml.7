Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AFEC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F13822DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mwXcinp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfHUB7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:59:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfHUB7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rWwsYJQ7D6AU2lknQBcPDgMRmmPDyzGmI77nZ/As6Qc=; b=mwXcinp/PmkUL7Wt694ZzAc2Y
        KBLZ5ZdKajc1Wqx1nuxmOrHIiZspSmqYohKsR0rNOVAnhb/Npbu4fbll8cUaLeQpMdXjpopfGtaIm
        UG+6WHTVdE6iZa9vQisX7e4Br6h1ySeD5wNbn9qoUqbbDS+KW/2ddA6t5jStBkj4KTWq7FFwzTM0/
        fFI007H4fhDik/zbBuryqPLTgY0LMUNwXOoHYAiGET8gjJJF0ibCx+HC3mL8/suuDB9Z7FdiqNAvn
        /zHf4ejx79OkYhyqIMt7pqcMtGqFJk4TFUCR0HO0lnD+dc8TTbJ9HVMBYz8r/NauZIFrMIATqArH9
        h54FU5v9w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0FuV-0007s6-8q; Wed, 21 Aug 2019 01:59:39 +0000
Date:   Tue, 20 Aug 2019 18:59:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mmap.c: extract __vma_unlink_list as counter part
 for __vma_link_list
Message-ID: <20190821015939.GA28819@bombadil.infradead.org>
References: <20190814021755.1977-1-richardw.yang@linux.intel.com>
 <20190814021755.1977-3-richardw.yang@linux.intel.com>
 <20190814051611.GA1958@infradead.org>
 <20190814065703.GA6433@richard>
 <2c5cdffd-f405-23b8-98f5-37b95ca9b027@suse.cz>
 <20190820172629.GB4949@bombadil.infradead.org>
 <20190821005234.GA5540@richard>
 <20190821005417.GC18776@bombadil.infradead.org>
 <20190821012244.GA13653@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821012244.GA13653@richard>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:22:44AM +0800, Wei Yang wrote:
> On Tue, Aug 20, 2019 at 05:54:17PM -0700, Matthew Wilcox wrote:
> >On Wed, Aug 21, 2019 at 08:52:34AM +0800, Wei Yang wrote:
> >> On Tue, Aug 20, 2019 at 10:26:29AM -0700, Matthew Wilcox wrote:
> >> >On Wed, Aug 14, 2019 at 11:19:37AM +0200, Vlastimil Babka wrote:
> >> >> On 8/14/19 8:57 AM, Wei Yang wrote:
> >> >> > On Tue, Aug 13, 2019 at 10:16:11PM -0700, Christoph Hellwig wrote:
> >> >> >>Btw, is there any good reason we don't use a list_head for vma linkage?
> >> >> > 
> >> >> > Not sure, maybe there is some historical reason?
> >> >> 
> >> >> Seems it was single-linked until 2010 commit 297c5eee3724 ("mm: make the vma
> >> >> list be doubly linked") and I guess it was just simpler to add the vm_prev link.
> >> >> 
> >> >> Conversion to list_head might be an interesting project for some "advanced
> >> >> beginner" in the kernel :)
> >> >
> >> >I'm working to get rid of vm_prev and vm_next, so it would probably be
> >> >wasted effort.
> >> 
> >> You mean replace it with list_head?
> >
> >No, replace the rbtree with a new tree.  https://lwn.net/Articles/787629/
> 
> Sounds interesting.
> 
> While I am not sure the plan is settled down, and how long it would take to
> replace the rb_tree with maple tree. I guess it would probably take some time
> to get merged upstream.
> 
> IMHO, it would be good to have this cleanup in current kernel. Do you agree?

The three cleanups you've posted are fine.  Doing more work (ie the
list_head) seems like wasted effort to me.
