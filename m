Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73290C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3212133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfEWJS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:18:28 -0400
Received: from aws.guarana.org ([13.237.110.252]:46702 "EHLO aws.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfEWJS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:18:27 -0400
Received: by aws.guarana.org (Postfix, from userid 1006)
        id 08384A182E; Thu, 23 May 2019 09:18:23 +0000 (UTC)
Date:   Thu, 23 May 2019 09:18:22 +0000
From:   Kevin Easton <kevin@guarana.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Josh Snyder <joshs@netflix.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 4.19 053/105] mm/mincore.c: make mincore() more
 conservative
Message-ID: <20190523091822.GA18121@ip-172-31-14-16>
References: <20190520115247.060821231@linuxfoundation.org>
 <20190520115250.721190520@linuxfoundation.org>
 <20190522085741.GB8174@amd>
 <20190522092111.GD32329@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522092111.GD32329@dhcp22.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:21:11AM +0200, Michal Hocko wrote:
> On Wed 22-05-19 10:57:41, Pavel Machek wrote:
> > Hi!
> > 
> > > commit 134fca9063ad4851de767d1768180e5dede9a881 upstream.
> > > 
> > > The semantics of what mincore() considers to be resident is not
> > > completely clear, but Linux has always (since 2.3.52, which is when
> > > mincore() was initially done) treated it as "page is available in page
> > > cache".
> > > 
> > > That's potentially a problem, as that [in]directly exposes
> > > meta-information about pagecache / memory mapping state even about
> > > memory not strictly belonging to the process executing the syscall,
> > > opening possibilities for sidechannel attacks.
> > > 
> > > Change the semantics of mincore() so that it only reveals pagecache
> > > information for non-anonymous mappings that belog to files that the
> > > calling process could (if it tried to) successfully open for writing;
> > > otherwise we'd be including shared non-exclusive mappings, which
> > > 
> > >  - is the sidechannel
> > > 
> > >  - is not the usecase for mincore(), as that's primarily used for data,
> > >    not (shared) text
> > 
> > ...
> > 
> > > @@ -189,8 +205,13 @@ static long do_mincore(unsigned long add
> > >  	vma = find_vma(current->mm, addr);
> > >  	if (!vma || addr < vma->vm_start)
> > >  		return -ENOMEM;
> > > -	mincore_walk.mm = vma->vm_mm;
> > >  	end = min(vma->vm_end, addr + (pages << PAGE_SHIFT));
> > > +	if (!can_do_mincore(vma)) {
> > > +		unsigned long pages = DIV_ROUND_UP(end - addr, PAGE_SIZE);
> > > +		memset(vec, 1, pages);
> > > +		return pages;
> > > +	}
> > > +	mincore_walk.mm = vma->vm_mm;
> > >  	err = walk_page_range(addr, end, &mincore_walk);
> > 
> > We normally return errors when we deny permissions; but this one just
> > returns success and wrong data.
> > 
> > Could we return -EPERM there? If not, should it at least get a
> > comment?
> 
> This was a deliberate decision AFAIR. We cannot return failure because
> this could lead to an unexpected userspace failure. We are pretendeing
> that those pages are present because that is the safest option -
> e.g. consider an application which tries to refault until the page is
> present...

Yes, in particular several userspace applications I found used mincore()
to find out whether a particular range is mapped at all or not, treating
any error as "unmapped" and any non-error return as "mapped".

    - Kevin
