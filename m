Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7552121E6F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QnetA5ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKLVKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:10:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33363 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLVKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:10:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id c184so14268797pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F31pUIiRyz+ej3vULhS3I5/etO4orIdQ4TWQQD2Mw7U=;
        b=QnetA5ZKQQ/WjEq7mCSGOjZOmMqgAurfYb7OnYfvD3W9RrmWsIdgc/TaWiFScrboQM
         Qkgix6MH9RR00RXXFYJ7+EqUqxTqCRY7NN8ZoljCSfmNMWaAUvbtTd3/mmiW4E2CBk+G
         0fjMVCRqvXMpNdn8cz95SUVQDPlDYlUHBY8fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F31pUIiRyz+ej3vULhS3I5/etO4orIdQ4TWQQD2Mw7U=;
        b=iRKDWJUWt7k4TAL78BEOvqQ5o9DfyEuwIxvzAkkNyHQMlfgFf0P/DCCHsh3wpm2SFC
         6uqDeNbAUMj07PKhas4U+LzpAY+pxEQLSPt3SXHyrGEzq9LOiC8gyrsClugMtQRIspgN
         te7QYwQec+Zn6MtskLlArHXG6Coao++uR5l2jicr9Lk10f92BpzxNqWmvnpXWJfmcuPw
         n5Ecub+mqFRYEWWBHay+URB4Z3RsH9/d9AZlYIMn4Q5qHZyEaiZoKg6fPb1aUPdj4EGt
         GeF8FSSd+e0rqzyl9l+VH1wna36oXC3YlWeCOoHPL0wRxujhbYINgN7TKR80oJo16N4v
         iGUg==
X-Gm-Message-State: APjAAAXw1LkWDnkHxW4OXeywgcLDWpPusXubF3Ha6LN14RAgtaijktkp
        FbKatr4isV6vkiD9umd61PIqsw==
X-Google-Smtp-Source: APXvYqzk2gOZoM2ugCTGHWNZyvcJVVfSSOMzdsoHYiB+PWq1HYGAH4kJc6eUecMn1fHYJs8O/3Q/WQ==
X-Received: by 2002:a17:90a:e90:: with SMTP id 16mr9235202pjx.65.1573593037401;
        Tue, 12 Nov 2019 13:10:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w62sm21636661pfb.15.2019.11.12.13.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:10:36 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:10:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Use C int3 selftest but disable KASAN
Message-ID: <201911121304.7C1C2D79E@keescook>
References: <201911111348.7A0A6C3AFD@keescook>
 <20191112075746.GW4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112075746.GW4131@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 08:57:46AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 11, 2019 at 01:51:16PM -0800, Kees Cook wrote:
> > Instead of using inline asm for the int3 selftest (which confuses the
> > Clang's ThinLTO pass), 
> 
> What is that and why do we care?

This was breaking my build when using Clang and the LLVM linker with Link
Time Optimization (LTO) enabled, which is a prerequisite for enabling
Clang's Control Flow Integrity (CFI) feature that seeks to protect
indirect function calls from intentional (or accidental) manipulation.
Adding CFI to kernel builds is an ongoing project to further defend the
kernel from attacks[1], which many system builders are interested in
deploying.

> > this restores the C function but disables KASAN
> > (and tracing for good measure) to keep the things simple and avoid
> > unexpected side-effects. This attempts to keep the fix from commit
> > ecc606103837 ("x86/alternatives: Fix int3_emulate_call() selftest stack
> > corruption") without using inline asm.
> 
> See, I don't much like that. The selftest basically does a naked CALL
> and hard relies on the callee saving everything if required, which is
> very much against the C calling convention.
> 
> Sure, by disabling KASAN and all the other crap the compiler probably
> does the right thing by accident, but it is still a C ABI violation.

Okay, fair enough. I thought the patch seemed like a reasonable middle
ground, but I'll revisit it.

> We use ASM all over the kernel, why is this one a problem?

There seem to be a lot of weird visibility differences between GCC and
Clang with respect to asm. This is just declared differently from the
other many cases.

I'll see if I can find a better work-around.

-Kees

[1] https://android-developers.googleblog.com/2018/10/control-flow-integrity-in-android-kernel.html

-- 
Kees Cook
