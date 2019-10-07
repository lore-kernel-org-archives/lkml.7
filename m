Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C4BC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0894120867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d12Z74wV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfJGLdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:33:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58630 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfJGLdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R+2wQpuF0MCFL2UceMfCFFr4Pv+SKkxrAaYWbuvybOk=; b=d12Z74wV+QOKcKof2wmBJEAGN
        vX+xdvg9K92Nmb0GJgvZl/yyCtGXOxhxXwLbJt/Fo8j0ApQbt/eRUZP6bhzH7l4twQvcxh9JhXQBD
        pJih8CksfN/zsIxmRLRwORQK2g+72BKwtLNJP56ZkTloM0J0j6uTQoZDB20pny+7d3cZ+IfRcFIvR
        EGVCzgwKd5C2o2ZSyWsp4LCpC+5PMxlKiC73l+M6T4t+o1mauhjC6R6gIAufDgxLLuRoXgCxPcGRV
        Ss/cU+0XYmtfQ6TSesXwDF5v5QVEso+EaUigXAwluluHXmqL6wuV/ajwKyXn5cQquATjMxtR85KCP
        yhdgb3QzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHRGG-0002QT-IS; Mon, 07 Oct 2019 11:33:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B9053072F4;
        Mon,  7 Oct 2019 13:32:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42BBA20245BAF; Mon,  7 Oct 2019 13:33:07 +0200 (CEST)
Date:   Mon, 7 Oct 2019 13:33:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v2 00/13] Add static_call()
Message-ID: <20191007113307.GC2311@hirez.programming.kicks-ass.net>
References: <20191007090225.44108711.6@infradead.org>
 <20191007082708.01393931.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007082708.01393931.1@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 10:27:08AM +0200, Peter Zijlstra wrote:
> This series, which depends on the previous two, introduces static_call().
> 
> static_call(), is the idea of static_branch() applied to indirect function
> calls. Remove a data load (indirection) by modifying the text.
> 
> These patches are still based on the work Josh did earlier, but incorporated
> feedback from the last posting and have a lot of extra patches which resulted
> from me trying to actually use static_call().
> 
> This still relies on objtool to generate the .static_call_sites section, mostly
> because this is a natural place for x86_64 and works for both GCC and LLVM.
> Other architectures can pick other means if/when they implement the inline
> patching. The out-of-line (aka. trampoline) variant doesn't require this.
> 

FWIW, Steve, if we were to do something like:

CFLAGS += -mfentry -mfentry_name=____static_call_fentry_tramp

And have:

struct static_call_key ____static_call_fentry = {
	.func = NULL,
	.next = 1,
};
asm(".pushsection .static_call.text, \"ax\" \n"
    ".align 4 \n"
    ".globl ____static_call_fentry_tramp \n"
    "____static_call_fentry_tramp: \n"
    "  ret \n"
    ".type ____static_call_fentry_tramp, @function \n"
    ".size ____static_call_fentry_tramp, . - ____static_call_fentry_tramp \n"
    ".popsection \n");

Then the whole function entry thing would automagicaly turn into
something like static_cond_call(fentry)(...);

Not saying we should do that, but we could ;-)
