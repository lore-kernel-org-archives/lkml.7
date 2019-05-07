Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59653C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF4720825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QPTztP6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfEGLwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:52:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfEGLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZhK9N43hatgArJgXgcX7MZupL/r+Jz2D9rVyOWT+FU0=; b=QPTztP6Kg0vvP5r3kYM7gDUzz
        O4Gd7sJh9Ujpv/vLvcTFmvHPBmbJlAKO+Otoxybk+UnCHTfmNfOsCkPXHUrbSKqnMPbycjQaRPq5N
        xEVjtUkZcb39nPqPud67BbWhr4w2zpzcGJ0gJbfpRUebyDPD7WGVKtUQXg0p77YLjhyNN7O1qIE9b
        z+ztxhsre5L48O3XbT7QDLq63H+uurqeR52h8AUUZcNQ1KLN/6XSDx9M83bwRgjFBZY/wvZHA6CWK
        nSzmbBd8FXg99sjwKL1KL0ny6Ms4zpdnHyqV74Xl3HsIQkbo8M22u0Fd14Od9aSRk+GRCLvm2I0S7
        h+/LZ/5pA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNyde-0000PF-Jr; Tue, 07 May 2019 11:52:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74F112029F884; Tue,  7 May 2019 13:52:00 +0200 (CEST)
Date:   Tue, 7 May 2019 13:52:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        rostedt@goodmis.org
Subject: Re: [PATCH 23/25] objtool: Add UACCESS validation
Message-ID: <20190507115200.GT2606@hirez.programming.kicks-ass.net>
References: <20190318153840.906404905@infradead.org>
 <20190318155142.025214872@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318155142.025214872@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:39:03PM +0100, Peter Zijlstra wrote:
> +static const char *uaccess_safe_builtin[] = {
> +	/* KASAN */
> +	"kasan_report",
> +	"check_memory_region",
> +	/* KASAN out-of-line */
> +	"__asan_loadN_noabort",
> +	"__asan_load1_noabort",
> +	"__asan_load2_noabort",
> +	"__asan_load4_noabort",
> +	"__asan_load8_noabort",
> +	"__asan_load16_noabort",
> +	"__asan_storeN_noabort",
> +	"__asan_store1_noabort",
> +	"__asan_store2_noabort",
> +	"__asan_store4_noabort",
> +	"__asan_store8_noabort",
> +	"__asan_store16_noabort",
> +	/* KASAN in-line */
> +	"__asan_report_load_n_noabort",
> +	"__asan_report_load1_noabort",
> +	"__asan_report_load2_noabort",
> +	"__asan_report_load4_noabort",
> +	"__asan_report_load8_noabort",
> +	"__asan_report_load16_noabort",
> +	"__asan_report_store_n_noabort",
> +	"__asan_report_store1_noabort",
> +	"__asan_report_store2_noabort",
> +	"__asan_report_store4_noabort",
> +	"__asan_report_store8_noabort",
> +	"__asan_report_store16_noabort",

So I was building the kernel with GCC-4.9 (for another issue) and that
got me:

arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x69: call to __asan_store8() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: setup_sigcontext()+0x3d: call to __asan_load8() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: __setup_rt_frame()+0x308: call to __asan_load8() with UACCESS enabled
lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x33d: call to __asan_store1() with UACCESS enabled
lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch_v1()+0x19: call to __asan_load8() with UACCESS enabled
lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch()+0x19: call to __asan_load8() with UACCESS enabled

Can any of the KASAN folks enlighten me on this? Should I also whitelist
those symbols, and do I understand things correct that the difference
between * and *_noabort is absolutely nothing?
