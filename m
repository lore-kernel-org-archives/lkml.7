Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D946C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31FD2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlBxHyck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfFQLdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:33:32 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:43566 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFQLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:33:32 -0400
Received: by mail-io1-f54.google.com with SMTP id k20so20256527ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTaQurjF4DAEz2YA58sq1itwNB0DAFLlJ/DDxkRjQXs=;
        b=YlBxHyckiHCNw4pcv1L+3aipakmvWHdfu1oxzwefcQcVWnyNIn5NGlNqYIN/7QC0ey
         ioGaBXAv5AJACbpMWAaAsdLvLID96zO5uFRnyIa/tNH4W41NImVSVkxrQ0LVv/5lBHZz
         iEw6edvCS3C/y6wdXkjdsW3dJBbRBA4SU1vFKgiJzgFxZZEW6e1ELjhVW+MpsfItpE7h
         ZcLT9Ml5vwbXxOJ18xbKM2fo2/VHFZmbasZ2ki93QAjNEpwdH9E6TdwQqBrr5CEXoFeL
         rxMZ9NE4l66LJ1eS2LKTv6F9j1x+5ianNQxSP60RRxrfI+gX25JRg2p+ejEoCSKNrw9Y
         sWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTaQurjF4DAEz2YA58sq1itwNB0DAFLlJ/DDxkRjQXs=;
        b=pY8dOOseAWtCf8nAEldZoRCIGFlcVZ1j+kM9ejd4ME7irUI+z9IUoc/imHxSUqnK99
         MZHC7I6A0U915ohDzGa3X6PAsZM8gmav0htYF1+1iyN3BOpRT1KiybCa2EIQQvRuqSCI
         UKkzIB/Nxt6CZqxN+M0txlfsOBrD7Zq+NMNzN4rqWv0IF15RCmUB2mSH/AIPJ3RbN/7P
         XlzOLgXMK04bMHoRbuCMeiea7igaJlHWeZOf52uiQX8YZCYCxFBZSekEbW4NAidP2JC/
         Ml+jRk0KLGFJlFlV2w2PrW1JNCIv5ShA0HW0ibvtS042nuvSG11lJUfk8AMVdSo0879d
         mZsw==
X-Gm-Message-State: APjAAAWGPMihrrM1/5/TfNF0t8NBaK40gfU2NdcpOsatCvOxYbaySSRn
        1qN9ypqHrO+KujldJZgEGYhQQVhWDE4AXcTz6uMjEA==
X-Google-Smtp-Source: APXvYqzOD8mZdWMW5nl/G9kBu3RjbewHkgd/pSd8u227vGW4RBm64bgLB0Ejnt8SWGd0xJ5w7k3raGX9tSnxFEfpahY=
X-Received: by 2002:a02:3308:: with SMTP id c8mr15420974jae.103.1560771211244;
 Mon, 17 Jun 2019 04:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
 <20190612093151.GA11554@brain-police> <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
 <20190614095846.GC10506@fuggles.cambridge.arm.com> <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
 <20190614103850.GG10659@fuggles.cambridge.arm.com> <201906142026.1BC27EDB1E@keescook>
 <CAKv+Gu_XuhgUCYOeykrbaxJz-wL1HFrc_O+HeZHqaGkMHd2J9Q@mail.gmail.com>
 <201906150654.FF4400F7C8@keescook> <CAKv+Gu9-rZ16Nb9t3=knzW0BHu0eNxQoPwWS4c8UMMm=2iqiuw@mail.gmail.com>
 <201906161429.BCE1083@keescook>
In-Reply-To: <201906161429.BCE1083@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Jun 2019 13:33:19 +0200
Message-ID: <CAKv+Gu_8ibO4D01DZv6KjL2GnvKuVBVnt=doxkN0w=4utJ7NvQ@mail.gmail.com>
Subject: Re: [RFC] Disable lockref on arm64
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2019 at 23:31, Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Jun 15, 2019 at 04:18:21PM +0200, Ard Biesheuvel wrote:
> > Yes, I am using the same saturation point as x86. In this example, I
> > am not entirely sure I understand why it matters, though: the atomics
> > guarantee that the write by CPU2 fails if CPU1 changed the value in
> > the mean time, regardless of which value it wrote.
> >
> > I think the concern is more related to the likelihood of another CPU
> > doing something nasty between the moment that the refcount overflows
> > and the moment that the handler pins it at INT_MIN/2, e.g.,
> >
> > > CPU 1                   CPU 2
> > > inc()
> > >   load INT_MAX
> > >   about to overflow?
> > >   yes
> > >
> > >   set to 0
> > >                          <insert exploit here>
> > >   set to INT_MIN/2
>
> Ah, gotcha, but the "set to 0" is really "set to INT_MAX+1" (not zero)
> if you're using the same saturation.
>

Of course. So there is no issue here: whatever manipulations are
racing with the overflow handler can never result in the counter to
unsaturate.

And actually, moving the checks before the stores is not as trivial as
I thought, E.g., for the LSE refcount_add case, we have

        "       ldadd           %w[i], w30, %[cval]\n"                  \
        "       adds            %w[i], %w[i], w30\n"                    \
        REFCOUNT_PRE_CHECK_ ## pre (w30))                               \
        REFCOUNT_POST_CHECK_ ## post                                    \

and changing this into load/test/store defeats the purpose of using
the LSE atomics in the first place.

On my single core TX2, the comparative performance is as follows

Baseline: REFCOUNT_TIMING test using REFCOUNT_FULL (LSE cmpxchg)
      191057942484      cycles                    #    2.207 GHz
      148447589402      instructions              #    0.78  insn per
cycle

      86.568269904 seconds time elapsed

Upper bound: ATOMIC_TIMING
      116252672661      cycles                    #    2.207 GHz
       28089216452      instructions              #    0.24  insn per
cycle

      52.689793525 seconds time elapsed

REFCOUNT_TIMING test using LSE atomics
      127060259162      cycles                    #    2.207 GHz
                 0      instructions              #    0.00  insn per
cycle

      57.243690077 seconds time elapsed
