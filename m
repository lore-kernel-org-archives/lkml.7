Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17455C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1534267E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZI5Jposq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfEaK6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:58:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaK6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OabcuSRjyveA89Eqdr1wotAhQKSiw0JfuvfJ7wdc2J8=; b=ZI5JposqhwL//hZuTbt3YZ9Do
        +3Eb24++39Z9q3MnGZWuG80MsS67HEpwawYkWiSqVjmwQDnyQhhWQT1XuXXjzY71s6qB/UUvY4CfN
        5nGXb9ZkHVSP2J7dBN/KNwGu05WW7IFHfDFsRb4RxzmybLXkTQhHItgDt/r8s89HkynxDuyl7bB3Q
        gByJZxy0QHt4UjF/Faisf0wnvKeil8/ToQGDKzFoq/XmfrV3iC/2fI5ToNoVTpM1etbX99FtHVQMm
        CvGk6kFIDFFqJEgFR2wSxylItnItcpuo1hNhGyBvyAwWTjZz/0nLzDCt4abXE8yEHXkl9EGwdl+e7
        H4azl1Pfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWfEW-0005fe-JP; Fri, 31 May 2019 10:58:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97F7A2079A5C9; Fri, 31 May 2019 12:57:58 +0200 (CEST)
Date:   Fri, 31 May 2019 12:57:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Message-ID: <20190531105758.GO2623@hirez.programming.kicks-ass.net>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-12-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531063645.4697-12-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:36:44PM -0700, Nadav Amit wrote:
> When we flush userspace mappings, we can defer the TLB flushes, as long
> the following conditions are met:
> 
> 1. No tables are freed, since otherwise speculative page walks might
>    cause machine-checks.
> 
> 2. No one would access userspace before flush takes place. Specifically,
>    NMI handlers and kprobes would avoid accessing userspace.
> 
> Use the new SMP support to execute remote function calls with inlined
> data for the matter. The function remote TLB flushing function would be
> executed asynchronously and the local CPU would continue execution as
> soon as the IPI was delivered, before the function was actually
> executed. Since tlb_flush_info is copied, there is no risk it would
> change before the TLB flush is actually executed.
> 
> Change nmi_uaccess_okay() to check whether a remote TLB flush is
> currently in progress on this CPU by checking whether the asynchronously
> called function is the remote TLB flushing function. The current
> implementation disallows access in such cases, but it is also possible
> to flush the entire TLB in such case and allow access.

ARGGH, brain hurt. I'm not sure I fully understand this one. How is it
different from today, where the NMI can hit in the middle of the TLB
invalidation?

Also; since we're not waiting on the IPI, what prevents us from freeing
the user pages before the remote CPU is 'done' with them? Currently the
synchronous IPI is like a sync point where we *know* the remote CPU is
completely done accessing the page.

Where getting an IPI stops speculation, speculation again restarts
inside the interrupt handler, and until we've passed the INVLPG/MOV CR3,
speculation can happen on that TLB entry, even though we've already
freed and re-used the user-page.

Also, what happens if the TLB invalidation IPI is stuck behind another
smp_function_call IPI that is doing user-access?

As said,.. brain hurts.
