Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F419C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547CF20989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfCXWcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:32:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43226 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbfCXWcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:32:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id 67so5489977oif.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 15:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XAfYxCECD1BumVMAvzc9x9UmHGldg5m5w2xbFoBWpts=;
        b=j4hCJmRYwVhqDhVXhOCiFLSEyhQNGnGKIUOU1wm+0c/s515cm0JrQ5SvJrhDff8fkH
         LEIQYz1KDfNuwaR8HK9XpCdYJvc+JMA+KQji6pBEBykimIjJwsKwW7KCbqXidpLWTKP3
         YbSr/MthDzYqEB6ZnGt0+wXPJw/r613TaCnGsTFMpyUy55QViQ5ajYqGV6N7yph8tUUZ
         Cj6iTbnNeOdHGToFngJ3PT6Ftm7hBh6O2FYlGyqjUvD8c8pVuG4oaVkoQbyXw9q+qMOi
         cCh3F7Bl8gcn9/UdwuiNviYB0Z9T3adT3/aFsPFtdoA6+Ggxuru9Rt90imKjsc56e58X
         oM7A==
X-Gm-Message-State: APjAAAUazsiBcD4A3SlNbCsoULaDXbA+IdXVzURww1wlxIVCqpq8pysu
        PrbCgRg4hdYyzE28+vDASuo=
X-Google-Smtp-Source: APXvYqxywW9NrKkETCyQWHycpAOciWJnVNdC0hqqD9I5FdIl/LTCEmMi2QYAcle0nAnYWxUPTILWcQ==
X-Received: by 2002:aca:3e83:: with SMTP id l125mr9428894oia.146.1553466728435;
        Sun, 24 Mar 2019 15:32:08 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id u22sm3836521otk.49.2019.03.24.15.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 15:32:07 -0700 (PDT)
Date:   Sun, 24 Mar 2019 15:32:02 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [RFCv2] string: Use faster alternatives when constant arguments
 are used
Message-ID: <20190324223202.GA875@sultan-box.localdomain>
References: <20190324014445.28688-1-sultan@kerneltoast.com>
 <20190324022406.GA18988@sultan-box.localdomain>
 <2293c54f-40b1-1e59-665a-bd8f2cb957d2@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2293c54f-40b1-1e59-665a-bd8f2cb957d2@rasmusvillemoes.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:17:49PM +0100, Rasmus Villemoes wrote:
> gcc already knows the semantics of these functions and can optimize
> accordingly. E.g. for strcpy() of a literal to a buffer, gcc readily
> compiles

The example you gave appears to get optimized accordingly, but there are
numerous sane counterexamples that don't get optimized.

On arm64, with GCC 8.3.0, let's look at the simple strcmp usage in
kernel/trace/preemptirq_delay_test.c:

static int preemptirq_delay_run(void *data)
{
	unsigned long flags;

	if (!strcmp(test_mode, "irq")) {
		local_irq_save(flags);
		busy_wait(delay);
		local_irq_restore(flags);
	} else if (!strcmp(test_mode, "preempt")) {
		preempt_disable();
		busy_wait(delay);
		preempt_enable();
	}

	return 0;
}

This is what happens without my patch:

preemptirq_delay_run:
.LFB2517:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	.cfi_offset 19, -16
	.cfi_offset 20, -8
	adrp	x19, .LANCHOR0
	add	x19, x19, :lo12:.LANCHOR0
	mov	x0, x19
>	bl	strcmp
	cbz	w0, .L22
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
>	bl	strcmp
	cbz	w0, .L23

The calls to strcmp are not optimized out. Here is what this snippet looks like
after my patch:

preemptirq_delay_run:
.LFB2517:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	adrp	x0, .LANCHOR0
	mov	w1, 29289
	mov	x29, sp
	ldr	w2, [x0, #:lo12:.LANCHOR0]
	movk	w1, 0x71, lsl 16
	add	x3, x0, :lo12:.LANCHOR0
	cmp	w2, w1
	beq	.L23
	ldr	x1, [x0, #:lo12:.LANCHOR0]
	mov	x0, 29296
	movk	x0, 0x6565, lsl 16
	movk	x0, 0x706d, lsl 32
	movk	x0, 0x74, lsl 48
	cmp	x1, x0
	beq	.L24

The calls to strcmp were optimized out completely, not even replaced by a call
to memcmp.

I can produce lots of kernel examples that don't seem to follow basic str*
optimization, which is what prompted me to write this in the first place.

> Does this even compile? It's a well-known (or perhaps
> not-so-well-known?) pitfall that __builtin_constant_p() is not
> guaranteed to be usable in __builtin_choose_expr() - the latter only
> accepts bona fide integer constant expressions, while evaluation of
> __builtin_constant_p can be delayed until various optimization phases.

It not only compiles, but also seems to work correctly from what I've observed.

> This seems to be buggy - you don't know that src is at least as long as
> dest. And arguing "if it's shorter, there's a nul byte, which will
> differ from dest at that point, so memcmp will/should stop" means that
> the whole word-at-a-time argument would be out.

You mean reading the last word of a string could read out of bounds of the
string when using memcmp? There are lots of memcmp instances using a literal
string in the kernel; I don't think it would be hard to find one that violates
what you've pointed out, so I'm not really sure why it's a problem.

After a few minutes of grepping, it seems like the memcmp usage in
drivers/md/dm-integrity.c can read out of bounds on its arguments:
} else if (!memcmp(opt_string, "internal_hash:", strlen("internal_hash:"))) {
	r = get_alg_and_key(opt_string, &ic->internal_hash_alg, &ti->error,
			    "Invalid internal_hash argument");
	if (r)
		goto bad;
} else if (!memcmp(opt_string, "journal_crypt:", strlen("journal_crypt:"))) {
	r = get_alg_and_key(opt_string, &ic->journal_crypt_alg, &ti->error,
			    "Invalid journal_crypt argument");
	if (r)
		goto bad;
} else if (!memcmp(opt_string, "journal_mac:", strlen("journal_mac:"))) {

Where opt_string is a dynamically-set argument with no specified minimum length.

Sultan
