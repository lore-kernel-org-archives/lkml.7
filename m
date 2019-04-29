Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11CCC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739D02087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u+N9CRmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfD2HzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:55:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfD2HzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hvE5SI1O3XGBkD5CoDMawzofEYkCTr67IRpGFw2jAks=; b=u+N9CRmjlBk9buV0++UiGppXr
        YzjSKIiNGrJ5PlnsHj2+s50iJ2ASQrljmIC8k7r69ERZt92Zu7jPiTK7HreaaYMm5cU4+kAJOXcXf
        CkFFj91aUQG/RKIxI+MRcBSzbrfCBDSn4n/9RQioYxub6WuGx4vs2hv7jPclAAJPDte5qYsFl5/v3
        2ArlQOem+w8+95lrihG3SMqaeqoC/oUXlr0+TZSTs/iC7Tjoug2GZTZKnJ8HUoY9h5fvvt0hsdOeT
        XxuM9YPGAbF/1fJcPX/gggDQ7nSKj7cQRrDJipTNeS8D0jqgEdd0Dc4hplq2P2jyhFzS63uCz8e8m
        4JM3BlO0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hL182-0000BV-DT; Mon, 29 Apr 2019 07:55:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B080129A2413B; Mon, 29 Apr 2019 09:55:07 +0200 (CEST)
Date:   Mon, 29 Apr 2019 09:55:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     k-onishi <princeontrojanhorse@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] feat(CFS Bandwidth): add an interface for CFS Bandwidth
Message-ID: <20190429075507.GH2623@hirez.programming.kicks-ass.net>
References: <20190428073207.6733-1-princeontrojanhorse@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428073207.6733-1-princeontrojanhorse@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 04:32:06PM +0900, k-onishi wrote:
> I added an interface which is more intuitive
> and takes less write/read systemcalls.
> 
> I think that most people don't really care period
> and quota of CFS Bandwidth,
> 
> They just use it like
> "I will allow this process to use 50% of single core" in most cases.
> 
> But I know that we still need to care period and quota in some cases.
> 
> Please consider for merging this if you like, thanks.

This is ABI, never just add ABI without proper consideration. And given
we can already do this, it sreves no purpose what so ever.

If people cannot compute a runtime from a period, they have no business
being admin on a computer.
