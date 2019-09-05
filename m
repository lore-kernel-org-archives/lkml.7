Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF80C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC1C2082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KODwrZv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbfIEPYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:24:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731938AbfIEPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4QFZgq5+nT5oEr4DTI39fauvfzjjEc39wNO2ExmrIoY=; b=KODwrZv8ccEHHsY0uJ8BlzfL7B
        UtpzVL7jqpuJ/FUxOYe76sI9fzucF0D+jEeZLiKxfGCeaDdRMzOTVYMNFezcEQgqu6rLLB15GAgZ7
        i7zy+Ofc81azhr5CM7Ok4MaxAXe9T4po8hU44gXx4TnEfneNYMPLBsUEshutsy2pZtKadP6/8evoP
        2boIUWC6cOGOYlDBdDS/6pvDSBD+yjZ/aYcjp99wUThEcBL3UbgEbVYsektsu9sMYhplkMwZvlorD
        xeg+mx6QuduxJr/65Dwb8NStJbN07JEWKhTTRfkclF6lYh4TS4myY7SeGZuhw2GiMOt3bXTMNiSAS
        AHjrlKPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5tck-0004zu-5S; Thu, 05 Sep 2019 15:24:38 +0000
Date:   Thu, 5 Sep 2019 08:24:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
Message-ID: <20190905152438.GA18286@infradead.org>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
 <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 05:21:24PM +0200, Thomas Hellström (VMware) wrote:
> On 9/5/19 4:15 PM, Dave Hansen wrote:
> > Hi Thomas,
> > 
> > Thanks for the second batch of patches!  These look much improved on all
> > fronts.
> 
> Yes, although the TTM functionality isn't in yet. Hopefully we won't have to
> bother you with those though, since this assumes TTM will be using the dma
> API.

Please take a look at dma_mmap_prepare and dma_mmap_fault in this
branch:

	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-mmap-improvements

they should allow to fault dma api pages in the page fault handler.  But
this is totally hot off the press and not actually tested for the last
few patches.  Note that I've also included your two patches from this
series to handle SEV.
