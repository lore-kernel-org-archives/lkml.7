Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E54BC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B7921D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573114604;
	bh=Uwe58yZaYb7lvMrYAPvZ/vi7UReydYmnZib7wK+VWDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ulikxnnUVEGAwLcBovoEpyqym+G3SuANGoEtTj+XJuNH9EEAUnjm95K5DiPcIhvCt
	 KU2TsFeM0FDVyqf/61suViLcVKLrRQ5fnmR0/McH2TcTVGZS1vWIK9OFGblWP05mQV
	 FyZlcOV34G4ibYu/bNgKM2Jn2Ddfwsmc2aOarXFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfKGIQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:16:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39378 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:16:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id a11so1913828wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FkvWeqGxoQO9ZcghuUpi0Fu5rYC2dDjTf0d0Kdz9f7A=;
        b=PaCR6eswM2d3Z/Rvz7wWxawqsyP+t7YpLcynQjjq3QnHrchbk9p4pd3qED3wxIVcel
         gg721uVkcv0Ei374P1UlCGSEGJjZh174XLsw49R9EmkgMHZcYYUHhkzBGw0ux3xHjmQF
         myvGshTYDX0Adp4ds5nesExyXGUx5L9WrOFHpeiC5I8q00QV6ZQ8TmhzXMqJBSbxB/H3
         lzeN0dcPMYSP486zMVBx/LnSK28F4pGcSj9sIlo5pfbDLAwx/5M8BsWcjg26zitGpnSv
         qVaiKCxy/Lc2as4O/k60nOVouu9D7I8MFz6vs6fmtuLZ01gP9n/5RZ6y7LsTgDvfzEF+
         IAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FkvWeqGxoQO9ZcghuUpi0Fu5rYC2dDjTf0d0Kdz9f7A=;
        b=sbL0i+Qy945C5TeCUgxvzS4zGaGNbWxK3r+6g076ZFIrTkdoT1MlaRo9FDqu1mVb3h
         2luYBfJ4z0tnD0zrg8jaZdC0+EPX3V9W6u4NyEKoi2sarZTCv5coQ7yxHMR0VBmnuO23
         RyQP4gOeI1iEZfdyIs85gc3TxcsSa27YGhITl+W4jIfyZx643e6NdYRkhK1gKjyVLQ6E
         Tkeh30aBoS/2xCdTMrXNkSFYUm+e/qmdLuEKERHgg2KBu8fpn+KG4ioqC/Rb8tNm+8xo
         0qLpLUSVgvPa370e9L2LtmYOIHwgh2CDLLUfOJncHDbW3O9FKpvrQ4N4qSh27JgC2fA9
         oWeA==
X-Gm-Message-State: APjAAAWtyQeTt41+8OEjVFENfyzWIo3XyhWtBHe2aRGUZSFEjj+f+sJP
        WtqGw1vm5nTm56lT9vSOTcE=
X-Google-Smtp-Source: APXvYqwgZT7k3mx7HU82NRVOqRwCKyMyrYReHGAOcaW6V4Q9yASsvheNXNmf5TWT8hKM/evVLWRQ6A==
X-Received: by 2002:adf:cf04:: with SMTP id o4mr1547423wrj.162.1573114598157;
        Thu, 07 Nov 2019 00:16:38 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b1sm1169871wrs.74.2019.11.07.00.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 00:16:37 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:16:35 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
Message-ID: <20191107081635.GE30739@gmail.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.241007755@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106202806.241007755@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> +	/* Update the bitmap */
> +	if (turn_on) {
> +		bitmap_clear(bitmap, from, num);
> +	} else {
> +		bitmap_set(bitmap, from, num);
> +	}
> +
> +	/* Get the new range */
> +	first = find_first_zero_bit(bitmap, IO_BITMAP_BITS);
> +
> +	for (last = next = first; next < IO_BITMAP_BITS; last = next) {
> +		/* Find the next set bit and update last */
> +		next = find_next_bit(bitmap, IO_BITMAP_BITS, last);
> +		last = next - 1;
> +		if (next == IO_BITMAP_BITS)
> +			break;
> +		/* Find the next zero bit and continue searching */
> +		next = find_next_zero_bit(bitmap, IO_BITMAP_BITS, next);
> +	}
> +
> +	/* Calculate the byte boundaries for the updated region */
> +	copy_start = from / 8;
> +	copy_len = (round_up(from + num, 8) / 8) - copy_start;

This might seem like a small detail, but since we do the range tracking 
and copying at byte granularity anyway, why not do the zero range search 
at byte granularity as well?

I bet it's faster and simpler as well than the bit-searching.

We could also change over the bitmap to a char or u8 based array and lose 
all the sizeof(long) indexing headaches, resulting type casts, for 
anything but the actual bitmap_set/clear() calls, etc.?

I.e. now that most of the logic is byte granular, the basic data 
structure might as well reflect that?

> +	/*
> +	 * Update the per thread storage and the TSS bitmap. This must be
> +	 * done with preemption disabled to prevent racing against a
> +	 * context switch.
> +	 */
> +	preempt_disable();
> +	tss = this_cpu_ptr(&cpu_tss_rw);
>  
> +	if (!t->io_bitmap_ptr) {
> +		unsigned int tss_start = tss->io_zerobits_start;
> +		/*
> +		 * If the task did not use the I/O bitmap yet then the
> +		 * perhaps stale content in the TSS needs to be taken into
> +		 * account. If tss start is out of bounds the TSS storage
> +		 * does not contain a zero bit and it's sufficient just to
> +		 * copy the new range over.
> +		 */

s/tss/TSS

> +		if (tss_start < IO_BITMAP_BYTES) {
> +			unsigned int tss_end =  tss->io_zerobits_end;
> +			unsigned int copy_end = copy_start + copy_len;
> +
> +			copy_start = min(tss_start, copy_start);
> +			copy_len = max(tss_end, copy_end) - copy_start;
> +		}
> +	}
> +
> +	/* Copy the changed range over to the TSS bitmap */
> +	dst = (char *)tss->io_bitmap;
> +	src = (char *)bitmap;
> +	memcpy(dst + copy_start, src + copy_start, copy_len);
> +
> +	if (first >= IO_BITMAP_BITS) {
> +		/*
> +		 * If the resulting bitmap has all permissions dropped, clear
> +		 * TIF_IO_BITMAP and set the IO bitmap offset in the TSS to
> +		 * invalid. Deallocate both the new and the thread's bitmap.
> +		 */
> +		clear_thread_flag(TIF_IO_BITMAP);
> +		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
> +		tofree = bitmap;
> +		bitmap = NULL;

BTW., wouldn't it be simpler to just say that if a thread uses IO ops 
even once, it gets a bitmap and that's it? I.e. we could further simplify 
this seldom used piece of code.

> +	} else {
>  		/*
> +		 * I/O bitmap contains zero bits. Set TIF_IO_BITMAP, make
> +		 * the bitmap offset valid and make sure that the TSS limit
> +		 * is correct. It might have been wreckaged by a VMEXiT.
>  		 */
> +		set_thread_flag(TIF_IO_BITMAP);
> +		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
>  		refresh_tss_limit();
>  	}

I'm wondering, shouldn't we call refresh_tss_limit() in both branches, or 
is a VMEXIT-wreckaged TSS limit harmless if we otherwise have 
io_bitmap_base set to IO_BITMAP_OFFSET_INVALID?


>  	/*
> +	 * Update the range in the thread and the TSS
>  	 *
> +	 * Get the byte position of the first zero bit and calculate
> +	 * the length of the range in which zero bits exist.
>  	 */
> +	start = first / 8;
> +	end = first < IO_BITMAP_BITS ? round_up(last, 8) / 8 : 0;
> +	t->io_zerobits_start = tss->io_zerobits_start = start;
> +	t->io_zerobits_end = tss->io_zerobits_end = end;
>  
>  	/*
> +	 * Finally exchange the bitmap pointer in the thread.
>  	 */
> +	bitmap = xchg(&t->io_bitmap_ptr, bitmap);
> +	preempt_enable();
>  
> +	kfree(bitmap);
> +	kfree(tofree);
>  
>  	return 0;


Thanks,

	Ingo
