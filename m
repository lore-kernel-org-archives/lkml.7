Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E71DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D2C207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bVexAHVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbfIFKn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:43:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfIFKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uDVMSGf1AOvcOHnkrMI95vWCK7Pdvk5wBh0T9EQX0Ko=; b=bVexAHVxWdRsKDWXY577j+0eM
        QMU4F5MtSeIFyzH1R+vfsFtE3sJ2K7fHQVVr2/p9sOuFhExyUgRgwwhWOZg1LpNCnJJ7+9GYceEyq
        RqG2ZWHJmPxTJ4xi8SKw5+8G5zyoTal8/6RS+M5c3Wl/BVwBTmbKaKLGKun40PK1Gn+FZMqq+tfFD
        n8UhYPbvVNq4prd5/JXb6ZsPFnrOVd6LIY5ptD+NukfEYP2n/+1mfyp27rUUeXlhbYbHllRzpXDLb
        PZMwDt7F8899XDJ6H/v8KnQHMjTwegfkdVn6TnCxnPgYhHxw8jNJrjd54ltPfXoUI+Uf6mDt6qyFB
        hY/KQPhRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i6BiR-0006Kj-GL; Fri, 06 Sep 2019 10:43:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28E1C306023;
        Fri,  6 Sep 2019 12:43:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8900129E2C33C; Fri,  6 Sep 2019 12:43:41 +0200 (CEST)
Date:   Fri, 6 Sep 2019 12:43:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Austin Kim <austindh.kim@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dvhart@infradead.org, andy@infradead.org, hpa@zytor.com,
        allison@lohutok.net, armijn@tjaldur.nl, kjlu@umn.edu,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: move kmalloc() NULL check routine
Message-ID: <20190906104341.GW2349@hirez.programming.kicks-ass.net>
References: <20190905232951.GA28779@LGEARND20B15>
 <20190906093252.GB16843@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906093252.GB16843@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:32:52AM +0200, Greg KH wrote:
> On Fri, Sep 06, 2019 at 08:29:51AM +0900, Austin Kim wrote:
> > The result of kmalloc should have been checked ahead of below statement:
> > 	pqp = (struct bau_pq_entry *)vp;
> > 
> > Move BUG_ON(!vp) before above statement.
> > 
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> > ---
> >  arch/x86/platform/uv/tlb_uv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
> > index 20c389a..5f0a96bf 100644
> > --- a/arch/x86/platform/uv/tlb_uv.c
> > +++ b/arch/x86/platform/uv/tlb_uv.c
> > @@ -1804,9 +1804,9 @@ static void pq_init(int node, int pnode)
> >  
> >  	plsize = (DEST_Q_SIZE + 1) * sizeof(struct bau_pq_entry);
> >  	vp = kmalloc_node(plsize, GFP_KERNEL, node);
> > -	pqp = (struct bau_pq_entry *)vp;
> > -	BUG_ON(!pqp);
> > +	BUG_ON(!vp);
> 
> Ick!  Don't crash the whole machine if you are out of memory, that's a
> totally lazy and broken driver.  Fix this up properly please.

This is boot time init; if memory allocation fails, we're in trouble, no
way forward no way back.

It is not uncommon to have BUG_ON() for alloc failing during boot.

> But the original code is just fine (from a this is doing what I want it
> to do point of view), I don't see the need to change anything here, you
> did not modify any logic at all.

Agreed, the patch seems entirely pointless.
