Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA54C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8176120856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558350575;
	bh=xdE8V/8ROdDMJBxU1DJwKw3mMX0oiKOiXtH4jn4mbsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pPRw1iXgM5NKpPg+2AIc1zpELBVEtSSdokGDW90i4osQ9fCQzVrS9xnrw/nA7FgZM
	 NsIA9DaUfF+ucQ1LQzWgwzubTzIZC2esctOuxH3ISLtXBhswSwxtHzYfe3V5/bxvwo
	 eqH7tFeIOpJx8fFrPOK1TxVzehr0w00jmmz033vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbfETLJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732368AbfETLJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:09:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95A920675;
        Mon, 20 May 2019 11:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558350573;
        bh=xdE8V/8ROdDMJBxU1DJwKw3mMX0oiKOiXtH4jn4mbsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wOVNCDxENKYO0q/G1lnr6pHS2TvfvKKbdZY26Wc07DPYhlcHtBlWtMBI1Z/GNHH+M
         TM70+y+emNI8iJvcY/HDv5rWhNudKkRclkpSM1nrD+Q3sHnrdMUEFtaQlz5fn2IZkr
         bLp4RG9Emu+UfROJ7RmYE8u++Kbk5/voPKSJx1Uo=
Date:   Mon, 20 May 2019 13:09:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: Linux 5.1-rc5
Message-ID: <20190520110930.GC20211@kroah.com>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190502122128.GA2670@kroah.com>
 <20190502161758.26972bb2@mschwideX1>
 <20190502143110.GC17577@kroah.com>
 <20190502171055.132f023c@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502171055.132f023c@mschwideX1>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 05:10:55PM +0200, Martin Schwidefsky wrote:
> On Thu, 2 May 2019 16:31:10 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, May 02, 2019 at 04:17:58PM +0200, Martin Schwidefsky wrote:
> > > On Thu, 2 May 2019 14:21:28 +0200
> > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > >   
> > > > On Mon, Apr 15, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:  
> > > > > On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:    
> > > > > >
> > > > > > Can we please have the page refcount overflow fixes out on the list
> > > > > > for review, even if it is after the fact?    
> > > > > 
> > > > > They were actually on a list for review long before the fact, but it
> > > > > was the security mailing list. The issue actually got discussed back
> > > > > in January along with early versions of the patches, but then we
> > > > > dropped the ball because it just wasn't on anybody's radar and it got
> > > > > resurrected late March. Willy wrote a rather bigger patch-series, and
> > > > > review of that is what then resulted in those commits. So they may
> > > > > look recent, but that's just because the original patches got
> > > > > seriously edited down and rewritten.
> > > > > 
> > > > > That said, powerpc and s390 should at least look at maybe adding a
> > > > > check for the page ref in their gup paths too. Powerpc has the special
> > > > > gup_hugepte() case, and s390 has its own version of gup entirely. I
> > > > > was actually hoping the s390 guys would look at using the generic gup
> > > > > code.
> > > > > 
> > > > > I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
> > > > > largely irrelevant, partly since even theoretically this whole issue
> > > > > needs a _lot_ of memory.
> > > > > 
> > > > > Michael, Martin, see commit 6b3a70773630 ("Merge branch 'page-refs'
> > > > > (page ref overflow)"). You may or may not really care.    
> > > > 
> > > > I've now queued these patches up for the next round of stable releases,
> > > > as some people seem to care about these.
> > > > 
> > > > I didn't see any follow-on patches for s390 or ppc64 hit the tree for
> > > > these changes, am I just missing them and should also queue up a few
> > > > more to handle this issue on those platforms?  
> > > 
> > > I fixed that with a different approach. The following two patches are
> > > queued for the next merge window:
> > > 
> > > d1874a0c2805 "s390/mm: make the pxd_offset functions more robust"
> > > 1a42010cdc26 "s390/mm: convert to the generic get_user_pages_fast code"
> > > 
> > > With these two s390 now uses the generic gup code in mm/gup.c  
> > 
> > Nice!  Do you want me to queue those up for the stable backports once
> > they hit a public -rc release?
> 
> Yes please!

Now queued up to 5.0 and 5.1, but did not apply to 4.19 or older :(

thanks,

greg k-h
