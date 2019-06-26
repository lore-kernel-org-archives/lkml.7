Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE34EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14B920659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LDThWHcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfFZKnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:43:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFZKnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hW9JInVx6g/28QTS3QViHaTyJ87vpNU0Olana9v+OAE=; b=LDThWHcQVkL4dQjq1wGMb17LH
        l7G/bcYxqYscnYMxtYKac1lAuA3dxcdaqKULLg/CjN+zBvjlWtTERyC8/KBemrJ0tiuP0RVKru7to
        t3rEHetxPmT5eG65UTweM7ZULHnX1uAdFIIE+Pyjza7bNqf6r9FsUn7Jx1MB3FyDrJp6xX0XeJ/1+
        3zn0RBQhdYdsnrN8NerfgF6p60WVLDTiF4HiSfOZZmS8yrqRMeINUlC+U3lUMAJtMhf2B5DlHLVAH
        wV5GvZWWnR29l0/lKJDUG/35iVFRGl+GtoPWUS4BU559OtJ7iCuLjCffw2htlVbuGmTMRgpwSfSKb
        xKTrOkKyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg5Od-0003bx-40; Wed, 26 Jun 2019 10:43:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 732B5209CEDA9; Wed, 26 Jun 2019 12:43:21 +0200 (CEST)
Date:   Wed, 26 Jun 2019 12:43:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>,
        clang-built-linux@googlegroups.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190626104321.GC3463@hirez.programming.kicks-ass.net>
References: <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
 <20190626092432.GJ3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626092432.GJ3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:24:32AM +0200, Peter Zijlstra wrote:
> That is, would something like this:
> 
> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> index 06c3cc22a058..1761b1e76ddc 100644
> --- a/arch/x86/include/asm/jump_label.h
> +++ b/arch/x86/include/asm/jump_label.h
> @@ -32,7 +32,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
>  		: :  "i" (key), "i" (branch) : : l_yes);
>  
>  	return false;
> -l_yes:
> +l_yes: __attribute__((cold));
>  	return true;
>  }
>  
> @@ -49,7 +49,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
>  		: :  "i" (key), "i" (branch) : : l_yes);
>  
>  	return false;
> -l_yes:
> +l_yes: __attribute__((hot));
>  	return true;
>  }
>  
> Help LLVM?

No, that's broken. What we do is the likely() and unlikely() hints in
static_branch_{,un}likely():

#define static_branch_likely(x)							\
({										\
	bool branch;								\
	if (__builtin_types_compatible_p(typeof(*x), struct static_key_true))	\
		branch = !arch_static_branch(&(x)->key, true);			\
	else if (__builtin_types_compatible_p(typeof(*x), struct static_key_false)) \
		branch = !arch_static_branch_jump(&(x)->key, true);		\
	else									\
		branch = ____wrong_branch_error();				\
	likely(branch);								\
})

#define static_branch_unlikely(x)						\
({										\
	bool branch;								\
	if (__builtin_types_compatible_p(typeof(*x), struct static_key_true))	\
		branch = arch_static_branch_jump(&(x)->key, false);		\
	else if (__builtin_types_compatible_p(typeof(*x), struct static_key_false)) \
		branch = arch_static_branch(&(x)->key, false);			\
	else									\
		branch = ____wrong_branch_error();				\
	unlikely(branch);							\
})

That should convey out-of-line vs in-line 'hint'. And clearly that's
broken for LLVM.
