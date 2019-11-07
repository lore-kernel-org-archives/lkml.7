Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD9C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41A42084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CA/jIkbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfKGJk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:40:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfKGJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lzkY49EQgMIBpXGJdLVJxFX6mTrhPYBXrvK0JKad5pQ=; b=CA/jIkbiqZ5KXJaP8IYv6431F
        s82T8okomlGDevfT1ur5jhRx+ViRuc3hWNLpkqGcwCng+mJN1ZnjawDL7+WXdOpeAsbqpXopMl+tW
        mXt7gNvrXFpprO3snmj1b7BA4yjfOQB77Ba5PAohPs2Be9oaR6fTXWpUU88wmDIaYA3gvHdMfYjY6
        4QLRzouC07rxoQrp6yDg+uQLwBlQyE4RPQ2xBUNbrSuMsfDrsWjo8Eu45fcnYV4eQTMBq0iMeR1qN
        uPVKo4U+CRk6Q6B0lS1cM4vPNC+vf51uG1v9L1m8ytHi4VuoSlMJXAXLIDhAsFDT13QYMRA6oBnme
        JzbFyKlRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSeH8-0002rn-4V; Thu, 07 Nov 2019 09:40:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69FB8301747;
        Thu,  7 Nov 2019 10:39:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC4E0203C2B8B; Thu,  7 Nov 2019 10:40:20 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:40:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 00/12] futex: Cure robust/PI futex exit races
Message-ID: <20191107094020.GE4131@hirez.programming.kicks-ass.net>
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106215534.241796846@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 10:55:34PM +0100, Thomas Gleixner wrote:

>  fs/exec.c                |    2 
>  include/linux/compat.h   |    2 
>  include/linux/futex.h    |   38 +++--
>  include/linux/sched.h    |    3 
>  include/linux/sched/mm.h |    6 
>  kernel/exit.c            |   30 ----
>  kernel/fork.c            |   40 ++---
>  kernel/futex.c           |  324 ++++++++++++++++++++++++++++++++++++++++-------
>  8 files changed, 330 insertions(+), 115 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
