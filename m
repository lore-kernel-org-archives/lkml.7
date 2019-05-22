Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17528C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E149121479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558516878;
	bh=DVBjxMvb6Wz8fKxISx8qC9ooaWc7PjKonoIQtAzmwio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lpi6l3ojIScYhTJc/6zZgZABxYwpa6NTJp1ay9M/frAJ//e/F5RGWjo38+XKRiG1E
	 fmc8CghL8Uy4XlRT6T4jEdlcHnsNdzVg9L2fGjSl8V5jGj18gANxIivBJmaXDtHyGj
	 toQMSDc2Hn0TtxDMrAu2RUhBIiQhD/vqgJq0djVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfEVJVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:21:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728547AbfEVJVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:21:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E3CFADEC;
        Wed, 22 May 2019 09:21:13 +0000 (UTC)
Date:   Wed, 22 May 2019 11:21:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Josh Snyder <joshs@netflix.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 4.19 053/105] mm/mincore.c: make mincore() more
 conservative
Message-ID: <20190522092111.GD32329@dhcp22.suse.cz>
References: <20190520115247.060821231@linuxfoundation.org>
 <20190520115250.721190520@linuxfoundation.org>
 <20190522085741.GB8174@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522085741.GB8174@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-05-19 10:57:41, Pavel Machek wrote:
> Hi!
> 
> > commit 134fca9063ad4851de767d1768180e5dede9a881 upstream.
> > 
> > The semantics of what mincore() considers to be resident is not
> > completely clear, but Linux has always (since 2.3.52, which is when
> > mincore() was initially done) treated it as "page is available in page
> > cache".
> > 
> > That's potentially a problem, as that [in]directly exposes
> > meta-information about pagecache / memory mapping state even about
> > memory not strictly belonging to the process executing the syscall,
> > opening possibilities for sidechannel attacks.
> > 
> > Change the semantics of mincore() so that it only reveals pagecache
> > information for non-anonymous mappings that belog to files that the
> > calling process could (if it tried to) successfully open for writing;
> > otherwise we'd be including shared non-exclusive mappings, which
> > 
> >  - is the sidechannel
> > 
> >  - is not the usecase for mincore(), as that's primarily used for data,
> >    not (shared) text
> 
> ...
> 
> > @@ -189,8 +205,13 @@ static long do_mincore(unsigned long add
> >  	vma = find_vma(current->mm, addr);
> >  	if (!vma || addr < vma->vm_start)
> >  		return -ENOMEM;
> > -	mincore_walk.mm = vma->vm_mm;
> >  	end = min(vma->vm_end, addr + (pages << PAGE_SHIFT));
> > +	if (!can_do_mincore(vma)) {
> > +		unsigned long pages = DIV_ROUND_UP(end - addr, PAGE_SIZE);
> > +		memset(vec, 1, pages);
> > +		return pages;
> > +	}
> > +	mincore_walk.mm = vma->vm_mm;
> >  	err = walk_page_range(addr, end, &mincore_walk);
> 
> We normally return errors when we deny permissions; but this one just
> returns success and wrong data.
> 
> Could we return -EPERM there? If not, should it at least get a
> comment?

This was a deliberate decision AFAIR. We cannot return failure because
this could lead to an unexpected userspace failure. We are pretendeing
that those pages are present because that is the safest option -
e.g. consider an application which tries to refault until the page is
present...

Worth a comment? Probably yes, care to send a patch?
-- 
Michal Hocko
SUSE Labs
