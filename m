Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABA8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B971213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hXlpHWX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDAJeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:34:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36952 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfDAJeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AYMDSvhbnsbqhnhLpWaIkl1vWRlzxF1dhoJu98rOPYQ=; b=hXlpHWX9PJxQ6IOQGPiPGVNAo
        gWfhNZ1sXkF3fJYtFZdb++0l7NjjxN/zHMfBCBGW4TVwylzDdnx0nZBwM2Vi+wd+uadahNB8TC77X
        0VoBa8SD5DbUmdPrqotODUib/5XBFtZDUHDV4Si0Q1+x5srdf+i94qOdhe5gwRtHMmZsbf7L7aQww
        G6yBNI+g6hBjIugEs77iN6OicnNwJQW/9p7jNNyEP6dYb5YoiPTjUP1RHKJPhAGZ+03BazMwBvPUe
        5zoi3fYkK9kk+wxPFESEodyFdESJXXoGcTPTliMgNBHNbi/kHTXBHCRjmbncMCq8EhuAvPkZBBKIa
        2aAQKyyNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAtK8-0007w6-0u; Mon, 01 Apr 2019 09:33:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5E4C2026BE95; Mon,  1 Apr 2019 11:33:45 +0200 (CEST)
Date:   Mon, 1 Apr 2019 11:33:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190401093345.GA14281@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <20190401090653.GF11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401090653.GF11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:06:53AM +0200, Peter Zijlstra wrote:
> On Fri, Mar 29, 2019 at 11:20:04AM -0400, Alex Kogan wrote:
> > diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> > index bc6d3244e1af..71ee4b64c5d4 100644
> > --- a/kernel/locking/mcs_spinlock.h
> > +++ b/kernel/locking/mcs_spinlock.h
> > @@ -17,8 +17,18 @@
> >  
> >  struct mcs_spinlock {
> >  	struct mcs_spinlock *next;
> > +#ifndef CONFIG_NUMA_AWARE_SPINLOCKS
> >  	int locked; /* 1 if lock acquired */
> >  	int count;  /* nesting count, see qspinlock.c */
> > +#else /* CONFIG_NUMA_AWARE_SPINLOCKS */
> > +	uintptr_t locked; /* 1 if lock acquired, 0 if not, other values */
> > +			  /* represent a pointer to the secondary queue head */
> > +	u32 node_and_count;	/* node id on which this thread is running */
> > +				/* with two lower bits reserved for nesting */
> > +				/* count, see qspinlock.c */
> > +	u32 encoded_tail; /* encoding of this node as the main queue tail */
> > +	struct mcs_spinlock *tail;    /* points to the secondary queue tail */
> > +#endif /* CONFIG_NUMA_AWARE_SPINLOCKS */
> >  };
> 
> Please, have another look at the paravirt code, in particular at struct
> pv_node and its usage. This is horrible.

Thing is, this turns into a right mess when you also have PV spinlocks
on.

One thing we could maybe do is change locked and count to u8, then your
overlay structure could be something like:

struct mcs_spinlock {
	struct mcs_spinlock *next;
	u8 locked;
	u8 count;
};

struct cna_node {
	/* struct mcs_spinlock overlay */
	struct mcs_spinlock *next;
	u8 locked;
	u8 count;

	/* our CNA bits, consuming the slack and PV space */
	u16 node;
	u32 encoded_tail;
	struct mcs_spinlock *head;
	struct mcs_spinlock *tail;
};

Then you also don't need the first two patches.
