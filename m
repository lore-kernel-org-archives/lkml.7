Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00E8C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CA1214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c5eWmIVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCKXQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:16:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfCKXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Br46lGaHLLPas131613WNAWzOcK3hkenTAoL8GthMww=; b=c5eWmIVHq6dZRZYDzabKP/5PK
        FMF8Edg+cPcp2VCJpQ+E1US4MjznNvMutd82So391HEnzp8oGlORJfMQQPScUwIsqktnBMLzWLi+F
        s9JCc30p9hwOib62LxhOVpimJ9jEzBvQENLXp357T97xf738zjn9KVCLoXtSmnfq9uBf/LnP34GDI
        BhSiZlgThp1UplG+Cy+rQ9cORsr+TFseLbaDm/J6t/wh3b5ABJgJCrkM0czKvmtTrsqfKat8pcm77
        yuvWdLoWYnmQklHxl8wxB34Cn+QyBffL566/AwtLfIaU/XTIyyLrXrZQ80sP5Nmt3j+O4y4HxG3j1
        imT5lRboQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3U9q-0005zC-0K; Mon, 11 Mar 2019 23:16:34 +0000
Date:   Mon, 11 Mar 2019 16:16:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Message-ID: <20190311231633.GF19508@bombadil.infradead.org>
References: <20190311010744.5862-1-tobin@kernel.org>
 <20190311204919.GA20002@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311204919.GA20002@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 08:49:23PM +0000, Roman Gushchin wrote:
> The patchset looks good to me, however I'd add some clarifications
> why switching from lru to slab_list is safe.
> 
> My understanding is that the slab_list fields isn't currently in use,
> but it's not that obvious that putting slab_list and next/pages/pobjects
> fields into a union is safe (for the slub case).

It's already in a union.

struct page {
        union {
                struct {        /* Page cache and anonymous pages */
                        struct list_head lru;
...
                struct {        /* slab, slob and slub */
                        union {
                                struct list_head slab_list;     /* uses lru */
                                struct {        /* Partial pages */
                                        struct page *next;

slab_list and lru are in the same bits.  Once this patch set is in,
we can remove the enigmatic 'uses lru' comment that I added.
