Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C436B20868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r70GPl5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCHPXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:23:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCHPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BkWjg8JnuN9Uuj60Hju+NBy0JAN4stAxWziAH7bC9DY=; b=r70GPl5jIFFYednI9WTMgDbDy
        V207545Ygxp70Ckzct4xKYYSS5sbMXMksVyAcYg76s8jJylIrX0AFnx4UC3pNawk6sRiG3e5zuYbH
        ymsoTaTaVwiPnJzOc5MQa5ZvhdEtq3thB5vmIU+3zn4+YFImXf1WzTB2530HKp/Q/qGFsRrZqUDn5
        sE7f33TQRJ2RFm34gBjN9A+M6LKe3d34lS9ZuACLQIw5Cwsc4+7pKAPIVpO1CTNtQ1uLVb0+M8bIR
        VKwgU0wff55Q82MMK5UIZZ7SqMzpHG2lwoHaj+COiS0m0uMTfxsCIGWV/s4hTrtC5raFUFKI4Adec
        Hi4jw5Ssg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2HLE-0005vf-9x; Fri, 08 Mar 2019 15:23:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD8D8202631D4; Fri,  8 Mar 2019 16:23:18 +0100 (CET)
Date:   Fri, 8 Mar 2019 16:23:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190308152318.GC32494@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
 <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com>
 <20190307184813.GL32477@hirez.programming.kicks-ass.net>
 <20190307202319.GD32534@hirez.programming.kicks-ass.net>
 <20190307204021.GE32534@hirez.programming.kicks-ass.net>
 <20190308150703.3jozuvj2crcxvlzp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308150703.3jozuvj2crcxvlzp@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:07:03AM -0600, Josh Poimboeuf wrote:
> On Thu, Mar 07, 2019 at 09:40:21PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 07, 2019 at 09:23:19PM +0100, Peter Zijlstra wrote:
> > > On Thu, Mar 07, 2019 at 07:48:13PM +0100, Peter Zijlstra wrote:
> > > > Another thing I need to look at is why objtool only found memset_orig
> > > > (from __memset) but not memset_erms, which if I read the code right, is
> > > > a possible alternative there.
> > > 
> > > Turns out we only look for sibling calls in the original instruction
> > > stream, not in any alternatives; which in general seems like a fair
> > > enough assumption.
> > 
> > And while I'm looking at memset_64.S, why are memset_erms and
> > memset_orig global functions? At the very least they should be local,
> > and ideally not even functions.
> 
> I think the only benefit is that they would show up better on stack
> traces, but that could also be solved by just making them local labels
> inside memset.  Which is what I think they should be.

Boris wanted to use alternative_call_2, just like copy_user_generic().
Which makes more sense to me still.
