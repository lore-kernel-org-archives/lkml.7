Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EF5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE63020883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfCYDqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:46:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbfCYDqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:46:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77AA7308A946;
        Mon, 25 Mar 2019 03:46:34 +0000 (UTC)
Received: from localhost (ovpn-12-56.pek2.redhat.com [10.72.12.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE3761001DC8;
        Mon, 25 Mar 2019 03:46:33 +0000 (UTC)
Date:   Mon, 25 Mar 2019 11:46:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        keescook@chromium.org, kirill@shutemov.name,
        yamada.masahiro@socionext.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, thgarnie@google.com
Subject: Re: [PATCH v4 4/6] x86/mm/KASLR: Fix the wrong calculation of memory
 region initial size
Message-ID: <20190325034631.GC3659@MiWiFi-R3L-srv>
References: <20190314094645.4883-1-bhe@redhat.com>
 <20190314094645.4883-5-bhe@redhat.com>
 <alpine.DEB.2.21.1903242144160.1798@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903242144160.1798@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 25 Mar 2019 03:46:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24/19 at 09:58pm, Thomas Gleixner wrote:
> On Thu, 14 Mar 2019, Baoquan He wrote:
> > In memory region KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate
> > the initial size of the direct mapping region. This is correct in
> > the old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> > 46 bits, and only 4-level mode was supported.
> > 
> > Later, in commit:
> > b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
> > __PHYSICAL_MASK_SHIFT was changed to be always 52 bits, no matter it's
> > 5-level or 4-level. This is wrong for 4-level paging. Then when we
> > adapt physical memory region size based on available memory, it
> > will overflow if the amount of system RAM and the padding is bigger
> > than 64 TB.
> 
> I have no idea what that sentence means and what will overflow. Neither I
> have the time to stare at the code to figure it out. Changelogs need to be
> self explanatory. Providing a simple example with numbers or an
> illustration would be helpful.
> 
> > In fact, here MAX_PHYSMEM_BITS should be used instead. Fix it by
> > replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
> 
> So this is an actual bug fix, which is in the middle of this series. Bug
> fixes go first and need to be independent of the rest of the series.
> 
> They also need a Fixes: tag.
> 
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index d7ea6b252594..ebf6d1d92385 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -131,7 +131,7 @@ void __init kernel_randomize_memory(void)
> >  	if (!kaslr_memory_enabled())
> >  		return;
> >  
> > -	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
> > +	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
> >  	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
> 
> That said, I surely can understand why this change needs to be done, but
> the changelog needs to explain the issue so someone with less experience or
> someone looking at this in a year from now doesn't have to bang his head
> against the wall.

OK, let me add example into log and make log more understandable.
Thanks.

I will take out patch 4, 5, 6 of this series and send them out
separately. Then send patch 1, 2 ,3 as a clean up patch series.
