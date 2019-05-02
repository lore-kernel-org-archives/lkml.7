Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D0AC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91672075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556799693;
	bh=R/ozEIIEfsa2BBgUE6Zb0DzWINwSciwlbxuHIoiZm/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O1afbVJE9Jlj3hD5bAUsUC0M49CRVBXXHVUZrNXX7Nk94o3Rsp9M2QvTeB5yBfS7t
	 YLKDQzeA+MVEx0AlaLGZAqGeMPs0qTX8yxyglU7XITWYpQ7pVBpxenWlnhT6E0cCfq
	 iC98jOOLFHh5kbDb/chMVlnBXQtnB26WzDruVk38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfEBMVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfEBMVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:21:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6C920645;
        Thu,  2 May 2019 12:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556799691;
        bh=R/ozEIIEfsa2BBgUE6Zb0DzWINwSciwlbxuHIoiZm/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0XTRRMUhLI54mTjNUrl3u8Pgw1CnKMLL7BU/VWQQLVvLwEqsg2QGEFYkOLCrfMefg
         72/5LLgQvaEFw/NGIvQTFrCbD2sBmrd1FZVuXsTUDJcnapwzEJij3k7uGBg9fKZk6J
         NYNl4NCI3Zb1X9/mQWzxXz0YyeQTvgjb68kltXAw=
Date:   Thu, 2 May 2019 14:21:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: Linux 5.1-rc5
Message-ID: <20190502122128.GA2670@kroah.com>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:
> On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Can we please have the page refcount overflow fixes out on the list
> > for review, even if it is after the fact?
> 
> They were actually on a list for review long before the fact, but it
> was the security mailing list. The issue actually got discussed back
> in January along with early versions of the patches, but then we
> dropped the ball because it just wasn't on anybody's radar and it got
> resurrected late March. Willy wrote a rather bigger patch-series, and
> review of that is what then resulted in those commits. So they may
> look recent, but that's just because the original patches got
> seriously edited down and rewritten.
> 
> That said, powerpc and s390 should at least look at maybe adding a
> check for the page ref in their gup paths too. Powerpc has the special
> gup_hugepte() case, and s390 has its own version of gup entirely. I
> was actually hoping the s390 guys would look at using the generic gup
> code.
> 
> I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
> largely irrelevant, partly since even theoretically this whole issue
> needs a _lot_ of memory.
> 
> Michael, Martin, see commit 6b3a70773630 ("Merge branch 'page-refs'
> (page ref overflow)"). You may or may not really care.

I've now queued these patches up for the next round of stable releases,
as some people seem to care about these.

I didn't see any follow-on patches for s390 or ppc64 hit the tree for
these changes, am I just missing them and should also queue up a few
more to handle this issue on those platforms?

thanks,

greg k-h
