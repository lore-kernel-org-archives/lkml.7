Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372C3C282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCEF2146F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDFBzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 21:55:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfDFBzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 21:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C316388AA6;
        Sat,  6 Apr 2019 01:55:50 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E5E919C5B;
        Sat,  6 Apr 2019 01:55:49 +0000 (UTC)
Date:   Sat, 6 Apr 2019 09:55:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mingo@kernel.org, hpa@zytor.com,
        kirill@shutemov.name, keescook@chromium.org,
        yamada.masahiro@socionext.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, thgarnie@google.com,
        mike.travis@hpe.com, frank.ramsay@hpe.com
Subject: Re: [PATCH 1/2] x86/mm/KASLR: Fix the wrong calculation of memory
 region initial size
Message-ID: <20190406015547.GZ7627@MiWiFi-R3L-srv>
References: <20190404020314.8162-1-bhe@redhat.com>
 <20190404020314.8162-2-bhe@redhat.com>
 <20190405165856.GJ23348@zn.tnic>
 <alpine.DEB.2.21.1904051919430.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904051919430.1802@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 06 Apr 2019 01:55:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/19 at 07:22pm, Thomas Gleixner wrote:
> On Fri, 5 Apr 2019, Borislav Petkov wrote:
> > On Thu, Apr 04, 2019 at 10:03:13AM +0800, Baoquan He wrote:
> > > In memory region KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate
> > 
> > What is "memory region KASLR"?
> > 
> > > the initial size of the direct mapping region. This is correct in
> > > the old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> > > 46 bits, and only 4-level mode was supported.
> > > 
> > > Later, in commit:
> > > b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
> > > __PHYSICAL_MASK_SHIFT was changed to be always 52 bits, no matter it's
> > > 5-level or 4-level.
> > > 
> > > This is wrong for 4-level paging since it may cause randomness of KASLR
> > > being greatly weakened in 4-level. For KASLR, we compare the sum of RAM
> > > size and CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING with the size of the
> > > max RAM which can be supported by system, then choose the bigger one as
> > > the value to reserve space for the direct mapping region. The max RAM
> > > supported in 4-level is 64 TB according to MAX_PHYSMEM_BITS. However,
> > > here it's 4 PB in code to be compared with when __PHYSICAL_MASK_SHIFT is
> > > mistakenly used. E.g in a system owning 64 TB RAM, it will reserve 74 TB
> > > (which is 64 TB plus CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING). In fact
> > > it should reserve 64 TB according to the algorithm which is supposed to
> > > do. Obviously the extra 10 TB space should be saved to join randomization.
> > 
> > It is not a trivial situation you're trying to explain and that
> > paragraph is very very hard to understand. I can only rhyme up what
> > you're trying to say.
> > 
> > So please rewrite it using simple declarative sentences. Don't try to
> > say three things in one sentence but say one thing in three sentences.
> > Keep it simple.
> 
> For complex scenarios a simple ascii scheme is often helpful
> 
> Situation A
> 
>     ------- LIMIT1
> 
>     ------- LIMIT2
> 			<- unused area
>     -------
> 
>     ------- 0
> 
> Situation B
> 
>     ------- LIMIT1
> 
> 
> 		
>     ------- LIMIT2
> 
>     ------- 0
> 
> 
> I was not trying to depict your problem, it's just a random thing, but you get
> the idea.

OK, got it. Will rewrite with simpler sentences, and some more
understandable ways to depict. Thanks a lot.

Thanks
Baoquan

