Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914D5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA4420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BgqoRbf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbfJJJVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:21:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58208 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387463AbfJJJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dM+zNGSNOaaeInNQWIpN++xOSr2s5LE3tb5oYqXmsDk=; b=BgqoRbf8yoW75UGASXF0z271y
        +I7Rmq8VsjAqIUZI7sGA+Sw9AHCNQnH0GV8qNoghODvF19KAM9nDybqOl1A7R6/Ig32PV7b/1w2FG
        jHhW137wJkZRnIzsGafbCbZU3ynvwCqoK8nk0KkYkyNOgSBnh+D3aIChvsW6li15O6Rl5dOUT/6fj
        fMj+91tlNlNY5QBuVlsVQSHpfhRGmy9rUHAU/NhQ2elzFr9xyT0zebHIekSMRb7u/9fxsn4IMoJic
        mnZ7M4i7tRWnY6Sh3C++UORyTKn1d1KRXc4dWAjM0OKba1fgPd4mDVo0okHoDcxrwb82bTmaXX+rh
        /dUSyeBug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIUcy-00013x-K3; Thu, 10 Oct 2019 09:20:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE3C1307092;
        Thu, 10 Oct 2019 11:20:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACD9720C3749A; Thu, 10 Oct 2019 11:20:54 +0200 (CEST)
Date:   Thu, 10 Oct 2019 11:20:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191010092054.GR2311@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081945.10951536.8@infradead.org>
 <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009224135.2dcf7767@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:41:35PM -0400, Steven Rostedt wrote:
> On Tue, 8 Oct 2019 10:43:35 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> 
> > BTW, I'd really like to take this patch series through my tree. That
> > way I can really hammer it, as well as I have code that will be built
> > on top of it.
> 
> I did a bit of hammering and found two bugs. One I sent a patch to fix
> (adding a module when tracing is enabled), but the other bug I
> triggered, I'm too tired to debug right now. But figured I'd mention it
> anyway.

I'm thinking this should fix it... Just not sure this is the right plce,
then again, we're doing the same thing in jump_label and static_call, so
perhaps we should do it like this.

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1230,10 +1230,15 @@ void text_poke_queue(void *addr, const v
  * dynamically allocated memory. This function should be used when it is
  * not possible to allocate memory.
  */
-void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
+void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	struct text_poke_loc tp;
 
+	if (unlikely(system_state == SYSTEM_BOOTING)) {
+		text_poke_early(addr, opcode, len);
+		return;
+	}
+
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
