Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FD6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAED20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551911752;
	bh=MnrUjp1HaAv2scXKkmLjwNBR4KrlvQyZ8hyFOJXhyGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=arLjna4Tefzrk8qDJTejP0KSzD4Yy9boyFmDyNdyZeVGbWPzrYxQJg8twqqA7y3Ee
	 DWtL5yvC2Jn63Btq19eNUeVoHSMdlFTMS5+Qg8cSxt2et7L3em5hRg2Xn41uMtj664
	 HdH/dTU/xi6qNtVtosj+pabsUsQ2yd/SHm6GG9Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCFWfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:35:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCFWfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:35:50 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AA70B5975;
        Wed,  6 Mar 2019 22:35:48 +0000 (UTC)
Date:   Wed, 6 Mar 2019 14:35:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyril Hrubis <chrubis@suse.cz>, Daniel Gruss <daniel@gruss.cc>,
        Dave Chinner <david@fromorbit.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Kevin Easton <kevin@guarana.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] mincore() and IOCB_NOWAIT adjustments
Message-Id: <20190306143547.c686225447822beaf3b6e139@linux-foundation.org>
In-Reply-To: <nycvar.YFH.7.76.1903061310170.19912@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
        <20190130124420.1834-1-vbabka@suse.cz>
        <nycvar.YFH.7.76.1903061310170.19912@cbobk.fhfr.pm>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019 13:11:39 +0100 (CET) Jiri Kosina <jikos@kernel.org> wrote:

> On Wed, 30 Jan 2019, Vlastimil Babka wrote:
> 
> > I've collected the patches from the discussion for formal posting. The first
> > two should be settled already, third one is the possible improvement I've
> > mentioned earlier, where only in restricted case we resort to existence of page
> > table mapping (the original and later reverted approach from Linus) instead of
> > faking the result completely. Review and testing welcome.
> > 
> > The consensus seems to be going through -mm tree for 5.1, unless Linus wants
> > them alredy for 5.0.
> > 
> > Jiri Kosina (2):
> >   mm/mincore: make mincore() more conservative
> >   mm/filemap: initiate readahead even if IOCB_NOWAIT is set for the I/O
> > 
> > Vlastimil Babka (1):
> >   mm/mincore: provide mapped status when cached status is not allowed
> 
> Andrew,
> 
> could you please take at least the correct and straightforward fix for 
> mincore() before we figure out how to deal with the slightly less 
> practical RWF_NOWAIT? Thanks.

I assume we're talking about [1/3] and [2/3] from this thread?

Can we have a resend please?  Gather the various acks and revisions,
make changelog changes to address the review questions and comments?

Thanks.
