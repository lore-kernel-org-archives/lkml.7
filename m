Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334B0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB76620835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ah3y4ju0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfDXUUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:20:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbfDXUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gtC/CUPlFtAMyxjH1wQBFTK5CfdQnQD/owV+EtKziJE=; b=ah3y4ju0TB4PyH0mfIs0dPXWG
        L7DveKuRwVDmOxpNe3CLWQaTEc5D9U3dJe7BbNiRTTVHOkZCOwEUf1m3dVuFgbaIUr8+cwB5at7fU
        /XyJ8iCoynTcQvBt2W6+Hv6I0f9vPFbZMoq2nqUlc/rSGBS++Kv4E5NKI//DnfjBX8Fw1aY8nZSlL
        bVxd3oUpsw+bjk2PD3GDIOecAtwn5BdZhsvZOV4MIVml6rj+V25+ACOn4C3tL3jnkn6t1hVM22Gu2
        ulVlcynDWatW6rCpxM4bv/v3GecYz55R5Jk1Yv7iFgCvWySyaDZ+hvV781lEWUBbDxmZtvFAEkwot
        +0FeunrEQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJONC-0007u8-Vc; Wed, 24 Apr 2019 20:20:06 +0000
Date:   Wed, 24 Apr 2019 13:20:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: Allow userland to request that the kernel clear
 memory on release
Message-ID: <20190424202006.GH19031@bombadil.infradead.org>
References: <20190424191440.170422-1-matthewgarrett@google.com>
 <20190424192812.GG19031@bombadil.infradead.org>
 <CACdnJutj4K1kQj7yXcCNVWM_hmrUwMfZ-JBi=FHkBvYFfbJNZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJutj4K1kQj7yXcCNVWM_hmrUwMfZ-JBi=FHkBvYFfbJNZA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:33:11PM -0700, Matthew Garrett wrote:
> On Wed, Apr 24, 2019 at 12:28 PM Matthew Wilcox <willy@infradead.org> wrote:
> > But you can't have a new PageFlag.  Can you instead zero the memory in
> > unmap_single_vma() where we call uprobe_munmap() and untrack_pfn() today?
> 
> Is there any way the page could be referenced by something other than
> a VMA at this point? If so we probably don't want to zero it here, but
> we do want to zero it when the page is finally released (which is why
> I went with a page flag)

It could be the target/source of direct I/O, or userspace could have
registered it with an RDMA device, or ...

It depends on the semantics you want.  There's no legacy code to
worry about here.  I was seeing this as the equivalent of an atexit()
handler; userspace is saying "When this page is unmapped, zero it".
So it doesn't matter that somebody else might be able to reference it --
userspace could have zeroed it themselves.
