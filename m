Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F9EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D07208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GrI76u0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfDBKiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:38:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDBKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hTmOEIK+bdjwk1/fRX0roH9PANmf8xxXsis2dR2ZomE=; b=GrI76u0yKlSd8L7tyAFAW9Hgt
        OBE+LC2fk0ssiS65MVz37zo/bRLTQ07y+DDdsohneYKecJOrlCRTsqWlgP35rapaN8zsAmjcZ91kP
        3nLZc/dxWAzD5KLKdXfHOgVTErQ5vdL0lh57qSoKSVRW97bpHVeQg6cEQLQRjGkphCjbDnDXxNOF1
        wficRIeNgDVi6omphPkFG62FTz3xOBmEcB0YlXmM+ZSkqwuSjjEkRiExaYW3hcR7aRDDh3KoHvfWm
        6OTUBIkcPCCwFfp+suDCyMBDBM2bOKxiGB/U9dqos6itg77amnXhDGdgIPmZYVH+78P/TyRiuf62c
        ffly+0zmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBGng-0004Dc-Qi; Tue, 02 Apr 2019 10:37:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E00BB203CBE11; Tue,  2 Apr 2019 12:37:50 +0200 (CEST)
Date:   Tue, 2 Apr 2019 12:37:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com, tytso@mit.edu
Subject: Re: [PATCH v2 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20190402103750.GN11158@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-5-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329152006.110370-5-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:20:05AM -0400, Alex Kogan wrote:
> @@ -25,6 +29,18 @@
>  
>  #define MCS_NODE(ptr) ((struct mcs_spinlock *)(ptr))
>  
> +/* Per-CPU pseudo-random number seed */
> +static DEFINE_PER_CPU(u32, seed);
> +
> +/*
> + * Controls the probability for intra-node lock hand-off. It can be
> + * tuned and depend, e.g., on the number of CPUs per node. For now,
> + * choose a value that provides reasonable long-term fairness without
> + * sacrificing performance compared to a version that does not have any
> + * fairness guarantees.
> + */
> +#define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
> +
>  static inline __pure int decode_numa_node(u32 node_and_count)
>  {
>  	int node = (node_and_count >> _Q_NODE_OFFSET) - 1;
> @@ -102,6 +118,35 @@ static struct mcs_spinlock *find_successor(struct mcs_spinlock *me)
>  	return NULL;
>  }
>  
> +/*
> + * xorshift function for generating pseudo-random numbers:
> + * https://en.wikipedia.org/wiki/Xorshift

Cute; so clearly you've read that page, but then you provide us a
variant that isn't actually listed there.

Your naming is also non-standard in that it does not relay the period.
The type seems to suggest 32bit, so the name should then have been:

  xorshift32()

Now, where did you get those parameters from; is this a proper
xorshift32 ?

> + */
> +static inline u32 xor_random(void)
> +{
> +	u32 v;
> +
> +	v = this_cpu_read(seed);
> +	if (v == 0)
> +		get_random_bytes(&v, sizeof(u32));

Given xorshift is a LFSR subset, the above case will only ever happen
_once_ and it seems like bad form to stick it here instead of in a init
function.

Also, does it really matter, can't we simply initialize the variable
with a !0 value and call it a day?

As to that variable, seed is clearly a misnomer, the wiki page you
reference calls it state, which might be a little ambiguous, xs_state
otoh should work just fine.

> +	v ^= v << 6;
> +	v ^= v >> 21;
> +	v ^= v << 7;
> +	this_cpu_write(seed, v);
> +
> +	return v;
> +}

Now, you've read that page and you know there's 'trivial' improvements
on the pure xorshift, why not pick one of those? xorwow seems cheap
enough, or that xorshift128plus() one.

> +
> +/*
> + * Return false with probability 1 / @range.
> + * @range must be a power of 2.
> + */
> +static bool probably(unsigned int range)
> +{
> +	return xor_random() & (range - 1);
> +}

Uhh, you sure that's what it does? The only way for that to return false
is when all @range bits are 0, which happens once (2^32/range)-1 times,
or am I mistaken?

Also, linux/random.h includes next_pseudo_random32(), should we be using
that? Arguably that's more expensive on a number of platforms due to the
multiplication. Also, we actually have xorshift32 already in tree in
lib/test_hash.c.

The advantage of next_psuedo_random32() is that it doesn't have that 0
identify that pure LFSRs suffer from and it has 0 state.  Now at a
glance, the xorwow/xorshift128plus variants don't seem to suffer that 0
identify, so that's good, but they still have fairly large state. It
also seems unfortunate to litter the tree with custom PRNGs. Ted?


