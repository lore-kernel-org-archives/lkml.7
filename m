Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AA3C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FF0223BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563905947;
	bh=Awat9gsewjbgPYbV/sg1258A8MvYYSlvsfznyoqnKc8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=VQhc6+58U1u5havxlUPGc+ms986qfe2B68ED1Sd1Bn0p+/MBpJSG/71VjCP7Jv+08
	 MguNX6WwEL9hHo4qTmyodS4Rvpmc3Hj6hJfpMnNWKYO6v9JTfLy0F0lp/ZbrMuu+s+
	 2e1BnUNslEU3mgicRABafM3lrp+JlS1SZx7awdYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbfGWSTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfGWSTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:19:05 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 624C62084D;
        Tue, 23 Jul 2019 18:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563905945;
        bh=Awat9gsewjbgPYbV/sg1258A8MvYYSlvsfznyoqnKc8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pAq+kDaHErUf7z0A9YeuslsNjOOpqTeBmy2yWZ/WPZnlJXKuWhoBj4PA0sRvyshLP
         rBChVn4/w7vvs9e33FUkKT96KV42rbexeF9eW4c084faYM+yuugLVh0sxDslZE8WMd
         CiJwB7vdVBFo4aBCYavOSAWt1sD0ejfSPloUQMLU=
Message-ID: <d7cd46333eb1a29fb7e0e078dc4fef7646fe2a8c.camel@kernel.org>
Subject: Re: [PATCH] mm: check for sleepable context in kvfree
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        lhenriques@suse.com, cmaiolino@redhat.com,
        Christoph Hellwig <hch@lst.de>
Date:   Tue, 23 Jul 2019 14:19:03 -0400
In-Reply-To: <20190723181124.GM363@bombadil.infradead.org>
References: <20190723131212.445-1-jlayton@kernel.org>
         <3622a5fe9f13ddfd15b262dbeda700a26c395c2a.camel@kernel.org>
         <20190723175543.GL363@bombadil.infradead.org>
         <f43c131d9b635994aafed15cb72308b32d2eef67.camel@kernel.org>
         <20190723181124.GM363@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 11:11 -0700, Matthew Wilcox wrote:
> On Tue, Jul 23, 2019 at 02:05:11PM -0400, Jeff Layton wrote:
> > On Tue, 2019-07-23 at 10:55 -0700, Matthew Wilcox wrote:
> > > > HCH points out that xfs uses kvfree as a generic "free this no matter
> > > > what it is" sort of wrapper and expects the callers to work out whether
> > > > they might be freeing a vmalloc'ed address. If that sort of usage turns
> > > > out to be prevalent, then we may need another approach to clean this up.
> > > 
> > > I think it's a bit of a landmine, to be honest.  How about we have kvfree()
> > > call vfree_atomic() instead?
> > 
> > Not a bad idea, though it means more overhead for the vfree case.
> > 
> > Since we're spitballing here...could we have kvfree figure out whether
> > it's running in a context where it would need to queue it instead and
> > only do it in that case?
> > 
> > We currently have to figure that out for the might_sleep_if anyway. We
> > could just have it DTRT instead of printk'ing and dumping the stack in
> > that case.
> 
> I don't think we have a generic way to determine if we're currently
> holding a spinlock.  ie this can fail:
> 
> spin_lock(&my_lock);
> kvfree(p);
> spin_unlock(&my_lock);
> 
> If we're preemptible, we can check the preempt count, but !CONFIG_PREEMPT
> doesn't record the number of spinlocks currently taken.


Ahh right...that makes sense.

Al also suggested on IRC that we could add a kvfree_atomic if that were
useful. That might be good for new callers, but we'd probably need a
patch like this one to suss out which of the existing kvfree callers
would need to switch to using it.

I think you're quite right that this is a landmine. That said, this
seems like something we ought to try to clean up.
-- 
Jeff Layton <jlayton@kernel.org>

