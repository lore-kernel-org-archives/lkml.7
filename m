Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C427CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8868620880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfDHHyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:54:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfDHHyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:54:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1FE53168907;
        Mon,  8 Apr 2019 07:54:17 +0000 (UTC)
Received: from localhost (ovpn-12-121.pek2.redhat.com [10.72.12.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 468E460CCC;
        Mon,  8 Apr 2019 07:54:17 +0000 (UTC)
Date:   Mon, 8 Apr 2019 15:54:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, kirill@shutemov.name,
        keescook@chromium.org, yamada.masahiro@socionext.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        thgarnie@google.com, mike.travis@hpe.com, frank.ramsay@hpe.com
Subject: Re: [PATCH 1/2] x86/mm/KASLR: Fix the wrong calculation of memory
 region initial size
Message-ID: <20190408075414.GA3856@localhost.localdomain>
References: <20190404020314.8162-1-bhe@redhat.com>
 <20190404020314.8162-2-bhe@redhat.com>
 <20190405165856.GJ23348@zn.tnic>
 <20190406015119.GY7627@MiWiFi-R3L-srv>
 <20190406044348.GA14245@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190406044348.GA14245@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 08 Apr 2019 07:54:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/19 at 06:43am, Borislav Petkov wrote:
> On Sat, Apr 06, 2019 at 09:51:19AM +0800, Baoquan He wrote:
> > It's KASLR happened in kernel_randomize_memory() of arch/x86/mm/kaslr.c .
> 
> What is "KASLR happened in"? This doesn't make any sense. When you look
> at that function, there's a comment above it:
> 
> /* Initialize base and padding for each memory region randomized with KASLR */
> 
> Do you mean, that, per chance?
> 
> > In fact, I don't know how to call it. Previously, I wrote it as mm
> > KASLR, to distinguish from KASLR during kernel decompression. Ingo
> > blamed the name,
> 
> Of course he did, because it didn't make any sense to him either.
> 
> > so I changed it to memory region KASLR. Seems Thomas
> > Garnier called it KASLR for kernel memory regions in his original KASLR
> > adding patch. May I call it 'KASLR for kernel memory regions', or 'KASLR
> > for memory regions'?
> 
> So you're fixing kaslr_regions[0].size_tb. It's base gets initialized to
> page_offset_base.
> 
> Now, if you look at
> 
> Documentation/x86/x86_64/mm.txt
> 
> it says there:
> 
>  ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
> 
> so that is the direct mapping memory region of all physical memory.
> 
> Now, you're apparently fixing its size.
> 
> Am I making sense and are you catching my drift?

Yes, makes sense. I will make it more specific, and use
kernel_randomize_memory() instead to indicate the place where code issue
is found out. Thanks.

> 
> You need to explain what you change in your commit messages in
> *understandable* english so that reviewer/committer or even a person
> who's not deeply involved in KASLR inner workings, can at least get an
> idea about what the commit message is talking about.
> 
> If you come up with strange constructs like "memory region KASLR" or
> "KASLR happened in" or "mm KASLR" which only make sense in your head,
> you're not doing anyone any favour.
> 
> Commit messages need to be very understandable when someone is looking
> at them months or even years from now. And you need to restrain yourself
> when you write them. You will appreciate that the first time you have to
> do git archeology, dig out an ancient commit and wonder why we did it
> this way.
> 
> Because we didn't document as good in previous years and our commits
> from the past suck big time.
> 
> Thanks!
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
