Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAAFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADEA20850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dn0nkNUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDAJHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:07:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36616 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfDAJHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tr5iG0RatrjjKf2qKctaugtMj1dq+AB/Tt9yx6X0tTQ=; b=dn0nkNUxPzscydUMEDgkUuJmM
        G3yTjs9PPkAfE2Z1N086P7bUmc9Ag9xdwU3GcKB/M+aOz62jreKNWcIEqVvQB6v7NDW4gcgVGrGeP
        q5p3P4VPnw/oVjOhqsiY6WPFkchqNu1hai4Qk6RkvTgDw/uwXUPgJ0p7LsrTUOn3VKkR1Rg4JDpZk
        iW+fNMoF2JZ1zeS3dN+VBhQcmMK9dhQExQWT7odhU5p+2n/lMUBHypcV8rthCh3sKDAfpxVW3AN9Q
        1G0kub/xg68ZNyRqu26LVEzCcl8xx+Vup5Ki+0zz/hFVM6v6zYOd54o307eDM5oAJIaSsLZ3JNnNy
        K52I5NZQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAsu6-0007nt-Ma; Mon, 01 Apr 2019 09:06:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A2492026BE95; Mon,  1 Apr 2019 11:06:53 +0200 (CEST)
Date:   Mon, 1 Apr 2019 11:06:53 +0200
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
Message-ID: <20190401090653.GF11158@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329152006.110370-4-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:20:04AM -0400, Alex Kogan wrote:
> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> index bc6d3244e1af..71ee4b64c5d4 100644
> --- a/kernel/locking/mcs_spinlock.h
> +++ b/kernel/locking/mcs_spinlock.h
> @@ -17,8 +17,18 @@
>  
>  struct mcs_spinlock {
>  	struct mcs_spinlock *next;
> +#ifndef CONFIG_NUMA_AWARE_SPINLOCKS
>  	int locked; /* 1 if lock acquired */
>  	int count;  /* nesting count, see qspinlock.c */
> +#else /* CONFIG_NUMA_AWARE_SPINLOCKS */
> +	uintptr_t locked; /* 1 if lock acquired, 0 if not, other values */
> +			  /* represent a pointer to the secondary queue head */
> +	u32 node_and_count;	/* node id on which this thread is running */
> +				/* with two lower bits reserved for nesting */
> +				/* count, see qspinlock.c */
> +	u32 encoded_tail; /* encoding of this node as the main queue tail */
> +	struct mcs_spinlock *tail;    /* points to the secondary queue tail */
> +#endif /* CONFIG_NUMA_AWARE_SPINLOCKS */
>  };

Please, have another look at the paravirt code, in particular at struct
pv_node and its usage. This is horrible.

>  #ifndef arch_mcs_spin_lock_contended
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 074f65b9bedc..7cc923a59716 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c

> @@ -527,6 +544,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		next = READ_ONCE(node->next);
>  		if (next)
>  			prefetchw(next);
> +	} else {
> +		 /* In CNA, we must pass a non-zero value to successor when
> +		  * we unlock. This store should be harmless performance-wise,
> +		  * as we just initialized @node.
> +		  */

Buggered comment style, also, it confuses the heck out of me. What does
it want to say?

Also, why isn't it hidden in your pv_wait_head_or_lock() implementation?

> +		node->locked = 1;
>  	}
>  
