Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A17C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A72420854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MAb08vz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfB1TB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:01:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfB1TB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kGIstRIPMaHHmUX9ti2AYr78dKS9FrMpFqBae+rMp+A=; b=MAb08vz95D76HXImRKhdfzqiG
        SFYSCliWvLeXuNmGBAAXqvKTr82QiTK1WiULljgYubrN+6vYxB49UDB7GE5VKmDBvhaUFybGE5tCv
        v0nVpJDcqyF52lEoOHhNovhs9CqA9+tfVnYKnrK/Rb78UVxVXd4t7XkxWH1NpmppMm5yHSoWFEcYt
        XmoMbDxhyZa7y2CthggE3/6MNSku3aK97anSXinNoND3PM/MCL7bl6PwzltpLVvHlMQSj+QoawAHg
        uDOrrIZYBlyeZvrZ8eNsScGQ0BmDQ/l0jEllqcP8k96REb2YxF/vDEfGNH4Am/17fgkLb6uDdw+7A
        lihCX4Myg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzQvi-0006AW-Cf; Thu, 28 Feb 2019 19:01:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F28D3202C2DAC; Thu, 28 Feb 2019 20:01:11 +0100 (CET)
Date:   Thu, 28 Feb 2019 20:01:11 +0100
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
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
Message-ID: <20190228190111.GI32494@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.540038736@infradead.org>
 <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
 <20190228175114.GG32494@hirez.programming.kicks-ass.net>
 <20190228180154.GO32534@hirez.programming.kicks-ass.net>
 <CAHk-=whJww5smbSU2VzvcR7tajNqp=i9ZBYHK3RvwVXbs+V_JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whJww5smbSU2VzvcR7tajNqp=i9ZBYHK3RvwVXbs+V_JQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:29:25AM -0800, Linus Torvalds wrote:
> On Thu, Feb 28, 2019 at 10:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Weird, that jump is from C, not from a .fixup table. objtool _should_
> > see that and complain if there is a AC=1 path that reaches RET.
> 
> No, unsafe_put_user() actually does the "asm goto" thing, so the jump
> is literally hidden as an exception entry. And apparently objtool
> doesn't follow exceptions (which *normally* doesn't matter for code
> liveness analysis since they normally jump back to right after the
> excepting instruction, but maybe it misses some exception handling
> code because of it?).
> 
> You may have looked at unsafe_get_user(), which does indeed make the
> branch as C code, because gcc currently does not allow outputs from
> "asm goto" statements (which "get" obviously needs).

Indeed I did. But it looks like objtool actually does parse .fixup. What
appears to go wrong is the 'visited' marker for backward jumps.

If we've been there with AC=0 first, and then backjump with AC=1, things
go missing.

I've also now confused myself on how it branches from alternatives. It
looks like it now considers paths that take the STAC alternative, and
exit through the NOP alternative (which should be CLAC) and then hit
RET with AC=1.

I'll get this sorted, eventually..

