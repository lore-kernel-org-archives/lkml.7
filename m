Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14AFC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C130207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVEmyxPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfDBJnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:43:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53958 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDBJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S8MQn98qOqgzAiCgSbcL7hpe7vaijewxBXYXQRkz4Fw=; b=pVEmyxPFNEFM12bnA5XRPUND2
        OZQd7bb7DLg5q6Iis1XoUbheAb1ETIdBMrUxgDQkb3vnTxzo2tNgAmbN+9346Fofd34mrz3a4cvlt
        aLuRVLEAY6wgnLBGtLAotY+iCvqePMmqjhMZErkk6/ZVIChOJlrPVQa0vHv7tlwFYkFQR/p519qgn
        3bQjf1HgT3TtdwY8awLyl8Bzf4JdUzyfAvLQRQVD8dakzZJ5yY7G/NmtlNJGTRfH65im8I0sLKuOs
        pKFXH/Lz3XLQ5dHBpelMqH0A8B0Ey7j0ucJNxzZ8iOeBK78HwU7zvWGYUsNRNMlSejoMv3rQLXcwt
        E+fG1qvBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBFww-0000nk-PF; Tue, 02 Apr 2019 09:43:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E5572871E77C; Tue,  2 Apr 2019 11:43:20 +0200 (CEST)
Date:   Tue, 2 Apr 2019 11:43:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190402094320.GM11158@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:36:19AM -0400, Waiman Long wrote:
> On 03/29/2019 11:20 AM, Alex Kogan wrote:
> > +config NUMA_AWARE_SPINLOCKS
> > +	bool "Numa-aware spinlocks"
> > +	depends on NUMA
> > +	default y
> > +	help
> > +	  Introduce NUMA (Non Uniform Memory Access) awareness into
> > +	  the slow path of spinlocks.
> > +
> > +	  The kernel will try to keep the lock on the same node,
> > +	  thus reducing the number of remote cache misses, while
> > +	  trading some of the short term fairness for better performance.
> > +
> > +	  Say N if you want absolute first come first serve fairness.
> > +
> 
> The patch that I am looking for is to have a separate
> numa_queued_spinlock_slowpath() that coexists with
> native_queued_spinlock_slowpath() and
> paravirt_queued_spinlock_slowpath(). At boot time, we select the most
> appropriate one for the system at hand.

Agreed; and until we have static_call, I think we can abuse the paravirt
stuff for this.

By the time we patch the paravirt stuff:

  check_bugs()
    alternative_instructions()
      apply_paravirt()

we should already have enumerated the NODE topology and so nr_node_ids()
should be set.

So if we frob pv_ops.lock.queued_spin_lock_slowpath to
numa_queued_spin_lock_slowpath before that, it should all get patched
just right.

That of course means the whole NUMA_AWARE_SPINLOCKS thing depends on
PARAVIRT_SPINLOCK, which is a bit awkward...
