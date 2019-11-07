Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F66C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CE820656
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OMTs0Kwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfKGJtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:49:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4/YlrvbO3+I6jJmxrnw6nxmMB83D4J2ofaqNrEMIKkU=; b=OMTs0KwiJbDOIiFZ9Yuo2F98/
        QwhMr0x7w60Rl+lYwDEcbe+g+FFVjZCMYuqUJ6FUadKy/G+3yxLjNJYPL2wY/W6xJXqa4lRDuD1iL
        xbXj5EXOUbD9U8DesIlgUM8e474v1KbmI4mQqEPrug1RqE7pzvd4NrQauqetWsdOJFqeblNsieGZr
        coQI3RF4LYceHEUDjSj+vDOKlTwL4ltGjpU0pZnMRDGHf4L2sVmeXQeCxBqtGKSAfxxs6vY+6CGHS
        fzKc2M8JLQTJSPo1upwY8Aam1ZkFAgl9145bzThrltCwUGTcfDfU5wimJhaiilW2QFfD5ev35L+ll
        luUp1EWRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSeQD-0002zR-TN; Thu, 07 Nov 2019 09:49:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F2673040CB;
        Thu,  7 Nov 2019 10:48:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB4DD203C2B8B; Thu,  7 Nov 2019 10:49:43 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:49:43 +0100
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
Subject: Re: [patch 09/12] futex: Provide state handling for exec() as well
Message-ID: <20191107094943.GF4131@hirez.programming.kicks-ass.net>
References: <20191106215534.241796846@linutronix.de>
 <20191106224556.753355618@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106224556.753355618@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 10:55:43PM +0100, Thomas Gleixner wrote:

> +static void futex_cleanup_end(struct task_struct *tsk, int state)
> +{
> +	/*
> +	 * Lockless store. The only side effect is that an observer might
> +	 * take another loop until it becomes visible.
> +	 */
> +	tsk->futex_state = state;

As I mentioned yesterday, paranoia would've made me write this as
smp_store_release(), also to avoid it creaping back into the locked
region.

That is, the comment above deals with it being visible late, but it
could be visible early.

At the same time, if this is a release, what does it pair with. The
obvious place would be the load in handle_exit_race() but that didn't
want to make sense last night -- and I'm not sure it wants to make more
sense today.

