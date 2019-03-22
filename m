Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7908C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88A221873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zbt4AiAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfCVNVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:21:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfCVNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hw3ZtZSh4y78LcwFC7knlBZdOdzIfUNtqXkI2P++IvI=; b=Zbt4AiAWGBY6okvEekZtK6TS4F
        PTLe64W03umLD5nMSHvoCMhFEc4lCxttGX4EneARFbw7Wk07uvTnz/Ir8Hl1nAuKuj3nWtYcwKHfG
        4lnt+VewjSCFLnWQf0H6NwJw0adquIeo05Oj6qlq6AOFapqexQfI8VP518uRb7Pi5IqICBdl92ARY
        tDAnHXgUGavzntghHV+Bay6zLlMg1KYzVuN20T34X59Oc8MmgfVAJgxJQwa0GUnqoz9YSMbg9h/Ow
        IH3z+678WV11fgVbeRfilpWZX1p31/flKDOsK2UqdbN/QAWsLrzzQAqzjhUf2yTf9GSLzrZZqdNLG
        r47bHwFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7K6x-00047T-Fh; Fri, 22 Mar 2019 13:21:27 +0000
Date:   Fri, 22 Mar 2019 06:21:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] arm64, mm: Move generic mmap layout functions to mm
Message-ID: <20190322132127.GA18602@infradead.org>
References: <20190322074225.22282-1-alex@ghiti.fr>
 <20190322074225.22282-2-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190322074225.22282-2-alex@ghiti.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It then introduces a new define ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> that can be defined by other architectures to benefit from those functions.

Can you make this a Kconfig option defined in arch/Kconfig or mm/Kconfig
and selected by the architectures?

> -#ifndef STACK_RND_MASK
> -#define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))	/* 8MB of VA */
> -#endif
> -
> -static unsigned long randomize_stack_top(unsigned long stack_top)
> -{
> -	unsigned long random_variable = 0;
> -
> -	if (current->flags & PF_RANDOMIZE) {
> -		random_variable = get_random_long();
> -		random_variable &= STACK_RND_MASK;
> -		random_variable <<= PAGE_SHIFT;
> -	}
> -#ifdef CONFIG_STACK_GROWSUP
> -	return PAGE_ALIGN(stack_top) + random_variable;
> -#else
> -	return PAGE_ALIGN(stack_top) - random_variable;
> -#endif
> -}
> -

Maybe the move of this function can be split into another prep patch,
as it is only very lightly related?

> +#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
> +	defined(ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)

Not sure if it is wrіtten down somehwere or just convention, but I
general see cpp defined statements aligned with spaces to the
one on the previous line.

Except for these nitpicks this looks very nice to me, thanks for doing
this work!
