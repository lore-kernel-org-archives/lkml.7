Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC43C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA2F218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y4ndwh0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLSNM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:12:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X2rxmFp1nN4MsfxtIvmlE76kILeHh88dwPXVZiG/rcc=; b=Y4ndwh0tsVYEEvEZDSgCnUAwC
        4F5CwU7Z9BQdZxHvnSoeKOxsw2z7wftTAWGMymZc+Ebc9UElG8eCiV7T/5lxavnWV09M/gZ2Sfbyl
        Z9W6HvrZ2qxnOQXKV00FLEbny+/ONiB0RnzP/S4aG5gMQ8+LMn4ETV5mNnh9Yv8MWdYdUXiOSzJVD
        e2RxNqZ9VzoMk4H9ZPSL5C78aaBAfPkDZwWl3WaltXVZcdmGtQPi3K8rMKjunV/jSYsmvrCnBwohm
        esrMXcEJW7q13+NW3OfoRVzKt8eUYaULJmav+m55KdFekV+ypmu5DoWKpWoFM/6iwTvC7s0lmTlrl
        pj3d+fB4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihvbg-0000Vn-9r; Thu, 19 Dec 2019 13:12:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 885BC3007F2;
        Thu, 19 Dec 2019 14:11:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B1782B3DB890; Thu, 19 Dec 2019 14:12:42 +0100 (CET)
Date:   Thu, 19 Dec 2019 14:12:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Message-ID: <20191219131242.GK2827@hirez.programming.kicks-ass.net>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 03:39:14PM +0300, Kirill Tkhai wrote:
> In kernel/sched/Makefile files, describing different sched classes, already
> go in the order from the lowest priority class to the highest priority class:
> 
> idle.o fair.o rt.o deadline.o stop_task.o
> 
> The documentation of GNU linker says, that section appears in the order
> they are seen during link time (see [1]):
> 
> >Normally, the linker will place files and sections matched by wildcards
> >in the order in which they are seen during the link. You can change this
> >by using the SORT keyword, which appears before a wildcard pattern
> >in parentheses (e.g., SORT(.text*)).
> 
> So, we may expect const variables from idle.o will go before ro variables
> from fair.o in RO_DATA section, while ro variables from fair.o will go
> before ro variables from rt.o, etc.
> 
> (Also, it looks like the linking order is already used in kernel, e.g.
>  in drivers/md/Makefile)
> 
> Thus, we may introduce an optimization based on xxx_sched_class addresses
> in these two hot scheduler functions: pick_next_task() and check_preempt_curr().
> 
> One more result of the patch is that size of object file becomes a little
> less (excluding added BUG_ON(), which goes in __init section):
> 
> $size kernel/sched/core.o
>          text     data      bss	    dec	    hex	filename
> before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
> after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o

Does LTO preserve this behaviour? I've never quite dared do this exact
optimization.
