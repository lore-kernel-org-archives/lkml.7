Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28F1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6809E206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552254216;
	bh=BQ064W/9YUPs28KwAr0rKZp3QNMHPzxtGXWSYKYNqo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dRJkmZpIWm/jU/tKcPRPcBhbrrxI2qDZxCTwQb+kaeEZvV+9hmBF+ZRqbzIVkWyZc
	 oc0kavtw9WL4MShzKdVJ4PzPUHOjXRaLm5aA8XJSbUxwq139Br1S3VtLlFMjExBlPv
	 D/TMky/aKMN3GjN2U3wML41/FiaQOtt0pX2U7OSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfCJVne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:43:34 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:45847 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfCJVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:43:34 -0400
Received: by mail-lj1-f172.google.com with SMTP id d24so2290683ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkxUb1LZi0ljL0wF/4Bz1lUnGux2IB6YzP+MRSw0I8s=;
        b=YgYKZB3l5B8hgTTyRsoDIY7KNRRyglu+WxlbBuGN8p/tIsEWXkMFi6nrlIeaI5OiAm
         2j+sSRSCZRBQgjsw5u26QU/KunQfB2ZhXjRK2j55bvACNNoWnEccS5xyGRRcFjNH6lmq
         cs16GPUcTOV8PlNvWeEFgFBHiNLd1p6y7fKSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkxUb1LZi0ljL0wF/4Bz1lUnGux2IB6YzP+MRSw0I8s=;
        b=NejNKRV24TPCoquHMj208gQUBFvx0ICHgZJnKDAoKj8usCjwimDEZiz9zev6MWbCVA
         /+6oFq8XzRH9O6pbwHuOTd/bimODDOn6uVp2/npc+Y9WWvL/jSaD2N9P8fpWs/nBBWAt
         otMKKuU2Gx7GPPptG1MuR58qvY5XBiZTowwWLFkUNwecoq7pQbOu1pB5qqL18YJ5MoHn
         9IaNgzyQsKBb41Re/YKmqZNwjd1NS2q6rJIHhibo53ArdAXpdi83BLwE0kvwHvrYLVf1
         Tnma5BkTnyVcLOvg67YsnowM+soM1bk6GLZzCTAlLh4XFE0RMzBn45d71CSRegg7fYjf
         CSVA==
X-Gm-Message-State: APjAAAVB0SEDWhma/oJkA3w4CmyPKsS+Vll7ArZJU8tSN33OYTzD5gEg
        AVzikZXjOXIZ4bTRxrpDeJWzhyCuWpA=
X-Google-Smtp-Source: APXvYqzOt8jlL0pkWqHtjLQhbj0z/cyvPa/ZpvtXObScp4jVroOdZhwvHIwCQyp6TVpecL69AuvAuQ==
X-Received: by 2002:a2e:9c97:: with SMTP id x23mr3940217lji.13.1552254210808;
        Sun, 10 Mar 2019 14:43:30 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b21sm823254lfi.7.2019.03.10.14.43.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 14:43:29 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id p1so1931124lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:43:29 -0700 (PDT)
X-Received: by 2002:ac2:5088:: with SMTP id f8mr15494586lfm.11.1552254209194;
 Sun, 10 Mar 2019 14:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.5173016541431155948.tglx@nanos.tec.linutronix.de>
In-Reply-To: <155221755097.13878.5173016541431155948.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Mar 2019 14:43:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com>
Message-ID: <CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com>
Subject: Re: [GIT pull] x86/asm for 5.1
To:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 4:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> +extern volatile unsigned long cr4_pin;
> +
>  static inline void native_write_cr4(unsigned long val)
>  {
> +       unsigned long warn = 0;
> +
> +again:
> +       val |= cr4_pin;
>         asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
> +       /*
> +        * If the MOV above was used directly as a ROP gadget we can
> +        * notice the lack of pinned bits in "val" and start the function
> +        * from the beginning to gain the cr4_pin bits for sure. Note
> +        * that "val" must be volatile to keep the compiler from
> +        * optimizing away this check.
> +        */
> +       if ((val & cr4_pin) != cr4_pin) {
> +               warn = ~val & cr4_pin;
> +               goto again;
> +       }
> +       WARN_ONCE(warn, "Attempt to unpin cr4 bits: %lx; bypass attack?!\n",
> +                 warn);
>  }

Yeah, no.

No way am I pulling a "security fix" that is that stupid, and that
badly documented. The comments are actively *not* matching the code,
and the actual code is so horribly written that it forces the compiler
to do extra stupid and unnecessary things (reloading that 'cr4_pin"
twice _after_ the thing you're trying to fix, for no actual good
reason - it only needs one reload).

The asm could trivially have just had a memory clobber in it, instead
of the wrongheaded - and incorrectly documented - volatile.

And btw, when you do the same thing twice, just do it the same way,
instead of having two different ways of doing it. There was a totally
different model to handling native_write_cr0() having similar issues.

Finally, I suspect this is all subtly buggy anyway, because your
'cr4_pin' thing is a global variable, but the cr4 bits are per-cpu,
and I don't see how this works with the different CPU's setting things
up one after each other, but the first one sets the pinned bits.

So it basically "pins" the bits on CPU's before they are ready, so the
secondary CPU's maghically get the bits set _independently_ of running
the actual setup code to set them. That may *work*, but it sure looks
iffy.

In particular, the whole problem with "the compiler might optimize it
away" comes from the fact that you do the "or" before even writing the
value, which shouldn't have been done anyway, but was forced by the
fact that you used a global mask for something that was really per-cpu
state to be set up (ie you *had* to set the bits wrong on the CPU
early, because you tested the wrong global bits afterwards),

If you had made the pinned bits value be percpu, all of the problems
would have gone away, because it wouldn't have had that bogus "val |=
cr4_pin" before.

So I think this code is
 (a) buggy
 (b) actively incorrectly documented
 (c) inconsistent
 (d) badly designed

and when you have code where the _only_ raison d'etre is security, you
had better have some seriously higher requirements than this.

IOW, the code probably should just do

    DECLARE_PER_CPU_READ_MOSTLY(unsigned long, cr4_pin);

    static inline void native_write_cr4(unsigned long val)
    {
        for (;;) {
                unsigned long pin;
                asm volatile("mov %0,%%cr4": : "r" (val):"memory");
                pin = __this_cpu_read(cr4_pin);
                if (likely((val & pin) == pin)
                        return;
                WARN_ONCE("Attempt to unpin cr4 bits: %lx; bypass
attack?!\n", pin & ~val);
                val |= pin;
        }
    }

which is a lot more straightforward, doesn't have that odd data
pollution between CPU's, and doesn't need to play any odd games.

And no, the above isn't tested, of course. But at least it makes sense
and doesn't have odd volatiles or strange "set global state and
percolate it into percpu stuff by magic". It *might* work.

Would you perhaps want to add a percpu section that is
read-after-boot? Maybe. But honestly, if the attacker can already
modify arbitrary percpu data, you may have bigger issues than cr4.

                  Linus
