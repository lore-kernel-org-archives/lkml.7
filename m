Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69595C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336AB2466E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jmZyhgQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLFPbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:31:42 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48868 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfLFPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E0hIDqtLWD/kwlFAt2EAbBJXjXgF73qWQFs1wfH1DG4=; b=jmZyhgQ54PNr4pTvmzYmflYKj
        3VCM48Y2fu4DjgD90dbWk4f/tUJ1MD8ZViHh8HkDAhxPpmJ1fQhM+r9jS7HJOjGfKAMenE/mthp+l
        zxlwKjwH1Iaq3gV+a8++FeO5uVwxQfflpmG/Ybgc7MzBP5O2oyNODRPXDnX+ng3J4fdmBHHjZQX+d
        aSoR6lx+lIMMkw2V5bGJbBD4D97vkUF4/SJ2RdUa6Zn8Vo62dqx+s/pGz/0mELs3tsH3rKCPj4dBw
        SFi/Va5YbATiovy+zmm9Ern24m5MDt9gihlbHMH5vrJkEugRl2osCv0CS0izLp/EbWb6P/D2cmIj0
        yw5U49u9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idFZr-0000kw-TQ; Fri, 06 Dec 2019 15:31:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5549D30025A;
        Fri,  6 Dec 2019 16:30:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D02192B275E69; Fri,  6 Dec 2019 16:31:29 +0100 (CET)
Date:   Fri, 6 Dec 2019 16:31:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Malte Skarupke <malteskarupke@web.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, malteskarupke@fastmail.fm
Subject: Re: [PATCH] futex: Support smaller futexes of one byte or two byte
 size.
Message-ID: <20191206153129.GI2844@hirez.programming.kicks-ass.net>
References: <20191204235238.10764-1-malteskarupke@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204235238.10764-1-malteskarupke@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 06:52:38PM -0500, Malte Skarupke wrote:
> Two reasons for adding this:
> 1. People often want small mutexes. Having mutexes that are only one byte
> in size was the first reason WebKit mentioned for re-implementing futexes
> in a library:
> https://webkit.org/blog/6161/locking-in-webkit/

They have the best locking namespace _ever_!! Most impressed with them
for getting away with that.

> I had to change where we store two flags that were previously stored in
> the low bits of the address, since the address can no longer be assumed
> to be aligned on four bytes. Luckily the high bits were free as long as
> PAGE_SIZE is never more than 1 gigabyte.

For now it seems unlikely to run with 1G base pages :-)

> The reason for only supporting u8 and u16 is that those were easy to
> support with the existing interface. 64 bit futexes would require bigger
> changes. 

Might make sense to enumerate the issues you've found that stand in the
way of 64bit futexes. But yes, I can think of a few.


> @@ -467,7 +469,14 @@ static void drop_futex_key_refs(union futex_key *key)
> 
>  enum futex_access {

I prefer FUTEX_NONE, to match PROT_NONE.

>  	FUTEX_READ,
> -	FUTEX_WRITE
> +	FUTEX_WRITE,
> +	/*
> +	 * for operations that only need the address and don't touch the
> +	 * memory, like FUTEX_WAKE or FUTEX_REQUEUE. (not FUTEX_CMP_REQUEUE)
> +	 * this will skip the size checks of the futex, allowing those
> +	 * operations to be used with futexes of any size.
> +	 */
> +	FUTEX_NO_READ_WRITE
>  };
> 
>  /**

> @@ -520,25 +529,37 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
>   * lock_page() might sleep, the caller should not hold a spinlock.
>   */
>  static int
> -get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_access rw)
> +get_futex_key(u32 __user *uaddr, int flags, union futex_key *key, enum futex_access rw)
>  {
>  	unsigned long address = (unsigned long)uaddr;
>  	struct mm_struct *mm = current->mm;
>  	struct page *page, *tail;
>  	struct address_space *mapping;
> -	int err, ro = 0;
> +	int err, fshared, ro = 0;
> +
> +	fshared = flags & FLAGS_SHARED;
> 
>  	/*
>  	 * The futex address must be "naturally" aligned.
>  	 */
> +	if (flags & FLAGS_8_BITS || rw == FUTEX_NO_READ_WRITE) {
> +		if (unlikely(!access_ok(uaddr, sizeof(u8))))
> +			return -EFAULT;
> +	} else if (flags & FLAGS_16_BITS) {
> +		if (unlikely((address % sizeof(u16)) != 0))
> +			return -EINVAL;
> +		if (unlikely(!access_ok(uaddr, sizeof(u16))))
> +			return -EFAULT;
> +	} else {
> +		if (unlikely((address % sizeof(u32)) != 0))
> +			return -EINVAL;
> +		if (unlikely(!access_ok(uaddr, sizeof(u32))))
> +			return -EFAULT;
> +	}

That might be better written like:

	if (rw != FUTEX_NONE)
		size = futex_size(flags);
	else
		size = 1;

	if (unlikely((address % size) != 0))
		return -EINVAL;
	if (unlikely(!access_ok(uaddr, size)))
		return -EFAULT;


> @@ -799,6 +820,48 @@ static int get_futex_value_locked(u32 *dest, u32 __user *from)
>  	return ret ? -EFAULT : 0;
>  }
> 
> +static int
> +get_futex_value_locked_any_size(u32 *dest, u32 __user *from, int flags)
> +{
> +	int ret;
> +	u8 dest_8_bits;
> +	u16 dest_16_bits;
> +
> +	pagefault_disable();
> +	if (flags & FLAGS_8_BITS) {
> +		ret = __get_user(dest_8_bits, (u8 __user *)from);
> +		*dest = dest_8_bits;
> +	} else if (flags & FLAGS_16_BITS) {
> +		ret = __get_user(dest_16_bits, (u16 __user *)from);
> +		*dest = dest_16_bits;
> +	} else {
> +		ret = __get_user(*dest, from);
> +	}
> +	pagefault_enable();
> +
> +	return ret ? -EFAULT : 0;
> +}
> +
> +static int get_futex_value_any_size(u32 *dest, u32 __user *from, int flags)
> +{
> +	int ret;
> +	u8 uval_8_bits;
> +	u16 uval_16_bits;
> +
> +	if (flags & FLAGS_8_BITS) {
> +		ret = get_user(uval_8_bits, (u8 __user *)from);
> +		if (ret == 0)
> +			*dest = uval_8_bits;
> +	} else if (flags & FLAGS_16_BITS) {
> +		ret = get_user(uval_16_bits, (u16 __user *)from);
> +		if (ret == 0)
> +			*dest = uval_16_bits;
> +	} else {
> +		ret = get_user(*dest, from);
> +	}
> +	return ret;
> +}

Perhaps write that like:

static inline int __get_futex_value(u32 *dest, u32 __user *from, int flags)
{
	u32 val = 0;
	int ret;

	switch (futex_size(flags)) {
	case 1:
		/*
		 * afaict __get_user() doesn't care about the type of
		 * the first argument
		 */
		ret = __get_user(val, (u8 __user *)from);
		break;

	case 2:
		....

	case 4:

	}

	if (!ret)
		*dest = val;

	return ret;
}

static inline int get_futex_value(...)
{
	do uaccess check
	return __get_futex_value();
}

static inline int get_futex_value_locked(...)
{
	int ret;

	pagefault_disable();
	ret = __get_futex_value(...);
	pagefault_enable();

	return ret;
}

>  /*
>   * PI code:

> +	if (op & FUTEX_ALL_SIZE_BITS) {
> +		switch (cmd) {
> +		case FUTEX_CMP_REQUEUE:
> +			/*
> +			 * for cmp_requeue, only uaddr has to be of the size
> +			 * passed in the flags. uaddr2 can be of any size
> +			 */
> +		case FUTEX_WAIT:
> +		case FUTEX_WAIT_BITSET:
> +			switch (op & FUTEX_ALL_SIZE_BITS) {
> +			case FUTEX_SIZE_8_BITS:
> +				flags |= FLAGS_8_BITS;
> +				break;
> +			case FUTEX_SIZE_16_BITS:
> +				flags |= FLAGS_16_BITS;
> +				break;
> +			case FUTEX_SIZE_32_BITS:
> +				break;
> +			default:
> +				/*
> +				 * if both bits are set we could silently treat
> +				 * that as a 32 bit futex, but we may want to
> +				 * use this pattern in the future to indicate a
> +				 * 64 bit futex or an arbitrarily sized futex.
> +				 * so we don't want code relying on this yet.
> +				 */
> +				return -EINVAL;
> +			}
> +			break;
> +		case FUTEX_WAKE:
> +		case FUTEX_REQUEUE:
> +			/*
> +			 * these instructions work with sized mutexes, but you
> +			 * don't need to pass the size. we could silently
> +			 * ignore the size argument, but the code won't verify
> +			 * that the correct size is used, so it's preferable
> +			 * to make that clear to the caller.
> +			 *
> +			 * for requeue the meaning would also be ambiguous: do
> +			 * both of them have to be the same size or not? they
> +			 * don't, and that's clearer when you just don't pass
> +			 * a size argument.
> +			 */
> +			return -EINVAL;

Took me a while to figure out this relies on FUTEX_NONE to avoid the
alignment tests.

> +		default:
> +			/*
> +			 * all other cases are not supported yet
> +			 */
> +			return -EINVAL;
> +		}
> +	}
> 
>  	switch (cmd) {
>  	case FUTEX_LOCK_PI:
> --
> 2.17.1
> 
