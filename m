Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBB8C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E00921670
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556814773;
	bh=McrNd6tEs6nZVZHZJyUQ93Q3IzXi+DcF9byW0dFV23Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pPjDOqLd23hF1XdEkQ0P8k6jyzLXKv6ZN8Ijj48L9egTlf/kvZhE18kYD0ByzD7xk
	 FvLdMbYuGCkwC0CnbLzpwIlhtmwiHmzkdEc+kleiW5WwC46o3Ht2q6VLjgMypxgqdL
	 Ma5HhgFsQB2p9hWktnw8UAkJ0ETJcSd+foIPLypE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEBQcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfEBQcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:32:51 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EE40217D7
        for <linux-kernel@vger.kernel.org>; Thu,  2 May 2019 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556814770;
        bh=McrNd6tEs6nZVZHZJyUQ93Q3IzXi+DcF9byW0dFV23Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TWKFY4hGY9y3ZYl2DSaHLJTt/+JyEyAs0Lero670lxqNEbI6IKErvi+lHR7HU9CNz
         MZ27AOQPjy40S1ebGWgqL2/vxA5Y1SBgSFE+FtP/ofczkC17LnbXC3oEpaO2fZh3hV
         fRABWvih5quF6vjzL0jRnEsXy2YEYlKuy4/KxYdI=
Received: by mail-wm1-f42.google.com with SMTP id y197so3470483wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:32:50 -0700 (PDT)
X-Gm-Message-State: APjAAAUO4JKynpwRS/vOIQhSyPBkJFSPlIgEFkb7igu1gu3h4YaJrIRl
        6Jlksui2qo9nJBEDPwy7k4q2q4FZj+Q+sQTU8oLIdg==
X-Google-Smtp-Source: APXvYqyyVb0mAXndRwfcJvxzuSkpl2wEeWNiGvHb9CLah9bx/jCba8GeoyQekgioeB/zcw/EWZLLsbHAXwmx/9ydGS4=
X-Received: by 2002:a1c:9689:: with SMTP id y131mr3220276wmd.74.1556814768564;
 Thu, 02 May 2019 09:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
 <20190426140102.GA4922@mit.edu> <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net> <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com> <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com> <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com>
In-Reply-To: <20190502150853.GA16779@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 2 May 2019 09:32:35 -0700
X-Gmail-Original-Message-ID: <CALCETrVBXZNAKGRXm0_txKGjqKnjx30Eb05hesye8M50D4A8Mw@mail.gmail.com>
Message-ID: <CALCETrVBXZNAKGRXm0_txKGjqKnjx30Eb05hesye8M50D4A8Mw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 8:09 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Andy Lutomirski <luto@kernel.org> wrote:
>
> > Or we decide that calling get_random_bytes() is okay with IRQs off and
> > this all gets a bit simpler.
>
> BTW., before we go down this path any further, is the plan to bind this
> feature to a real CPU-RNG capability, i.e. to the RDRAND instruction,
> which excludes a significant group of x86 of CPUs?

It's kind of the opposite.  Elena benchmarked it, and RDRAND's
performance was truly awful here.

>
> Because calling tens of millions of system calls per second will deplete
> any non-CPU-RNG sources of entropy and will also starve all other users
> of random numbers, which might have a more legitimate need for
> randomness, such as the networking stack ...

There's no such thing as "starving" other users in this context.  The
current core RNG code uses a cryptographic RNG that has no limits on
the number of bytes extracted.  If you want the entropy-accounted
stuff, you can use /dev/random, which is separate.

> 8 gigabits/sec sounds good throughput in principle, if there's no
> scalability pathologies with that.

The latency is horrible.

>
> It would also be nice to know whether RDRAND does buffering *internally*,

Not in a useful way :(

> Any non-CPU source of randomness for system calls and plans to add
> several extra function calls to every x86 system call is crazy talk I
> believe...

I think that, in practice, the only real downside to enabling this
thing will be the jitter in syscall times. Although we could decide
that the benefit is a bit dubious and the whole thing isn't worth it.
But it will definitely be optional.
