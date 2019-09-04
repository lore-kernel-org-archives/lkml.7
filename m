Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8933C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF00820820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n1kToRkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfIDLtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:49:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33280 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbfIDLtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+qy3BCgboLWKLhGlnuK29K83eBLQ7Un2Rq4/KGyVKXM=; b=n1kToRkrAQGhUnCaK6UHHnmMV
        jFXDheRByPbp5j2G21CqstNiO6C/spiiuITOgNS4C6nnhaFDEV7mr3CpTuLaUioc+vlbtqJtsmzi2
        D9nepF3dyi+o97s4beE6cXSIf2HRqzyC2pnMLXb2kMJ08wIEUJu3lg634BhHPa+e7/TE+quJh+22g
        r+6cfgLbcxo5h3TseNCrvCaMHk5Lz42+a/QB9IY1Pum/SKbyX30XfKbIqI2TIvSZK5sT+kyEa1Yk1
        s/DDFLvl3r4t+2rMnb4kCc+zd6nml5gAHeDTR9dWZ/AmwDhTWFcPytTJYh/N+ps7ywRAp0EC+wy8R
        67jQK2a4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Tn1-0004fA-7l; Wed, 04 Sep 2019 11:49:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8080830116F;
        Wed,  4 Sep 2019 13:48:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1038A29D88309; Wed,  4 Sep 2019 13:49:29 +0200 (CEST)
Date:   Wed, 4 Sep 2019 13:49:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
Message-ID: <20190904114929.GV2386@hirez.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
 <20190903202434.GX2349@hirez.programming.kicks-ass.net>
 <1029906102.725.1567543307658.JavaMail.zimbra@efficios.com>
 <20190904112819.GD2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904112819.GD2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 01:28:19PM +0200, Peter Zijlstra wrote:
> @@ -196,6 +198,17 @@ static int membarrier_register_global_expedited(void)
>  		 */
>  		smp_mb();
>  	} else {
> +		struct task_struct *g, *t;
> +
> +		read_lock(&tasklist_lock);
> +		do_each_thread(g, t) {
> +			if (t->mm == mm) {
> +				atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED,
> +					  &t->membarrier_state);
> +			}
> +		} while_each_thread(g, t);
> +		read_unlock(&tasklist_lock);
> +
>  		/*
>  		 * For multi-mm user threads, we need to ensure all
>  		 * future scheduler executions will observe the new

Arguably, because this is exposed to unpriv users and a potential
preemption latency issue, we could do it in 3 passes:

	- RCU, mark all found lacking, count
	- RCU, mark all found lacking, count
	- if count of last pass, tasklist_lock

That way, it becomes much harder to trigger the bad case.

Do we worry about that?
