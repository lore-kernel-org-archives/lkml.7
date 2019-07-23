Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C66C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86F5205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I9Ao+ylY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403771AbfGWSL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:11:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfGWSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PtkDHY09nL+AaT/QB8borVWjMlOkOsCWyGNywWHu9dY=; b=I9Ao+ylYbfPsG82DBSU7ktLiX
        4mFNsEoBkXYA6Zop7f+67r/JWnHsYBUo/JyWrJpbf9ac4U4ScV3Ke117Av1aZtxmu0TBOFmYcBkSX
        K1fdaIEgelFroiIQKV+fqL+/kaCzKTC1C3gn8Z1aqPRDi1OHonx5IBVpedCDuyEyFG7E7SGavpPkm
        9OoBLh58J+z9Rup71QNO/XnauElmstPsj8Cm6gJkP0AaC0xJ2RP6FDwsZexddr/2Q4apdT4HaCUsa
        ntB+tu18mYpYM2/hWkot0ngAEKl7DEOkkWPcUWRKTBM1qirdtaNDVWRkdk9a7UQFD7m5po2KPKLV4
        +pUcEueiQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hpzG0-00019M-Np; Tue, 23 Jul 2019 18:11:24 +0000
Date:   Tue, 23 Jul 2019 11:11:24 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        lhenriques@suse.com, cmaiolino@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm: check for sleepable context in kvfree
Message-ID: <20190723181124.GM363@bombadil.infradead.org>
References: <20190723131212.445-1-jlayton@kernel.org>
 <3622a5fe9f13ddfd15b262dbeda700a26c395c2a.camel@kernel.org>
 <20190723175543.GL363@bombadil.infradead.org>
 <f43c131d9b635994aafed15cb72308b32d2eef67.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43c131d9b635994aafed15cb72308b32d2eef67.camel@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 02:05:11PM -0400, Jeff Layton wrote:
> On Tue, 2019-07-23 at 10:55 -0700, Matthew Wilcox wrote:
> > > HCH points out that xfs uses kvfree as a generic "free this no matter
> > > what it is" sort of wrapper and expects the callers to work out whether
> > > they might be freeing a vmalloc'ed address. If that sort of usage turns
> > > out to be prevalent, then we may need another approach to clean this up.
> > 
> > I think it's a bit of a landmine, to be honest.  How about we have kvfree()
> > call vfree_atomic() instead?
> 
> Not a bad idea, though it means more overhead for the vfree case.
> 
> Since we're spitballing here...could we have kvfree figure out whether
> it's running in a context where it would need to queue it instead and
> only do it in that case?
> 
> We currently have to figure that out for the might_sleep_if anyway. We
> could just have it DTRT instead of printk'ing and dumping the stack in
> that case.

I don't think we have a generic way to determine if we're currently
holding a spinlock.  ie this can fail:

spin_lock(&my_lock);
kvfree(p);
spin_unlock(&my_lock);

If we're preemptible, we can check the preempt count, but !CONFIG_PREEMPT
doesn't record the number of spinlocks currently taken.
