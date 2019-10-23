Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D71CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011D520650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XgVr/qDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbfJWLs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:48:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbfJWLs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9dSEppQA0zukOyOGzSeFOc6C/ThFaH8w34WM1hQFp6A=; b=XgVr/qDHNiMu6tpV95rREang4
        9vfwCOILKRNAh/pkDIFvyAVcih0R0P0WqO6Q6b381BmA9d8BL51X6bLjrbcE4Orki4HdUyq6G+9BT
        eyVCW9L+wOw9hn6YTO73aEpH4LSQGf0VqTlnt+UBJBwyU/SZV5nv7Zlw6oFeO4fpbBCX8GKj5NJGU
        HvLp6xVLLTG14iJnuAfzxJ7nS+62fTWV4WLJiItTnYajHdZl/PcnWq2Cz+dlIgIdwJDu3ivqtUfvX
        V0R8125e8xZBCG7R8VR9mTsyeIY4v1rFky4eSVIz9m8d5ZWWmBih2qLe4dhKeCQ6HdaTNc7ooD05u
        tdwPU9cqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNF82-00031x-D9; Wed, 23 Oct 2019 11:48:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A5F9301224;
        Wed, 23 Oct 2019 13:47:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9418D2B1C6364; Wed, 23 Oct 2019 13:48:35 +0200 (CEST)
Date:   Wed, 23 Oct 2019 13:48:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191023114835.GT1817@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021141402.GI1817@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:14:02PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 21, 2019 at 08:53:12AM -0500, Josh Poimboeuf wrote:

> > Doesn't livepatch code also need to be modified?  We have:
> 
> Urgh bah.. I was too focussed on the other klp borkage :/ But yes,
> arm64/ftrace and klp are the only two users of that function (outside of
> module.c) and Mark was already writing a patch for arm64.
> 
> Means these last two patches need to wait a little until we've fixed
> those.

So the other KLP issue:

<mbenes> peterz: ad klp, apply_relocate_add() and text_poke()... what
         about apply_alternatives() and apply_paravirt()? They call
         text_poke_early(), which was ok with module_disable/enable_ro(), but
	 now it is not, I suppose. See arch_klp_init_object_loaded() in
         arch/x86/kernel/livepatch.c.

<peterz> mbenes: hurm, I don't see why we would need to do
         apply_alternatives() / apply_paravirt() later, why can't we do that
	 the moment we load the module

<peterz> mbenes: that is, those things _never_ change after boot

<mbenes> peterz: as jpoimboe explained. See commit
         d4c3e6e1b193497da3a2ce495fb1db0243e41e37 for detailed explanation.

Now sadly that commit missed all the useful information, luckily I could
find the patch in my LKML folder, more sad, that thread still didn't
contain the actual useful information, for that I was directed to
github:

  https://github.com/dynup/kpatch/issues/580

Now, someone is owning me a beer for having to look at github for this.

That finally explained that what happens is that the RELA was trying to
fix up the paravirt indirect call to 'local_irq_disable', which
apply_paravirt() will have overwritten with 'CLI; NOP'. This then
obviously goes *bang*.

This then raises a number of questions:

 1) why is that RELA (that obviously does not depend on any module)
    applied so late?

 2) why can't we unconditionally skip RELA's to paravirt sites?

 3) Is there ever a possible module-dependent RELA to a paravirt /
    alternative site?


Now, for 1), I would propose '.klp.rela.${mod}' sections only contain
RELAs that depend on symbols in ${mod} (or modules in general). We can
fix up RELAs that depend on core kernel early without problems. Let them
be in the normal .rela sections and be fixed up on loading the
patch-module as per usual.

This should also deal with 2, paravirt should always have RELAs into the
core kernel.

Then for 3) we only have alternatives left, and I _think_ it unlikely to
be the case, but I'll have to have a hard look at that.

Hmmm ?
