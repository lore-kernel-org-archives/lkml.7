Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB29CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B68220716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QEmNHA5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfLQUYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:24:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57788 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfLQUYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+VcbmUHkikhltbhd384iXiV0e3cBMTK3Pkyk6nNtzPI=; b=QEmNHA5sBmmnxttmG/iNlHW8S
        vCiuejabmHLvSp8H7RzhXtzasihDG+G815h8cGG7oCPPiSErs1K4z7+M6pmYp08N0CCq/uzKzW/f1
        jXswpWrzKgnGltC7AoTQIVnYxnfMjCTXaWFPXu3ISEdrvkd7U1182hukxDUPvNCIDiPBTCH4k1TDf
        5a7YSczdMrvtXb5ps8bNhNhpg0orECp/HaY9sG3mDB3DcvXL7mbVA/dskrNq95EICpAL/qpd9zSkP
        kvzaS6jv+GHHtKQ+vsleFCmTSQOrvarNEmqN+i18bte7fxYGFtJR/XL6fylGghvytbDFHzE91OQZK
        YFZsKMpYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihJNp-0005u0-RB; Tue, 17 Dec 2019 20:23:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BC1E300F29;
        Tue, 17 Dec 2019 21:22:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D7202B2CEC1A; Tue, 17 Dec 2019 21:23:52 +0100 (CET)
Date:   Tue, 17 Dec 2019 21:23:52 +0100
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
Message-ID: <20191217202352.GH2844@hirez.programming.kicks-ass.net>
References: <20191204204823.1503-1-peterx@redhat.com>
 <20191211154058.GO2827@hirez.programming.kicks-ass.net>
 <20191211162925.GD48697@xz-x1>
 <20191216203705.GV2844@hirez.programming.kicks-ass.net>
 <20191216205833.GB161272@xz-x1>
 <20191217095156.GZ2844@hirez.programming.kicks-ass.net>
 <20191217153128.GB7258@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217153128.GB7258@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:31:28AM -0500, Peter Xu wrote:
> On Tue, Dec 17, 2019 at 10:51:56AM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 16, 2019 at 03:58:33PM -0500, Peter Xu wrote:
> > > On Mon, Dec 16, 2019 at 09:37:05PM +0100, Peter Zijlstra wrote:
> > > > On Wed, Dec 11, 2019 at 11:29:25AM -0500, Peter Xu wrote:
> > 
> > > > > (3) Others:
> > > > > 
> > > > > *** arch/mips/kernel/process.c:
> > > > > raise_backtrace[713]           smp_call_function_single_async(cpu, csd);
> > > > 
> > > > per-cpu csd data, seems perfectly fine usage.
> > > 
> > > I'm not sure whether I get the point, I just feel like it could still
> > > trigger as long as we do it super fast, before IPI handled,
> > > disregarding whether it's per-cpu csd or not.
> > 
> > No, I wasn't paying attention last night. I'm thinking this one might
> > maybe be in 1). It does the state check using that bitmap.
> 
> Indeed.  Though I'm not very certain to change this one too, since I'm
> not sure whether that pr_warn is really intended:
> 
>         if (cpumask_test_and_set_cpu(cpu, &backtrace_csd_busy)) {
>                 pr_warn("Unable to send backtrace IPI to CPU%u - perhaps it hung?\n",
>                         cpu);
>                 continue;
>         }
> 
> I mean, that should depend on if it can really hang somehow (or it's
> the same issue as what we're trying to fix)...  If it won't hang, then
> it should be safe I think, and this pr_warn could be helpless after all.

Yeah, leave it.

> > I suspect to be nice for virt. Both CPUID and MSR accesses can trap. but
> > now I'm confused, because it is mostly WRMSR that traps.
> > 
> > Anyway, see the commit here: 07cde313b2d2 ("x86/msr: Allow rdmsr_safe_on_cpu() to schedule")
> 
> Yes that makes sense.  Thanks for the pointer.
> 
> However, then my next confusion is why they can't provide a common
> solution to the smp code again... I feel like it could be even easier
> (please see below).  I'm not very familiar with smp code yet, but if
> it works it should benefit all callers imho.

Ah, so going to sleep on wait_for_completion() is _much_ more expensive
than a short spin. So it all depends on the expected behaviour of the
IPI I suppose.

In general we expect these IPIs to be 'quick'.

Also, as is, you're allowed to use the smp_call_function*() family with
preemption disabled, which pretty much precludes using
wait_for_completion().
