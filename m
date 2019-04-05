Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC335C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AFB206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oH0o6R5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfDEQ7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:59:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfDEQ7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:59:06 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2EB041EC0A6C;
        Fri,  5 Apr 2019 18:59:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554483545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gIWwUWkjNwyXcWAkqMClbIPFYAXC7NsNDkT2LPMv+/M=;
        b=oH0o6R5DXao7pom1O5CWOFgFvUKvh6FSgbYb9AxLyUiuQOUIEK23cC22TwfWSYAJFgwkde
        eQ1uAFXwVOBsmY20KUPX23PwMC8diIrBK7N+AZLExaWYQ3UqIzmKsML7FQqWG7Lu29j2Bd
        DpY19euSqKzVdNaof9bYRZ/n0k9H7d0=
Date:   Fri, 5 Apr 2019 18:58:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, kirill@shutemov.name,
        keescook@chromium.org, yamada.masahiro@socionext.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        thgarnie@google.com, mike.travis@hpe.com, frank.ramsay@hpe.com
Subject: Re: [PATCH 1/2] x86/mm/KASLR: Fix the wrong calculation of memory
 region initial size
Message-ID: <20190405165856.GJ23348@zn.tnic>
References: <20190404020314.8162-1-bhe@redhat.com>
 <20190404020314.8162-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404020314.8162-2-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:03:13AM +0800, Baoquan He wrote:
> In memory region KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate

What is "memory region KASLR"?

> the initial size of the direct mapping region. This is correct in
> the old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> 46 bits, and only 4-level mode was supported.
> 
> Later, in commit:
> b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
> __PHYSICAL_MASK_SHIFT was changed to be always 52 bits, no matter it's
> 5-level or 4-level.
> 
> This is wrong for 4-level paging since it may cause randomness of KASLR
> being greatly weakened in 4-level. For KASLR, we compare the sum of RAM
> size and CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING with the size of the
> max RAM which can be supported by system, then choose the bigger one as
> the value to reserve space for the direct mapping region. The max RAM
> supported in 4-level is 64 TB according to MAX_PHYSMEM_BITS. However,
> here it's 4 PB in code to be compared with when __PHYSICAL_MASK_SHIFT is
> mistakenly used. E.g in a system owning 64 TB RAM, it will reserve 74 TB
> (which is 64 TB plus CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING). In fact
> it should reserve 64 TB according to the algorithm which is supposed to
> do. Obviously the extra 10 TB space should be saved to join randomization.

It is not a trivial situation you're trying to explain and that
paragraph is very very hard to understand. I can only rhyme up what
you're trying to say.

So please rewrite it using simple declarative sentences. Don't try to
say three things in one sentence but say one thing in three sentences.
Keep it simple.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
