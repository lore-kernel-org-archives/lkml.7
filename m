Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0A2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE70206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KyBP0rs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKNP2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:28:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKNP2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=acOSLe9lKm8dmzBHUFM/wTBTEZWaloTBYtSbQHEpws8=; b=KyBP0rs8O8fxPZQDnnv8qaDQF
        lzZ4rE8VLVCAsaa4XunKoZWc2+mCbnvO9pwiMYA/rLIlCVwkKp8JsM7IEIBOnG1AohPNv0EIKSFBg
        HSc5jO3xe4D3OI+rzpCn7OKRGL4OG6HOR5Y/RFCtG7bPCAV9x/xyRJEgBEgvUMBpFCdQXVP9yFG4b
        clY5efoRDuMMVE4MDGcLHIRs8BcA/fz36A1Tg3xeT2mlHQYob7g7skYOfjP3O5Y3x2Ob365SEALFl
        lsDGcV1DD2F5J7synDgXad2zNKGL/zp6btFkKDwIT8nYN81S+5rrATOKHV1rKMlZJHWnOK6vfGv6p
        zkd1zGFng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVH2u-0001Ry-0o; Thu, 14 Nov 2019 15:28:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD7C530018B;
        Thu, 14 Nov 2019 16:27:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84730203A5895; Thu, 14 Nov 2019 16:28:29 +0100 (CET)
Date:   Thu, 14 Nov 2019 16:28:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bristot <bristot@redhat.com>, jbaron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH -v5 12/17] x86/kprobes: Fix ordering
Message-ID: <20191114152829.GA4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111132458.162172862@infradead.org>
 <394483573.90.1573659752560.JavaMail.zimbra@efficios.com>
 <20191114135311.GW4131@hirez.programming.kicks-ass.net>
 <1135959694.112.1573743977897.JavaMail.zimbra@efficios.com>
 <20191114151323.GK2865@paulmck-ThinkPad-P72>
 <135240750.136.1573744944568.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <135240750.136.1573744944568.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:22:24AM -0500, Mathieu Desnoyers wrote:

> >> > So what we do, after enabling the regular kprobe, is call
> >> > synchronize_rcu_tasks() to wait for each task to have passed through
> >> > schedule(). That guarantees no task is preempted inside the kprobe
> >> > shadow (when it triggers it ensures it resumes execution at an
> >> > instruction boundary further than 5 bytes away).
> >> 
> >> Indeed, given that synchronize_rcu_tasks() awaits for voluntary context
> >> switches (or user-space execution), it guarantees that no task was preempted
> >> within the kprobe shadow.
> >> 
> >> Considering that synchronize_rcu_tasks() is meant only for code rewriting,
> >> I wonder if it would make sense to include the core serializing guarantees
> >> within this RCU API ?
> > 
> > As in have synchronize_rcu_tasks() do the IPI-sync love before doing
> > the current wait-for-voluntary-context-switch work?
> 
> This is what I have in mind, yes, based on the assumption that the only
> intended use-case for synchronize_rcu_tasks() is code patching.

I don't think that is needed. As per the patch under discussion, we
unconditionally need that IPI-sync (even for !optimized) but we only
need the synchonize_rcu_tasks() thing for optimized kprobes.

Also, they really do two different things. Lets not tie them together.
