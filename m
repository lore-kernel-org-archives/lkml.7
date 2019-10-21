Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEFDCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13E420873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571650136;
	bh=Ij6S89oTE2ChGvN/UW+DXJfdLK0DsQIGRLCpuPOoRWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RGuQIdpo3SF80qT48z/BDQ3mcWaf07LZgqEKp7TlucsXlZwjb3zfhA4ln1q8FddTD
	 P9ae+pOHNj80n9PPRwW96Ra0KZWG0q9rD2Fwvywpo4Ft0saSDopznCJtnhh2TIL44Q
	 XVdm11HAr4EoRucZlJApwNrE1Jl4guEsbz1ZRyBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfJUJ2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfJUJ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:28:55 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C8F620684;
        Mon, 21 Oct 2019 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571650134;
        bh=Ij6S89oTE2ChGvN/UW+DXJfdLK0DsQIGRLCpuPOoRWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zWZzDriip6tNCgfYO0M88aJAV5J/LSHelLDvXsN0JxFO1eO3wP1xf9jH9VOPlWeRr
         l8gfqL/30jne+EhJJPVaCBHdwfmo0Jc+al53Fz46Fn92tge0OM9hWMU0I3I9+Es3ta
         pEfX+JuiTXYfFUauJoNlctRr1EGfMdnBG4PgNxEc=
Date:   Mon, 21 Oct 2019 18:28:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] add support for Clang's Shadow Call Stack
Message-Id: <20191021182849.d51a67b0c0fe74d8d524147f@kernel.org>
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 18 Oct 2019 09:10:15 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> This patch series adds support for Clang's Shadow Call Stack (SCS)
> mitigation, which uses a separately allocated shadow stack to protect
> against return address overwrites. More information can be found here:
> 
>   https://clang.llvm.org/docs/ShadowCallStack.html

Looks interesting, and like what function-graph tracing does...

> 
> SCS is currently supported only on arm64, where the compiler requires
> the x18 register to be reserved for holding the current task's shadow
> stack pointer. Because of this, the series includes four patches from
> Ard to remove x18 usage from assembly code and to reserve the register
> from general allocation.
> 
> With -fsanitize=shadow-call-stack, the compiler injects instructions
> to all non-leaf C functions to store the return address to the shadow
> stack and unconditionally load it again before returning. As a result,
> SCS is incompatible with features that rely on modifying function
> return addresses to alter control flow, such as function graph tracing
> and kretprobes. A copy of the return address is still kept in the
> kernel stack for compatibility with stack unwinding, for example.

Is it possible that kretprobes and function graph tracing modify the
SCS directly instead of changing real stack in that case?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
