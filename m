Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB4C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7DA21741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554863334;
	bh=whT/QhC4HHKekpkPzhuf92P1WlwCH4Fbqnn8pZR1tag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=suMQVBbE7QJxBBuMa3c1TEEESxUT7TgQ6qUyQvdhWt5oIFkMh42XDFnV8w7RuxOJG
	 0LMkrMpaJb8xz7ThmDDUbNzwJnJC6I+ZvvbybOMvLhgC33HdWdrbKcVF9ePSOx8DiH
	 o6HmXYGXLnI3nvjb4bcSitzYP9LSdYkAs9qfvWxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDJC2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfDJC2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:28:52 -0400
Received: from localhost (lfbn-1-18355-218.w90-101.abo.wanadoo.fr [90.101.143.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CDCE2084F;
        Wed, 10 Apr 2019 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554863331;
        bh=whT/QhC4HHKekpkPzhuf92P1WlwCH4Fbqnn8pZR1tag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2tFi6VbJsjQwyBW+ULM3u2qj7eHXAjltW2uJou/WN4npJBVwofBI7vo7rYypXcIKE
         UVRUBKZT66/uy5hkrOtuLHyP9BFZj4ETBxtvI5TMWSnE3wgDkYUK2bAngXk8vsWpB8
         Geyo66LZwUqQiTIfCDLM1qGdv5kBxV+sHfW3GxD4=
Date:   Wed, 10 Apr 2019 04:28:48 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/4] locking/lockdep: Test all incompatible scenario at
 once in check_irq_usage()
Message-ID: <20190410022846.GA30602@lenoir>
References: <20190402160244.32434-1-frederic@kernel.org>
 <20190402160244.32434-5-frederic@kernel.org>
 <20190409130352.GV4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409130352.GV4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 03:03:52PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 02, 2019 at 06:02:44PM +0200, Frederic Weisbecker wrote:
> > @@ -1988,45 +1961,151 @@ static int exclusive_bit(int new_bit)
> >  	return state | (dir ^ LOCK_USAGE_DIR_MASK);
> >  }
> >  
> > +static unsigned long exclusive_dir_mask(unsigned long mask)
> 
> Would you mind terribly if I call that: invert_dir_mask() ?

That's indeed much better.

> 
> > +{
> > +	unsigned long excl;
> > +
> > +	/* Invert dir */
> > +	excl = (mask & LOCKF_ENABLED_IRQ_ALL) >> LOCK_USAGE_DIR_MASK;
> > +	excl |= (mask & LOCKF_USED_IN_IRQ_ALL) << LOCK_USAGE_DIR_MASK;
> > +
> > +	return excl;
> > +}
> > +
> > +static unsigned long exclusive_mask(unsigned long mask)
> > +{
> > +	unsigned long excl = exclusive_dir_mask(mask);
> > +
> > +	/* Strip read */
> > +	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
> > +	excl &= ~LOCKF_IRQ_READ;
> > +
> > +	return excl;
> > +}
> 
> And I might write a comment to go with those functions; they're too
> clever by half. I'm sure I'll have forgotten how they work in a few
> months time.

It only takes a night for me to forget how my code works. Then I need
a whole day long to recollect. But once I'm done the next night starts.

So I'm not against comments, thanks :-)

> > +/*
> > + * Find the first pair of bit match between an original
> > + * usage mask and an exclusive usage mask.
> > + */
> > +static int find_exclusive_match(unsigned long mask,
> > +				unsigned long excl_mask,
> > +				enum lock_usage_bit *bit,
> > +				enum lock_usage_bit *excl_bit)
> > +{
> > +	int fs, nr = 0;
> > +
> > +	while ((fs = ffs(mask))) {
> > +		int excl;
> > +
> > +		nr += fs;
> > +		excl = exclusive_bit(nr - 1);
> > +		if (excl_mask & lock_flag(excl)) {
> > +			*bit = nr - 1;
> > +			*excl_bit = excl;
> > +			return 0;
> > +		}
> > +		mask >>= fs - 1;
> > +		/*
> > +		 * Prevent from shifts of sizeof(long) which can
> > +		 * give unpredictable results.
> > +		 */
> > +		mask >>= 1;
> > +	}
> > +	return -1;
> 
> Should we write that like:
> 
> 	for_each_set_bit(bit, &mask, LOCK_USED) {
> 		int excl = exclusive_bit(bit);
> 		if (excl_mask & lock_flag(excl)) {
> 			*bitp = bit;
> 			*excl_bitp = excl;
> 			return 0;
> 		}
> 	}
> 	return -1;
> 
> Or something along those lines?

Ah yes indeed. Linus didn't like the idea of using bitmap functions for lockdep
usage bits in the softirq vector patchset but here the case is different as it's
not used in lockdep fastpath. That's only for the bad locking scenario path so it's
all good I think.

Should I re-issue the set or you do the changes?

Thanks.
