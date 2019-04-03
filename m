Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B028BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680B3206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s8sW6KUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDCQBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:01:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDCQBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=egIDybEuB51DrNyJlt/PcAuz3Iil78G3z2tbRZ7T7Zk=; b=s8sW6KUNt8FeI8iM2AxETX8YIA
        Uu6b9xPYXuMhgGPhSes5pfTUf3H4hfN1OpPbB0DylzdOYYnxBA8ATmpPEpbk29/i82slHf9PlRqV/
        SC/AUW5fTristV9ADcMU7sfdKdVAZXn9fyjrFa7ETWjZz7jMkehzKmSeKczyNX9a+zEMN9fdm2M6H
        ZKizW9pPtmNQ35LlZCI2aYevlWfH3Hh7tGvdE09RyNvrW0++vL6sxNUM28sWzDjNZvxe1w8AbjgaL
        4iYWeDj0vEDY3ZJL/F+sVI3N/v3r5/rm7NYK+ag+98fjKADtSdSSof8UwjU4UWXIN0dN+hRjmeRuj
        wJlGXsVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBiKB-0003nq-Uz; Wed, 03 Apr 2019 16:01:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 061F72038C245; Wed,  3 Apr 2019 18:01:13 +0200 (CEST)
Date:   Wed, 3 Apr 2019 18:01:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190403160112.GK4038@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:39:09AM -0400, Alex Kogan wrote:

> >> The patch that I am looking for is to have a separate
> >> numa_queued_spinlock_slowpath() that coexists with
> >> native_queued_spinlock_slowpath() and
> >> paravirt_queued_spinlock_slowpath(). At boot time, we select the most
> >> appropriate one for the system at hand.
> Is this how this selection works today for paravirt?
> I see a PARAVIRT_SPINLOCKS config option, but IIUC you are talking about a different mechanism here.
> Can you, please, elaborate or give me a link to a page that explains that?

Oh man, you ask us to explain how paravirt patching works... that's
magic :-)

Basically, the compiler will emit a bunch of indirect calls to the
various pv_ops.*.* functions.

Then, at alternative_instructions() <- apply_paravirt() it will rewrite
all these indirect calls to direct calls to the function pointers that
are in the pv_ops structure at that time (+- more magic).

So we initialize the pv_ops.lock.* methods to the normal
native_queued_spin*() stuff, if KVM/Xen/whatever setup detectors pv
spnlock support changes the methods to the paravirt_queued_*() stuff.

If you wnt more details, you'll just have to read
arch/x86/include/asm/paravirt*.h and arch/x86/kernel/paravirt*.c, I
don't think there's a coherent writeup of all that.

> > Agreed; and until we have static_call, I think we can abuse the paravirt
> > stuff for this.
> > 
> > By the time we patch the paravirt stuff:
> > 
> >  check_bugs()
> >    alternative_instructions()
> >      apply_paravirt()
> > 
> > we should already have enumerated the NODE topology and so nr_node_ids()
> > should be set.
> > 
> > So if we frob pv_ops.lock.queued_spin_lock_slowpath to
> > numa_queued_spin_lock_slowpath before that, it should all get patched
> > just right.
> > 
> > That of course means the whole NUMA_AWARE_SPINLOCKS thing depends on
> > PARAVIRT_SPINLOCK, which is a bit awkward…

> Just to mention here, the patch so far does not address paravirt, but
> our goal is to add this support once we address all the concerns for
> the native version.  So we will end up with four variants for the
> queued_spinlock_slowpath() — one for each combination of
> native/paravirt and NUMA/non-NUMA.  Or perhaps we do not need a
> NUMA/paravirt variant?

I wouldn't bother with a pv version of the numa aware code at all. If
you have overcommitted guests, topology is likely irrelevant anyway. If
you have 1:1 pinned guests, they'll not use pv spinlocks anyway.

So keep it to tertiary choice:

 - native
 - native/numa
 - paravirt
