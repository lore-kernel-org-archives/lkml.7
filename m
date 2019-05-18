Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D295C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 10:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DC92087B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 10:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIdkarl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfERKAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 06:00:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36603 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERKAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 06:00:49 -0400
Received: by mail-io1-f66.google.com with SMTP id e19so7442816iob.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRtjnzNcf3yhB2MxCBJqAnArNNc7Fr+SZA5dBOrEV90=;
        b=ZIdkarl5Xn8hlQtMF0N5Ak3sHU9OmA6a3MbeviitO/YD7kxl6R0PDXc2zuCNPeSBm2
         KzoxF+mJkTlpMJqXnaXkrkEanhwuClbA6nLEgFSfZ/HgmFuiWSlzu77QaxVBPVENosSo
         5jjIqGxv7SlDz5gJ9n60bexQKxCZA9vABP0f5NY8QixxJdMeJ2abD1kbD/aaRFlIUpIV
         h1DPQMeR4Oywgi1tRclsA/eLxYlIAgRg2X+mv/shkCPzBRDObVSyfEdOojCkdxNCjzHE
         wCH6WZINfdmiyv0ZW3Ko8UV+PXK0BBomoi61/58Joj46jsB8Nj8EnreSAV40IVfsciWW
         7KSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRtjnzNcf3yhB2MxCBJqAnArNNc7Fr+SZA5dBOrEV90=;
        b=OQYxPPuNZXy5rnT9Ux3hGq5SogLx8Wm8eN96iJJoopQlzzC5USVxuTK2Oode/RcDXL
         +5IF8XkV66wsamTTI/jfQm6iM7PKChiwgP8rkZVw9YbPkyA7qaSIU5IYq4yft7iM0mli
         zwUDsIJkigHHH4lf723Oayy7IffBz63XgUQdiaFn3fAM4A4eRgfmzBwS+lr7GcFOa4YZ
         k5Pc4a666zHSko0Vq9lf5nikUAtpTbkS0O9Sw6J+m7dxDyvgYIij3xqIUTO0A9weTyjU
         WIC6V9xj3zTUf8owrPucKX/qEggSzcxiHqY1VtQp89b1otZwXwr0lx2/ygJetjzEugCU
         x0KA==
X-Gm-Message-State: APjAAAXuX+CylkRWfnZASsoXxNu6ME0h99gf8QLWIDV7MvMoju2UJ1Cq
        FQ6mSf1eoFh/xpH7yFgsmId/HhO5EtlUg/1M6sC9AA==
X-Google-Smtp-Source: APXvYqx4bvatpfL3NIuIe/lAYXvJa6LopMNSIHJiCMAb1SC4s1Ha0Ad/9vYk/fc50prgdpkalcj4sHsk3kWAy1dnzH0=
X-Received: by 2002:a5d:968e:: with SMTP id m14mr2874037ion.49.1558173648766;
 Sat, 18 May 2019 03:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190429145159.GA29076@hc> <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190502082741.GE13955@hc> <CAHk-=wjmtMrxC1nSEHarBn8bW+hNXGv=2YeAWmTw1o54V8GKWA@mail.gmail.com>
 <20190502231858.GB13168@dc5-eodlnx05.marvell.com> <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
 <20190506061100.GA8465@dc5-eodlnx05.marvell.com> <20190506181039.GA2875@brain-police>
 <20190518042424.GA28517@dc5-eodlnx05.marvell.com>
In-Reply-To: <20190518042424.GA28517@dc5-eodlnx05.marvell.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 18 May 2019 12:00:34 +0200
Message-ID: <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
Subject: Re: [RFC] Disable lockref on arm64
To:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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

On Sat, 18 May 2019 at 06:25, Jayachandran Chandrasekharan Nair
<jnair@marvell.com> wrote:
>
> On Mon, May 06, 2019 at 07:10:40PM +0100, Will Deacon wrote:
> > On Mon, May 06, 2019 at 06:13:12AM +0000, Jayachandran Chandrasekharan Nair wrote:
> > > Perhaps someone from ARM can chime in here how the cas/yield combo
> > > is expected to work when there is contention. ThunderX2 does not
> > > do much with the yield, but I don't expect any ARM implementation
> > > to treat YIELD as a hint not to yield, but to get/keep exclusive
> > > access to the last failed CAS location.
> >
> > Just picking up on this as "someone from ARM".
> >
> > The yield instruction in our implementation of cpu_relax() is *only* there
> > as a scheduling hint to QEMU so that it can treat it as an internal
> > scheduling hint and run some other thread; see 1baa82f48030 ("arm64:
> > Implement cpu_relax as yield"). We can't use WFE or WFI blindly here, as it
> > could be a long time before we see a wake-up event such as an interrupt. Our
> > implementation of smp_cond_load_acquire() is much better for that kind of
> > thing, but doesn't help at all for a contended CAS loop where the variable
> > is actually changing constantly.
>
> Looking thru the perf output of this case (open/close of a file from
> multiple CPUs), I see that refcount is a significant factor in most
> kernel configurations - and that too uses cmpxchg (without yield).
> x86 has an optimized inline version of refcount that helps
> significantly. Do you think this is worth looking at for arm64?
>

I looked into this a while ago [0], but at the time, we decided to
stick with the generic implementation until we encountered a use case
that benefits from it. Worth a try, I suppose ...

[0] https://lore.kernel.org/linux-arm-kernel/20170903101622.12093-1-ard.biesheuvel@linaro.org/

> > Implementing yield in the CPU may generally be beneficial for SMT designs so
> > that the hardware resources aren't wasted when spinning round a busy loop.
>
> Yield is probably used in sub-optimal implementations of delay or wait.
> It is going to be different across multiple implementations and
> revisions (given the description in ARM spec). Having a more yielding(?)
> implementation would be equally problematic especially in the lockref
> case.
>
> > For this particular discussion (i.e. lockref), however, it seems as though
> > the cpu_relax() call is questionable to start with.
>
> In case of lockref, taking out the yield/pause and dropping to queued
> spinlock after some cycles appears to me to be a better approach.
> Relying on the quality of cpu_relax() on the specific processor to
> mitigate against contention is going to be tricky anyway.
>
> We will do some more work here, but would appreciate any pointers
> based on your experience here.
>
> Thanks,
> JC
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
