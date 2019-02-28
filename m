Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12477C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27812183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EZ5PfbUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbfB1Kwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:52:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfB1Kwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4pNEMp16Jt4auJyhzHscy3Z3Wjvd7nyXXu0OUJ7VnCU=; b=EZ5PfbUBrCuVPRFVFRBa01IJK
        J5921RzWTae10yuQlcNkjdpR5c1dwDoLzAC/rxjZfE3Ho5zumbwYJ6wQOn739znLKpvnbszI88Oyp
        VLZvJ0SK+6TXOXY+SjcbWDDd/4KabUQBcno2NWmijH0xuCpKnZXxrqZXWxAnuePDD/WMdpNF+tLYX
        JWFwnYeBfYk+LSLgnT1QGv16/KUNVqUZQWwBSEXmkhU2DNROKVnEhejdFcNokw2erccHfk9rMi2EY
        oU6TvyL62cjbrAwDEfAxHtKCpB2qqqHjDatui8ue9YQaejGx0djDXid0iSoiizTTmjOKBB1r0tM1k
        X+rDA05yA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzJIl-000819-Th; Thu, 28 Feb 2019 10:52:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51D4D202CF60E; Thu, 28 Feb 2019 11:52:29 +0100 (CET)
Date:   Thu, 28 Feb 2019 11:52:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
Message-ID: <20190228105229.GZ32494@hirez.programming.kicks-ass.net>
References: <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net>
 <19b35cb1-9527-2e15-6deb-9ce7c1ef1d66@virtuozzo.com>
 <20190227142623.GR32494@hirez.programming.kicks-ass.net>
 <20190227143313.GK32534@hirez.programming.kicks-ass.net>
 <CACT4Y+a9yJvwzwVcjhyOkJUdMp05mxW1++EduLLa2M_buQ7OhA@mail.gmail.com>
 <20190227172816.GT32494@hirez.programming.kicks-ass.net>
 <20190228094008.GN32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YSi_XnjNnOhtL1ctQQuZViarxvN+muB-oCmakjgB9mzQ@mail.gmail.com>
 <CACT4Y+Y6yp+1fuOMM9xK2gzKk1tPvarjQuUaNC1h0L8EZKenQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y6yp+1fuOMM9xK2gzKk1tPvarjQuUaNC1h0L8EZKenQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:05:10AM +0100, Dmitry Vyukov wrote:
> On Thu, Feb 28, 2019 at 10:59 AM Dmitry Vyukov <dvyukov@google.com> wrote:

> > I guess this warning originated for user-space where programmer does
> > not define them and does not generally know about them and signature
> > is not a public contract for user. And then for kernel it just stayed
> > the same because not doing this warning would require somebody to
> > proactively think about this potential difference and add an
> > additional code to skip this check and even then it wasn't obvious why
> > one will want to do this with these functions. So that's where we are
> > now.
> 
> Maybe asm directive will help to trick the compiler?

So I went back and forth on the annotation; and we're back to the same
we use for STACK_FRAME_NON_STANDARD() because that forces GCC to
actually generate the symbol.

Without that GCC IPA will go and wreck things by either making the
entire symbol go away or generating partial functions.

I'm currently doing a hard-coded list of names in objtool for this :/
But I'm having trouble with that alias crud.
