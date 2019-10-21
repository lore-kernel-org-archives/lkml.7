Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D0ECA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8253D20640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eio8Y/HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfJUOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:21:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34087 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbfJUOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:21:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id f5so2543093lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q1HctBzQiK5hA29kzO53363Sc4r3NNEVIalh9LblfCE=;
        b=Eio8Y/HHXxr7OzfngiTkJVWtqGR0tKR2EA7B90WDXGsRzi3WeYivED8alDgOnfhSNs
         e8kHP6rBgebnNlH7VJmWB86OXnqzKEIGnjNb4CntO1jURYcY7ZggLw2zt5UNH9AOzTg9
         3/39/Hpq/D3lPoA5tlew8uRmwM1fMPZ5ekwrYwEr1u6DmNwMHPyEACLWiMau7Qdkfl1E
         zXSXjdWg7HChtiETgN2mCgDi9SXBSwR/W5lZsxv8viKkGkFgLYBkyqY562IePiAAh6wV
         JSAWtF/ut/wOBufqMNmOvhl7MDS8om/tMYjDP+XbUJaUCGn/IeZ9nWpdRcY9OlVzvINp
         pYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q1HctBzQiK5hA29kzO53363Sc4r3NNEVIalh9LblfCE=;
        b=VJMBJJ8pDu6SUub8tNy7mrS8Yw7bj5ySuh19EKp+tMQk59am0Dtnixo3n1Z6SkQRzV
         QOYjqs8bRpeH/qZ6JIL7+gAaD7QTkf4O1CNIBChJaowf3kJVujpwRBz36lZ62r3IGt+I
         E1aELAJUmVw9xAItLZFVSPXNr9+TrTWT3dHUelMwr1JoRnwSgrqIeswwBdXLiPbrYaoB
         x4sWJsO7dd53x2U8WpaZpMxCo/5KB7/f/5lM5nUX1aTfYGUR5KXFf8lD+MGeJZzyA+M6
         SPENw4FRybOCcJDwrgInJIa6SnhO0XhND2sEvvWdiDYKaZH01hiDmvjZERtOSUmIQiGB
         ql7A==
X-Gm-Message-State: APjAAAXrfUDnEKhlup77PpPTBo5pBrwyjOLUhDg2albhebDExTZtjJAI
        e5hkl+lAfGEPR14MdffsaznO5srtDTukbGOYuhc=
X-Google-Smtp-Source: APXvYqx0riDQIAXkzlyt/cf5UnwbIcAmWLg9VWm9pfXTg6rKAsFY0lStk5YTN37E3VUK7xjvIshbyhqFwSMpIC0fzlE=
X-Received: by 2002:a05:6512:61:: with SMTP id i1mr2780955lfo.97.1571667693356;
 Mon, 21 Oct 2019 07:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
 <20191014164110.GA58307@google.com> <CAMJBoFOqG8GYby-MLCgiYgsfntNP2hiX25WibxvUjpkLHvwsUQ@mail.gmail.com>
 <20191015200044.GA233697@google.com>
In-Reply-To: <20191015200044.GA233697@google.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Mon, 21 Oct 2019 16:21:21 +0200
Message-ID: <CAMJBoFM48tbay5B7VqvuNQrPkaXEvzG19n++Ke4p6cdSMCDQZw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow ZRAM to use any zpool-compatible backend
To:     Minchan Kim <minchan@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        "Theodore Ts'o" <tytso@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:00 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, Oct 15, 2019 at 09:39:35AM +0200, Vitaly Wool wrote:
> > Hi Minchan,
> >
> > On Mon, Oct 14, 2019 at 6:41 PM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > On Thu, Oct 10, 2019 at 11:04:14PM +0300, Vitaly Wool wrote:
> > > > The coming patchset is a new take on the old issue: ZRAM can curren=
tly be used only with zsmalloc even though this may not be the optimal comb=
ination for some configurations. The previous (unsuccessful) attempt dates =
back to 2015 [1] and is notable for the heated discussions it has caused.
> > > >
> > > > The patchset in [1] had basically the only goal of enabling ZRAM/zb=
ud combo which had a very narrow use case. Things have changed substantiall=
y since then, and now, with z3fold used widely as a zswap backend, I, as th=
e z3fold maintainer, am getting requests to re-interate on making it possib=
le to use ZRAM with any zpool-compatible backend, first of all z3fold.
> > > >
> > > > The preliminary results for this work have been delivered at Linux =
Plumbers this year [2]. The talk at LPC, though having attracted limited in=
terest, ended in a consensus to continue the work and pursue the goal of de=
coupling ZRAM from zsmalloc.
> > > >
> > > > The current patchset has been stress tested on arm64 and x86_64 dev=
ices, including the Dell laptop I'm writing this message on now, not to men=
tion several QEmu confugirations.
> > > >
> > > > [1] https://lkml.org/lkml/2015/9/14/356
> > > > [2] https://linuxplumbersconf.org/event/4/contributions/551/
> > >
> > > Please describe what's the usecase in real world, what's the benefit =
zsmalloc
> > > cannot fulfill by desgin and how it's significant.
> >
> > I'm not entirely sure how to interpret the phrase "the benefit
> > zsmalloc cannot fulfill by design" but let me explain.
> > First, there are multi multi core systems where z3fold can provide
> > better throughput.
>
> Please include number in the description with workload.

Sure. So on an HMP 8-core ARM64 system with ZRAM, we run the following comm=
and:
fio --bs=3D4k --randrepeat=3D1 --randseed=3D100 --refill_buffers \
    --buffer_compress_percentage=3D50 --scramble_buffers=3D1 \
    --direct=3D1 --loops=3D15 --numjobs=3D4 --filename=3D/dev/block/zram0 \
     --name=3Dseq-write --rw=3Dwrite --stonewall --name=3Dseq-read \
     --rw=3Dread --stonewall --name=3Dseq-readwrite --rw=3Drw --stonewall \
     --name=3Drand-readwrite --rw=3Drandrw --stonewall

The results are the following:

zsmalloc:
Run status group 0 (all jobs):
  WRITE: io=3D61440MB, aggrb=3D1680.4MB/s, minb=3D430167KB/s,
maxb=3D440590KB/s, mint=3D35699msec, maxt=3D36564msec

Run status group 1 (all jobs):
   READ: io=3D61440MB, aggrb=3D1620.4MB/s, minb=3D414817KB/s,
maxb=3D414850KB/s, mint=3D37914msec, maxt=3D37917msec

Run status group 2 (all jobs):
  READ: io=3D30615MB, aggrb=3D897979KB/s, minb=3D224494KB/s,
maxb=3D228161KB/s, mint=3D34351msec, maxt=3D34912msec
  WRITE: io=3D30825MB, aggrb=3D904110KB/s, minb=3D226027KB/s,
maxb=3D229718KB/s, mint=3D34351msec, maxt=3D34912msec

Run status group 3 (all jobs):
   READ: io=3D30615MB, aggrb=3D772002KB/s, minb=3D193000KB/s,
maxb=3D193010KB/s, mint=3D40607msec, maxt=3D40609msec
  WRITE: io=3D30825MB, aggrb=3D777273KB/s, minb=3D194318KB/s,
maxb=3D194327KB/s, mint=3D40607msec, maxt=3D40609msec

z3fold:
Run status group 0 (all jobs):
  WRITE: io=3D61440MB, aggrb=3D1224.8MB/s, minb=3D313525KB/s,
maxb=3D329941KB/s, mint=3D47671msec, maxt=3D50167msec

Run status group 1 (all jobs):
   READ: io=3D61440MB, aggrb=3D3119.3MB/s, minb=3D798529KB/s,
maxb=3D862883KB/s, mint=3D18228msec, maxt=3D19697msec

Run status group 2 (all jobs):
   READ: io=3D30615MB, aggrb=3D937283KB/s, minb=3D234320KB/s,
maxb=3D234334KB/s, mint=3D33446msec, maxt=3D33448msec
  WRITE: io=3D30825MB, aggrb=3D943682KB/s, minb=3D235920KB/s,
maxb=3D235934KB/s, mint=3D33446msec, maxt=3D33448msec

Run status group 3 (all jobs):
   READ: io=3D30615MB, aggrb=3D829591KB/s, minb=3D207397KB/s,
maxb=3D210285KB/s, mint=3D37271msec, maxt=3D37790msec
  WRITE: io=3D30825MB, aggrb=3D835255KB/s, minb=3D208813KB/s,
maxb=3D211721KB/s, mint=3D37271msec, maxt=3D37790msec

So, z3fold is faster everywhere (including being *two* times faster on
read) except for sequential write which is the least important use
case in real world.

> > Then, there are low end systems with hardware
> > compression/decompression support which don't need zsmalloc
> > sophistication and would rather use zbud with ZRAM because the
> > compression ratio is relatively low.
>
> I couldn't imagine how it's bad with zsmalloc. Could you be more
> specific?


> > Finally, there are MMU-less systems targeting IOT and still running
> > Linux and having a compressed RAM disk is something that would help
> > these systems operate in a better way (for the benefit of the overall
> > Linux ecosystem, if you care about that, of course; well, some people
> > do).
>
> Could you write down what's the problem to use zsmalloc for MMU-less
> system? Maybe, it would be important point rather other performance
> argument since other functions's overheads in the callpath are already
> rather big.

Well, I assume you had the reasons to make zsmalloc depend on MMU in Kconfi=
g:
...
config ZSMALLOC
    tristate "Memory allocator for compressed pages"
    depends on MMU
    help
...

But even disregarding that, let's compare ZRAM/zbud and ZRAM/zsmalloc
performance and memory these two consume on a relatively low end
2-core ARM.
Command:
fio --bs=3D4k --randrepeat=3D1 --randseed=3D100 --refill_buffers
--scramble_buffers=3D1 \
        --direct=3D1 --loops=3D15 --numjobs=3D2 --filename=3D/dev/block/zra=
m0 \
        --name=3Dseq-write --rw=3Dwrite --stonewall --name=3Dseq-read --rw=
=3Dread \
        --stonewall --name=3Dseq-readwrite --rw=3Drw --stonewall
--name=3Drand-readwrite \
        --rw=3Drandrw --stonewall

zsmalloc:
Run status group 0 (all jobs):
  WRITE: io=3D30720MB, aggrb=3D374763KB/s, minb=3D187381KB/s,
maxb=3D188389KB/s, mint=3D83490msec, maxt=3D83939msec

Run status group 1 (all jobs):
   READ: io=3D30720MB, aggrb=3D964000KB/s, minb=3D482000KB/s,
maxb=3D482015KB/s, mint=3D32631msec, maxt=3D32632msec

Run status group 2 (all jobs):
   READ: io=3D15308MB, aggrb=3D431263KB/s, minb=3D215631KB/s,
maxb=3D215898KB/s, mint=3D36302msec, maxt=3D36347msec
  WRITE: io=3D15412MB, aggrb=3D434207KB/s, minb=3D217103KB/s,
maxb=3D217373KB/s, mint=3D36302msec, maxt=3D36347msec

Run status group 3 (all jobs):
   READ: io=3D15308MB, aggrb=3D327328KB/s, minb=3D163664KB/s,
maxb=3D163667KB/s, mint=3D47887msec, maxt=3D47888msec
  WRITE: io=3D15412MB, aggrb=3D329563KB/s, minb=3D164781KB/s,
maxb=3D164785KB/s, mint=3D47887msec, maxt=3D47888msec

zbud:
Run status group 0 (all jobs):
  WRITE: io=3D30720MB, aggrb=3D735980KB/s, minb=3D367990KB/s,
maxb=3D373079KB/s, mint=3D42159msec, maxt=3D42742msec

Run status group 1 (all jobs):
   READ: io=3D30720MB, aggrb=3D927915KB/s, minb=3D463957KB/s,
maxb=3D463999KB/s, mint=3D33898msec, maxt=3D33901msec

Run status group 2 (all jobs):
   READ: io=3D15308MB, aggrb=3D403467KB/s, minb=3D201733KB/s,
maxb=3D202051KB/s, mint=3D38790msec, maxt=3D38851msec
  WRITE: io=3D15412MB, aggrb=3D406222KB/s, minb=3D203111KB/s,
maxb=3D203430KB/s, mint=3D38790msec, maxt=3D38851msec

Run status group 3 (all jobs):
   READ: io=3D15308MB, aggrb=3D334967KB/s, minb=3D167483KB/s,
maxb=3D167487KB/s, mint=3D46795msec, maxt=3D46796msec
  WRITE: io=3D15412MB, aggrb=3D337254KB/s, minb=3D168627KB/s,
maxb=3D168630KB/s, mint=3D46795msec, maxt=3D46796msec

Pretty equal except for sequential write which is twice as good with zbud.

Now to the fun part.
zsmalloc:
  0 .text         00002908  0000000000000000  0000000000000000  00000040  2=
**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
zbud:
  0 .text         0000072c  0000000000000000  0000000000000000  00000040  2=
**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE

And this does not cover dynamic memory allocation overhead which is
higher for zsmalloc. So once again, given that the compression ratio
is low (e. g. a simple HW accelerator is used), what would most
unbiased people prefer to use in this case?

> > > I really don't want to make fragmentaion of allocator so we should re=
ally see
> > > how zsmalloc cannot achieve things if you are claiming.
> >
> > I have to say that this point is completely bogus. We do not create
> > fragmentation by using a better defined and standardized API. In fact,
> > we aim to increase the number of use cases and test coverage for ZRAM.
> > With that said, I have hard time seeing how zsmalloc can operate on a
> > MMU-less system.
> >
> > > Please tell us how to test it so that we could investigate what's the=
 root
> > > cause.
> >
> > I gather you haven't read neither the LPC documents nor my
> > conversation with Sergey re: these changes, because if you did you
> > wouldn't have had the type of questions you're asking. Please also see
> > above.
>
> Please include your claims in the description rather than attaching
> file. That's the usualy way how we work because it could make easier to
> discuss by inline.

Did I attach something? I don't quite recall that. I posted links to
previous discussions and conference materials, each for a reason.

> >
> > I feel a bit awkward explaining basic things to you but there may not
> > be other "root cause" than applicability issue. zsmalloc is a great
> > allocator but it's not universal and has its limitations. The
> > (potential) scope for ZRAM is wider than zsmalloc can provide. We are
> > *helping* _you_ to extend this scope "in real world" (c) and you come
> > up with bogus objections. Why?
>
> Please add more detail to convince so we need to think over why zsmalloc
> cannot be improved for the usecase.

This approach is wrong. zsmalloc is good enough and covers a lot of
use cases but there are still some where it doesn't work that well by
design. E. g. on an XIP system we do care about the code size since
it's stored uncompressed but still want to use ZRAM. Why would we want
to waste almost 10K just on zsmalloc code if the counterpart (zbud in
that case) works better?

Best regards,
   Vitaly
