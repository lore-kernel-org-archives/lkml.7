Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD8EC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E15208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k7BpvjHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfE0QGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:06:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41338 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0QGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cT0nnEVHc74sh0VxBOWfPvyYRYvuQp5XPXl0gDXCTJM=; b=k7BpvjHOYHorHZlxbRavox661
        EytxPl7zpFApkTACyvS4vyurhmqOorjvxVtoD+ShZSTvgWYyrqKLu+/uz72DhA5dL5b2F40/llIQh
        wghOOMD4vB3+rsvoYjAdDL65EiGwQA2ANPD4LqAeQYv7XJIvJYl4rYqmTzM45qEVjmYVUmEdku1X1
        d7S6bYlURl4x1xhmptCSE2EpKxCasufJ7CoG4gNxBJ+OyQp0sAhMpjPu/W43ch/kxQeHrxZOK9JSe
        tMcvpgnhALgo6cXjNdmofxBB2gw7EQe824k6wn8CHQT/q7I5qkPKhrqb14CoDhVJibX9Npdq9+23s
        QnRV/i1Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVI8i-0004ph-KR; Mon, 27 May 2019 16:06:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D76FF20277364; Mon, 27 May 2019 18:06:18 +0200 (CEST)
Date:   Mon, 27 May 2019 18:06:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Imre Deak <imre.deak@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 2/2] lockdep: Fix merging of hlocks with non-zero
 references
Message-ID: <20190527160618.GT2650@hirez.programming.kicks-ass.net>
References: <20190524201509.9199-1-imre.deak@intel.com>
 <20190524201509.9199-2-imre.deak@intel.com>
 <20190527151438.GF2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527151438.GF2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 05:14:38PM +0200, Peter Zijlstra wrote:
> On Fri, May 24, 2019 at 11:15:09PM +0300, Imre Deak wrote:
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 967352d32af1..9e2a4ab6c731 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -3637,6 +3637,11 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
> >  
> >  static int __lock_is_held(const struct lockdep_map *lock, int read);
> >  
> > +static int hlock_reference(int reference)
> > +{
> > +	return reference ? : 1;
> > +}
> > +
> >  /*
> >   * This gets called for every mutex_lock*()/spin_lock*() operation.
> >   * We maintain the dependency maps and validate the locking attempt:
> > @@ -3702,17 +3707,15 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
> >  	if (depth) {
> >  		hlock = curr->held_locks + depth - 1;
> >  		if (hlock->class_idx == class_idx && nest_lock) {
> > -			if (hlock->references) {
> > -				/*
> > -				 * Check: unsigned int references overflow.
> > -				 */
> > -				if (DEBUG_LOCKS_WARN_ON(hlock->references == UINT_MAX))
> 
> What tree is this against? Afaict this is still 12 bits ?!
> 
> > -					return 0;
> > +			/*
> > +			 * Check: unsigned int references overflow.
> > +			 */
> > +			if (DEBUG_LOCKS_WARN_ON(hlock_reference(hlock->references) >
> > +						UINT_MAX - hlock_reference(references)))
> 
> Idem. Also very weird overflow check..
> 
> > +				return 0;
> >  
> > -				hlock->references++;
> > -			} else {
> > -				hlock->references = 2;
> > -			}
> > +			hlock->references = hlock_reference(hlock->references) +
> > +					    hlock_reference(references);
> >  
> >  			return 2;
> >  		}

I think you wanted something like this: ?

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3731,6 +3731,11 @@ print_lock_nested_lock_not_held(struct t
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
 
+static inline int hlock_references(struct held_lock *hlock)
+{
+	return hlock->references ? : 1;
+}
+
 /*
  * This gets called for every mutex_lock*()/spin_lock*() operation.
  * We maintain the dependency maps and validate the locking attempt:
@@ -3796,17 +3801,14 @@ static int __lock_acquire(struct lockdep
 	if (depth) {
 		hlock = curr->held_locks + depth - 1;
 		if (hlock->class_idx == class_idx && nest_lock) {
-			if (hlock->references) {
-				/*
-				 * Check: unsigned int references:12, overflow.
-				 */
-				if (DEBUG_LOCKS_WARN_ON(hlock->references == (1 << 12)-1))
-					return 0;
-
-				hlock->references++;
-			} else {
-				hlock->references = 2;
-			}
+			if (!references)
+				references++;
+
+			hlock->references = hlock_references(hlock) + references;
+
+			/* Overflow */
+			if (DEBUG_LOCKS_WARN_ON(hlock->references < references))
+				return 0;
 
 			return 2;
 		}
