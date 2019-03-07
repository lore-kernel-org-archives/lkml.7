Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367A120840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551937569;
	bh=woS8eJdF9WhN4ajNoBXAip9dtR/2dJRhAAKFISudxNA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=RL7jq0/eXYDXUCb44e1wYMpdLtehUXeuShxCpkvLQi7915O5KNCvl1lEKYYNEo/Sa
	 QnVdiDl9/qLIMEMDplS+yLvzTAfjr/Dm/FDrafbQEcpq6Z1qnGjt8x058BD7B2p+/L
	 ZLT3EUwnBxV+NzY9c6b0/vRpkykoxHrhCmWByhpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfCGFqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfCGFqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:46:07 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47BE920835;
        Thu,  7 Mar 2019 05:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551937566;
        bh=woS8eJdF9WhN4ajNoBXAip9dtR/2dJRhAAKFISudxNA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JnpI9P7JZvwsGbKHOcx2/JGhPR4vyJd/ZcnCjfwjYyMtNLhlCRy9CwMVhuNuQC9jZ
         k+M7DQS2Z6GhDz7L7A7ychx/sNNQ7Uj8dW/doLFzVkZazEc8s7GKodp1OXF6z717H+
         lA8f3sfTnF8sP3Dj2+wfATWll6jNd1aOxje5dJiQ=
Date:   Thu, 7 Mar 2019 06:46:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>
Subject: Re: [PATCH 1/3] mm/mincore: make mincore() more conservative
In-Reply-To: <20190307004036.GA16785@nautica>
Message-ID: <nycvar.YFH.7.76.1903070643560.19912@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-2-vbabka@suse.cz> <20190306151351.f8ae1acae51ccad1a3537284@linux-foundation.org> <nycvar.YFH.7.76.1903070047360.19912@cbobk.fhfr.pm>
 <20190307004036.GA16785@nautica>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019, Dominique Martinet wrote:

> > > 
> > > 	addr = 4095
> > > 	vma->vm_end = 4096
> > > 	pages = 1000
> > > 
> > > then `end' is 4096 and `(end - addr) << PAGE_SHIFT' is zero, but it
> > > should have been 1.
> > 
> > Good catch! It should rather be something like
> > 
> > 	unsigned long pages = (end >> PAGE_SHIFT) - (addr >> PAGE_SHIFT);
> 
> That would be 0 for addr = 0 and vma->vm_end = 1; I assume we would
> still want to count that as one page.

Yeah, that was bogus as well, ETOOTIRED yesterday, sorry for the noise. 
Both the variants are off.

> I'm not too familiar with this area of the code, but I think there's a
> handy macro we can use for this, perhaps
>   DIV_ROUND_UP(end - addr, PAGE_SIZE) ?
> 
> kernel/kexec_core.c has defined PAGE_COUNT() which seems more
> appropriate but I do not see a global equivalent
> #define PAGE_COUNT(x) (((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)

I'll fix that up when doing the other changes requested by Andrew.

Thanks,

-- 
Jiri Kosina
SUSE Labs

