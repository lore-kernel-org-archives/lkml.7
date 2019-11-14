Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEB6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C800E2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XmGB0Z0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKNPn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:43:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfKNPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yCDAxDEHJIYlDrd94Z2kbm5R5wgHLkedcF+IJ/xgRUI=; b=XmGB0Z0tRTH4RcVIk8F8n3wD1
        YNfpQg5WA08GRtva8Qxub8mBjTUAJMogZ0uiusFh44zhcJNXwP+B+i+kyI/i62UjJDIPjAGAyO85L
        KdoCKL1lB0EYWXsR0KR0ifix9aPZTHDJwKsLpM1TzRug0iB+MQwtiGZ6p3zVhNb28vn6Wqi/qaXvC
        Mk0N3i74i5DMyleABrRswGTJg/Hgbyv+RL4/jvgvYI5goJqt/hLHYkce+NWcNBVwJ2/IRQMLccxJ5
        8feZm19d8XsbpcgMUVTyNfUP/gVNPSlWHHXPqrdtxQe87kfAEAT3RuRHoAjOzk9zt+GqtkBGXvoAY
        K7LOe0TKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVHGs-0007AO-Ak; Thu, 14 Nov 2019 15:42:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43F253002B0;
        Thu, 14 Nov 2019 16:41:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F034C20302F15; Thu, 14 Nov 2019 16:42:55 +0100 (CET)
Date:   Thu, 14 Nov 2019 16:42:55 +0100
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
Message-ID: <20191114154255.GR4114@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111132458.162172862@infradead.org>
 <394483573.90.1573659752560.JavaMail.zimbra@efficios.com>
 <20191114135311.GW4131@hirez.programming.kicks-ass.net>
 <1135959694.112.1573743977897.JavaMail.zimbra@efficios.com>
 <20191114151323.GK2865@paulmck-ThinkPad-P72>
 <135240750.136.1573744944568.JavaMail.zimbra@efficios.com>
 <20191114152829.GA4131@hirez.programming.kicks-ass.net>
 <1849439575.148.1573745401685.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1849439575.148.1573745401685.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:30:01AM -0500, Mathieu Desnoyers wrote:
> ----- On Nov 14, 2019, at 10:28 AM, Peter Zijlstra peterz@infradead.org wrote:

> > I don't think that is needed. As per the patch under discussion, we
> > unconditionally need that IPI-sync (even for !optimized) but we only
> > need the synchonize_rcu_tasks() thing for optimized kprobes.
> > 
> > Also, they really do two different things. Lets not tie them together.
> 
> I'm fine with this approach, I just thought it would be good to consider
> the alternative.

Fair enough; I also just remembered we use synchronize_rcu_tasks() in
scenarios where we don't need to IPI-sync, for instrance when freeing
ftrace trampolines. There we just want to make sure nothing is still
preempted inside the trampoline when we free it -- which would be BAD
:-)
