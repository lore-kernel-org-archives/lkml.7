Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88466C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D55F2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQlJ/BiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392412AbfIFGcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:32:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388744AbfIFGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NZb9OMfbhfEBf9CQkdhgvBZ3CNpG50UBGVbYSMEPXRk=; b=nQlJ/BiQGAgDtLtP4cuBwA6Q6F
        OzgJOnZNJdgSVF7a9WbJ3xEHL8XwVOXqyJWKHWDUU+DeQGvrrgEqNRTJjnPTymABWQlkV01eN8SPp
        O/tE7BrzLhpsyRfMV7/QgCJeIe+jlhg8nd/iIJM10Mcs68RnHim+H2nHR/xS1VTTPhhHnT+RWNMhk
        9SBAzMKPJYYo9nwvGXDaj27RLe5VopaHUolqA/5VhiigzDqgPuktzcZ7scLrWWICZYDa9A6IlNZm+
        sNb68z3ID596XCQBv9nbgGDygfVPj4fKgyDhYBLmkWDNh1jdh9ZYZ1ZIQfxiXMeFMZLrizk96LgiH
        DlIjZxIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i67mt-0008Fn-GB; Fri, 06 Sep 2019 06:32:03 +0000
Date:   Thu, 5 Sep 2019 23:32:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: dma_mmap_fault discussion
Message-ID: <20190906063203.GA25415@infradead.org>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
 <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <20190905152438.GA18286@infradead.org>
 <cbbb0e95-8df1-9ab8-59ad-81bd7f3933fa@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbbb0e95-8df1-9ab8-59ad-81bd7f3933fa@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 07:05:43PM +0200, Thomas Hellström (VMware) wrote:
> I took a quick look at the interfaces and have two questions:
> 
> 1) dma_mmap_prepare(), would it be possible to drop the references to the
> actual coherent region? The thing is that TTM doesn't know at mmap time what
> memory will be backing the region. It can be VRAM, coherent memory or system

I guess we can shift the argument checking into the fault handler.

> 2) @cpu_addr and @dma_addr are the values pointing at the beginning of an
> allocated chunk, right?

Yes.

> The reason I'm asking is that TTM's coherent memory
> pool is sub-allocating from larger chunks into smaller PAGE_SIZE chunks,
> which means that a TTM buffer object may be randomly split across larger
> chunks, which means we have to store these values for each PAGE_SiZE chunk.

For implementations that remap non-contigous regions using vmap we need the
start cpu address passed, as that is used to find the vm_struct structure
for it.  That being said I don't see a problem with you keeping track
of the original start and offset into in your suballocation helpers.
