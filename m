Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21116C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D890720C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557162846;
	bh=hKEivjPezdoQpNsw9V8wzbLUYXgRFE3IPMuKbpOvsIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XAMmd8CHSeXKFB0hCYfm0LVu4D/0a2bmjQem1ca/mZD+yAZx34ljXef7VnajC4Zf8
	 goEuB6HoneaFCiwzFzF0Bmsmk/AqgpufFVVmM3QGXPDj23KAtRuKI3iIBiSqHhd2u1
	 NM0lLIOFjRDFY2lZBxjVF6d+71KRCBHpLm5P4y54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfEFROE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:14:04 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44865 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfEFROE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:14:04 -0400
Received: by mail-lf1-f48.google.com with SMTP id n134so7889505lfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWErFa2Tb4Iv9aICLnei73w528HT1mPAhqrqIzBV8n8=;
        b=A/1GS57fjXXZgfDIFSzv5EkjXjqduB2iecI//MYxRTsOyDEtXxuDBaXBNmKk3QNbZo
         ic+a6bYXBTLe0BX8PfBz1JeKdB8jrQ/3YOzCOEe0IgU7hvKDFxotfpKn/N3W1iJDimFx
         GYlEKt8UbE9tbFG9WjvQkiWtxAMk3TOqfUJS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWErFa2Tb4Iv9aICLnei73w528HT1mPAhqrqIzBV8n8=;
        b=m4w4NefOJiyV9MIRLs+/cjfWgbZ/o8jCswCbt4mOeI7lRC42SK6xlOlpotzcr/UVab
         VQJAEcH530OapNn3DaVihDVdNc99nZL73pXV3V1pes66N/x6aMPEDauEgrnKmbh5fAs4
         LKqZjWXwq2u1oRWNAtXe0czYrJTA8fVFU9EEYofQarxvXPWeiMEeb190hds4Cp4wBnZw
         AHkhnw2dJml/JIWj/Y5yjRytQpDuRiXQ4hEdUSxagLjB/COHe+FmyJmyxn4Etfe6YFww
         nY1AoL79Bgx+TF3IIuhBsRei6AKjQTmebebPT3IrOhQlOaJOTmcHMuvOr+3b0upp1xn6
         WDfQ==
X-Gm-Message-State: APjAAAWuhimS07PeSr0Q+4ffcS6cauj+9HnsyvBpnEou0nXSTt7uF8c9
        wT6dYaABmoT/NEFesnbSKgftKGPqrKk=
X-Google-Smtp-Source: APXvYqzpHJia0/aqNHWR13ZSL7xU5ItUlavJdrK8G2XlUJRGOsIQ0rNOBz4ro3mx/PIaVh7pv96eCw==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr12425383lfk.129.1557162840951;
        Mon, 06 May 2019 10:14:00 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id s12sm2430160ljd.66.2019.05.06.10.13.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 10:13:59 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id h126so9710952lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 10:13:59 -0700 (PDT)
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr13444160lfl.67.1557162838971;
 Mon, 06 May 2019 10:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190429145159.GA29076@hc> <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190502082741.GE13955@hc> <CAHk-=wjmtMrxC1nSEHarBn8bW+hNXGv=2YeAWmTw1o54V8GKWA@mail.gmail.com>
 <20190502231858.GB13168@dc5-eodlnx05.marvell.com> <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
 <20190506061100.GA8465@dc5-eodlnx05.marvell.com>
In-Reply-To: <20190506061100.GA8465@dc5-eodlnx05.marvell.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 10:13:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGAef6+mZi-_+rfTDxXrLDw-jrOiy3MNEpLAkC5scGRg@mail.gmail.com>
Message-ID: <CAHk-=whGAef6+mZi-_+rfTDxXrLDw-jrOiy3MNEpLAkC5scGRg@mail.gmail.com>
Subject: Re: [EXT] Re: [RFC] Disable lockref on arm64
To:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Cc:     Jan Glauber <jglauber@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 5, 2019 at 11:13 PM Jayachandran Chandrasekharan Nair
<jnair@marvell.com> wrote:
>
> > It's not normal, and it's not inevitable.
>
> If you look at the code, the CAS failure is followed by a yield
> before retrying the CAS. Yield on arm64 is expected to be a hint
> to release resources so that other threads/cores can make progress.
> Under heavy contention, I expect the current code to behave the way
> I noted in my last mail, with the issue with fairness as well.

Yes, this is a good point.

It's entirely possibly that _particularly_ for CAS loops - where we
get an updated value that caused the CAS to fail - we should not yield
in between every CAS. Exactly so that we don't force the CPU to flush
the cacheline that it just got and make the CAS loop do lots of
unnecessary work and just keep looping.

That said, I think right now all ARM implementations actually treat
the yield instruction as a pure nop, so I assume this isn't actually
the root of the ThunderX2 problems.

But we could do something like "unroll the cmpxchg loop twice, only
yield every other iteration" exactly for the case wher cpu_relax()
might encourage the CPU to actually release the cacheline.

If you find that something like that would help ThunderX2, we can most
certainly try that kind of thing. It makes sense, and unrolling the
cmpxchg loop once might even help with branch prediction (ie the
common case might be that the *first* cmpxchg succeeds, and that's
what the branch predictors get primed for, but then if the first one
actually fails, we fall through to the contention case, and now maybe
the branch predictor ends up being primed for *that* case for the
second one).

Yes, the above is wild handwaving - but it's the kind of thing we
could easily do if the hardware people have a good argument for them.

I'm not asking for _perfect_ hardware. I'm just asking for hardware to
not be actively antagonistic to something fundamental like a cmpxchg
loop.

> Your larger point seems to be that the hardware has smarter to
> scale standard locking implementations when adding cores, and
> be graceful even in extremely high contention cases. Yes, this
> is something we should be looking at for ThunderX3.

Yes. Also, my point really is that no core should ever be in the
situation that it fetches a cache-line, only to then release it
immediately again without making any progress. You do want a *certain*
amount of stickiness to the cachelines.

Of course, you very much do not want to overdo it - I'm talking about
keeping the cacheline around for tens of cycles, not for hundreds of
cycles. Enough that if you have small code snippets that are in and
out quickly, you don't see bouncing at that level.

Because you *don't* want the stickiness to be such that once one CPU
has the cacheline, it will stay with that CPU (or that socket) as long
as the CPU hammers it all the time.

So for example, in the case of a cmpxchg loop, maybe you'll get a
couple of branch mispredicts the first few times round the loop (first
because the original value read was a plain read and the cacheline was
shared rather than exclusive, but then after that because the branch
predictor saw previous cases where there was no contention, and the
loop exited immediately).

So maybe the first couple of iterations the core might be "slow
enough" to not get the cmpxchg loop working well. But not a lot more
than that (again, unless something special happens, like an interrupt
storm that keeps interrupting the loop).

End result: I do think the cache coherency needs to be a *bit* smarter
than just a "oh, another core wants this line, I will now immediately
try to satisfy it". And yes, those kinds of things get more important
the more cores you have. You don't need a whole lot of smarts if you
have just a couple of cores, because you'll be making progress
regardless.

And note that I really think this kind of support absolutely falls on
hardware. Software simply _cannot_ make some good tuning decision
using backoff or whatever. Yes, yes, I know people have done things
like that historically (Sparc and SunOS were famous for it), but part
of doing them historically was that

 (a) they didn't know better

 (b) the software was often tuned to particular hardware and loads (or
at least a very small set of hardware)

 (c) there wasn't necessarily better hardware options available

but none of the above is true today.

Things like backoff loops in software are not only hw specific, they
tend to have seriously bad fairness behavior (and they depend on
everybody honoring the backoff, which can be a security issue), so
then you have to add even more complexity to deal with the fairness
issues, and your cmpxchg loop becomes something truly disgusting.

Which is why I say: "do it right in hardware".

                   Linus
