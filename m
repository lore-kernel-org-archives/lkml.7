Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D54C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DB4249F0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FwO2bWK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfFDMHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:07:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfFDMHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=syCKIAxBHgkuMWXLTEQ3r1RG7kSirXm5ulIaSV56KSI=; b=FwO2bWK5E7fMVtBY8ox3opJRm
        TDa/KgZBTFoCzROgRwfPwHZKdfp7gdDnr7owQWe7w465nDekukdOk/yt9c5z6WqddqI85POtymGTi
        xSauj2+vi3yLM69dppRZPmumFsUh7OSpIPCWWmV+erylP4AHU37PQ1fU2lHINquEV5HmhkKBz6A3O
        AuG870/KneaJlBKPJSL4IvnMaoVh5icti+wL3ZTvDxgpbVa5vFjRpAe6rj+H5CPr4GNn31+7eqA5j
        ITmJ2+tGoHt+cvtBly8MeoJ/iR65pTs2lsTNEwWFz6awbBQugtx/Bm+2OtL2xVu3EB6aN+qNNVXJ9
        qb2dvfOzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY8DV-0001QW-Sl; Tue, 04 Jun 2019 12:07:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2A7020114D93; Tue,  4 Jun 2019 14:06:59 +0200 (CEST)
Date:   Tue, 4 Jun 2019 14:06:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, jpoimboe@redhat.com,
        mojha@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH HACK RFC] cpu: Prevent late-arriving interrupts from
 disrupting offline
Message-ID: <20190604120659.GC3419@hirez.programming.kicks-ass.net>
References: <20190602011253.GA6167@linux.ibm.com>
 <20190603083848.GB3436@hirez.programming.kicks-ass.net>
 <20190604081435.GQ28207@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604081435.GQ28207@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:14:35AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 03, 2019 at 10:38:48AM +0200, Peter Zijlstra wrote:

> > And then there's powerpc which for some obscure reason thinks it needs
> > to enable preemption when dying ?! pseries_cpu_die() actually calls
> > msleep() ?!?!
> 
> Isn't pseries_cpu_die() invoked via the smp_ops->cpu_die() function
> pointer, whch is invoked from __cpu_die() in arch/powerpc/kernel/smp.c?
> Then, if I am reading the code correctly, __cpu_die() is invoked from
> takedown_cpu(), which is invoked not from the dying CPU but rather from
> a surviving CPU.  Or am I misreading the code?

Argh..

arch_cpu_idle_dead() -> cpu_die() -> ppc_md.cpu_die()

which is _NOT_ smp_ops.cpu_die()

this one ends in pseries_mach_cpu_die()
