Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FCDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A9F218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayZO67lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbfB1SKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:10:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32823 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfB1SKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:10:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id z14so17299773oid.0;
        Thu, 28 Feb 2019 10:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q9cre5/Aq7q411RwATkV0IuqFgfbnApY5djU5qJvN3A=;
        b=ayZO67ljJsjtlPuTZG+11HlQj1sn3rUYO/oOPb5KrlkuDfJIsR58qzUFj8TkVUzxbr
         Ee/fkN/7Lb8HCeFhguevuM0YmMLaJcJzRhs/gMkSzv+O6Gt06ob0Q6FEnqGHeeu/kE1l
         084OO13O/A0k+LFasowMpxf6W7sdMm/j0w3ET0i7nkyWgtBV1KgT0S0ENpl8kEfHdubw
         VG4IGrz0qjXJwld6YeNuuaRFHzH7KW2msDTG8NL8WQKflvJhEogTbn9StABVYfbnXPN3
         r9ZF9nX36NtZFJboFETarFfI2XTAZYJsZkcM0gpHDqrnYQ10m/6P+kTTO47+pSvg1nTF
         X+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q9cre5/Aq7q411RwATkV0IuqFgfbnApY5djU5qJvN3A=;
        b=t9oMdAUl/JMlOhQXdsCJ5IV+gd1OIgnc+6LMmhR0qhrEwZOTMUQ2w5mDBzAB2wFWuZ
         8EyflCl10Pnut6GBABCM7DUNPPw+Mj/BniAXj2PA0KXCmhEl6Y0s3iSMY0H80Wabkh+u
         XUnH4asl5v/EkH1h1sr/307+Il0u82wz3I93jbpoTm+jbkcveGuhzLn3r1pwDImHgixm
         Vx9QL+a7xClClcIdHq8W3dIhf09v5FnBudqR1gT3AhZNf5afXAHA6xx1Ffj1PZiqoDnk
         zJXEB0qHL1K08J6XfcL2Ukf7lLCruiHXDk7rI420rqMQW27qeoHqdzbLw00v1njakSBU
         scxw==
X-Gm-Message-State: APjAAAVcYatV8A9S16yMs4v3CJGJuIfA6+m3lsce830w/iwnCou11kVS
        RaQiaymt1jsR52SLP7l+Vpo4aSO4nCd1Q2fzBis=
X-Google-Smtp-Source: APXvYqzUCFZi0dibhMqNTbXhKL4QxJB2Ogk0D4V6uHWuVNt2j0i4HoLSKytnVJxa3NPVXREaO8EzK/al/KJlVHPn8SM=
X-Received: by 2002:aca:c5d5:: with SMTP id v204mr675765oif.104.1551377420275;
 Thu, 28 Feb 2019 10:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20190221221941.29358-1-daniel@iogearbox.net> <tip-ce02ef06fcf7a399a6276adb83f37373d10cbbe1@git.kernel.org>
 <33bf951448e7d916fd4a6ad41cd3d040e9d1f118.camel@infradead.org>
 <CAMe9rOrcOVRWuNWy3xp7NMD=2UbGH+C5zifDhd=-AxrrzEVrmw@mail.gmail.com>
 <79add9a9-543b-a791-ecbe-79edd49f1bb3@iogearbox.net> <CAMe9rOryEsLHossVa=QmaKW1wbW67AOnewkB_RN_WkveBEwnZg@mail.gmail.com>
 <4604e680-7962-f1ee-5b79-711247f4e7d5@iogearbox.net>
In-Reply-To: <4604e680-7962-f1ee-5b79-711247f4e7d5@iogearbox.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 28 Feb 2019 10:09:43 -0800
Message-ID: <CAMe9rOotJ+s0nR58Si3F_X8V6OcZKB8+q8+wORQ7C1YT1Nx+DQ@mail.gmail.com>
Subject: Re: [tip:x86/build] x86, retpolines: Raise limit for generating
 indirect calls from switch-case
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, bjorn.topel@intel.com,
        David Miller <davem@davemloft.net>, brouer@redhat.com,
        magnus.karlsson@intel.com, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ast@kernel.org,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 9:58 AM Daniel Borkmann <daniel@iogearbox.net> wrot=
e:
>
> On 02/28/2019 05:25 PM, H.J. Lu wrote:
> > On Thu, Feb 28, 2019 at 8:18 AM Daniel Borkmann <daniel@iogearbox.net> =
wrote:
> >> On 02/28/2019 01:53 PM, H.J. Lu wrote:
> >>> On Thu, Feb 28, 2019 at 3:27 AM David Woodhouse <dwmw2@infradead.org>=
 wrote:
> >>>> On Thu, 2019-02-28 at 03:12 -0800, tip-bot for Daniel Borkmann wrote=
:
> >>>>> Commit-ID:  ce02ef06fcf7a399a6276adb83f37373d10cbbe1
> >>>>> Gitweb:     https://git.kernel.org/tip/ce02ef06fcf7a399a6276adb83f3=
7373d10cbbe1
> >>>>> Author:     Daniel Borkmann <daniel@iogearbox.net>
> >>>>> AuthorDate: Thu, 21 Feb 2019 23:19:41 +0100
> >>>>> Committer:  Thomas Gleixner <tglx@linutronix.de>
> >>>>> CommitDate: Thu, 28 Feb 2019 12:10:31 +0100
> >>>>>
> >>>>> x86, retpolines: Raise limit for generating indirect calls from swi=
tch-case
> >>>>>
> >>>>> From networking side, there are numerous attempts to get rid of ind=
irect
> >>>>> calls in fast-path wherever feasible in order to avoid the cost of
> >>>>> retpolines, for example, just to name a few:
> >>>>>
> >>>>>   * 283c16a2dfd3 ("indirect call wrappers: helpers to speed-up indi=
rect calls of builtin")
> >>>>>   * aaa5d90b395a ("net: use indirect call wrappers at GRO network l=
ayer")
> >>>>>   * 028e0a476684 ("net: use indirect call wrappers at GRO transport=
 layer")
> >>>>>   * 356da6d0cde3 ("dma-mapping: bypass indirect calls for dma-direc=
t")
> >>>>>   * 09772d92cd5a ("bpf: avoid retpoline for lookup/update/delete ca=
lls on maps")
> >>>>>   * 10870dd89e95 ("netfilter: nf_tables: add direct calls for all b=
uiltin expressions")
> >>>>>   [...]
> >>>>>
> >>>>> Recent work on XDP from Bj=C3=B6rn and Magnus additionally found th=
at manually
> >>>>> transforming the XDP return code switch statement with more than 5 =
cases
> >>>>> into if-else combination would result in a considerable speedup in =
XDP
> >>>>> layer due to avoidance of indirect calls in CONFIG_RETPOLINE enable=
d
> >>>>> builds.
> >>>>
> >>>> +HJL
> >>>>
> >>>> This is a GCC bug, surely? It should know how expensive each
> >>>> instruction is, and choose which to use accordingly. That should be
> >>>> true even when the indirect branch "instruction" is a retpoline, and
> >>>> thus enormously expensive.
> >>>>
> >>>> I believe this is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D869=
52 so
> >>>> please at least reference that bug, and be prepared to turn this hac=
k
> >>>> off when GCC is fixed.
> >>>
> >>> We couldn't find a testcase to show jump table with indirect branch
> >>> is slower than direct branches.
> >>
> >> Ok, I've just checked https://github.com/marxin/microbenchmark/tree/re=
tpoline-table
> >> with the below on top.
> >>
> >>  Makefile | 6 +++---
> >>  switch.c | 2 +-
> >>  test.c   | 6 ++++--
> >>  3 files changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index bd83233..ea81520 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -1,16 +1,16 @@
> >>  CC=3Dgcc
> >>  CFLAGS=3D-g -I.
> >> -CFLAGS+=3D-O2 -mindirect-branch=3Dthunk
> >> +CFLAGS+=3D-O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-regi=
ster
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > Does slowdown show up only with -mindirect-branch=3Dthunk-inline?
>
> Not really, numbers are in similar range / outcome. Additionally, I also =
tried
> on a bit bigger machine (Xeon Gold 5120 this time). First is thunk-inline=
, second
> is thunk, and third is w/o raising limit for comparison; first test (from=
 last
> mail) on that machine:

Please re-open:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D86952

with new info.

--=20
H.J.
