Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68161C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344DC218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555115751;
	bh=pOAxgJi9RRNIdw7zzU7wbjBjEnrdsEqQ6Vyk6/a9SvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jjzK4LC9n0+hR8IX3iULO+l2c/AP2uFL9QjHKTOUS0PHDGiKKxbdWzkSq0qgXj+EL
	 V9tzHJp6IGQPB1/PwT52MdrPBX9acpfprtEM2Wzsh0AxXItrJymuQKQHRH5N/CoU0X
	 RNmtHF9nh5bLKDelJwryDHxQQ4bos+ctoFTMX7Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfDMAft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfDMAft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:35:49 -0400
Received: from localhost (lfbn-1-18355-218.w90-101.abo.wanadoo.fr [90.101.143.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E3D2084E;
        Sat, 13 Apr 2019 00:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555115748;
        bh=pOAxgJi9RRNIdw7zzU7wbjBjEnrdsEqQ6Vyk6/a9SvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5SFpS9+6qVTYIoVUAtAi2MtWniZrE/uNUDclELXQcqor7wp1ul6YPZroLTi267B6
         8gE7garNlU72u8RTqsxtLp90fQpwy64XiS1SzRymXxrNKMavohY12Ip0jeykkbzwQk
         w5GeNP7OVqCxm7QnM+cyhM/Oaht3TEVR9wBRDjpU=
Date:   Sat, 13 Apr 2019 02:35:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/4] locking/lockdep: Test all incompatible scenario at
 once in check_irq_usage()
Message-ID: <20190413003543.GA9544@lenoir>
References: <20190402160244.32434-1-frederic@kernel.org>
 <20190402160244.32434-5-frederic@kernel.org>
 <20190409130352.GV4038@hirez.programming.kicks-ass.net>
 <20190410022846.GA30602@lenoir>
 <20190411104632.GH4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411104632.GH4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:46:32PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 10, 2019 at 04:28:48AM +0200, Frederic Weisbecker wrote:
> > Should I re-issue the set or you do the changes?
> 
> I've made it like so; does that work? In particular, do the comments
> make sense? It is always hard to write these things down.

It's especially hard because we describe both the bits of the usage mask
and the bits of the bit numbers of the usage mask. The resulting description
can only be naughty :-)

That said I can probably clarify that in lockdep_internals.h on further
patches.

A few comments though:

> +/*
> + * The bit number is encoded like:
> + *
> + *  bit0: 0 exclusive, 1 read lock
> + *  bit1: 0 used in irq, 1 irq enabled
> + *  bit2-n: state
> + */
>  static int exclusive_bit(int new_bit)
>  {
>  	int state = new_bit & LOCK_USAGE_STATE_MASK;
> @@ -1988,45 +1968,158 @@ static int exclusive_bit(int new_bit)
>  	return state | (dir ^ LOCK_USAGE_DIR_MASK);
>  }
>  
> +/*
> + * Observe that when given a bitmask where each bitnr is encoded as above, a
> + * right shift of the mask transforms the individual bitnrs as -1.
> + *
> + * So for all bits where bitnr1 == 1, we can create the mask where bitnr1 == 0

So by bitnr1 you're referring to direction, right?

> + * by subtracting 2, or shifting the mask right by 2.

In which case we can perhaps reformulate:

  So for all bits whose number have LOCK_ENABLED_* set (bitnr1 == 1), we can create the
  mask with those bit numbers using LOCK_USED_IN_* (bitnr1 == 0) instead by
  subtracting the bit number by 2, or shifting the mask right by 2.

And same would go for below.

> + *
> + * Similarly, bitnr1 == 0 becomes bitnr1 == 1 by adding 2, or shifting left 2.
> + *
> + * So split the mask (note that LOCKF_ENABLED_IRQ_ALL|LOCKF_USED_IN_IRQ_ALL is
> + * all bits set) and recompose with bitnr1 flipped.
> + */
> +static unsigned long invert_dir_mask(unsigned long mask)
> +{
> +	unsigned long excl = 0;
> +
> +	/* Invert dir */
> +	excl |= (mask & LOCKF_ENABLED_IRQ_ALL) >> LOCK_USAGE_DIR_MASK;
> +	excl |= (mask & LOCKF_USED_IN_IRQ_ALL) << LOCK_USAGE_DIR_MASK;
> +
> +	return excl;
> +}
> +
> +/*
> + * As above, we clear bitnr0 with bitmask ops. First, for all bits with bitnr1
> + * set, add those with bitnr1 cleared. And then mask out all bitnr1.
> + */

Same here:

  As above, we clear bitnr0 (LOCK_*_READ off) with bitmask ops. First, for all bits
  with bitnr1 set (LOCK_ENABLED_*) , add those with bitnr1 cleared (LOCK_USED_IN_*).
  And then mask out all bitnr1.

> +static unsigned long exclusive_mask(unsigned long mask)
> +{
> +	unsigned long excl = invert_dir_mask(mask);
> +
> +	/* Strip read */
> +	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
> +	excl &= ~LOCKF_IRQ_READ;
> +
> +	return excl;
> +}

Not sure I'm making things clearer but at least that's some more pointers
to enum lock_usage_bit (defined on headers where I should add more layout
explanations, especially to make it clear we play with bit number bits :-s  )

Thanks.
