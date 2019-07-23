Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F70C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8898022543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pjwch1Qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391228AbfGWRzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:55:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbfGWRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bl0M5NSk0nmCZFb/3HXW8+xYe1ZmbQXUvDwYm6YUgfk=; b=Pjwch1QkqUDzGn63jiv3m7mO8
        eZhAGD1vxQSBR0t+nWjWFBkokMonpycyRfXPkWsfe4FEf9lJAWvfoGb/0yPbVYiH9z3Hhh6xXEDg5
        zr4VUm0R/xlzryCVOr6PmUmENT6zpTuuKdMQwg5/UK7F1kaOI3VpvG89/rWSIF6RwvvpvQ3MpXHWN
        yQ8muS9Odn+YEFoGSCibtUSbyROrieftl5Bnz5BTaI8Trw3xuvq+Cft1SdWFJ7V6Gtt+aMU6hGGal
        5DaKTYERMJC5hF8XIY0NnhcBt26AgMGDV9jAY6zOWTBbVmIBad4tH4OAALgaUWdrWmFpnTCeI5V+N
        5tdpZCS5A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hpz0p-0004AD-Lp; Tue, 23 Jul 2019 17:55:43 +0000
Date:   Tue, 23 Jul 2019 10:55:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        lhenriques@suse.com, cmaiolino@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm: check for sleepable context in kvfree
Message-ID: <20190723175543.GL363@bombadil.infradead.org>
References: <20190723131212.445-1-jlayton@kernel.org>
 <3622a5fe9f13ddfd15b262dbeda700a26c395c2a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3622a5fe9f13ddfd15b262dbeda700a26c395c2a.camel@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:52:36PM -0400, Jeff Layton wrote:
> On Tue, 2019-07-23 at 09:12 -0400, Jeff Layton wrote:
> > A lot of callers of kvfree only go down the vfree path under very rare
> > circumstances, and so may never end up hitting the might_sleep_if in it.
> > Ensure that when kvfree is called, that it is operating in a context
> > where it is allowed to sleep.
> > 
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Luis Henriques <lhenriques@suse.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  mm/util.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> 
> FWIW, I started looking at this after Luis sent me some ceph patches
> that fixed a few of these problems. I have not done extensive testing
> with this patch, so maybe consider this an RFC for now.
> 
> HCH points out that xfs uses kvfree as a generic "free this no matter
> what it is" sort of wrapper and expects the callers to work out whether
> they might be freeing a vmalloc'ed address. If that sort of usage turns
> out to be prevalent, then we may need another approach to clean this up.

I think it's a bit of a landmine, to be honest.  How about we have kvfree()
call vfree_atomic() instead?
