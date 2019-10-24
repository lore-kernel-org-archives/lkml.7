Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14ACCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C141621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NznMugWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfJXUZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:25:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60692 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfJXUZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2NBCLK6FFrToFaOr2ueLEIR5bVHQUahE6WKOO6S6q9o=; b=NznMugWcCCeO31J+1mmIrnkDKk
        EzRozIDWxW179xrjhru0dxgxNIowbayz35WPrnqoPLNTuIlSZ6vhsSOEiUsLOClsF8BIjJWUGm2/A
        fG9HsjMupyU8gBU1wHWkyxplNvVu8PmT/ixZbLpkqsSNUuQNzZ1G3dmgfe8H1LNysQRzkZyegwQm9
        XfONOji1IfqpPpEOgcGh9ipqHlEUadwec/ssLeQzmVPfRhNHsWqOD3gGsEnfFp9vEt7VyIXZBK0Sa
        wGnwNpF4LGgUGVuAQ5YtW9EObctln5WG0QL9cWPDMeIkRORX7NyW2/Xc/bNtnYavwJNxlOOmEr8Rn
        4F4IkamQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNjfG-0004CD-Ou; Thu, 24 Oct 2019 20:24:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D88DF3006E3;
        Thu, 24 Oct 2019 22:23:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 736C72B3FBB13; Thu, 24 Oct 2019 22:24:55 +0200 (CEST)
Date:   Thu, 24 Oct 2019 22:24:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191024202455.GK4114@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021222110.49044eb5@oasis.local.home>
 <20191022202401.GO1817@hirez.programming.kicks-ass.net>
 <20191023145245.53c75d70@gandalf.local.home>
 <20191024101609.GA4131@hirez.programming.kicks-ass.net>
 <20191024110024.324a9435@gandalf.local.home>
 <20191024164320.GD4131@hirez.programming.kicks-ass.net>
 <20191024141731.5c7c414c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024141731.5c7c414c@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:17:31PM -0400, Steven Rostedt wrote:
> On Thu, 24 Oct 2019 18:43:20 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > 
> > >   CC [M]  drivers/gpu/drm/i915/gem/i915_gem_context.o
> > > /work/git/linux-trace.git/kernel/trace/trace_events_hist.c: In function ‘register_synth_event’:
> > > /work/git/linux-trace.git/kernel/trace/trace_events_hist.c:1157:15: error: ‘struct trace_event_class’ has no member named ‘define_fields’; did you mean ‘get_fields’?
> > >   call->class->define_fields = synth_event_define_fields;
> > >                ^~~~~~~~~~~~~
> > >                get_fields
> > > make[3]: *** [/work/git/linux-trace.git/scripts/Makefile.build:265: kernel/trace/trace_events_hist.o] Error 1
> > > make[3]: *** Waiting for unfinished jobs....  
> > 
> > allmodconfig clean
> > 
> > (omg, so much __field(); fail)
> 
> Well it built without warnings and passed the ftrace selftests.
> 
> I haven't ran it through the full suite, but that can wait for the v5.

I'll push it out to git to the 0day robot can have a go at it. For v5
I'm still staring at some KLP borkage. Then again, maybe I should delay
that last bit and make that a new series.
