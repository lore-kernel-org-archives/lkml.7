Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B287C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D0A218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML89Mwpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfB1Q0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:26:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35886 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbfB1Q0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:26:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id v62so18188979otb.3;
        Thu, 28 Feb 2019 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S/n52nyQI1ob1aAhh/6w3laZ7MeR2orZeeXWSPn0utw=;
        b=ML89MwpkAbY3RZfbdTZCH5kct9a0HNWqTLb+LDdelHe1XqIzhApDePOMGu1kUYoban
         9AYxd8aYQ1yCs7sfyitOoPGz1IxcW1Td1ZzD+WtiBfaUDgIqqYtUbmaozMmakUnSb7Ts
         RiQjcO4VomLHGtRCX4eZT86SC9GUrAKQHp2WSTUrkcIWrs65Im7Vr0NrGqLGHtkRvWDu
         2wp5haCV5TmKATnXPX2c4YbXi/l4y2dusoCJPdMmicOyjyYkFtuM2O/wzYF5H8k9qgXH
         f+jjbRs5QXHmu3Bq8b07HWQAmqs/xjtUya/+HP9NnooJthUaq+50Sv7S/S0eYQdWS7FX
         gmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S/n52nyQI1ob1aAhh/6w3laZ7MeR2orZeeXWSPn0utw=;
        b=eV2DEHWNHi2T//KsepOIAUcI1pieO5vhbOQDc821czSz2GH4phh7bfGH9fn/Q1eLEZ
         cBBMybuaQ4RiZ4H3JEQfUwrHxxspc8htQAx2cbd4Ey1o9NpJxvxazj7gz6DSMt8FuZVx
         2FbIoU7T8/rqha79nzvq1j+MmxNHRwfbJ3Vw4ZbwhL1Zjvh4K6i1VZE/6Dk1EKyDND5t
         HWXMbLUpCc+skgvKu7xB0b1EPdcCwjO2UUbLY913YDEbaZsWKIMTDvph+W3S2t2/CHa6
         eKjDyix0pz8VYR6btsKVyDJBknM8isbWgNQHq4DVbLK7Y+l6U/JBJwBXwURPzZYKjwYE
         qwSQ==
X-Gm-Message-State: APjAAAUImv+/RGX4kaHqnqeAu0rf2phxhIOVC6sQdbCdkBJfhLpv3Zoe
        GrvPI1oW4WY4GfKTUwUKSWUbB2PIIW/gXNyQhxU=
X-Google-Smtp-Source: APXvYqyD/0mAVgHFOuMOtjcpWp9NgyFbfhLho2PeDCSFhud0pdnOb+FIf3hwkqwYrJk3aAzh9lZfEquTZQCvfSvqYSQ=
X-Received: by 2002:a9d:138:: with SMTP id 53mr252090otu.169.1551371175756;
 Thu, 28 Feb 2019 08:26:15 -0800 (PST)
MIME-Version: 1.0
References: <20190221221941.29358-1-daniel@iogearbox.net> <tip-ce02ef06fcf7a399a6276adb83f37373d10cbbe1@git.kernel.org>
 <33bf951448e7d916fd4a6ad41cd3d040e9d1f118.camel@infradead.org>
 <CAMe9rOrcOVRWuNWy3xp7NMD=2UbGH+C5zifDhd=-AxrrzEVrmw@mail.gmail.com> <79add9a9-543b-a791-ecbe-79edd49f1bb3@iogearbox.net>
In-Reply-To: <79add9a9-543b-a791-ecbe-79edd49f1bb3@iogearbox.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 28 Feb 2019 08:25:39 -0800
Message-ID: <CAMe9rOryEsLHossVa=QmaKW1wbW67AOnewkB_RN_WkveBEwnZg@mail.gmail.com>
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

On Thu, Feb 28, 2019 at 8:18 AM Daniel Borkmann <daniel@iogearbox.net> wrot=
e:
>
> On 02/28/2019 01:53 PM, H.J. Lu wrote:
> > On Thu, Feb 28, 2019 at 3:27 AM David Woodhouse <dwmw2@infradead.org> w=
rote:
> >> On Thu, 2019-02-28 at 03:12 -0800, tip-bot for Daniel Borkmann wrote:
> >>> Commit-ID:  ce02ef06fcf7a399a6276adb83f37373d10cbbe1
> >>> Gitweb:     https://git.kernel.org/tip/ce02ef06fcf7a399a6276adb83f373=
73d10cbbe1
> >>> Author:     Daniel Borkmann <daniel@iogearbox.net>
> >>> AuthorDate: Thu, 21 Feb 2019 23:19:41 +0100
> >>> Committer:  Thomas Gleixner <tglx@linutronix.de>
> >>> CommitDate: Thu, 28 Feb 2019 12:10:31 +0100
> >>>
> >>> x86, retpolines: Raise limit for generating indirect calls from switc=
h-case
> >>>
> >>> From networking side, there are numerous attempts to get rid of indir=
ect
> >>> calls in fast-path wherever feasible in order to avoid the cost of
> >>> retpolines, for example, just to name a few:
> >>>
> >>>   * 283c16a2dfd3 ("indirect call wrappers: helpers to speed-up indire=
ct calls of builtin")
> >>>   * aaa5d90b395a ("net: use indirect call wrappers at GRO network lay=
er")
> >>>   * 028e0a476684 ("net: use indirect call wrappers at GRO transport l=
ayer")
> >>>   * 356da6d0cde3 ("dma-mapping: bypass indirect calls for dma-direct"=
)
> >>>   * 09772d92cd5a ("bpf: avoid retpoline for lookup/update/delete call=
s on maps")
> >>>   * 10870dd89e95 ("netfilter: nf_tables: add direct calls for all bui=
ltin expressions")
> >>>   [...]
> >>>
> >>> Recent work on XDP from Bj=C3=B6rn and Magnus additionally found that=
 manually
> >>> transforming the XDP return code switch statement with more than 5 ca=
ses
> >>> into if-else combination would result in a considerable speedup in XD=
P
> >>> layer due to avoidance of indirect calls in CONFIG_RETPOLINE enabled
> >>> builds.
> >>
> >> +HJL
> >>
> >> This is a GCC bug, surely? It should know how expensive each
> >> instruction is, and choose which to use accordingly. That should be
> >> true even when the indirect branch "instruction" is a retpoline, and
> >> thus enormously expensive.
> >>
> >> I believe this is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D86952=
 so
> >> please at least reference that bug, and be prepared to turn this hack
> >> off when GCC is fixed.
> >
> > We couldn't find a testcase to show jump table with indirect branch
> > is slower than direct branches.
>
> Ok, I've just checked https://github.com/marxin/microbenchmark/tree/retpo=
line-table
> with the below on top.
>
>  Makefile | 6 +++---
>  switch.c | 2 +-
>  test.c   | 6 ++++--
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index bd83233..ea81520 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,16 +1,16 @@
>  CC=3Dgcc
>  CFLAGS=3D-g -I.
> -CFLAGS+=3D-O2 -mindirect-branch=3Dthunk
> +CFLAGS+=3D-O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Does slowdown show up only with -mindirect-branch=3Dthunk-inline?

>  ASFLAGS=3D-g
>
>  EXE=3Dtest
>
>  OBJS=3Dtest.o switch-no-table.o switch.o
>
> -switch-no-table.o switch-no-table.s: CFLAGS +=3D -fno-jump-tables
> +switch-no-table.o switch-no-table.s: CFLAGS +=3D --param=3Dcase-values-t=
hreshold=3D20
>
>  all: $(EXE)
> -       ./$(EXE)
> +       taskset 1 ./$(EXE)
>
>  $(EXE): $(OBJS)
>         $(CC) -o $@ $^
> diff --git a/switch.c b/switch.c
> index fe0a8b0..233ec14 100644
> --- a/switch.c
> +++ b/switch.c
> @@ -3,7 +3,7 @@ int global;
>  int
>  foo (int x)
>  {
> -  switch (x) {
> +  switch (x & 0xf) {
>      case 0:
>        return 11;
>      case 1:
> diff --git a/test.c b/test.c
> index 3d1e0da..7fc22a4 100644
> --- a/test.c
> +++ b/test.c
> @@ -15,21 +15,23 @@ main ()
>    unsigned long long start, end;
>    unsigned long long diff1, diff2;
>
> +  global =3D 0;
>    start =3D __rdtscp (&i);
>    for (i =3D 0; i < LOOP; i++)
>      foo_no_table (i);
>    end =3D __rdtscp (&i);
>    diff1 =3D end - start;
>
> -  printf ("no jump table: %lld\n", diff1);
> +  printf ("global:%d no jump table: %lld\n", global, diff1);
>
> +  global =3D 0;
>    start =3D __rdtscp (&i);
>    for (i =3D 0; i < LOOP; i++)
>      foo (i);
>    end =3D __rdtscp (&i);
>    diff2 =3D end - start;
>
> -  printf ("jump table   : %lld (%.2f%%)\n", diff2, 100.0f * diff2 / diff=
1);
> +  printf ("global:%d jump table   : %lld (%.2f%%)\n", global, diff2, 100=
.0f * diff2 / diff1);
>
>    return 0;
>  }
> --
> 2.17.1
>
> ** This basically iterates through the cases:
>
> Below I'm getting ~twice the time needed for jump table vs no jump table
> for the flags kernel is using:
>
> # make
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r   -c -o test.o test.c
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r --param=3Dcase-values-threshold=3D20   -c -o switch-no-table.o switch-no-=
table.c
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r   -c -o switch.o switch.c
> gcc -o test test.o switch-no-table.o switch.o
> taskset 1 ./test
> global:50000000 no jump table: 6329361694
> global:50000000 jump table   : 13745181180 (217.17%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 6328846466
> global:50000000 jump table   : 13746479870 (217.20%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 6326922428
> global:50000000 jump table   : 13745139496 (217.25%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 6327943506
> global:50000000 jump table   : 13744388354 (217.20%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 6332503572
> global:50000000 jump table   : 13729817800 (216.82%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 6328378006
> global:50000000 jump table   : 13747069902 (217.23%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 6326481236
> global:50000000 jump table   : 13749345724 (217.33%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 6329332628
> global:50000000 jump table   : 13745879704 (217.18%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 6327734850
> global:50000000 jump table   : 13746412678 (217.24%)
>
> For comparison that both are 100% when raising limit is _not_ in use
> (which is expected of course but just to make sure):
>
> root@snat:~/microbenchmark# make
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r   -c -o test.o test.c
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r   -c -o switch-no-table.o switch-no-table.c
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r   -c -o switch.o switch.c
> gcc -o test test.o switch-no-table.o switch.o
> taskset 1 ./test
> global:50000000 no jump table: 13704083238
> global:50000000 jump table   : 13746838060 (100.31%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 13753854740
> global:50000000 jump table   : 13746624470 (99.95%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 13707053714
> global:50000000 jump table   : 13746682002 (100.29%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 13708843624
> global:50000000 jump table   : 13749733040 (100.30%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 13707365404
> global:50000000 jump table   : 13747683096 (100.29%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 13707014114
> global:50000000 jump table   : 13746444272 (100.29%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 13709596158
> global:50000000 jump table   : 13750499176 (100.30%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 13709484118
> global:50000000 jump table   : 13747952446 (100.28%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:50000000 no jump table: 13708873570
> global:50000000 jump table   : 13748950096 (100.29%)
>
> ** Next case would be constantly hitting first switch case:
>
> diff --git a/switch.c b/switch.c
> index 233ec14..fe0a8b0 100644
> --- a/switch.c
> +++ b/switch.c
> @@ -3,7 +3,7 @@ int global;
>  int
>  foo (int x)
>  {
> -  switch (x & 0xf) {
> +  switch (x) {
>      case 0:
>        return 11;
>      case 1:
> diff --git a/test.c b/test.c
> index 7fc22a4..2849112 100644
> --- a/test.c
> +++ b/test.c
> @@ -5,6 +5,7 @@ extern int foo (int);
>  extern int foo_no_table (int);
>
>  int global =3D 20;
> +int j =3D 0;
>
>  #define LOOP 800000000
>
> @@ -18,7 +19,7 @@ main ()
>    global =3D 0;
>    start =3D __rdtscp (&i);
>    for (i =3D 0; i < LOOP; i++)
> -    foo_no_table (i);
> +    foo_no_table (j);
>    end =3D __rdtscp (&i);
>    diff1 =3D end - start;
>
> @@ -27,7 +28,7 @@ main ()
>    global =3D 0;
>    start =3D __rdtscp (&i);
>    for (i =3D 0; i < LOOP; i++)
> -    foo (i);
> +    foo (j);
>    end =3D __rdtscp (&i);
>    diff2 =3D end - start;
>
> # make
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r   -c -o test.o test.c
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r --param=3Dcase-values-threshold=3D20   -c -o switch-no-table.o switch-no-=
table.c
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r   -c -o switch.o switch.c
> gcc -o test test.o switch-no-table.o switch.o
> taskset 1 ./test
> global:0 no jump table: 6098109200
> global:0 jump table   : 30717871980 (503.73%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6097799330
> global:0 jump table   : 30727386270 (503.91%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6097559796
> global:0 jump table   : 30715992452 (503.74%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6098532172
> global:0 jump table   : 30716423870 (503.67%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6097429586
> global:0 jump table   : 30715774634 (503.75%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6097813848
> global:0 jump table   : 30716476820 (503.73%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6096955736
> global:0 jump table   : 30715385478 (503.78%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6096820240
> global:0 jump table   : 30719682434 (503.86%)
>
> ** And next case would be constantly hitting default case:
>
> diff --git a/test.c b/test.c
> index 2849112..be9bfc1 100644
> --- a/test.c
> +++ b/test.c
> @@ -5,7 +5,7 @@ extern int foo (int);
>  extern int foo_no_table (int);
>
>  int global =3D 20;
> -int j =3D 0;
> +int j =3D 1000;
>
>  #define LOOP 800000000
>
> # make
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r   -c -o test.o test.c
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r --param=3Dcase-values-threshold=3D20   -c -o switch-no-table.o switch-no-=
table.c
> gcc -g -I. -O2 -mindirect-branch=3Dthunk-inline -mindirect-branch-registe=
r   -c -o switch.o switch.c
> gcc -o test test.o switch-no-table.o switch.o
> taskset 1 ./test
> global:0 no jump table: 6422890064
> global:0 jump table   : 6866072454 (106.90%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6423267608
> global:0 jump table   : 6866266176 (106.90%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6424721624
> global:0 jump table   : 6866607842 (106.88%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6424225664
> global:0 jump table   : 6866843372 (106.89%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6424073830
> global:0 jump table   : 6866467050 (106.89%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6426515396
> global:0 jump table   : 6867031640 (106.85%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6425126656
> global:0 jump table   : 6866352988 (106.87%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6423040024
> global:0 jump table   : 6867233670 (106.92%)
> root@snat:~/microbenchmark# make
> taskset 1 ./test
> global:0 no jump table: 6422256136
> global:0 jump table   : 6865902094 (106.91%)
>
> I could also try different distributions perhaps for the case selector,
> but observations match in that direction with what Bjorn et al also have
> been seen in XDP case.
>
> Thanks,
> Daniel



--=20
H.J.
