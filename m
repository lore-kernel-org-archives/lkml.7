Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C6FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF72421D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LxJhXFNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLSODG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:03:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLSODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xkx3Sb45pQu0H1ZFfnrJEoAGriM9SaStS1kzmfIEEew=; b=LxJhXFNfzxK8Tgd8JTMc8AYVv
        5pwRjQEncNX1kxDlS7KWLQko12PMyfg5c3IpS1eICcEB951LjDwh5WRPM+X5K8+7gSndcV5pp0vD2
        Mu8soGHmhPnFfYo7NaAKDdLj9JnSYirdkqNKST3hR08FTCRfZZXLmTxpKHNUMNkmZXVAzl7p13j0J
        BfwpetPFI71AP/FohnxcZNwXLCHSvYZ2ARDoB32aIajyLMl/i68K4BrxIkzJICtkoPISGofR7dueY
        x67/4483xDu1Ku6jJjgW55b78ZvH0eWlcnVIaC1vnFeJnXz5ZM1PYxFzD9gbCOHQv64GBMCn9XTAL
        3ZFm71jeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihwOE-0000qy-JZ; Thu, 19 Dec 2019 14:02:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB52C304C1B;
        Thu, 19 Dec 2019 15:01:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E6202B3E1685; Thu, 19 Dec 2019 15:02:52 +0100 (CET)
Date:   Thu, 19 Dec 2019 15:02:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Message-ID: <20191219140252.GS2871@hirez.programming.kicks-ass.net>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
 <20191219131242.GK2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219131242.GK2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 02:12:42PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 19, 2019 at 03:39:14PM +0300, Kirill Tkhai wrote:
> > In kernel/sched/Makefile files, describing different sched classes, already
> > go in the order from the lowest priority class to the highest priority class:
> > 
> > idle.o fair.o rt.o deadline.o stop_task.o
> > 
> > The documentation of GNU linker says, that section appears in the order
> > they are seen during link time (see [1]):
> > 
> > >Normally, the linker will place files and sections matched by wildcards
> > >in the order in which they are seen during the link. You can change this
> > >by using the SORT keyword, which appears before a wildcard pattern
> > >in parentheses (e.g., SORT(.text*)).
> > 
> > So, we may expect const variables from idle.o will go before ro variables
> > from fair.o in RO_DATA section, while ro variables from fair.o will go
> > before ro variables from rt.o, etc.
> > 
> > (Also, it looks like the linking order is already used in kernel, e.g.
> >  in drivers/md/Makefile)
> > 
> > Thus, we may introduce an optimization based on xxx_sched_class addresses
> > in these two hot scheduler functions: pick_next_task() and check_preempt_curr().
> > 
> > One more result of the patch is that size of object file becomes a little
> > less (excluding added BUG_ON(), which goes in __init section):
> > 
> > $size kernel/sched/core.o
> >          text     data      bss	    dec	    hex	filename
> > before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
> > after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o
> 
> Does LTO preserve this behaviour? I've never quite dared do this exact
> optimization.

Also, ld.lld seems a popular option.
