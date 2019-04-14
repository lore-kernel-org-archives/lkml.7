Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63E9C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4E720880
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555258602;
	bh=+Ku/5BjUoC4T6P/q2jGkMG43TTUSVUGvZJLf9C8ijZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iv2OQXqVjEqNm0wlL0DHyPaC2oMY9umcatKMbOnQUffTvK/Smp5hxF33aqzWQNf8N
	 5H58mUcjnJsAgNVB95q8YESbHpwzkBbvvnANGGxZs17JQhyrko6QdiTtDDU06HSisb
	 CRJeQOfQh0u2lySGXx4mkIE8ijS4unIHn9DEAid4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfDNQQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfDNQQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:16:41 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 683FC20880
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 16:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555258599;
        bh=+Ku/5BjUoC4T6P/q2jGkMG43TTUSVUGvZJLf9C8ijZI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gQ9mxgkMp/q5HEu1w4NYo9Kf+rtmLe9ex7uPphPQEZOuEIIKJvED5doHqdRjz8w7V
         Nwy44nkFslAD5WFaZOeKskQvdS/HRUdKf/tTX2h11f/sDAtiGkEcj6n18HoFlkmD2m
         X7WfgHXxN8dnXpEf9ShFrB5PHRCCTbx9QFqiT0Og=
Received: by mail-wm1-f45.google.com with SMTP id r186so4343410wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 09:16:39 -0700 (PDT)
X-Gm-Message-State: APjAAAV8RmWfaMxQjjREAJHILtoxp51gvk8SFv2FUzrUbEK/lAT/kNVj
        HcZAe9j7qoAe+vxhNzVUOkjEFoKC0rHeWi358k8WrQ==
X-Google-Smtp-Source: APXvYqyFo54CjaUiNs0xTSZe1OHyO9KpVQjLN7XYrXilveopeKBtV9xGbxgugFA9c5riLNeOJ+PP9o6668KDpPuOrKo=
X-Received: by 2002:a1c:6c04:: with SMTP id h4mr19021074wmc.135.1555258598010;
 Sun, 14 Apr 2019 09:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190414155936.679808307@linutronix.de> <20190414160143.591255977@linutronix.de>
In-Reply-To: <20190414160143.591255977@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 14 Apr 2019 09:16:26 -0700
X-Gmail-Original-Message-ID: <CALCETrUhVc_u3HL-x7wMnk9ukEbwQPvc9N5Na-Q55se0VwcCpw@mail.gmail.com>
Message-ID: <CALCETrUhVc_u3HL-x7wMnk9ukEbwQPvc9N5Na-Q55se0VwcCpw@mail.gmail.com>
Subject: Re: [patch V3 01/32] mm/slab: Fix broken stack trace storage
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 9:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> kstack_end() is broken on interrupt stacks as they are not guaranteed to be
> sized THREAD_SIZE and THREAD_SIZE aligned.
>
> Use the stack tracer instead. Remove the pointless pointer increment at the
> end of the function while at it.
>
> Fixes: 98eb235b7feb ("[PATCH] page unmapping debug") - History tree
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: linux-mm@kvack.org
> ---
>  mm/slab.c |   28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1470,33 +1470,29 @@ static bool is_debug_pagealloc_cache(str
>  static void store_stackinfo(struct kmem_cache *cachep, unsigned long *addr,
>                             unsigned long caller)
>  {
> -       int size = cachep->object_size;
> +       int size = cachep->object_size / sizeof(unsigned long);
>
>         addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
>
> -       if (size < 5 * sizeof(unsigned long))
> +       if (size < 5)
>                 return;
>
>         *addr++ = 0x12345678;
>         *addr++ = caller;
>         *addr++ = smp_processor_id();
> -       size -= 3 * sizeof(unsigned long);
> +#ifdef CONFIG_STACKTRACE
>         {
> -               unsigned long *sptr = &caller;
> -               unsigned long svalue;
> -
> -               while (!kstack_end(sptr)) {
> -                       svalue = *sptr++;
> -                       if (kernel_text_address(svalue)) {
> -                               *addr++ = svalue;
> -                               size -= sizeof(unsigned long);
> -                               if (size <= sizeof(unsigned long))
> -                                       break;
> -                       }
> -               }
> +               struct stack_trace trace = {
> +                       .max_entries    = size - 4;
> +                       .entries        = addr;
> +                       .skip           = 3;
> +               };

This looks correct, but I think that it would have been clearer if you
left the size -= 3 above.  You're still incrementing addr, but you're
not decrementing size, so they're out of sync and the resulting code
is hard to follow.

--Andy
