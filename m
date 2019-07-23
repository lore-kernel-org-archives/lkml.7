Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221DCC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEB8223BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563905116;
	bh=rAlMUYDiLSqWc5h78CMWYXPZl9tMbGMy0McuERVfjeM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=LVswbiF1wOxTYcEdvFAn3RHkCnqxWm6o/QXmZiT6w0zPsN+2ABvSjSDoaOaiOwCQY
	 tJgurvQHsukM6h65UyUIkzmVc/p0BPeO0okPTS6+OCTigXWp6QgpXqvyaAfUHfHEEs
	 LL6O+CDzGggduD6DDPgEuXXniKR6I5jbE+0QmyG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfGWSFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfGWSFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:05:14 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D21821926;
        Tue, 23 Jul 2019 18:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563905113;
        bh=rAlMUYDiLSqWc5h78CMWYXPZl9tMbGMy0McuERVfjeM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YQ/N0Xsar7YCkc6u4JNaNtp4JIHg+jQXNIQIJCS7xOhoo207XnXIzqsVtVuxY7wLF
         9E2skJ1Vz2dpuFqSqtBoD0CQdgr5fKlGVFBsGVQ4rvgUs8aCpXTxC1LuCQDMvzmbEl
         QNhSlpOtHcSJAQlqy6VWJcmic4GO09KGFW22MRcY=
Message-ID: <f43c131d9b635994aafed15cb72308b32d2eef67.camel@kernel.org>
Subject: Re: [PATCH] mm: check for sleepable context in kvfree
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        lhenriques@suse.com, cmaiolino@redhat.com,
        Christoph Hellwig <hch@lst.de>
Date:   Tue, 23 Jul 2019 14:05:11 -0400
In-Reply-To: <20190723175543.GL363@bombadil.infradead.org>
References: <20190723131212.445-1-jlayton@kernel.org>
         <3622a5fe9f13ddfd15b262dbeda700a26c395c2a.camel@kernel.org>
         <20190723175543.GL363@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 10:55 -0700, Matthew Wilcox wrote:
> On Tue, Jul 23, 2019 at 01:52:36PM -0400, Jeff Layton wrote:
> > On Tue, 2019-07-23 at 09:12 -0400, Jeff Layton wrote:
> > > A lot of callers of kvfree only go down the vfree path under very rare
> > > circumstances, and so may never end up hitting the might_sleep_if in it.
> > > Ensure that when kvfree is called, that it is operating in a context
> > > where it is allowed to sleep.
> > > 
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Luis Henriques <lhenriques@suse.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  mm/util.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > 
> > FWIW, I started looking at this after Luis sent me some ceph patches
> > that fixed a few of these problems. I have not done extensive testing
> > with this patch, so maybe consider this an RFC for now.
> > 
> > HCH points out that xfs uses kvfree as a generic "free this no matter
> > what it is" sort of wrapper and expects the callers to work out whether
> > they might be freeing a vmalloc'ed address. If that sort of usage turns
> > out to be prevalent, then we may need another approach to clean this up.
> 
> I think it's a bit of a landmine, to be honest.  How about we have kvfree()
> call vfree_atomic() instead?

Not a bad idea, though it means more overhead for the vfree case.

Since we're spitballing here...could we have kvfree figure out whether
it's running in a context where it would need to queue it instead and
only do it in that case?

We currently have to figure that out for the might_sleep_if anyway. We
could just have it DTRT instead of printk'ing and dumping the stack in
that case.
-- 
Jeff Layton <jlayton@kernel.org>

