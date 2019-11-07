Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADBBC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB4121882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573115147;
	bh=vPXuQe0fmwpYRnOBjiZWZn3Ei+GTg8IjVoYeD0Uenhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=11mrsuRRzeyeH3bPwohz6onKjq1Aw9Ulwehp1Z4/AzqzstWdIkcPnKjvgokyuDm5g
	 Rlql7lh+K6zriqar/mBtoNf8HL1h07A/SYER2PtVqb+Yc6iEBJNSLzGGY5T0rcxigK
	 wCgbHUr1xtdyRb3CLPUG1dFEcMKlrCAua2gDpAns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfKGIZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:25:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32777 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:25:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id w30so2004730wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KJB6gfmjpi2GdIkkNg/6ZW3cyRBalou77J8+gGCf82E=;
        b=YlSfcKG6laG+DOWDefWNERunx+hQ9Iaujw1R9U0DmLCwl6jbrNSVCzEcXu1Ia2b7IE
         8S84lZnMYCn3IxP6fTycwFP0Ik3wN4lfuZOQoUROGB0sxYQ+AGcwVKqp4NFETIfoiIEF
         4chtVUS905GuSdD03b20x6pQFOOcLk8x4dNRJn0LWD5MGdqDBlTBoQNOkpz0KiH2rSVV
         juYVEZzxaAhII8G0+k1PvvRV37DHRIBvVoY0To5wclKJX8jqnwVaYGYjruOMlx76ktfB
         j7iPOavAJcykY0Gk6PtYGfXLmQmmD41EtIyqSOAHW/mFhQipZpHFLWHdqUnXnfKNZcAq
         jnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJB6gfmjpi2GdIkkNg/6ZW3cyRBalou77J8+gGCf82E=;
        b=LJA+VvN0m5llKeVlb/aY5vSq7kwQgL7ppHerLXOvGEiCcpYxgQ+DuKNNSQIRs2B5v0
         PIq0eD8TUIKQRw6LRLbpp2KBfJsTgZXeyEeWrQH/EuV+ElQOIndQxXfmVjWl0SfjyEZn
         N7/9Pw8Z3i7o1iKVoPrurvxBxTbmIfN5GzOITENi1VDKXt2Nqsn0vhrwHT/BpKug93L7
         zVBJWyXrd8v9p4DygXLPSk0Y7BZGwRjZ41VgyHmZ9eBA9nudcfRf2n2A4Rip2WEslTSe
         a+BWFGGhnpOBjKzdsk9qfvqrb5uNN7w9VXVu1R4Ct812mDoa8AnckrXU9qR0z5Xql5jz
         MFAw==
X-Gm-Message-State: APjAAAUvDWksC36cVyliq8T5T9rVtXYC8IH0g1hrsRN49fmEptgSk+jq
        bYbQilGHX4K8/G+7xJ/otvI=
X-Google-Smtp-Source: APXvYqxGKwl92j3I2dy8Cmse1j4VKL6l3DVHNiZioE72xPzAKYP6NujFOEA8liqMN37l5YLrhtdYkA==
X-Received: by 2002:adf:f6d1:: with SMTP id y17mr1528533wrp.255.1573115144057;
        Thu, 07 Nov 2019 00:25:44 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id n17sm1340232wrp.40.2019.11.07.00.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 00:25:43 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:25:41 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
Message-ID: <20191107082541.GF30739@gmail.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.241007755@linutronix.de>
 <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Nov 6, 2019 at 12:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Calculate both the position of the first zero bit and the last zero bit to
> > limit the range which needs to be copied. This does not solve the problem
> > when the previous tasked had only byte 0 cleared and the next one has only
> > byte 65535 cleared, but trying to solve that would be too complex and
> > heavyweight for the context switch path. As the ioperm() usage is very rare
> > the case which is optimized is the single task/process which uses ioperm().
> 
> Hmm.
> 
> I may read this patch wrong, but from what I can tell, if we really
> have just one process with an io bitmap, we're doing unnecessary
> copies.
> 
> If we really have just one process that has an iobitmap, I think we
> could just keep the bitmap of that process entirely unchanged. Then,
> when we switch away from it, we set the io_bitmap_base to an invalid
> base outside the TSS segment, and when we switch back, we set it back
> to the valid one. No actual bitmap copies at all.
> 
> So I think that rather than the "begin/end offset" games, we should
> perhaps have a "what was the last process that used the IO bitmap for
> this TSS" pointer (and, I think, some sequence counter, so that when
> the process updates its bitmap, it invalidates that case)?
> 
>  Of course, you can do *nboth*, but if we really think that the common
> case is "one special process", then I think the begin/end offset is
> useless, but a "last bitmap process" would be very useful.
> 
> Am I missing something?

In fact on SMP systems this would result in a very nice optimization: 
pretty quickly *all* TSS's would be populated with that single task's 
bitmap, and it would persist even across migrations from CPU to CPU.

I'd love to get rid of the offset caching and bit scanning games as well 
- it doesn't really help in a number of common scenarios and it 
complicates this non-trivial piece of code a *LOT* - and we probably 
don't really have the natural testing density of this code anymore to 
find any regressions quickly.

So intuitively I'd suggest we gravitate towards the simplest 
implementation, with a good caching optimization for the single-task 
case.

I.e. the model I'm suggesting is that if a task uses ioperm() or iopl() 
then it should have a bitmap from that point on until exit(), even if 
it's all zeroes or all ones. Most applications that are using those 
primitives really need it all the time and are using just a few ioports, 
so all the tracking doesn't help much anyway.

On a related note, another simplification would be that in principle we 
could also use just a single bitmap and emulate iopl() as an ioperm(all) 
or ioperm(none) calls. Yeah, it's not fully ABI compatible for mixed 
ioperm()/iopl() uses, but is that ABI actually being relied on in 
practice?

Thanks,

	Ingo
