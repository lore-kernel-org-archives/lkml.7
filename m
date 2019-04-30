Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F55C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B02721670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="loVtF8KB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfD3SBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:01:37 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46071 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfD3SBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:01:36 -0400
Received: by mail-vs1-f66.google.com with SMTP id o10so8514453vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udGYYZ0yreK6CtTU+km/hkbu5NAgxUoskOjd7fbDP/U=;
        b=loVtF8KBjSkZ8K3xAisNVfIzS4JJpgbqd/1xbj5zJ/zndA/l2aYmvKyzT5P2WNF0Ph
         8EfksqMoTlhy+kreTuVOGfFpGdcIxKSdNaywlFu4kJSR84ljsb1/KB9nPoxLCTN99eEZ
         73+nUgycHbo2eoku46d5DG3xXX7nj7nXZ3Kkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udGYYZ0yreK6CtTU+km/hkbu5NAgxUoskOjd7fbDP/U=;
        b=AX1yFOcAh0v3EYY0kAl5cQ65uux+wrzL9PVLf1FxDfoMeoaGs5GHaG4BMNbCt/2mQ1
         VcwC86c6NWZm+TQ1qekohIURSP10cX1Oec+DfRWx1QKlUuboaG0G47EOonw34xk/2cY9
         IJtS/rZfkEuJzVSwYX0xn49c8yIPzsJJCyJxenw9U+S2fIQENjPaPnl6oTNv/hinTdzx
         UOXUGB6Sa/Ah28g7lCJw/5r+tlbFU9G/vl9ll4ULH0DFT5lvd5bl8xn84OwE1fWsPm0e
         iyqf2PV3jDFPi+PrBHm2Ooih4nfF7c7Iswhmvf68oeeCPBNslrU4FheFvIyyGLSKvhRK
         gV5A==
X-Gm-Message-State: APjAAAUEXzRPJhrIIzwEEvggHSesFz+piL9bGqBmvT9GN/13A6cueaZO
        spM+pVPnEnCtiusXijaQIr0Dwq5wTfw=
X-Google-Smtp-Source: APXvYqw5IaBKdhM/5krXQmB/rCgQiPSrvFUv5K8F1SGviNULc7r6jHcBI0Z/u97XAuq0KAFYjbaXQg==
X-Received: by 2002:a67:82c8:: with SMTP id e191mr37537009vsd.24.1556647294383;
        Tue, 30 Apr 2019 11:01:34 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id u3sm3982942vsi.2.2019.04.30.11.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 11:01:31 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id h127so3306469vkd.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 11:01:31 -0700 (PDT)
X-Received: by 2002:a1f:3c83:: with SMTP id j125mr35725886vka.92.1556647290472;
 Tue, 30 Apr 2019 11:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net> <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu> <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com> <20190417151555.GG4686@mit.edu>
 <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com> <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
 <20190426140102.GA4922@mit.edu> <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net> <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Apr 2019 11:01:02 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK108afSxMp6qtcdEr-D-ONz80L0C_4p2oLsMsDWvK=zw@mail.gmail.com>
Message-ID: <CAGXu5jK108afSxMp6qtcdEr-D-ONz80L0C_4p2oLsMsDWvK=zw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 10:51 AM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
> base: Simple syscall: 0.1761 microseconds
> get_random_bytes (4096 bytes per-cpu buffer): 0.1793 microsecons
> get_random_bytes (64 bytes per-cpu buffer): 0.1866 microsecons

The 4096 size seems pretty good.

> Below is a snip of what I quickly did (relevant parts) to get these numbers.
> I do initial population of per-cpu buffers in late_initcall, but
> practice shows that rng might not always be in good state by then.
> So, we might not have really good randomness then, but I am not sure
> if this is a practical problem since it only applies to system boot and by
> the time it booted, it already issued enough syscalls that buffer gets refilled
> with really good numbers.
> Alternatively we can also do it on the first syscall that each cpu gets, but I
> am not sure if that is always guaranteed to have a good randomness.

Populating at first syscall seems like a reasonable way to delay. And
I agree: I think we should not be too concerned about early RNG state:
we should design for the "after boot" behaviors.

> diff --git a/lib/percpu-random.c b/lib/percpu-random.c
> new file mode 100644
> index 000000000000..3f92c44fbc1a
> --- /dev/null
> +++ b/lib/percpu-random.c
> @@ -0,0 +1,49 @@
> +#include <linux/types.h>
> +#include <linux/percpu.h>
> +#include <linux/random.h>
> +
> +static DEFINE_PER_CPU(struct rnd_buffer, stack_rand_offset) __latent_entropy;
> +
> +
> +/*
> + *    Generate some initially weak seeding values to allow
> + *    to start the prandom_u32() engine.
> + */
> +static int __init stack_rand_offset_init(void)
> +{
> +    int i;
> +
> +    /* exctract bits to out per-cpu rand buffers */
> +    for_each_possible_cpu(i) {
> +        struct rnd_buffer *buffer = &per_cpu(stack_rand_offset, i);
> +        buffer->byte_counter = 0;
> +        /* if rng is not initialized, this won't extract us good stuff
> +         * but we cannot wait for rng to initialize either */
> +        get_random_bytes(&(buffer->buffer), sizeof(buffer->buffer));

Instead of doing get_random_bytes() here, just set byte_counter =
RANDOM_BUFFER_SIZE and let random_get_byte() do the work on a per-cpu
basis?

> +
> +    }
> +
> +    return 0;
> +}
> +late_initcall(stack_rand_offset_init);
> +
> +unsigned char random_get_byte(void)
> +{
> +    struct rnd_buffer *buffer = &get_cpu_var(stack_rand_offset);
> +    unsigned char res;
> +
> +    if (buffer->byte_counter >= RANDOM_BUFFER_SIZE) {
> +        get_random_bytes(&(buffer->buffer), sizeof(buffer->buffer));
> +        buffer->byte_counter = 0;
> +    }
> +
> +    res = buffer->buffer[buffer->byte_counter];
> +    buffer->buffer[buffer->byte_counter] = 0;
> +    buffer->byte_counter ++;
> +     put_cpu_var(stack_rand_offset);
> +    return res;
> +}
> +EXPORT_SYMBOL(random_get_byte);

Otherwise, sure, looks good. I remain worried about info leaks of the
percpu area causing pain down the road, but we find a safer way to do
this, we can do it later.

-- 
Kees Cook
