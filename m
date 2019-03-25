Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013A920850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MxtNtrnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfCYVYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:24:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37790 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:24:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id v21so8900197edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bNT9ld7oCcEjs9RcGgi16U400DSf8+LBcAvLOtsIWTA=;
        b=MxtNtrnxskiH2vE3uVtez4EIP7xHGpgVth086I5qzAouLT9XLleeFqa01SVCI8AHi4
         /zE5KhFjXPOxgeNca7STW2y3FUtICpjgsTYmWFegcAi5Y/TaaIRlHnpJu7ezk4LccHEn
         T3azDMm9o7ncxoTMASw6GGBLIfffV/vDNk/ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bNT9ld7oCcEjs9RcGgi16U400DSf8+LBcAvLOtsIWTA=;
        b=Za82ZwwfP7Byjl8vMG2C1OEf00BcD0PorMXqMAtaHvUvyXIwr7Hu0N20+CusnU14JE
         bUWs4Eq7XNTJtV8rsAvhWdjWrtiKzzUFimlvB9yd32cXTA1oMcxLWN31NPxxBJWT6w9C
         cxqs/JG48o0qg6/GgFzW1jPzxp/GMSYyp60MXp1q6KeXk0BbocskshlHQD+Sm6w3W85c
         uNkqObKIPid1Ym50pvBvdIw6fC3J6+g7QbOPElD/FTdEyceWXYnx0heWccWwRIiXfBPf
         qwcixqeK8UopOtN7c5R4i90+4uD9xtet+G274I0YCA5Hjwqm4KbRtFvL/oAHpmIXEnKs
         56Jw==
X-Gm-Message-State: APjAAAU/PwERw67DNqPlCNc98RfTBAgxhMpFihR58fLIWbn6LljCcl4y
        xwwcw39qJl9POXCJ7/xj/AYJyw==
X-Google-Smtp-Source: APXvYqxMtZGSPPAxY2+8vOg+308SdmOJA2T9t/pCkBJRKCzJAoXvEVa8Xd/NCrihKL8lMVrHografw==
X-Received: by 2002:a17:906:1299:: with SMTP id k25mr14905248ejb.80.1553549042526;
        Mon, 25 Mar 2019 14:24:02 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id n3sm3716935eja.56.2019.03.25.14.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:24:01 -0700 (PDT)
Subject: Re: [RFCv2] string: Use faster alternatives when constant arguments
 are used
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
References: <20190324014445.28688-1-sultan@kerneltoast.com>
 <20190324022406.GA18988@sultan-box.localdomain>
 <2293c54f-40b1-1e59-665a-bd8f2cb957d2@rasmusvillemoes.dk>
 <20190324223202.GA875@sultan-box.localdomain>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8672b98c-bf71-7b5b-625e-2f241807d46c@rasmusvillemoes.dk>
Date:   Mon, 25 Mar 2019 22:24:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190324223202.GA875@sultan-box.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2019 23.32, Sultan Alsawaf wrote:
> On Sun, Mar 24, 2019 at 10:17:49PM +0100, Rasmus Villemoes wrote:
>> gcc already knows the semantics of these functions and can optimize
>> accordingly. E.g. for strcpy() of a literal to a buffer, gcc readily
>> compiles
> 
> The example you gave appears to get optimized accordingly, but there are
> numerous sane counterexamples that don't get optimized.
> 
> On arm64, with GCC 8.3.0, let's look at the simple strcmp usage in
> kernel/trace/preemptirq_delay_test.c:
> 
> static int preemptirq_delay_run(void *data)
> {
> 	unsigned long flags;
> 
> 	if (!strcmp(test_mode, "irq")) {
> 		local_irq_save(flags);
> 		busy_wait(delay);
> 		local_irq_restore(flags);
> 	} else if (!strcmp(test_mode, "preempt")) {
> 		preempt_disable();
> 		busy_wait(delay);
> 		preempt_enable();
> 	}
> 
> 	return 0;
> }
> 
> This is what happens without my patch:

Excellent, this is the kind of examples I was looking for. On x86-64,
there's no callq strcmp in sight (just a repz cmpsb loop). With your
patch, the code gets compiled similar to the arm64 case (it's a rather
convenient case which can be done as single 4- or 8-byte comparisons).

> I can produce lots of kernel examples that don't seem to follow basic str*
> optimization, which is what prompted me to write this in the first place.

Probably because the compiler doesn't want to introduce memory accesses
that are not allowed by the C language.

>> Does this even compile? It's a well-known (or perhaps
>> not-so-well-known?) pitfall that __builtin_constant_p() is not
>> guaranteed to be usable in __builtin_choose_expr() - the latter only
>> accepts bona fide integer constant expressions, while evaluation of
>> __builtin_constant_p can be delayed until various optimization phases.
> 
> It not only compiles, but also seems to work correctly from what I've observed.

Interesting. I'll have to look into how that can be.

>> This seems to be buggy - you don't know that src is at least as long as
>> dest. And arguing "if it's shorter, there's a nul byte, which will
>> differ from dest at that point, so memcmp will/should stop" means that
>> the whole word-at-a-time argument would be out.
> 
> You mean reading the last word of a string could read out of bounds of the
> string when using memcmp? There are lots of memcmp instances using a literal
> string in the kernel; I don't think it would be hard to find one that violates
> what you've pointed out, so I'm not really sure why it's a problem.

Existing code may have bugs. Or existing code may use a dubious pattern
which happens to be ok due to the context it appears in, but becomes
buggy when copy-pasted elsewhere.

> After a few minutes of grepping, it seems like the memcmp usage in
> drivers/md/dm-integrity.c can read out of bounds on its arguments:
> } else if (!memcmp(opt_string, "internal_hash:", strlen("internal_hash:"))) {
> 	r = get_alg_and_key(opt_string, &ic->internal_hash_alg, &ti->error,
> 			    "Invalid internal_hash argument");
> 	if (r)
> 		goto bad;

Yeah, this actually looks buggy. Maybe we don't have any memcmp()
implementations that do word-at-a-time (it would mostly make sense on BE
architectures). Or maybe there's something here that guarantees
sufficient slack after the nul byte, so we never read across a page
boundary (which is how bad things could happen).

Something like

  char stackbuffer[32];
  fill_stackbuffer_somehow();
  if (memcmp(stackbuffer, "literal", strlen("literal"))

should be sorta ok, even if memcmp might end up reading uninitialized bytes.

What I'm worried about is your patch changing every single strcmp(,
"literal") into a memcmp, with absolutely no way of knowing or checking
anything about the other buffer. And actually, it doesn't have to be a
BE arch with a word-at-a-time memcmp. If (as is usually the case) the
strcmp() result is compared to zero, after you change

  !strcmp(buf, "literal")

into

  !memcmp(buf, "literal", 8)

the compiler may (exactly as you want it to) change that into a single
8-byte load (or two 4-byte loads) and comparisons to literals, no
memcmp() involved. And how do you know that _that_ is ok, for every one
of the hundreds, if not thousands, of instances in the tree?

So, for strcpy(), I think gcc does optimize across all arches. For
strcat(), I dunno, it probably doesn't have many users and users of
strcat() obviously do not care about performance anyway. And for
strcmp(), some arch backends already optimize pretty well, some may be
lacking (either because the arch does not have suitable string ops, or
because nobody implemented the optimizations in gcc yet), and converting
blindly to memcmp() seems to be somewhat dangerous - a few pre-existing
"open-coded" such instances doesn't really justify a tree-wide conversion.

Rasmus
