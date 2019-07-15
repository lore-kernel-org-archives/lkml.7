Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BA82080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q0Qsqf7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfGONG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:06:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbfGONG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S6d0Uh9ElvljaSsYjmJyZ6Glp9AxqeU2DyFta5bh0Vk=; b=q0Qsqf7xUmcdfbA8LatL4rZ+4
        4U+CqUCE7HPY1UJD/kTOy9twF8VftEu1clxmugXS00IRnERoxvFxg6C8tnlXDgnSpS0olgjtVoIES
        U8x6xMrZh6NVol0Edv2GSBuFRQKGjnawJ7BbhQZP+DUKnfahSLfYqu1ZxkJC8WzYnB0xb81ksKnIm
        0rjp+iUd8e9NwMP8p3Ov4NnE2mignjQ2Bi3UipKXSTzzBNsCfnyDnYzugrhCCw41AkbNENZuBfEMu
        y9/KJ5pMqPj64kBhtxgoDEGBlsnbYLsjEYjQh2VWotOgvw+r846gZJXDhYl0HIz4gPt6Qehf9Z6Gd
        txYH2h7Gg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hn0gq-0000nW-QN; Mon, 15 Jul 2019 13:06:48 +0000
Date:   Mon, 15 Jul 2019 06:06:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, dvyukov@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
Message-ID: <20190715130648.GA32320@bombadil.infradead.org>
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190713212548.GZ32320@bombadil.infradead.org>
 <4b4eb1f9-440c-f4cd-942c-2c11b566c4c0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b4eb1f9-440c-f4cd-942c-2c11b566c4c0@linux.alibaba.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 08:47:07PM -0700, Yang Shi wrote:
> 
> 
> On 7/13/19 2:25 PM, Matthew Wilcox wrote:
> > On Sat, Jul 13, 2019 at 04:49:04AM +0800, Yang Shi wrote:
> > > When running ltp's oom test with kmemleak enabled, the below warning was
> > > triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
> > > passed in:
> > There are lots of places where kmemleak will call kmalloc with
> > __GFP_NOFAIL and ~__GFP_DIRECT_RECLAIM (including the XArray code, which
> > is how I know about it).  It needs to be fixed to allow its internal
> > allocations to fail and return failure of the original allocation as
> > a consequence.
> 
> Do you mean kmemleak internal allocation? It would fail even though
> __GFP_NOFAIL is passed in if GFP_NOWAIT is specified. Currently buddy
> allocator will not retry if the allocation is non-blockable.

Actually it sets off a warning.  Which is the right response from the
core mm code because specifying __GFP_NOFAIL and __GFP_NOWAIT makes no
sense.
