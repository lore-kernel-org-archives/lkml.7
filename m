Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05157C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD008218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568832614;
	bh=6PhX5srdvtJmEHVj/KpalpakQF+YsaIEeJPCRUAPdoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Pb1ogzIseARIpmFRH4/x+zW7agZj/xknPAqPbMEF6FOJ+netywaFb4UXF3z9Bkyk
	 AbA2RwHDh0Lc/aVvKXjB8lxbla2NYRoSKRJPZvDX+KSyG8Mja4h6EGYaQJpxW3bV6L
	 eaTKPviIByEFzUd3XOIWvyIhAYR5WYrxit7nbeYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfIRSuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387670AbfIRSuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:50:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E4921897;
        Wed, 18 Sep 2019 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568832613;
        bh=6PhX5srdvtJmEHVj/KpalpakQF+YsaIEeJPCRUAPdoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jP24yQmJzdVumGF2v7fLA0B87w3NT/5EC4wIhMKzhsbgYCviAYhVNiu0cYlsEGogM
         tJGpW6jbC7jmc/E+4mX2ED4QMR1H4miCsAkCpjPq0jI0I1Ri/og7NtJFTXpuiDlVTr
         /p5jk5iUMw6fKVtFuVGCjxOX9naf4WBjNWhMjVZk=
Date:   Wed, 18 Sep 2019 20:50:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.4-rc1
Message-ID: <20190918185010.GA1933470@kroah.com>
References: <20190918114754.GA1899504@kroah.com>
 <20190918182412.GA9924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918182412.GA9924@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 11:24:12AM -0700, Christoph Hellwig wrote:
> Just as a note of record:  I don't think either file system move
> is a good idea.  erofs still needs a lot of work, especially in
> interacting with the mm code like abusing page->mapping.

At least it is special-purpose "read only" filesystem currently shipping
on a few million phones, so the fall-out isn't a big deal :)

Also, the erofs developers have been asking for reviews for a very long
time and only now got them.  Which goes back to the issue of vfs reviews
we all discussed last week (see below).

> exfat is just a random old code drop from Samsung hastily picked up,
> and also duplicating the fat16/32 functionality, and without
> consultation of the developes of that who are trying to work through
> their process of contributing the uptodate and official version of it.

Those developers are still yet to be found, we only got a "drop" of the
samsung code _after_ this code was merged, from non-samsung people.  No
samsung developers have said they would actually help with any of this
work, and when asked what differed from the in-tree stuff, I got a list,
but no specifics.  I'll be working through that list over the next month
to resolve those issues.

Also the fat16/32 code is disabled, so that shouldn't be a problem for
anyone.

Again, this is a special-purpose filesystem that will be under heavy
development for a while.  There was no common out-of-tree place that
everyone could actually work on this, just inumerable forks on github,
my own included.  Now we have that common place for this all to be
worked on, and also there is a very good legal benefit for this to be
in-tree, which always is a nice win.

To get back to the meta-problem here, we need a common "vfs/filesystem"
tree somewhere with reviewers.  I'm glad to set up the tree and handle
patches, but I am not a vfs expert by any means (I only understand the
virtual half, not the backing half), so I can't be the only one to do
reviews.  Do you know of anyone that we can drag in as reviewers to help
make it easier for new filesystems to get reviews as well as existing
ones to have their patches collected and forwarded on to Linus at the
proper times?

thanks,

greg k-h
