Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FAC2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIp9E68l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfCRRvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:51:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCRRvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DTyWIIlYkucxzG/SiSGlpQv/dozAXvEV/aQ29qomeLE=; b=UIp9E68lC/OQGSuHAA/JMbRNc
        P9vh7roELswq/yfekrHuJlr2EaHl+Ayr8cNWjzy781s40pjdqt4DAlajMUnSqWnlP1TblKfJ6dC4Z
        OrQNKVfIMDlNOoKRcBuQDhXzJSPJR53Ti4TIy2xwjKYMn9DYZujchkpfIzUvzew9d3r07X8EFD8Ly
        pNm6DaGVaR/kUiwLkmU1ctorlDfV4Zo7JSoal0jraBt6/qa/+o//9jgNtxDgvLA2rG+TMmI83MlXB
        BN7wLURNItrG5R/JLZq5Yr5YONJhBUAn9U13RkFe39QAyOLR+ApmqCbws3YZjx/4bQXQcEtojl2nn
        p3Iq+96cg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5wQC-0007Cl-Jc; Mon, 18 Mar 2019 17:51:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D397202194EA; Mon, 18 Mar 2019 18:51:35 +0100 (CET)
Date:   Mon, 18 Mar 2019 18:51:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/25] x86: Make SMAP 64-bit only
Message-ID: <20190318175135.GE6521@hirez.programming.kicks-ass.net>
References: <20190318153840.906404905@infradead.org>
 <20190318155139.963285969@infradead.org>
 <CAHk-=wgYUTJ33ANOF5=5AKafzgqCi4Xe9iRCdgUV4s05HrH_Pw@mail.gmail.com>
 <20190318173657.GV6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318173657.GV6058@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 06:36:57PM +0100, Peter Zijlstra wrote:
> then I'd sleep much better if we make 32bit context switch EFLAGS.
> Because, yes, x86_64 objtool validates a lot of the x86_32 code too, but
> unless we have 100% coverage, there's always the chance an AC=1 escapes.

How about I do a patch that schedules EFLAGS for both 32bit and 64bit,
mark this for backporting to infinity.

And then at the end, after the objtool-ac bits land, I do a patch
removing the EFLAGS scheduling for x86_64.
