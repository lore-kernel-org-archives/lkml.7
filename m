Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECBCC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F45220840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCGQu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:50:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfCGQu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:50:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B9F6285C7;
        Thu,  7 Mar 2019 16:50:25 +0000 (UTC)
Received: from treble (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3487D5C1B5;
        Thu,  7 Mar 2019 16:50:23 +0000 (UTC)
Date:   Thu, 7 Mar 2019 10:50:21 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
Message-ID: <20190307165021.nforh2xvvznb56j3@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net>
 <20190307131312.GC32534@hirez.programming.kicks-ass.net>
 <20190307164705.qbu4ytdfdmsighas@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307164705.qbu4ytdfdmsighas@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 07 Mar 2019 16:50:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:47:05AM -0600, Josh Poimboeuf wrote:
> On Thu, Mar 07, 2019 at 02:13:12PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 07, 2019 at 01:55:26PM +0100, Peter Zijlstra wrote:
> > > On Thu, Mar 07, 2019 at 01:03:17PM +0100, Peter Zijlstra wrote:
> > 
> > 
> > > > 01be     20d3:  31 c0                   xor    %eax,%eax
> > > > 01c0     20d5:  4c 39 eb                cmp    %r13,%rbx
> > > > 01c3     20d8:  77 08                   ja     20e2 <__do_sys_waitid+0x1cd>
> > 
> > randconfig-build/kernel/exit.o: warning: objtool:   __do_sys_waitid()+0x1c3: (branch)
> > 
> > > > 01cd     20e2:	83 f0 01             	xor    $0x1,%eax
> > > > 01d0     20e5:	48 89 c2             	mov    %rax,%rdx
> > > > 01d3     20e8:	83 e2 01             	and    $0x1,%edx
> > > > 01d6     20eb:	48 83 c2 02          	add    $0x2,%rdx
> > > > 01da     20ef:	48 ff 04 d5 00 00 00 	incq   0x0(,%rdx,8)
> > > > 01e1     20f6:	00 
> > > > 01de 			20f3: R_X86_64_32S	_ftrace_branch+0x148
> > > > 01e2     20f7:	84 c0                	test   %al,%al
> > > > 01e4     20f9:	75 2d                	jne    2128 <__do_sys_waitid+0x213>
> > > 
> > > we do not take this branch and fall-through.
> > 
> > And that is the error, I think. We should've taken it and went to:
> > 
> >   return -EFAULT;
> > 
> > because:
> > 
> >  +1be	xor  %eax,%eax	eax=0
> >  +1cd   xor  $0x1,%eax	eax=1
> >  +1e2   test %al,%al	1&1==1 -> ZF=0
> >  +1e4   jnz
> > 
> > Is an unconditional code sequence, but there's no way objtool can do
> > that without becoming a full blown interpreter :/
> > 
> > > > 0213     2128:  49 c7 c7 f2 ff ff ff    mov    $0xfffffffffffffff2,%r15
> > > > ffffffffffffe0eb }
> > > > 021a     212f:  48 8d 65 d8             lea    -0x28(%rbp),%rsp
> > > > 021e     2133:  4c 89 f8                mov    %r15,%rax
> > > > 0221     2136:  5b                      pop    %rbx
> > > > 0222     2137:  41 5c                   pop    %r12
> > > > 0224     2139:  41 5d                   pop    %r13
> > > > 0226     213b:  41 5e                   pop    %r14
> > > > 0228     213d:  41 5f                   pop    %r15
> > > > 022a     213f:  5d                      pop    %rbp
> > > > 022b     2140:  c3                      retq
> 
> This "fixes" it, and also seems to help -Os make much code:

much *smaller* code

> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 445348facea9..8de63db58fdd 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -67,7 +67,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  				.line = __LINE__,			\
>  			};						\
>  		______r = !!(cond);					\
> -		______f.miss_hit[______r]++;					\
> +		if (______r) ______f.miss_hit[1]++; else ______f.miss_hit[0]++; \
>  		______r;						\
>  	}))
>  #endif /* CONFIG_PROFILE_ALL_BRANCHES */

-- 
Josh
