Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D03C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD271206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551746024;
	bh=1uqGiYWmQbzjgGG96niXhdENB8bnQDuYxmogfpL5eAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OvMtiJiFIOCndTLYh/p22wJsxqJFj4gHBViffakv/nVf8eauttDAnzWgLA0t58nbl
	 qa19Dq6RNK9RlLtQDVgPaCX1OtD32WTlM1i4TaWWZIqfuDB+n6rRAAzRZMfFSGJOhl
	 e9+lCj/wklFtadAKU53ZhodrSZRLIBn/Lwk0orCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCEAdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:33:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37955 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfCEAdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:33:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id 199so5994223ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSf70cL2RGgyOc3zQT9hIPFMQ6rAGhCNNZF5Ejd4GOA=;
        b=A8t1IllR2PbXTGURjyyxZj5rCqF2+9DuN5zp+9Y/HO2WcIoHb9KfNsKQu+kDY5QsTF
         vfLCBXBqE6Oc9FwAx/VrPBdS5CGDnktCs6Cb54qK4wp82LhJBdQaKrXw9F6qO7eh0Zdo
         N54jWx8xeWcgf/iFpUsIcHcjUbkdDNO2DEmdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSf70cL2RGgyOc3zQT9hIPFMQ6rAGhCNNZF5Ejd4GOA=;
        b=CHgJBd8WPKdH4OTfY8xTjoXIO00ZhCVn7PZZocDT+LowuFEOnsf9tkTNybrzsSB2TM
         HZ9skjLyMnNrcXatPQ9WTAvyNqR4OxNHLrdl0K1deqKkwHBq3S8z2NTtN0S90GeFrPxu
         0vAbiwL9dy/DL2Js2Npciu7gd+OZ9RqAybHfrJWy29PbdFYtcKLVSjnCRx3Qo+13/esc
         G6oRcDYoTOQHqiX99gqLGrLZyEVTmmeM9yis1pOdZcM0yV5ZMsVosLbRplcHc39ylc/n
         B5qv7BdZbiGow2xnHslQfTu8CMexUtfs9ZVc2bSXZNJnrYRA1CKcV6c3Eg9j3qJUBIhn
         c11w==
X-Gm-Message-State: APjAAAUIQlgiC/WjIaAotJXvGhDFao7WYJKJMWCei9AN83W3j1fh6NqM
        hm/8SFjhxaIRBUZyw7PsyBy3FWRLiic=
X-Google-Smtp-Source: APXvYqw0gE57pecWsysGDPUjQCKUlgElqyvuDO4ig/wFOaHqWroU7o1+YzBAlWH7xDV0UBJy7TJaYw==
X-Received: by 2002:a2e:964b:: with SMTP id z11mr10918113ljh.138.1551746020378;
        Mon, 04 Mar 2019 16:33:40 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t11sm1756331ljj.92.2019.03.04.16.33.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 16:33:39 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id z20so5981203ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:33:38 -0800 (PST)
X-Received: by 2002:a2e:8510:: with SMTP id j16mr11977194lji.2.1551746018426;
 Mon, 04 Mar 2019 16:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none> <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
 <1551583190.duzqnmfnvg.astroid@bobo.none> <CAHk-=whVN58nWh29jvXx+X-Yx9dCC6BeAZOtKak+d01y_UVg=A@mail.gmail.com>
 <1551606848.8cceyn7nhv.astroid@bobo.none> <CAHk-=wi9ZnP_17qwPB_b3hJ+C7DP3oxcRAPuDBCoEbe2QrbQew@mail.gmail.com>
 <1551743521.hogpbicfcz.astroid@bobo.none>
In-Reply-To: <1551743521.hogpbicfcz.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Mar 2019 16:33:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi4aAzhvPBon1wLS0zdzzg-_GQhkteBiQZE8KuotThToQ@mail.gmail.com>
Message-ID: <CAHk-=wi4aAzhvPBon1wLS0zdzzg-_GQhkteBiQZE8KuotThToQ@mail.gmail.com>
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

On Mon, Mar 4, 2019 at 4:21 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Well you don't have to talk about it but why do you want me to stop?
> I don't understand. It's an open topic still after this series. I
> can post a new thread about it if that would upset you less, I just
> thought it would kind of fit here because we're talking about mmiowb,
> I'm not trying to derail this series.

Because if anybody is doing lockless programming with IO, they deserve
whatever they get.

In other words, the whole "wmb()" issue is basically not an issue.

We already have rules like:

 - mmio is ordered wrt itself

 - mmio is ordered wrt previous memory ops (because of dma)

and while it turned out that at least alpha had broken those rules at
some point, and we had a discussion about it, that was just a bug.

So there's basically no real reason to ever use "wmb()" with any of
the normal mmio stuff.

Now, we do have __raw_writel() etc, which are explicitly not ordered,
but they also haven't been really standardized. And in fact, people
who use them often seem to want to use them together with various weak
memory remappings.

And yes, "wmb()" has been the traditional way to order those, to the
point where "wmb()" on x86 is actually a "sfence" because once you do
IO on those kinds of unordered mappings, the usual SMP rules go out
the window (a normal "smp_wmb()" is just a compiler barrier on x86).

But notice how this is *entirely* independent of the spinlock issue,
and has absolutely *nothing* to do with the whole mmiowb() thing that
was always about "normal IO vs normal RAM" (due to the ia64 breakage).

                 Linus
