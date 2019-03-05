Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C14920652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2IsnPcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCEVug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:50:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfCEVuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IYF06Fn89jbE735n2truln7RThJkUdQZkfi5xUO771w=; b=A2IsnPcRincOTOVQpBK20Pucm
        jgfaX6aTQ+O/78psILE5gqXxtwTiWXak+VRYvmBzMhIA9bbXB55tn681VlG/4l5MVHyhC6efcb8Zc
        WVbJPpv3ep/oQ18A8pK2501LNnVd44T2K0A4f8o6nudqqqMBBJvnqR/NR+KLhVonfiOW1y+rv6F+y
        sc56jbp0eouUejiALdyTNjVMOKywK/nxgEHiPLuGfGpEQmQoNdhgiqLVCmYnNAbyU+AIPA6ZT4j/8
        TpRFZJIz9aT/zYXy29u+6fuppTMZSnDpLbDC/e8VywoGF66yR8Iu3FHe1cuR1wfmwnr7KW7plz6h5
        +3UyPkKsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1Hwm-0003Vc-NN; Tue, 05 Mar 2019 21:50:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09CF120288BA3; Tue,  5 Mar 2019 22:49:59 +0100 (CET)
Date:   Tue, 5 Mar 2019 22:49:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH for 5.1 0/3] Restartable Sequences updates for 5.1
Message-ID: <20190305214958.GP32477@hirez.programming.kicks-ass.net>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 02:47:52PM -0500, Mathieu Desnoyers wrote:
> Mathieu Desnoyers (3):
>   rseq: cleanup: Reflect removal of event counter in comments
>   rseq: cleanup: remove rseq_len from task_struct
>   rseq/selftests: Adapt number of threads to the number of detected cpus
> 
>  arch/arm/kernel/signal.c                       | 3 +--
>  arch/x86/kernel/signal.c                       | 5 +----
>  include/linux/sched.h                          | 4 ----
>  kernel/rseq.c                                  | 9 +++------
>  tools/testing/selftests/rseq/run_param_test.sh | 7 +++++--
>  5 files changed, 10 insertions(+), 18 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
