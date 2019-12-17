Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC202C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AFB207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PG7xVVA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLQJwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:52:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52092 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfLQJwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P+XbrbFamg7yOE0Az6flqWnD9aZupyC6htsQMuIN+Lg=; b=PG7xVVA84MBmFPXHJO0+9E9qB
        +wOrDfW1Kc8+1qs6zVG/P9fjbyvREghDYuijgW8cTgvGOGgvXjXwgB6+agg1s3FzrLQrkDdS40pXy
        ZP7sUXHrGr2B7L8bj3N1KoCqscY3cDI/qTOmWGEdbVYBMiU1M+XB1jgHSqtpB6ccW1qaOu/JHVjDG
        ng154sMmj36bsQA4nEI8hpJvXi3T29lIt2v0HrBH7CMSbVy1zVg7gVwOvSo/nIpVfSSerb76waarB
        1ITJaG92EtOKGLjWo9zaECAskhhtnAywQEI/1/c2yGgG1yotjcBpMSZQkel+pi0CjO6UiZlL1qt1B
        VcXefwcaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ih9WK-0004V4-4X; Tue, 17 Dec 2019 09:52:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 650FA305FE5;
        Tue, 17 Dec 2019 10:50:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEC602B3D7E85; Tue, 17 Dec 2019 10:51:56 +0100 (CET)
Date:   Tue, 17 Dec 2019 10:51:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] smp: Allow smp_call_function_single_async() to insert
 locked csd
Message-ID: <20191217095156.GZ2844@hirez.programming.kicks-ass.net>
References: <20191204204823.1503-1-peterx@redhat.com>
 <20191211154058.GO2827@hirez.programming.kicks-ass.net>
 <20191211162925.GD48697@xz-x1>
 <20191216203705.GV2844@hirez.programming.kicks-ass.net>
 <20191216205833.GB161272@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216205833.GB161272@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 03:58:33PM -0500, Peter Xu wrote:
> On Mon, Dec 16, 2019 at 09:37:05PM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 11, 2019 at 11:29:25AM -0500, Peter Xu wrote:

> > > (3) Others:
> > > 
> > > *** arch/mips/kernel/process.c:
> > > raise_backtrace[713]           smp_call_function_single_async(cpu, csd);
> > 
> > per-cpu csd data, seems perfectly fine usage.
> 
> I'm not sure whether I get the point, I just feel like it could still
> trigger as long as we do it super fast, before IPI handled,
> disregarding whether it's per-cpu csd or not.

No, I wasn't paying attention last night. I'm thinking this one might
maybe be in 1). It does the state check using that bitmap.

> > > *** arch/x86/kernel/cpuid.c:
> > > cpuid_read[85]                 err = smp_call_function_single_async(cpu, &csd);
> > > *** arch/x86/lib/msr-smp.c:
> > > rdmsr_safe_on_cpu[182]         err = smp_call_function_single_async(cpu, &csd);
> > 
> > These two have csd on stack and wait with a completion. seems fine.
> 
> Yeh this is true, then I'm confused why they don't use the sync()
> helpers..

I suspect to be nice for virt. Both CPUID and MSR accesses can trap. but
now I'm confused, because it is mostly WRMSR that traps.

Anyway, see the commit here: 07cde313b2d2 ("x86/msr: Allow rdmsr_safe_on_cpu() to schedule")
