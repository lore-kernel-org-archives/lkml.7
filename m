Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9703DC10F00
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7252320684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCGAky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:40:54 -0500
Received: from nautica.notk.org ([91.121.71.147]:56907 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfCGAkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:40:53 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id A4A33C009; Thu,  7 Mar 2019 01:40:51 +0100 (CET)
Date:   Thu, 7 Mar 2019 01:40:36 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20190307004036.GA16785@nautica>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz>
 <20190130124420.1834-2-vbabka@suse.cz>
 <20190306151351.f8ae1acae51ccad1a3537284@linux-foundation.org>
 <nycvar.YFH.7.76.1903070047360.19912@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1903070047360.19912@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina wrote on Thu, Mar 07, 2019:
> > I'm not sure this is correct in all cases.   If
> > 
> > 	addr = 4095
> > 	vma->vm_end = 4096
> > 	pages = 1000
> > 
> > then `end' is 4096 and `(end - addr) << PAGE_SHIFT' is zero, but it
> > should have been 1.
> 
> Good catch! It should rather be something like
> 
> 	unsigned long pages = (end >> PAGE_SHIFT) - (addr >> PAGE_SHIFT);

That would be 0 for addr = 0 and vma->vm_end = 1; I assume we would
still want to count that as one page.
I'm not too familiar with this area of the code, but I think there's a
handy macro we can use for this, perhaps
  DIV_ROUND_UP(end - addr, PAGE_SIZE) ?

kernel/kexec_core.c has defined PAGE_COUNT() which seems more
appropriate but I do not see a global equivalent
#define PAGE_COUNT(x) (((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)

-- 
Dominique
