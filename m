Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F045C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 04:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D771A2173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 04:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="k9k26M+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDFEn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 00:43:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54486 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfDFEn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 00:43:57 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D12E1EC02D1;
        Sat,  6 Apr 2019 06:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554525835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uGfHzJZR+lbX+3FgfXSRb9MMRiQ5AF1qWLrY+o1XmXY=;
        b=k9k26M+OL5REo6mYYlbXiYU0wotIRj+qNZcbENVDFZRdzkhy6TDalYrXG3Fmm6N4XaFfhQ
        kDU47/M8u0MV9/nWl2DVL1qke5nkljEql4Cgp5vLOFiA2g1gGAS1VgdJKxOAenqZMk3PGS
        FcbWm3hMfX6V7uwkLZYSVhk5ZUfdnyg=
Date:   Sat, 6 Apr 2019 06:43:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, kirill@shutemov.name,
        keescook@chromium.org, yamada.masahiro@socionext.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        thgarnie@google.com, mike.travis@hpe.com, frank.ramsay@hpe.com
Subject: Re: [PATCH 1/2] x86/mm/KASLR: Fix the wrong calculation of memory
 region initial size
Message-ID: <20190406044348.GA14245@zn.tnic>
References: <20190404020314.8162-1-bhe@redhat.com>
 <20190404020314.8162-2-bhe@redhat.com>
 <20190405165856.GJ23348@zn.tnic>
 <20190406015119.GY7627@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190406015119.GY7627@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 09:51:19AM +0800, Baoquan He wrote:
> It's KASLR happened in kernel_randomize_memory() of arch/x86/mm/kaslr.c .

What is "KASLR happened in"? This doesn't make any sense. When you look
at that function, there's a comment above it:

/* Initialize base and padding for each memory region randomized with KASLR */

Do you mean, that, per chance?

> In fact, I don't know how to call it. Previously, I wrote it as mm
> KASLR, to distinguish from KASLR during kernel decompression. Ingo
> blamed the name,

Of course he did, because it didn't make any sense to him either.

> so I changed it to memory region KASLR. Seems Thomas
> Garnier called it KASLR for kernel memory regions in his original KASLR
> adding patch. May I call it 'KASLR for kernel memory regions', or 'KASLR
> for memory regions'?

So you're fixing kaslr_regions[0].size_tb. It's base gets initialized to
page_offset_base.

Now, if you look at

Documentation/x86/x86_64/mm.txt

it says there:

 ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)

so that is the direct mapping memory region of all physical memory.

Now, you're apparently fixing its size.

Am I making sense and are you catching my drift?

You need to explain what you change in your commit messages in
*understandable* english so that reviewer/committer or even a person
who's not deeply involved in KASLR inner workings, can at least get an
idea about what the commit message is talking about.

If you come up with strange constructs like "memory region KASLR" or
"KASLR happened in" or "mm KASLR" which only make sense in your head,
you're not doing anyone any favour.

Commit messages need to be very understandable when someone is looking
at them months or even years from now. And you need to restrain yourself
when you write them. You will appreciate that the first time you have to
do git archeology, dig out an ancient commit and wonder why we did it
this way.

Because we didn't document as good in previous years and our commits
from the past suck big time.

Thanks!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
