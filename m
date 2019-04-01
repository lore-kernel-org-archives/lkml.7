Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDBAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3072086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D/5HSQzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDAJV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:21:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfDAJVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UdqfqcqBuRUK6eRe3zfitc0Tv5Sfj4VsCq/y5wFNUWQ=; b=D/5HSQzKsreWwbw0JR02bezLe
        hzajNFCd1ARYyFH9V3avOtnvNt87/EjYY73QZG2+yI9pgI+DNK3QuQvzxiUKZQR7fgyYJ2ICQBPQ3
        t2HmSikTY6demZG359XGfAmbKKdp73tJA9zsvfXAt6iLcVFJ5zeqi0mBcnhuP5e9zlGq3iEclXmAJ
        ojYgfgb4TYmw22t968PY+tinp+XoAFN7+ApNbPj7/s8EdCNXXx7Qoa1p+nsPXYwvIcx4sF7o5cagN
        aLMeEQou5NiEEjZTHxKmzUnbVVLgciWJ2welWQ2RIaP5pI+FPzbgnFSKe+TPbX9aQdjLq2DrdULuD
        BrJkIgJxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAt81-00045B-6y; Mon, 01 Apr 2019 09:21:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF06F2026BE95; Mon,  1 Apr 2019 11:21:15 +0200 (CEST)
Date:   Mon, 1 Apr 2019 11:21:15 +0200
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
Message-ID: <20190401092115.GH11158@hirez.programming.kicks-ass.net>
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
> +static inline void pass_mcs_lock(struct mcs_spinlock *node,
> +				 struct mcs_spinlock *next)
> +{
> +	struct mcs_spinlock *succ = NULL;
> +
> +	succ = find_successor(node);
> +
> +	if (succ) {
> +		arch_mcs_spin_unlock_contended(&succ->locked, node->locked);
> +	} else if (node->locked > 1) {
> +		/*
> +		 * If the secondary queue is not empty, pass the lock
> +		 * to the first node in that queue.
> +		 */
> +		succ = MCS_NODE(node->locked);
> +		succ->tail->next = next;
> +		arch_mcs_spin_unlock_contended(&succ->locked, 1);
> +	} else {
> +		/*
> +		 * Otherwise, pass the lock to the immediate successor
> +		 * in the main queue.
> +		 */
> +		arch_mcs_spin_unlock_contended(&next->locked, 1);
> +	}
> +}

Note that something like:

static inline void
pass_mcs_lock(struct mcs_spinlock *node, struct mcs_spinlock *next)
{
	struct mcs_spinlock *succ = NULL;
	uintptr_t *var = &next->locked;
	uintptr_t val = 1;

	succ = find_successor(node);
	if (succ) {
		var = &succ->locked;
		val = node->locked;
	} else if (node->locked > 1) {
		succ = MCS_NODE(node->locked);
		succ->tail->next = next; /* WRITE_ONCE() !?!? */
		var = &node->locked;
	}

	arch_mcs_spin_unlock_contended(var, val);
}

is shorter and generates much better code if
arch_mcs_spin_unlock_contended() is asm volatile ().
