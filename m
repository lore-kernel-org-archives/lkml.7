Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4EAC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6438A21848
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfE0PWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:22:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:52310 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfE0PWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:22:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 08:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,519,1549958400"; 
   d="scan'208";a="178919746"
Received: from ideak-desk.fi.intel.com ([10.237.72.204])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2019 08:22:03 -0700
Date:   Mon, 27 May 2019 18:21:28 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/2] lockdep: Fix OOO unlock when hlocks need merging
Message-ID: <20190527152128.GB24536@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20190524201509.9199-1-imre.deak@intel.com>
 <20190527150251.GE2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527150251.GE2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 05:02:51PM +0200, Peter Zijlstra wrote:
> On Fri, May 24, 2019 at 11:15:08PM +0300, Imre Deak wrote:
> > 
> > 	ww_mutex_lock(&ww_lock_a, &ww_ctx);
> > 
> > 	mutex_lock(&lock_c);
> > 
> > 	ww_mutex_lock(&ww_lock_b, &ww_ctx);
> > 
> > 	mutex_unlock(&lock_c);		(*)
> 
> > triggers the following WARN in __lock_release() when doing the unlock at *:
> > 
> > 	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - 1);
> > 
> > The problem is that the WARN check doesn't take into account the merging
> > of ww_lock_a and ww_lock_b which results in decreasing curr->lockdep_depth
> > by 2 not only 1.
> 
> Cute...
> 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index c40fba54e324..967352d32af1 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -3714,7 +3714,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
> >  				hlock->references = 2;
> >  			}
> >  
> > -			return 1;
> > +			return 2;
> >  		}
> >  	}
> >  
> > @@ -3920,22 +3920,33 @@ static struct held_lock *find_held_lock(struct task_struct *curr,
> >  }
> >  
> >  static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
> > -			      int idx)
> > +				int idx, bool *first_merged)
> >  {
> >  	struct held_lock *hlock;
> > +	int first_idx = idx;
> >  
> >  	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
> >  		return 0;
> >  
> >  	for (hlock = curr->held_locks + idx; idx < depth; idx++, hlock++) {
> > -		if (!__lock_acquire(hlock->instance,
> > +		switch (__lock_acquire(hlock->instance,
> >  				    hlock_class(hlock)->subclass,
> >  				    hlock->trylock,
> >  				    hlock->read, hlock->check,
> >  				    hlock->hardirqs_off,
> >  				    hlock->nest_lock, hlock->acquire_ip,
> > -				    hlock->references, hlock->pin_count))
> > +				    hlock->references, hlock->pin_count)) {
> > +		case 0:
> >  			return 1;
> > +		case 1:
> > +			break;
> > +		case 2:
> > +			*first_merged = idx == first_idx;
> > +			break;
> > +		default:
> > +			WARN_ON(1);
> > +			return 0;
> > +		}
> >  	}
> >  	return 0;
> >  }
> 
> Does it work for you if I change it like so?

Yep, works this way, and yes thought later that canceling *first_merged
for idx!=first_idx was a bit strange (even if it still worked).

> 
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3712,7 +3712,7 @@ static int __lock_acquire(struct lockdep
>  				hlock->references = 2;
>  			}
>  
> -			return 1;
> +			return 2;
>  		}
>  	}
>  
> @@ -3918,22 +3918,33 @@ static struct held_lock *find_held_lock(
>  }
>  
>  static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
> -			      int idx)
> +				int idx, unsigned int *merged)
>  {
>  	struct held_lock *hlock;
> +	int first_idx = idx;
>  
>  	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
>  		return 0;
>  
>  	for (hlock = curr->held_locks + idx; idx < depth; idx++, hlock++) {
> -		if (!__lock_acquire(hlock->instance,
> +		switch (__lock_acquire(hlock->instance,
>  				    hlock_class(hlock)->subclass,
>  				    hlock->trylock,
>  				    hlock->read, hlock->check,
>  				    hlock->hardirqs_off,
>  				    hlock->nest_lock, hlock->acquire_ip,
> -				    hlock->references, hlock->pin_count))
> +				    hlock->references, hlock->pin_count)) {
> +		case 0:
>  			return 1;
> +		case 1:
> +			break;
> +		case 2:
> +			*merged += (idx == first_idx);
> +			break;
> +		default:
> +			WARN_ON(1);
> +			return 0;
> +		}
>  	}
>  	return 0;
>  }
> @@ -3944,9 +3955,9 @@ __lock_set_class(struct lockdep_map *loc
>  		 unsigned long ip)
>  {
>  	struct task_struct *curr = current;
> +	unsigned int depth, merged = 0
>  	struct held_lock *hlock;
>  	struct lock_class *class;
> -	unsigned int depth;
>  	int i;
>  
>  	if (unlikely(!debug_locks))
> @@ -3971,14 +3982,14 @@ __lock_set_class(struct lockdep_map *loc
>  	curr->lockdep_depth = i;
>  	curr->curr_chain_key = hlock->prev_chain_key;
>  
> -	if (reacquire_held_locks(curr, depth, i))
> +	if (reacquire_held_locks(curr, depth, i, &merged))
>  		return 0;
>  
>  	/*
>  	 * I took it apart and put it back together again, except now I have
>  	 * these 'spare' parts.. where shall I put them.
>  	 */
> -	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth))
> +	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - merged))
>  		return 0;
>  	return 1;
>  }
> @@ -3986,8 +3997,8 @@ __lock_set_class(struct lockdep_map *loc
>  static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
>  {
>  	struct task_struct *curr = current;
> +	unsigned int depth, merged = 0;
>  	struct held_lock *hlock;
> -	unsigned int depth;
>  	int i;
>  
>  	if (unlikely(!debug_locks))
> @@ -4012,7 +4023,7 @@ static int __lock_downgrade(struct lockd
>  	hlock->read = 1;
>  	hlock->acquire_ip = ip;
>  
> -	if (reacquire_held_locks(curr, depth, i))
> +	if (reacquire_held_locks(curr, depth, i, &merged))
>  		return 0;
>  
>  	/*
> @@ -4021,6 +4032,11 @@ static int __lock_downgrade(struct lockd
>  	 */
>  	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth))
>  		return 0;
> +
> +	/* Merging can't happen with unchanged classes.. */
> +	if (DEBUG_LOCKS_WARN_ON(merged))
> +		return 0;
> +
>  	return 1;
>  }
>  
> @@ -4035,8 +4051,8 @@ static int
>  __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
>  {
>  	struct task_struct *curr = current;
> +	unsigned int depth, merged = 1;
>  	struct held_lock *hlock;
> -	unsigned int depth;
>  	int i;
>  
>  	if (unlikely(!debug_locks))
> @@ -4091,14 +4107,15 @@ __lock_release(struct lockdep_map *lock,
>  	if (i == depth-1)
>  		return 1;
>  
> -	if (reacquire_held_locks(curr, depth, i + 1))
> +	if (reacquire_held_locks(curr, depth, i + 1, &merged))
>  		return 0;
>  
>  	/*
>  	 * We had N bottles of beer on the wall, we drank one, but now
>  	 * there's not N-1 bottles of beer left on the wall...
> +	 * Pouring two of the bottles together is acceptable.
>  	 */
> -	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth-1);
> +	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - merged);
>  
>  	/*
>  	 * Since reacquire_held_locks() would have called check_chain_key()
