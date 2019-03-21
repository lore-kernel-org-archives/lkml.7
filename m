Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B67C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8466C21902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NDXHckrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfCUS20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:28:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38004 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K7jgdLmtsMcvZO7oun2rohRv0sVj/+6PVxGcpmuFeak=; b=NDXHckrNujEcuZGUOjnC4dENX
        Zy5tQ6BXvHcpdInaRi90cTbNBQ0f2jgpmAyasMFUDXFDS6NEQzC1cWQPKuAwkJ35PPUfkpW9BtTOe
        +cS9vEmrrLbdDGE/O7IyJnqLDkl3vMbzyRtOrmtptU+2vzzCSJMs56KbZNzW9hNNIKD/mYoewc9B+
        cx1bmCCPBgjvblOLgt8ft51bWtncaX0LpfGsVcEqpT8OpsXd/P2SfTh28Jyg0wXMusf8lLNaxbK0u
        c9O7Fu7oa/jZ34mPHJvgd+YAmg2Y0LkKhhEcIgOeDgZypaXbFGimxyP6jLzcQu+g+5oJXOLi5AX62
        /9umL7fww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h72Pq-0001aE-Mz; Thu, 21 Mar 2019 18:27:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43CDB2072618D; Thu, 21 Mar 2019 19:27:45 +0100 (CET)
Date:   Thu, 21 Mar 2019 19:27:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321182745.GU5996@hirez.programming.kicks-ass.net>
References: <20190320221534.165ab87b@oasis.local.home>
 <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net>
 <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home>
 <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:05:06AM -0700, Andy Lutomirski wrote:

> Ugh.
> 
> I certainly agree in principle that sticking the CR2 read into the asm
> is the right solution.  But this patch makes the spaghetti even more
> tangled.  Maybe we can rearrange the code a bit so that the entry
> sequence saves at least one register before calling error_entry, so we
> can do it the obvious way.

What is the obvious way? Note that with all the Xen/paravirt-me-harder
bits on, we need to clobber at least RAX to get CR2.

And most of the patch was munging the paravirt bits to make that happen.

Another thing I did notices is that CLAC and CLD are not next to one
another in these paths.
