Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EB9C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DBF20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551916880;
	bh=HgFOMLICi1QJiVbm5oWtZL/K+Q/vZOFKt42rHTdGeK4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=WFlL3BWpFpHzFTAI76s1nllGvefLT7lauc0I8ESUUeXaBOWc9fcRywRIuSu1Fj7AB
	 p/GRDKI2XR1YyDHF6YcVFZbb8lDqPIePyNkJ5bWUl1e/uhZcLrTd4bQHYL30nZmuY7
	 h/E6qq3TK/3p5tVS81xUkc5sII4vbfMhxd4b3iVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCGABT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:01:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCGABR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:01:17 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA77F20663;
        Thu,  7 Mar 2019 00:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551916877;
        bh=HgFOMLICi1QJiVbm5oWtZL/K+Q/vZOFKt42rHTdGeK4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OTMXPM78hTmYuQgl1sjZB0quC4zqJCCgtl4Cv35/WOtanjStfH1Mn020uhu2C9pCv
         tPaoozOqW8KvPTcm8IU7jr/1nSQtel/PR22JIhqglbwLcVWLy9BrwCCj9S+Ft712hQ
         Nk9MLH289O4h65C1ValoAO08JCbKndlBg+BAgmuo=
Date:   Thu, 7 Mar 2019 01:01:10 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>
Subject: Re: [PATCH 1/3] mm/mincore: make mincore() more conservative
In-Reply-To: <20190306151351.f8ae1acae51ccad1a3537284@linux-foundation.org>
Message-ID: <nycvar.YFH.7.76.1903070047360.19912@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-2-vbabka@suse.cz> <20190306151351.f8ae1acae51ccad1a3537284@linux-foundation.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019, Andrew Morton wrote:

> > The semantics of what mincore() considers to be resident is not completely
> > clear, but Linux has always (since 2.3.52, which is when mincore() was
> > initially done) treated it as "page is available in page cache".
> > 
> > That's potentially a problem, as that [in]directly exposes meta-information
> > about pagecache / memory mapping state even about memory not strictly belonging
> > to the process executing the syscall, opening possibilities for sidechannel
> > attacks.
> > 
> > Change the semantics of mincore() so that it only reveals pagecache information
> > for non-anonymous mappings that belog to files that the calling process could
> > (if it tried to) successfully open for writing.
> 
> "for writing" comes as a bit of a surprise.  Why not for reading?

I guess this is a rhetorical question from you :) but fair enough, good 
point, I'll explain this a bit more in the changelog and in the code 
comments.

> > @@ -189,8 +197,13 @@ static long do_mincore(unsigned long addr, unsigned long pages, unsigned char *v
> >  	vma = find_vma(current->mm, addr);
> >  	if (!vma || addr < vma->vm_start)
> >  		return -ENOMEM;
> > -	mincore_walk.mm = vma->vm_mm;
> >  	end = min(vma->vm_end, addr + (pages << PAGE_SHIFT));
> > +	if (!can_do_mincore(vma)) {
> > +		unsigned long pages = (end - addr) >> PAGE_SHIFT;
> 
> I'm not sure this is correct in all cases.   If
> 
> 	addr = 4095
> 	vma->vm_end = 4096
> 	pages = 1000
> 
> then `end' is 4096 and `(end - addr) << PAGE_SHIFT' is zero, but it
> should have been 1.

Good catch! It should rather be something like

	unsigned long pages = (end >> PAGE_SHIFT) - (addr >> PAGE_SHIFT);

I'll fix that up and resend tomorrow.

Thanks,

-- 
Jiri Kosina
SUSE Labs

