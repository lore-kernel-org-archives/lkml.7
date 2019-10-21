Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EED3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618462070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jI96QAyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfJUOOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:14:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfJUOON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3plDKgnJ0HIBgorG9S0obRwxJpV76imeOkBiLbgmUVo=; b=jI96QAyV+T8iQka+zb2k3I0La
        m5+z/93EllmecZGX0rVGGpiis5VkADLMV5wnm55qT6CXkwj0jMYqhaRQJTV1a7wvzmMLMK6irIIOL
        CHtkc8dChg33RvYj4823hFfOy0HzSlWiV+JnjwteEneEU0ltXVwLZTgQ3WjzkMl0GT3wdGJ1ZpzlV
        gNms5sh2NJgWh0H2Y7PO54X+SZ8syV7/q1USt595HeKzAKxQTpGoPFK6GGlJsSPOIhLzWiiFKT2ei
        Z760kUW793RxEOPoct4W/LBCEQXMtlbH5kQ9LIbn7VGqU23XqGQTRyCbMmqhDp8faYXuA9qaJXcVM
        dCERYIv/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMYRh-0007cr-4G; Mon, 21 Oct 2019 14:14:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CBED300EBF;
        Mon, 21 Oct 2019 16:13:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E496238D26BE; Mon, 21 Oct 2019 16:14:02 +0200 (CEST)
Date:   Mon, 21 Oct 2019 16:14:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191021141402.GI1817@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021135312.jbbxsuipxldocdjk@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 08:53:12AM -0500, Josh Poimboeuf wrote:
> On Fri, Oct 18, 2019 at 09:35:40AM +0200, Peter Zijlstra wrote:
> > Now that set_all_modules_text_*() is gone, nothing depends on the
> > relation between ->state = COMING and the protection state anymore.
> > This enables moving the protection changes later, such that the COMING
> > notifier callbacks can more easily modify the text.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > ---
> >  kernel/module.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -3683,10 +3683,6 @@ static int complete_formation(struct mod
> >  	/* This relies on module_mutex for list integrity. */
> >  	module_bug_finalize(info->hdr, info->sechdrs, mod);
> >  
> > -	module_enable_ro(mod, false);
> > -	module_enable_nx(mod);
> > -	module_enable_x(mod);
> > -
> >  	/* Mark state as coming so strong_try_module_get() ignores us,
> >  	 * but kallsyms etc. can see us. */
> >  	mod->state = MODULE_STATE_COMING;
> > @@ -3852,6 +3848,10 @@ static int load_module(struct load_info
> >  	if (err)
> >  		goto bug_cleanup;
> >  
> > +	module_enable_ro(mod, false);
> > +	module_enable_nx(mod);
> > +	module_enable_x(mod);
> > +
> >  	/* Module is ready to execute: parsing args may do that. */
> >  	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
> >  				  -32768, 32767, mod,
> 
> [ Sorry if this was already discussed, I still have a large backlog. ]
> 
> Doesn't livepatch code also need to be modified?  We have:

Urgh bah.. I was too focussed on the other klp borkage :/ But yes,
arm64/ftrace and klp are the only two users of that function (outside of
module.c) and Mark was already writing a patch for arm64.

Means these last two patches need to wait a little until we've fixed
those.
