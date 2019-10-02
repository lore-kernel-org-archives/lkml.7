Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC466C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937FF21848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XsW8B0AD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfJBSNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:13:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBSNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B05xaQuhRjJFx1QiohMUgG3+4tbrPvqqJ4/dan/Std8=; b=XsW8B0ADu2Ia3ARlJ6UN+ywm7z
        GbT0P98DDvav7eCuvXuSAepYqOhnY6+KEYEMZRyhXEsdFe8shiLpy6785dO3/bAQROU3OwAtkQeez
        NYZznFxJPQPzB5DyV44TQzfLkGCvZsMBygTgvR+/T3OGfBYT2+zeSVtzDdIlV+KatcBIFzZWO2vQF
        7A6iuwwZ+CQDbCoUuNbNPYcBHnyj5kfBn2F1CvMgtIC2A3dWlFrlWFDGm1z/2vyxKAj6ZUk+hMnSB
        C+ZL7Cwurt0wlF9yJ2FktiV23jaP9Ok5HtOW6Ni3Jy5ZBRpmXfQJfH58BkmIaTR/OvtOmTPluvIZ3
        BjlAL3mw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFj8A-0006WK-Ak; Wed, 02 Oct 2019 18:13:42 +0000
Date:   Wed, 2 Oct 2019 11:13:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 3/7] mm: Add write-protect and clean utilities for
 address space ranges
Message-ID: <20191002181342.GB32665@bombadil.infradead.org>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-4-thomas_os@shipmail.org>
 <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:06:43AM -0700, Linus Torvalds wrote:
> On Wed, Oct 2, 2019 at 6:48 AM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
> >
> > From: Thomas Hellstrom <thellstrom@vmware.com>
> >
> > Add two utilities to a) write-protect and b) clean all ptes pointing into
> > a range of an address space.
[...]
> Yes, it's a bit more typing. But I really think
> "clean_mapping_dirty_pages()" is just not only more in line with the
> mm naming, I think it's a lot more legible and understandable than
> "as_dirty_clean()", which just makes me go "what the heck does that
> function do?"
> 
> And I really think it needs more than just "as" -> "mapping".
> "mapping_dirty_clean()" still makes me go "what?" in a way that
> "clean_mapping_dirty_pages()" does not. One name reads as a series or
> random words, the other reads as a "this is what the function does".

I'd suggest clean_mapping_pages() -- a function which does that would
naturally skip the non-dirty pages, and that doesn't need to be in the
function name.
