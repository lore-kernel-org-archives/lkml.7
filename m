Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3F7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6977120850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dSniS5hX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbfCAPIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:08:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57248 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfCAPH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VFOTBGnenStc7irbPbVwOgwqyQ6Emq7ZDqgr09LaHTg=; b=dSniS5hX3773Ymspu80OJs/UPN
        xeLiuYh4AYqY+tcIe7FUq7vQCG9EegeCtAJXgQaOPUekxXVKDjW5MKYadBURV742u323LV1qG0J9v
        oimBJdTwSGXxgehqA3rPx0kDOW3bzQ5jvn90/ICCEN/PwYjgZba/n/k58YFo8yGz7P8wogGmEwHSO
        atZL2RSjaht68oBqK+CMIUSh14AqCH+P6QT/562pyApn5xxN6y2acn1PIvqZoFH283FjJQ0xA1FTa
        vcnsjH+3uIsxLE3MoUOdIU5zlZvrwP+0NwGlt4zsQ2A1Pfwrq/y/MQx8fIRqQ4j9OCeXpe2dGfz0o
        iyo4mxLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzjlI-0000Nl-0S; Fri, 01 Mar 2019 15:07:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDFC5239359C0; Fri,  1 Mar 2019 16:07:42 +0100 (CET)
Date:   Fri, 1 Mar 2019 16:07:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190301150742.GU32534@hirez.programming.kicks-ass.net>
References: <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CE650687-ECB3-4A7C-96BA-A061D54AEF40@zytor.com>
 <20190223083942.GF32477@hirez.programming.kicks-ass.net>
 <15DE0017-9AE5-4E7A-96CD-E5E9F5B72516@zytor.com>
 <20190225132103.GD32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190225132103.GD32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 02:21:03PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 25, 2019 at 12:47:00AM -0800, hpa@zytor.com wrote:
> > It doesn't have to understand the contents of the memop, but it seems
> > that the presence of a modrm with mode ≠ 3 should be plenty. It needs
> > to know that much in order to know the length of instructions anyway.
> > For extra credit, ignore LEA or hinting instructions.
> 
> A little something like so then?


$ ./objtool check --no-fp --backtrace ../../defconfig-build/arch/x86/lib/usercopy_64.o
../../defconfig-build/arch/x86/lib/usercopy_64.o: warning: objtool: .altinstr_replacement+0x3: UACCESS disable without MEMOPs: __clear_user()
../../defconfig-build/arch/x86/lib/usercopy_64.o: warning: objtool: __clear_user()+0x3a: (alt)
../../defconfig-build/arch/x86/lib/usercopy_64.o: warning: objtool: __clear_user()+0x2e: (branch)
../../defconfig-build/arch/x86/lib/usercopy_64.o: warning: objtool: __clear_user()+0x18: (branch)
../../defconfig-build/arch/x86/lib/usercopy_64.o: warning: objtool: .altinstr_replacement+0xffffffffffffffff: (branch)
../../defconfig-build/arch/x86/lib/usercopy_64.o: warning: objtool: __clear_user()+0x5: (alt)
../../defconfig-build/arch/x86/lib/usercopy_64.o: warning: objtool: __clear_user()+0x0: <=== (func)


0000000000000000 <__clear_user>:
   0:   e8 00 00 00 00          callq  5 <__clear_user+0x5>
   1: R_X86_64_PLT32       __fentry__-0x4
   5:   90                      nop
   6:   90                      nop
   7:   90                      nop
   8:   48 89 f0                mov    %rsi,%rax
   b:   48 c1 ee 03             shr    $0x3,%rsi
   f:   83 e0 07                and    $0x7,%eax
  12:   48 89 f1                mov    %rsi,%rcx
  15:   48 85 c9                test   %rcx,%rcx
  18:   74 0f                   je     29 <__clear_user+0x29>
  1a:   48 c7 07 00 00 00 00    movq   $0x0,(%rdi)
  21:   48 83 c7 08             add    $0x8,%rdi
  25:   ff c9                   dec    %ecx
  27:   75 f1                   jne    1a <__clear_user+0x1a>
  29:   48 89 c1                mov    %rax,%rcx
  2c:   85 c9                   test   %ecx,%ecx
  2e:   74 0a                   je     3a <__clear_user+0x3a>
  30:   c6 07 00                movb   $0x0,(%rdi)
  33:   48 ff c7                inc    %rdi
  36:   ff c9                   dec    %ecx
  38:   75 f6                   jne    30 <__clear_user+0x30>
  3a:   90                      nop
  3b:   90                      nop
  3c:   90                      nop
  3d:   48 89 c8                mov    %rcx,%rax
  40:   c3                      retq


Seems correct. Not sure you want to go fix that though. Let me know if
you want more output.
