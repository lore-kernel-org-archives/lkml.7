Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3DCC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5EF2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZZJA3p/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfDINDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:03:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfDINDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yz7y3uRjexTMwBlrpw3DdpRr3Ih3yhNfcZOnq/NFiQQ=; b=KZZJA3p/k62DBVI7YRc9TM7lF
        5vtfkypO3/sgM3/NiMuTqYCKdrGxiEI47ONCr43u9u3x75wxVgKTRyqjSy0aNFXqkWBvjrXSxSy56
        +3pWmQc+NAEvK3nLBftmLIR2q2MVgjzjEcIpSTe8c95/jaM2jUD8N2SRrQAVNCHmdAMgZ3HETVq9M
        SJPu7QK2p0/Aah0bVjPI50xgVLMjUGx++UcOqBOGJNIaCUdVnOMR3xVojnDTjgh7QnkmVBRMze9dG
        E+lWFBHpjP9NoDRU2JQTzAvchdtrlXnDzX8s1DOw1XTUZMSnf/oAxqHhLzwDp5VuuMVwVB5UZfcJt
        IX+Pz/k8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDqPq-0002rP-NV; Tue, 09 Apr 2019 13:03:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 623ED29B12221; Tue,  9 Apr 2019 15:03:52 +0200 (CEST)
Date:   Tue, 9 Apr 2019 15:03:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/4] locking/lockdep: Test all incompatible scenario at
 once in check_irq_usage()
Message-ID: <20190409130352.GV4038@hirez.programming.kicks-ass.net>
References: <20190402160244.32434-1-frederic@kernel.org>
 <20190402160244.32434-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402160244.32434-5-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:02:44PM +0200, Frederic Weisbecker wrote:
> @@ -1988,45 +1961,151 @@ static int exclusive_bit(int new_bit)
>  	return state | (dir ^ LOCK_USAGE_DIR_MASK);
>  }
>  
> +static unsigned long exclusive_dir_mask(unsigned long mask)

Would you mind terribly if I call that: invert_dir_mask() ?

> +{
> +	unsigned long excl;
> +
> +	/* Invert dir */
> +	excl = (mask & LOCKF_ENABLED_IRQ_ALL) >> LOCK_USAGE_DIR_MASK;
> +	excl |= (mask & LOCKF_USED_IN_IRQ_ALL) << LOCK_USAGE_DIR_MASK;
> +
> +	return excl;
> +}
> +
> +static unsigned long exclusive_mask(unsigned long mask)
> +{
> +	unsigned long excl = exclusive_dir_mask(mask);
> +
> +	/* Strip read */
> +	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
> +	excl &= ~LOCKF_IRQ_READ;
> +
> +	return excl;
> +}

And I might write a comment to go with those functions; they're too
clever by half. I'm sure I'll have forgotten how they work in a few
months time.

Very well done :-)

> +/*
> + * Find the first pair of bit match between an original
> + * usage mask and an exclusive usage mask.
> + */
> +static int find_exclusive_match(unsigned long mask,
> +				unsigned long excl_mask,
> +				enum lock_usage_bit *bit,
> +				enum lock_usage_bit *excl_bit)
> +{
> +	int fs, nr = 0;
> +
> +	while ((fs = ffs(mask))) {
> +		int excl;
> +
> +		nr += fs;
> +		excl = exclusive_bit(nr - 1);
> +		if (excl_mask & lock_flag(excl)) {
> +			*bit = nr - 1;
> +			*excl_bit = excl;
> +			return 0;
> +		}
> +		mask >>= fs - 1;
> +		/*
> +		 * Prevent from shifts of sizeof(long) which can
> +		 * give unpredictable results.
> +		 */
> +		mask >>= 1;
> +	}
> +	return -1;

Should we write that like:

	for_each_set_bit(bit, &mask, LOCK_USED) {
		int excl = exclusive_bit(bit);
		if (excl_mask & lock_flag(excl)) {
			*bitp = bit;
			*excl_bitp = excl;
			return 0;
		}
	}
	return -1;

Or something along those lines?

> +}
> +
