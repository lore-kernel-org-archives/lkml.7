Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7049A214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3Al45pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfCLCii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:38:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfCLCih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ok7Jka9kdFefhwhAvAaPL3/12Bc5D9En5EUc/BRhy+g=; b=W3Al45ptYcop7XvpXCgnlleG7
        TIKOrvpx+7LOVG250M7sMevNxQZoQ627xff+ixZVyFr0LG/dt5bqM7C+A73yF0Asx/TzkJYe8YFkZ
        rpWZ9Js6X0PpFSegVFkfJ5pBRJmSsn10l8TdOxPuuHQ8dD4E+nvlvA+OVTD39oNZb6/HMgL0f4+i7
        8fwJTyt2vvpWbYpjDIqr6NJOtH7Ks6Ng61NTZoPZ1LYTT9VDWoDXMAmfmD7lLFVdf9gN9YPFlhnPy
        E79U6+f5j1u1JpDEDey46Fdjb4fWyKUVP+OmB0SEsez0rit5VpJIV2ib4F+rFxmQzOcTRAy9awN/b
        DMY+a1QUA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3XJE-0005kn-RB; Tue, 12 Mar 2019 02:38:28 +0000
Date:   Mon, 11 Mar 2019 19:38:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Roman Gushchin <guro@fb.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Message-ID: <20190312023828.GH19508@bombadil.infradead.org>
References: <20190311010744.5862-1-tobin@kernel.org>
 <20190311204919.GA20002@tower.DHCP.thefacebook.com>
 <20190311231633.GF19508@bombadil.infradead.org>
 <20190312010554.GA9362@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312010554.GA9362@eros.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:05:54PM +1100, Tobin C. Harding wrote:
> > slab_list and lru are in the same bits.  Once this patch set is in,
> > we can remove the enigmatic 'uses lru' comment that I added.
> 
> Funny you should say this, I came to me today while daydreaming that I
> should have removed that comment :)
> 
> I'll remove it in v2.

That's great.  BTW, something else you could do to verify this patch
set is check that the object file is unchanged before/after the patch.
I tend to use 'objdump -dr' to before.s and after.s and use 'diff'
to compare the two.
