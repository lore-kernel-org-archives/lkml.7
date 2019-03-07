Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0405AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C484620675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/szqWVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCGMzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:55:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XSZkNgeDlJsSG53OA6qoCCgwdL5s/unQsXVqrhxGf3g=; b=s/szqWVgPjSw+NdeXh8m66Gbm
        5HQ8jq8YVSLW9+cGqiS5j8m8/d0hFM2+vg+AC7yl/OStXBqvv4QadDsF85CntjJOFjge2YIkjySPI
        THw28KweEi9WKjPzjTtpnSErECoaMeqxGI/BBVZEopdwa6M8r+UxlVtuYEHvUzHRcf3eg266sdQEi
        3vVOOeD5S0+iV1CE/LW8cezUKzCqECCEJhiOFUKbLEKdbfOnNwLQdxv5csBKagB6RK5sBtESZWNJ1
        aNMWILHK59wTyPhA6MNF39oD2hR0RPeLg364jbgUsXxd+0uY2I7Q3+w/csmR6bqb5E4L1IPeS5CCS
        gQuCsP2rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1sYb-0001YQ-S8; Thu, 07 Mar 2019 12:55:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93A4020297BBE; Thu,  7 Mar 2019 13:55:26 +0100 (CET)
Date:   Thu, 7 Mar 2019 13:55:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        rostedt@goodmis.org
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
Message-ID: <20190307125526.GB32534@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307120317.GD32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307120317.GD32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 01:03:17PM +0100, Peter Zijlstra wrote:


> 01c3     20d8:	77 08                	ja     20e2 <__do_sys_waitid+0x1cd>

taken:

 randconfig-build/kernel/exit.o: warning: objtool:   __do_sys_waitid()+0x1c3: (branch)

> ffffffffffffe0f5 	alternative("", __stringify(__ASM_STAC), X86_FEATURE_SMAP);
> 01c8     20dd:	90                   	nop
> 01c9     20de:	90                   	nop
> 01ca     20df:	90                   	nop

Bye-bye STAC, jumped straight over.

> 01cd     20e2:	83 f0 01             	xor    $0x1,%eax
> 01d0     20e5:	48 89 c2             	mov    %rax,%rdx
> 01d3     20e8:	83 e2 01             	and    $0x1,%edx
> 01d6     20eb:	48 83 c2 02          	add    $0x2,%rdx
> 01da     20ef:	48 ff 04 d5 00 00 00 	incq   0x0(,%rdx,8)
> 01e1     20f6:	00 
> 01de 			20f3: R_X86_64_32S	_ftrace_branch+0x148
> 01e2     20f7:	84 c0                	test   %al,%al
> 01e4     20f9:	75 2d                	jne    2128 <__do_sys_waitid+0x213>

we do not take this branch and fall-through.

> ffffffffffffe0eb 		return -EFAULT;
> ffffffffffffe0eb 
> ffffffffffffe0eb 	unsafe_put_user(signo, &infop->si_signo, Efault);
> 01e6     20fb:	44 89 33             	mov    %r14d,(%rbx)

fault, take exception:

  randconfig-build/kernel/exit.o: warning: objtool:   __do_sys_waitid()+0x1e6: (alt)

Relocation section '.rela__ex_table' at offset 0x21568 contains 18 entries:
Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000000000  000200000002 R_X86_64_PC32     0000000000000000 .text + 20fb
000000000004  000200000002 R_X86_64_PC32     0000000000000000 .text + 2125

> ffffffffffffefe5 Efault:
> ffffffffffffe0eb 	user_access_end();
> 0210     2125:	90                   	nop
> 0211     2126:	90                   	nop
> 0212     2127:	90                   	nop

 randconfig-build/kernel/exit.o: warning: objtool:   __do_sys_waitid()+0x210: (alt)

000000000034  000200000002 R_X86_64_PC32     0000000000000000 .text + 2125
000000000038  00c800000002 R_X86_64_PC32     0000000000000000 .altinstr_replacement + c

0000000000000000 <.altinstr_replacement>:
c:   0f 01 ca                clac

 randconfig-build/kernel/exit.o: warning: objtool: .altinstr_replacement+0xc: redundant UACCESS disable

