Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C78C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C48C20656
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556808477;
	bh=lpFOwdvzwfKjTbaCyDMTCCv4ktauVXbFYxLn8j287xg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tclUZ+zHiw5ikzmr1AuJOs5vIEhk3ubpEMbCfxG8KsXV49UxgYOH6RbQ6SjR0/TSY
	 QbJHMMYhcumy4JZ6ObCkfpS8umdgtur+34ZTVwyvDgpbT4SD9HK9cQ1E1fqzb4ANRE
	 9nJD8bUVn+igo57ba6q6Ot1XqFp1FW0ZRZrcewZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfEBOr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBOrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:47:55 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8C752177B
        for <linux-kernel@vger.kernel.org>; Thu,  2 May 2019 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556808474;
        bh=lpFOwdvzwfKjTbaCyDMTCCv4ktauVXbFYxLn8j287xg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nEtIlhqhwn3OnVGI2el3ok32Oj/vgfMszhz1mhhyla8/nmfNtqGA7k8rec6c/5OF7
         FbH8Jkfrh/AYNPX7Lejr/qo41v68ZPgzv74msghQVuKIyrsvXH6gEYQqj7mZ+/do8p
         4o/kMYsUXg58lei/r0avkqJLUARiVDsjW1Uq3GPw=
Received: by mail-wm1-f52.google.com with SMTP id p16so3003197wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 07:47:53 -0700 (PDT)
X-Gm-Message-State: APjAAAVesamg7vm2zjvTzr2b5iKcm6JAs77m5f8lv1p8LaxbUAMQFvvg
        LfRS1Fce3ejGXmXCMxRobiBJKFjXsCZ7K/qsVFmeeA==
X-Google-Smtp-Source: APXvYqxOWKG8SU56mHwITDfpLAe3bFmIqEkBXT4GCiw/kiPrkESN6jsqgapH8wAU3Dw4yXX8xq62lKdxQvIfImiFpt0=
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr2830258wmh.32.1556808472396;
 Thu, 02 May 2019 07:47:52 -0700 (PDT)
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
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com> <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
In-Reply-To: <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 2 May 2019 07:47:39 -0700
X-Gmail-Original-Message-ID: <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
Message-ID: <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     David Laight <David.Laight@aculab.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
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

On Thu, May 2, 2019 at 2:23 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Reshetova, Elena
> > Sent: 02 May 2019 09:16
> ...
> > > I'm also guessing that get_cpu_var() disables pre-emption?
> >
> > Yes, in my understanding:
> >
> > #define get_cpu_var(var)                                              \
> > (*({                                                                  \
> >       preempt_disable();                                              \
> >       this_cpu_ptr(&var);                                             \
> > }))
> >
> > > This code could probably run 'fast and loose' and just ignore
> > > the fact that pre-emption would have odd effects.
> > > All it would do is perturb the randomness!
> >
> > Hm.. I see your point, but I am wondering what the odd effects might
> > be.. i.e. can we end up using the same random bits twice for two or more
> > different syscalls and attackers can try to trigger this situation?
>
> To trigger it you'd need to arrange for an interrupt in the right
> timing window to cause another process to run.
> There are almost certainly easier ways to break things.
>
> I think the main effects would be the increment writing to a different
> cpu local data (causing the same data to be used again and/or skipped)
> and the potential for updating the random buffer on the 'wrong cpu'.
>
> So something like:
>         /* We don't really care if the update is written to the 'wrong'
>          * cpu or if the vale comes from the wrong buffer. */
>         offset = *this_cpu_ptr(&cpu_syscall_rand_offset);
>         *this_cpu_ptr(&cpu_syscall_rand_offset) = offset + 1;
>
>         if ((offset &= 4095)) return this_cpu_ptr(&cpu_syscall_rand_buffer)[offset];
>
>         buffer = get_cpu_var((&cpu_syscall_rand_buffer);
>         get_random_bytes();
>         val = buffer[0];
>         /* maybe set cpu_syscall_rand_offset to 1 */
>         put_cpu_var();
>         return val;
>
> The whole thing might even work with a global buffer!
>

I don't see how this makes sense in the context of the actual entry
code.  The code looks like this right now:

        enter_from_user_mode();
<--- IRQs off here
        local_irq_enable();

Presumably this could become:

enter_from_user_mode();
if (the percpu buffer has enough bytes) {
  use them;
  local_irq_enable();
} else {
  local_irq_enable();
  get more bytes;
  if (get_cpu() == the old cpu) {
    refill the buffer;
  } else {
    feel rather silly;
  }
  put_cpu();
}

everything after the enter_from_user_mode() could get renamed
get_randstack_offset_and_irq_enable().

Or we decide that calling get_random_bytes() is okay with IRQs off and
this all gets a bit simpler.

--Andy
