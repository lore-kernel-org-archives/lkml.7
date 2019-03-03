Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6310C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFE120823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551639329;
	bh=D8u48AtsJ13RNjB4A28n4dk49ZO3j/U9BYWx31/NA6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RfBgbNj3lvyau6MOy2n/SSTQZp6MAVnpGMXTcIebN/TdUmaFiKkYIzzi53anE/sBI
	 93bWYu7q3ZTSSGwj33TDE49P6Aur/wqTrUO2VbhzCtIhLoOyRKXYEGpa3jCSwkClv7
	 zUuNSqShTVYoyL5Do1I8StblYET5PgYqI+1szhig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfCCSz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:55:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36282 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfCCSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:55:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id v10so2389093lji.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 10:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1W50RI8B+s5i2+RavDhhH//tg93qW8OQd63CNLw8EM=;
        b=cQWRPekTlkJSOtERYbvlXTAU4KigOPbGXaWYGWX8a5zPp0MRwpRcP1zEieqIayOmLw
         OJRo4bOTGqG2mM2jkwppQZGzjRJv1rCPFdxSNEypb8yUVoHijfZVfg/kbDzg261opkjJ
         PpvjdYT3gbU9dyl+sGfYplZhao/AKMfdSu92s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1W50RI8B+s5i2+RavDhhH//tg93qW8OQd63CNLw8EM=;
        b=PNKfI8gGZzfkgJzBwWSSxnqCZucHL4mYIWCrt1ibLxsb+qSmuz1kSfZWT6PfxCDCzV
         LTOcrbloOkc9UOQ8uEZiclq1Tn7rZxDp77ZcHPfUV+jf1I8M2JyeMgPq78qeeHNtwZnH
         DavEK78XzcFfBRF0mDVOeP2zm1XRTf7DxAzndsa84uCj7jNn/EAaB+DJtJ7f2qIXxOtR
         6LKS/bwg8dsvnWTIZ9zw2dGUs94gYkeYW9c+BQjhsnMkCfehC2jphDpXctUPQ/VUqMCA
         AOFceqnA2eSzRFxYLKRzEJnOiJYZICFwjEFXIOxiXuXKVYXiezJVVCOAuuXMlk5MRpYy
         sy3A==
X-Gm-Message-State: APjAAAW+F0jmQRPShJzusiwS9Fs2z69cFnpMKBiD+tSV87uOdMg+CbFB
        cufwlKh3RdXG/OuWqoNbfqgjbAtyowk=
X-Google-Smtp-Source: APXvYqxT2OBhpwKu81OHOJbCfOrYJnX9Idoy3JL01hSMJM4RpNyQPCzfF9GNYRL546CNaknF/j8N5g==
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr4493457ljj.69.1551639324747;
        Sun, 03 Mar 2019 10:55:24 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m10sm1048688lfk.57.2019.03.03.10.55.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 10:55:24 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id v185so1902755lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 10:55:24 -0800 (PST)
X-Received: by 2002:a19:3f44:: with SMTP id m65mr8007506lfa.136.1551638946307;
 Sun, 03 Mar 2019 10:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none> <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
 <1551583190.duzqnmfnvg.astroid@bobo.none> <CAHk-=whVN58nWh29jvXx+X-Yx9dCC6BeAZOtKak+d01y_UVg=A@mail.gmail.com>
 <1551606848.8cceyn7nhv.astroid@bobo.none>
In-Reply-To: <1551606848.8cceyn7nhv.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Mar 2019 10:48:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9ZnP_17qwPB_b3hJ+C7DP3oxcRAPuDBCoEbe2QrbQew@mail.gmail.com>
Message-ID: <CAHk-=wi9ZnP_17qwPB_b3hJ+C7DP3oxcRAPuDBCoEbe2QrbQew@mail.gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 2:05 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Why even bother with it at all, "internal" or not?  Just get rid of
> mmiowb, the concept is obsolete.

It *is* gone, for chrissake!  Only the name remains as an internal
detail of "this is what we need to do".

> Pretend ia64 doesn't exist for a minute. Now the regular mb/wmb barriers
> orders IO across CPUs with respect to their cacheable accesses.

Stop with the total red herring already.

THIS HAS NOTHING TO DO WITH mb()/wmb().

As long as you keep bringing those up, you're only showing that you're
talking about the wrong thing.

> Regardless of whether that cacheable access is a spin lock, a bit lock,
> an atomic, a mutex... This is how it was before mmiowb came along.

No.

Beflore mmiowb() came along, there was one rule: do what x86 does.

And x86 orders mmio inside spinlocks.

Seriously.

Notice how there's not a single "barrier" mentioned here anywhere in
the above. No "mb()", no "wmb()", no nothing. Only "spinlocks order
IO".

That's the fundamental rule (that we broke for ia64), and all that
matters for this patch series.

Stop talking about wmb(). It's irrelevant. A spinlock does not
*contain* a wmb().

Nobody even _cares_ about wmb(). They are entirely irrelevant wrt IO,
because IO is ordered on any particular CPU anyway (which is what
wmb() enforces).

Only when you do special things like __raw_writel() etc does wmb()
matter, but at that point this whole series is entirely irrelevant,
and once again, that's still about just ordering on a single CPU.

So as long as you talk about wmb(), all you show is that you're
talking about something entirely different FROM THIS WHOLE SERIES.

And like it or not, ia64 still exists. We support it. It doesn't
_matter_ and we don't much care any more, but it still exists. Which
is why we have that concept of mmiowb().

On other platforms, mmiowb() might be a wmb(). Or it might not. It
might be some other barrier, or it might be a no-op entirely without a
barrier at all. It doesn't matter. But mmiowb() exists, and is now
happily entirely hidden inside the rule of "spinlocks order MMIO
across CPU's".

                 Linus
