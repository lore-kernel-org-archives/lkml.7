Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A02EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B62B2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MN83kfU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDIKU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:20:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41846 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfDIKU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:20:28 -0400
Received: from zn.tnic (p200300EC2F0F850055F9EC31A4C987AB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8500:55f9:ec31:a4c9:87ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 751821EC04B9;
        Tue,  9 Apr 2019 12:20:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554805226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+DniVbKuY1f1OEtCTOKZRkVJKNOjQ8EojnWi0kF7Nrk=;
        b=MN83kfU/0g3zg71RLW70d+5xUBZVI5XZDNNBNf9abN0LtAo9eYnU33GD2Ze00kkrWZ8W4a
        Io0K38zSFY/iWw64jS0WRtfXjrCocWCGnUeBxTCShPY5k3kphMk75e9bWexCrsk4ZAV9fE
        gGJAQQqZdFFQBClAK1A0x5qpFZClbu8=
Date:   Tue, 9 Apr 2019 12:20:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86: mm: Do not use set_{pud,pmd}_safe when splitting
 the large page
Message-ID: <20190409102023.GA6150@zn.tnic>
References: <20190408191103.13501-1-brijesh.singh@amd.com>
 <20190409084031.GO4038@hirez.programming.kicks-ass.net>
 <20190409093935.GH14281@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409093935.GH14281@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:39:35AM +0200, Peter Zijlstra wrote:
> unsigned long kernel_physical_mapping_change(unsigned long paddr_start, unsigned
> 		long paddr_end, unsigned long page_size_mask)

... and add a comment above it what the "_change" thing is supposed to
mean...

> 	unsigned long last;
> 
> 	last = __kernel_physical_mapping_init(paddr_start, paddr_end, page_size_mask, false);
> 
> 	__flush_tlb_all();

... and maybe not do the flushing here because if you look at
early_set_memory_enc_dec(), it iterates over a bunch of addresses and
when it is done, does the TLB flush once.

If you did it here, then you'd flush after each change. Which is costly.

So maybe the comment above should also say that _change callers are
responsible to flush the TLB after they're done.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
