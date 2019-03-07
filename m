Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D462C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8BD2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YqebsCcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCGNNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:13:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51746 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGNNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=16T1xMsNBW8YtcgFDr1uWAjeTKs2Hka/m6a5mUMX8+c=; b=YqebsCcpf4PzLM95vj0K8xVQJ
        FGoeQfDLeZyizmlQw3QLVIX6zNenUoWyMWYWHhuSKMW0uPV7is1Mr+6UjWA1dJjL3rltHR+OoTXHl
        DQxqJP0cqYw/2KxM+Qp+GB3jmMs1vhdNw301BrJLQzSuYvZkV2K1dTpGgVbyw/BMymBFLgy4T1viB
        U2AP0b+K6iFARDazH9YZuWxsQEPJ4LKdVY10P4ny0BT8kMig4xfGMovbS8hHbx3gtA11PwCkxYbzi
        oTcTzX875u0RRtpk+aimMmwOrAlvwvrjdPnrz6+9Si6ARd1DXHeTpmz2sHM8kycxZIc78YXuag8nP
        WnATs0urQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1spo-0005qy-2L; Thu, 07 Mar 2019 13:13:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 070E120297ED1; Thu,  7 Mar 2019 14:13:13 +0100 (CET)
Date:   Thu, 7 Mar 2019 14:13:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        rostedt@goodmis.org
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
Message-ID: <20190307131312.GC32534@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307125526.GB32534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 01:55:26PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 07, 2019 at 01:03:17PM +0100, Peter Zijlstra wrote:


> > 01be     20d3:  31 c0                   xor    %eax,%eax
> > 01c0     20d5:  4c 39 eb                cmp    %r13,%rbx
> > 01c3     20d8:  77 08                   ja     20e2 <__do_sys_waitid+0x1cd>

randconfig-build/kernel/exit.o: warning: objtool:   __do_sys_waitid()+0x1c3: (branch)

> > 01cd     20e2:	83 f0 01             	xor    $0x1,%eax
> > 01d0     20e5:	48 89 c2             	mov    %rax,%rdx
> > 01d3     20e8:	83 e2 01             	and    $0x1,%edx
> > 01d6     20eb:	48 83 c2 02          	add    $0x2,%rdx
> > 01da     20ef:	48 ff 04 d5 00 00 00 	incq   0x0(,%rdx,8)
> > 01e1     20f6:	00 
> > 01de 			20f3: R_X86_64_32S	_ftrace_branch+0x148
> > 01e2     20f7:	84 c0                	test   %al,%al
> > 01e4     20f9:	75 2d                	jne    2128 <__do_sys_waitid+0x213>
> 
> we do not take this branch and fall-through.

And that is the error, I think. We should've taken it and went to:

  return -EFAULT;

because:

 +1be	xor  %eax,%eax	eax=0
 +1cd   xor  $0x1,%eax	eax=1
 +1e2   test %al,%al	1&1==1 -> ZF=0
 +1e4   jnz

Is an unconditional code sequence, but there's no way objtool can do
that without becoming a full blown interpreter :/

> > 0213     2128:  49 c7 c7 f2 ff ff ff    mov    $0xfffffffffffffff2,%r15
> > ffffffffffffe0eb }
> > 021a     212f:  48 8d 65 d8             lea    -0x28(%rbp),%rsp
> > 021e     2133:  4c 89 f8                mov    %r15,%rax
> > 0221     2136:  5b                      pop    %rbx
> > 0222     2137:  41 5c                   pop    %r12
> > 0224     2139:  41 5d                   pop    %r13
> > 0226     213b:  41 5e                   pop    %r14
> > 0228     213d:  41 5f                   pop    %r15
> > 022a     213f:  5d                      pop    %rbp
> > 022b     2140:  c3                      retq
