Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531F9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FF920857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="06ADJoJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfCHTtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:49:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36686 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfCHTtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KyLEx4DdouzZaSpUiiVEXcm2WiQb/71+9HMoF2e07iE=; b=06ADJoJGhaFFCgbuHjrZPEYFd
        /kZuVs8RdwG23JA850aZy0zLZf18Lv9T13ESMNSv0CuDSTVVeRsPn/qDi8nLRXSuEgAz7OLzGRmlq
        9f7dYBoOPjKXPVwp2gOCapX6jODTd/wZx0kCXZ6q97JzatnIRVdPuG/a/ro9OF8/dwL6cM0mKy0Z1
        7mZ1y6TuFDtr1p9OKdkndYvhAu1H5kLTJQoEomlTIqjuCnS4hJiqS9jcxAKuxQZixanuiC+2pVHk9
        e3StnGeQuEqpk3Jo7f5iZkHrUqcDQVGjW5OANUzBdMQ/34HL2qscAEj3xK3jLSAgpGHnz2avgLDSv
        UxcOtzhIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2LTz-0001Sc-H7; Fri, 08 Mar 2019 19:48:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EF5120281DC5; Fri,  8 Mar 2019 20:48:35 +0100 (CET)
Date:   Fri, 8 Mar 2019 20:48:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 03/20] x86/uaccess: Move copy_user_handle_tail into asm
Message-ID: <20190308194835.GD32494@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115159.349746915@infradead.org>
 <20190308185321.jukfavqk6pl3ifev@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308185321.jukfavqk6pl3ifev@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 12:53:21PM -0600, Josh Poimboeuf wrote:
> On Thu, Mar 07, 2019 at 12:45:14PM +0100, Peter Zijlstra wrote:
> >  /*
> > + * Try to copy last bytes and clear the rest if needed.
> > + * Since protection fault in copy_from/to_user is not a normal situation,
> > + * it is not necessary to optimize tail handling.
> > + *
> > + * Input:
> > + * rdi destination
> > + * rsi source
> > + * rdx count
> > + *
> > + * Output:
> > + * eax uncopied bytes or 0 if successful.
> > + */
> > +ALIGN;
> > +copy_user_handle_tail:
> > +	movl %edx,%ecx
> > +1:	rep movsb
> > +2:	mov %ecx,%eax
> > +	ASM_CLAC
> > +	ret
> > +
> > +	_ASM_EXTABLE_UA(1b, 2b)
> > +ENDPROC(copy_user_handle_tail)
> 
> This is an unstructured piece of code rather than a callable function,
> END would probably be more appropriate.  Or maybe it should just be a
> local label (.Lcopy_user_handle_tail) because I don't think the
> alignment and ELF symbol size are even needed.

ENDPROC makes it STT_FUNC and gets us stricter AC tests.
