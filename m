Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D874C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E3B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k8P9/UKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfFMUmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:42:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfFMUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kshn4ZcN21VZaUe82Mo3RQdVUWkWj4qocgi4/UQKjOI=; b=k8P9/UKRp4ziFYYHWL66rO2eN
        D8jDNH/mFy2wOaQEW9uSGv0RfQKD05TV7PtJavRr9wrN7cJkB8wfWt/AmtznMxSq6rTAZGVQ2HVpa
        XQPIqMpRoUFkbXbQ4fCp5ig4uI3lfPVOeDOAomhyWj22TDlV0SGLb33Lw+7MSUQyU59EXt/TVQ0Ol
        PwXohXhe1r9HU780A44+R67Iz2UXTClS5VvByZUYqCRZtgUOdaLij2fPG9FK93ToE7aaI5JLN/m8V
        FJNmOZthc+982RGbAPHJF67z6BMyYCtWU3p0bzCvAy3jrWpLjULS3502EUDYVMpjW8lWvXQJh+9ZZ
        UffNyk1GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbWXh-0006Wi-Qw; Thu, 13 Jun 2019 20:41:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4A3720435AA1; Thu, 13 Jun 2019 22:41:51 +0200 (CEST)
Date:   Thu, 13 Jun 2019 22:41:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>
Subject: Re: [PATCH 0/9] x86/bpf: unwinder fixes
Message-ID: <20190613204151.GP3436@hirez.programming.kicks-ass.net>
References: <cover.1560431531.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560431531.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 08:20:57AM -0500, Josh Poimboeuf wrote:

> Josh Poimboeuf (8):
>   objtool: Fix ORC unwinding in non-JIT BPF generated code
>   x86/bpf: Move epilogue generation to a dedicated function
>   x86/bpf: Simplify prologue generation
>   x86/bpf: Support SIB byte generation
>   x86/bpf: Fix JIT frame pointer usage
>   x86/unwind/orc: Fall back to using frame pointers for generated code
>   x86/bpf: Convert asm comments to AT&T syntax
>   x86/bpf: Convert MOV function/macro argument ordering to AT&T syntax
> 
> Song Liu (1):
>   perf/x86: Always store regs->ip in perf_callchain_kernel()
> 
>  arch/x86/events/core.c       |  10 +-
>  arch/x86/kernel/unwind_orc.c |  26 ++-
>  arch/x86/net/bpf_jit_comp.c  | 355 ++++++++++++++++++++---------------
>  kernel/bpf/core.c            |   5 +-
>  tools/objtool/check.c        |  16 +-
>  5 files changed, 246 insertions(+), 166 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
