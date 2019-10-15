Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318AEECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0610F21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tTgSO3RU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfJON4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:56:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbfJON4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=huWNRCrMrNlkbUCG2cnN58eIW9vw12u4cyjoMGe+vC4=; b=tTgSO3RUPNgO6oosNqdkqTDmI
        JvFwwOugRKoSRCS+17RGu142TGCEYbPrfGB1n4x1UfsBjiZ6WHzJT0jlU8YGP7IyVPO7f2hylG+cf
        VwY8MAlw3oewJg2FGb1rHs98VjZ7q5HY6FcEkQv7apEh+PXiUy86+QK/jkARXOP+QjD6WM00B/i+P
        YyVa8x1egrLuWethFF5cAzMc+xry4LkaLhQ3/uA84xGZGKUzMtQNyalGNwvO9toTmRmviOkH5F0Pj
        z4KKD9jbVV9MQKhB9GBlA4YicwJt4hThuiBFRbwS1EnvM7fObB4N0UPeO9V5VTLIkqhbEx3Jl9+Fc
        SF58MB5UA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKNJU-0003Xl-TK; Tue, 15 Oct 2019 13:56:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FD66300B8D;
        Tue, 15 Oct 2019 15:55:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAEBA20B972E4; Tue, 15 Oct 2019 15:56:34 +0200 (CEST)
Date:   Tue, 15 Oct 2019 15:56:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191015135634.GK2328@hirez.programming.kicks-ass.net>
References: <20191007081945.10951536.8@infradead.org>
 <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
 <20191011125903.GN2359@hirez.programming.kicks-ass.net>
 <20191015130739.GA23565@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015130739.GA23565@linux-8ccs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:07:40PM +0200, Jessica Yu wrote:
> I'm having trouble visualizing what changes you're planning on making.

I want all the text poking (jump_label, ftrace, klp whatever) to happen
_before_ we do the protection changes.

I also want to avoid flipping the protection state around unnecessarily,
because that clearly is just wasted work.

> I get that you want to squash ftrace_module_enable() into
> ftrace_module_init(), before module_enable_ro(). I'm fine with that as
> long as the races Steven described are addressed for affected arches.

Right, the problem is set_all_modules_text_*(), that relies on COMING
having made the protection changes.

After the x86 changes, there's only 2 more architectures that use that
function. I'll work on getting those converted and then we can delete
that function and worry no more about it.

> And livepatch should be OK as long as klp_module_coming() is always
> called *after* ftrace_module_enable(). But are you moving
> klp_module_coming() before the module_enable_* calls as well?  And if
> so, why?

I wanted to move the COMING notifier callback before the protection
changes, because that is the easiest way to convert jump_label and
static_call and AFAICT nothing really cared aside from ftrace.

The alternative is introducing additional module states, which just adds
complexity we don't really need if we can just flip things around a
little.

> > The fact that it is executable; also the fact that you do it right after
> > we mark it ro. Flipping the memory protections back and forth is just
> > really poor everything.
> > 
> > Once this ftrace thing is sorted, we'll change x86 to _refuse_ to make
> > executable (kernel) memory writable.
> 
> Not sure if relevant, but just thought I'd clarify: IIRC,
> klp_module_coming() is not poking the coming module, but it calls
> module_enable_ro() on itself (the livepatch module) so it can apply
> relocations and such on the new code, which lives inside the livepatch
> module, and it needs to possibly do this numerous times over the
> lifetime of the patch module for any coming module it is responsible
> for patching (i.e., call module_enable_ro() on the patch module, not
> necessarily the coming module). So I am not be sure why
> klp_module_coming() should be moved before complete_formation(). I
> hope I'm remembering the details correctly, livepatch folks feel free
> to chime in if I'm incorrect here.

You mean it does module_disable_ro() ? That would be broken and it needs
to be fixed. Can some livepatch person explain what it does and why?
