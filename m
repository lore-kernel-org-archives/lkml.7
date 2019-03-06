Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE45BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7A52064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551914035;
	bh=pst5NwcuCbqNAVvG4NbfPJQDxobSyRTwregW4uwvFdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XvWnpF9k5itF4mJbqELx92HwtePgz1SYZQX9HwDaNfkDeR9zDCvmwi74mbHEjo5d8
	 H/Wjtya6/AtSXtzDkQvnrjLw4aZQ5SylXl7ZkWKeo5S17y3i59dBAkGC7ZC1dvxH7m
	 uflTwEYdqFxuo5JvGdWJa9ULQ25MBHcODND3KaeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfCFXNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:13:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCFXNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:13:54 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 836AFB664;
        Wed,  6 Mar 2019 23:13:52 +0000 (UTC)
Date:   Wed, 6 Mar 2019 15:13:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, Jiri Kosina <jkosina@suse.cz>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>, Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/3] mm/mincore: make mincore() more conservative
Message-Id: <20190306151351.f8ae1acae51ccad1a3537284@linux-foundation.org>
In-Reply-To: <20190130124420.1834-2-vbabka@suse.cz>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
        <20190130124420.1834-1-vbabka@suse.cz>
        <20190130124420.1834-2-vbabka@suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 13:44:18 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> The semantics of what mincore() considers to be resident is not completely
> clear, but Linux has always (since 2.3.52, which is when mincore() was
> initially done) treated it as "page is available in page cache".
> 
> That's potentially a problem, as that [in]directly exposes meta-information
> about pagecache / memory mapping state even about memory not strictly belonging
> to the process executing the syscall, opening possibilities for sidechannel
> attacks.
> 
> Change the semantics of mincore() so that it only reveals pagecache information
> for non-anonymous mappings that belog to files that the calling process could
> (if it tried to) successfully open for writing.

"for writing" comes as a bit of a surprise.  Why not for reading?

Could we please explain the reasoning in the changelog and in the
(presently absent) comments which describe can_do_mincore()?

> @@ -189,8 +197,13 @@ static long do_mincore(unsigned long addr, unsigned long pages, unsigned char *v
>  	vma = find_vma(current->mm, addr);
>  	if (!vma || addr < vma->vm_start)
>  		return -ENOMEM;
> -	mincore_walk.mm = vma->vm_mm;
>  	end = min(vma->vm_end, addr + (pages << PAGE_SHIFT));
> +	if (!can_do_mincore(vma)) {
> +		unsigned long pages = (end - addr) >> PAGE_SHIFT;

I'm not sure this is correct in all cases.   If

	addr = 4095
	vma->vm_end = 4096
	pages = 1000

then `end' is 4096 and `(end - addr) << PAGE_SHIFT' is zero, but it
should have been 1.

Please check?

A mincore test suite in tools/testing/selftests would be useful,
methinks.  To exercise such corner cases, check for future breakage,
etc.

> +		memset(vec, 1, pages);
> +		return pages;
> +	}
> +	mincore_walk.mm = vma->vm_mm;
>  	err = walk_page_range(addr, end, &mincore_walk);
>  	if (err < 0)
>  		return err;


