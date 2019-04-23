Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627C3C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C71B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oz08JNOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfDWS5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:57:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDWS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RN0XQkgq/cEqemXmsR1c9nfHJ1rGNIByolIqIOEwfo0=; b=oz08JNObfyO6dXxU2v/sLkdg+P
        byKZsA/E2yYq9X5GjAuorCDHZ6Y/aniARhJtGjNsQ6DUuBtpIJVYIRdCQ7GJU1DchAiT1PwdEP7BF
        2XNHGlEhtCuPQlDaGD911d5fZG38DZFV7DwoVmuArFzLlgenrvld2NRj9sU6TvO8mXxbRms9Zhsax
        BtYVZqoozUoGNJr+izAgqe3XFH3ZgAFgaEbl+uMby3/x07Tg3T8DjXgbkvFYaEafGHUE1bPL68s4X
        WZt3bLy+cI9xLDZeFXvP4FrMZL99Q5RiTQCER0JnJyq3EYVzdKLfkOFu4Empigiw7Fpb/wSj+phrM
        LnZ1SDhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ0bi-0006mE-MZ; Tue, 23 Apr 2019 18:57:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8798929C3F389; Tue, 23 Apr 2019 20:57:28 +0200 (CEST)
Date:   Tue, 23 Apr 2019 20:57:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: mmotm 2019-04-19-14-53 uploaded (objtool)
Message-ID: <20190423185728.GX14281@hirez.programming.kicks-ass.net>
References: <20190419215358.WMVFXV3bT%akpm@linux-foundation.org>
 <af3819b4-008f-171e-e721-a9a20f85d8d1@infradead.org>
 <20190423082448.GY11158@hirez.programming.kicks-ass.net>
 <D7626BC0-FCE9-4424-A6F5-D4AAB6727ED4@amacapital.net>
 <20190423173912.GJ12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423173912.GJ12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 07:39:12PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 23, 2019 at 09:07:01AM -0700, Andy Lutomirski wrote:
> > > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> > > index 22ba683afdc2..c82abd6e4ca3 100644
> > > --- a/arch/x86/include/asm/uaccess.h
> > > +++ b/arch/x86/include/asm/uaccess.h
> > > @@ -427,10 +427,11 @@ do {                                    \
> > > ({                                \
> > >    __label__ __pu_label;                    \
> > >    int __pu_err = -EFAULT;                    \
> > > -    __typeof__(*(ptr)) __pu_val;                \
> > > -    __pu_val = x;                        \
> > > +    __typeof__(*(ptr)) __pu_val = (x);            \
> > > +    __typeof__(ptr) __pu_ptr = (ptr);            \
> > 
> > Hmm.  I wonder if this forces the address calculation to be done
> > before STAC, which means that gcc can’t use mov ..., %gs:(fancy
> > stuff).  It probably depends on how clever the optimizer is. Have you
> > looked at the generated code?
> 
> I have not; will do before posting the real patch.

x86_64-defconfig using gcc-7.3:

$ ./compare.sh defconfig-build defconfig-build1 vmlinux
compat_fillonedir                                         228        227   -1,+0
copy_fpstate_to_sigframe                                  446        448   +2,+0
                                             total   11374268   11374269   +1,+0


$ ./compare.sh defconfig-build defconfig-build1 vmlinux copy_fpstate_to_sigframe

...

0000 ffffffff81027448:  90                      nop                                                      \ 0000 ffffffff81027448:       8b 15 92 75 a8 01       mov    0x1a87592(%rip),%edx
0000 ffffffff81027449:  90                      nop                                                      \ 0000                         ffffffff8102744a: R_X86_64_PC32 fpu_user_xstate_size-0x4
0000 ffffffff8102744a:  90                      nop                                                      \ 0000 ffffffff8102744e:       48 01 da                add    %rbx,%rdx
0000 ffffffff8102744b:  8b 15 8f 75 a8 01       mov    0x1a8758f(%rip),%edx                              \ 0000 ffffffff81027451:       90                      nop
0000                    ffffffff8102744d: R_X86_64_PC32 fpu_user_xstate_size-0x4                         \ 0000 ffffffff81027452:       90                      nop
0000 ffffffff81027451:  c7 04 13 45 58 50 46    movl   $0x46505845,(%rbx,%rdx,1)                         \ 0000 ffffffff81027453:       90                      nop
0000 ffffffff81027458:  31 d2                   xor    %edx,%edx                                         \ 0000 ffffffff81027454:       c7 02 45 58 50 46       movl   $0x46505845,(%rdx)
0000 ffffffff8102745a:  90                      nop                                                      \ 0000 ffffffff8102745a:       31 d2                   xor    %edx,%edx
0000 ffffffff8102745b:  90                      nop                                                      \ 0000 ffffffff8102745c:       90                      nop
0000 ffffffff8102745c:  90                      nop                                                      \ 0000 ffffffff8102745d:       90                      nop
0000 ffffffff8102745d:  90                      nop                                                      \ 0000 ffffffff8102745e:       90                      nop
0000 ffffffff8102745e:  90                      nop                                                      \ 0000 ffffffff8102745f:       90                      nop
0000 ffffffff8102745f:  90                      nop                                                      \ 0000 ffffffff81027460:       90                      nop
0000 ffffffff81027460:  90                      nop                                                      \ 0000 ffffffff81027461:       90                      nop
0000 ffffffff81027461:  90                      nop                                                      \ 0000 ffffffff81027462:       90                      nop
0000 ffffffff81027462:  90                      nop                                                      \ 0000 ffffffff81027463:       90                      nop
0000 ffffffff81027463:  31 c9                   xor    %ecx,%ecx                                         \ 0000 ffffffff81027464:       90                      nop

...

So yes, it changes some code, but meh.
