Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A1EC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33819206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575758901;
	bh=KhY9NpaNgwJjR6iwqCVzrDCeGP7hTLWk/ZTtwQz2RLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BtbnfgbfTc2Cev58Kce+itvhURNC8yhIlHdz56wWhUn13qv1SU8pAeg4QTVmsJqN/
	 LGlRznw91QCl5aMBDzqZ9MJdFTO28+14nA0nFtjDYPHN306S8Cq8oSlYLhd6ippf71
	 B4Ji7L549HT5Po1fuG23iKFajj60AB0GS1FC2IwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLGWsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:48:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45269 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfLGWsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:48:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so11443704ljc.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 14:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+bzarr7WGG9UNw/1xFlnTHXwkh2li5KYb8dKx07T4w=;
        b=D6hYWc8qs0agBGRnbrYf1SDdMDgkvhKHwhdLZrSu85/3YN1ltTHpwMKTMhYoV/i120
         1onptQLl9ldf+3ruI4Bz9iKb/qrxCtvUs5vwPUmv15J/Ti+o0GKsC5Bp9Pf8ipD+F8TH
         n4jC3g0rUdz+iIu4PIDtkZQjZvGINraOeGlyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+bzarr7WGG9UNw/1xFlnTHXwkh2li5KYb8dKx07T4w=;
        b=NwG11uOvgv3M58EYHgPLJ53hikEYBz9ibq3k0PBpuP16q62w/HKFPprSAGv7isdTty
         tzx2x81aPEZNJFScCjXge4QP5Jjnwr+OD+G/nzxMeDmkfMsLOXEm0XkTedQmsCcGiQwu
         s61dsIiKQHMFgzjVxIcLbD6zX6EQ89TiiPJpK0KU5ML56aB0fHgcq4F/c8Wts5Rm2Y5r
         zvVjDPQDmZs/9Uxg4DU6m/82wXGKvcW8YvAaf2VJaPfNog4ZNtaG+zIHxKOcd+vuP5vj
         T/ALXxdIOse5w9OAz0q8KCpAQjb6j+8V4R0pqta7G4pycvAkFsbTsP+OP77rdWGgY9F3
         r7XQ==
X-Gm-Message-State: APjAAAX7SMYm4pgjrEhQFXaYCRzOS7WpYalhw9QLFYMxI90KwycRaLB7
        SdA09KRAR+DYu6nvKERU9DVwe7m7sOw=
X-Google-Smtp-Source: APXvYqwEU+YAHfEgtkPAVBfvmwwipTORywO0+xk8MNFnEh2hhRBrKeqncfAbwMb5xgurWX2kSl3pbQ==
X-Received: by 2002:a2e:809a:: with SMTP id i26mr12265696ljg.108.1575758890965;
        Sat, 07 Dec 2019 14:48:10 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v2sm8712802ljv.70.2019.12.07.14.48.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 14:48:09 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id a13so11465392ljm.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 14:48:09 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr10211828ljg.82.1575758888845;
 Sat, 07 Dec 2019 14:48:08 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com> <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Dec 2019 14:47:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
Message-ID: <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 7:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The "make goes slow" problem bisects down to b667b8673443 ("pipe:
> Advance tail pointer inside of wait spinlock in pipe_read()").

I'm not entirely sure that ends up being 100% true. It did bisect to
that, but the behavior wasn't entirely stable. There definitely is
some nasty timing trigger.

But I did finally figure out what seems to have been going on with at
least the biggest part of the build performance regression. It's seems
to be a nasty interaction with the scheduler and the GNU make
jobserver, and in particular the pipe wakeups really _really_ do seem
to want to be synchronous both for the readers and the writers.

When a writer wakes up a reader, we want the reader to react quickly
and vice versa. The most obvious case was for the GNU make jobserver,
where sub-makes would do a single-byte write to the jobserver pipe,
and we want to wake up the reader *immediatly*, because the reader is
actually a lot more important than the writer. The reader is what gets
the next job going, the writer just got done with the last one.

And when a reader empties a full pipe, it's because the writer is
generating data, and you want to just get the writer going again asap.

Anyway, I've spent way too much time looking at this and wondering
about odd performance patterns. It seems to be mostly back up to
normal.

I say "mostly", because I still see times of "not as many concurrent
compiles going as I'd expect". It might be a kbuild problem, it might
be an issue with GNU make (I've seen problems with the make jobserver
wanting many more tokens than expected before and the kernel makefiles
- it migth be about deep subdirectories etc), and it might be some
remaining pipe issue. But my allmodconfig builds aren't _enormously_
slower than they used to be.

But there's definitely some unhappy interaction with the jobserver. I
have 16 threads (8 cores with HT), and I generally use "make -j32" to
keep them busy because the jobserver isn't great. The pipe rework made
even that 2x slop not work all that well. Something held on to tokens
too long, and there was definitely some interaction with the pipe
wakeup code. Using "-j64" hid the problem, but it was a problem.

It might be the new scheduler balancing changes that are interacting
with the pipe thing. I'm adding PeterZ, Ingo and Vincent to the cc,
because I hadn't realized just how important the sync wakeup seems to
be for pipe performance even at a big level.

I've pushed out my pipe changes. I really didn't want to do that kind
of stuff at the end of the merge window, but I spent a lot more time
than I wanted looking at this code, because I was getting to the point
where the alternative was to just revert it all.

DavidH, give these a look:

  85190d15f4ea pipe: don't use 'pipe_wait() for basic pipe IO
  a28c8b9db8a1 pipe: remove 'waiting_writers' merging logic
  f467a6a66419 pipe: fix and clarify pipe read wakeup logic
  1b6b26ae7053 pipe: fix and clarify pipe write wakeup logic
  ad910e36da4c pipe: fix poll/select race introduced by the pipe rework

the top two of which are purely "I'm fed up looking at this code, this
needs to go" kind of changes.

In particular, that last change is because I think the GNU jobserver
problem is partly a thundering herd issue: when a job token becomes
free (ie somebody does a one-byte write to an empty jobserver pipe),
it wakes up *everybody* who is waiting for a token. One of them will
get it, and the others will go to sleep again. And then it repeats all
over. I didn't fix it, but it _could_ be fixed with exclusive waits
for readers/writers, but that means more smarts than pipe_wait() can
do. And because the jobserver isn't great at keeping everybody happy,
I'm using a much bigger "make -jX" value than the number of CPU's I
have, which makes the herd bigger. And I suspect none of this helps
the scheduler pick the _right_ process to run, which just makes
scheduling an even bigger problem.

            Linus
