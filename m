Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26B8C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDBD20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="C14HhIy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbfFJHWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:22:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42848 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387785AbfFJHWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:22:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so9435977qtk.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jOb1/PeO4O22cDS+f1+KzAenv4SW8wAwRqXfShAnI7g=;
        b=C14HhIy4+nv7vGwB1d7eXQh1P3dxxSgC1C0/QkzLk6xwBBa3MFQyunU2HRulQcUi1h
         ed6iKHyVlysuLJlZL7IxTXbOq8AdPW3q9g84yga2KtQPqXaUh5wMrB6D2aOdZ50hdaEm
         tlLnq0nfv8U3VSVj35o+hdm/zr0ZUdu/8+vuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jOb1/PeO4O22cDS+f1+KzAenv4SW8wAwRqXfShAnI7g=;
        b=t3G1ARfjnp9hQDtYSkig5pRPHho4n6yzyVGmfokz7AZGI48+TiT+7i9TvV9RBleWiU
         LiKj0iT3VdJ3avko/tlQO/v+IU4Ns5r2ME+514q3BTg6JWhCaKO+NBuczi0uGY5Nx+h+
         9eyRV540akLU0CgYeTfW0qtfE4E+RKBQi+oCyWlNxY+TdY6p/O+6CapyyYSPJfVnN7bI
         s7J2voFKk6X6g36xDWg2N5EpRq99VKxZL6NeFwwsFoRLPUKEGnuEO7rD2rqE3otOGZQa
         3VRGnP2S2QRt8q8L9kj8BS4J8QX9/TJM9iX/S1Phs+Z8SIDLEPMXyhnNddzBKiRCkegl
         /+rg==
X-Gm-Message-State: APjAAAUiQQc1ZdyvMBkuI7iuyFilkH4qU1UQaAHM362lZm0Z5Y2tnTRZ
        6jArm36ZxjneyjJKEwYwQl4icdEI9h9gfU5pH9qn7g==
X-Google-Smtp-Source: APXvYqzgEDs1TPrm3u0LT3bO8rpmrECSsRdRu2VSuVZ1VQcZCpASdtmc3R4b5d75HOg4TUeyfGHKygAfVUSbENIcXrY=
X-Received: by 2002:ac8:3613:: with SMTP id m19mr57391438qtb.193.1560151322703;
 Mon, 10 Jun 2019 00:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72kvpiC-i53AXM-YsCUvWroHQemmqxsXjnB330ZEeHahUg@mail.gmail.com>
 <CABWYdi1zhTTaN-GSgH0DnPfz7p=SRw0wts5QVYYVtfvoiS0qnQ@mail.gmail.com>
 <CANiq72=fsL5m2_e+bNovFCHy3=YVf53EKGtGE_sWvsAD=ONHuQ@mail.gmail.com>
 <20190516225013.nvhwqi5tfwtby6qb@treble> <CABWYdi29E++jBw8boFZAiDZA7iT5NiJhnNmiHb-Rvd9+97hSVA@mail.gmail.com>
 <20190517050931.GB32367@kroah.com> <20190517073813.GB2589@hirez.programming.kicks-ass.net>
 <CANiq72nUPoNHWM-dJuFc3=4D2=8XMuvO0PgGPjviOv+EhrAWUw@mail.gmail.com>
 <20190517085126.GA3249@kroah.com> <CANiq72muyjE3XPjmtQgJpGaqWR=YBi6KVNT3qe-EMXP7x+q_rQ@mail.gmail.com>
 <20190517152200.GI8945@kernel.org> <CABWYdi2Xsp4AUhV1GwphTd4-nN2zCZMmg5y7WheNc67KrdVBfw@mail.gmail.com>
 <4FE2D490-F379-4CAE-9784-9BF81B7FE258@kernel.org>
In-Reply-To: <4FE2D490-F379-4CAE-9784-9BF81B7FE258@kernel.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 10 Jun 2019 00:21:51 -0700
Message-ID: <CABWYdi2XXPYuavF0p=JOEY999M4z3_rk-8xsi3N=do=d7k09ig@mail.gmail.com>
Subject: Re: Linux 4.19 and GCC 9
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like 4.19.49 received some patches for GCC 9+, but unfortunately
perf still doesn't want to compile:

[07:15:32]In file included from /usr/include/string.h:635,
[07:15:32] from util/debug.h:7,
[07:15:32] from builtin-help.c:15:
[07:15:32]In function 'strncpy',
[07:15:32] inlined from 'add_man_viewer' at builtin-help.c:192:2,
[07:15:32] inlined from 'perf_help_config' at builtin-help.c:284:3:
[07:15:32]/usr/include/x86_64-linux-gnu/bits/string3.h:126:10: error:
'__builtin_strncpy' output truncated before terminating nul copying as
many bytes from a string as its length [-Werror=3Dstringop-truncation]
[07:15:32] 126 | return __builtin___strncpy_chk (__dest, __src, __len,
__bos (__dest));
[07:15:32] | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[07:15:32]builtin-help.c: In function 'perf_help_config':
[07:15:32]builtin-help.c:187:15: note: length computed here
[07:15:32] 187 | size_t len =3D strlen(name);
[07:15:32] | ^~~~~~~~~~~~
[07:15:32]cc1: all warnings being treated as errors



On Fri, May 17, 2019 at 11:27 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On May 17, 2019 2:23:10 PM GMT-03:00, Ivan Babrou <ivan@cloudflare.com> w=
rote:
> >On Fri, May 17, 2019 at 8:22 AM Arnaldo Carvalho de Melo
> ><arnaldo.melo@gmail.com> wrote:
> >>
> >> Em Fri, May 17, 2019 at 11:01:45AM +0200, Miguel Ojeda escreveu:
> >> > On Fri, May 17, 2019 at 10:51 AM Greg KH
> ><gregkh@linuxfoundation.org> wrote:
> >> > >
> >> > > On Fri, May 17, 2019 at 10:35:29AM +0200, Miguel Ojeda wrote:
> >> > > > On Fri, May 17, 2019 at 9:38 AM Peter Zijlstra
> ><peterz@infradead.org> wrote:
> >> > > > >
> >> > > > > Right; if there is anything you can reproduce on linus.git
> >I'll happily
> >> > > > > have a look. If it doesn't reproduce all you have to do is
> >find the
> >> > > > > patches that make it work and ask Greg.
> >> > > >
> >> > > > Just to clarify: Linus' master is clean of these issues with
> >GCC 9.1.1.
> >> > >
> >> > > Great!  Care to find the patches that did that work and send me
> >the git
> >> > > commit ids so that I can queue them up?  I don't have gcc9 here
> >yet on
> >> > > my systems, so I can not test for this.
> >> >
> >> > I am unsure about the perf and the objtools parts (Peter/Josh?),
> >but
> >>
> >> I'm not noticing these while building upstream perf with gcc 9.1.1 on
>                                                                        ^^=
^^^^^^^^^^^^^
>
> >at
> >> least fedora:30.
> >>
> >>     33  fedora:30                     : Ok   gcc (GCC) 9.1.1 20190503
> >(Red Hat 9.1.1-1)
> >
> >I've tried to replicate this in fedora:30 docker container and it's
> >there:
> >
> >[root@linuxkit-025000000001 perf]# gcc --version
> >gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1)
> >
> >[root@linuxkit-025000000001 perf]# pwd
> >/tmp/linux-4.19.44/tools/perf
>              ^^^^^^^^^^^^^^
>
> That is not upstream perf, please look for patches from 4.19 to Linus' ma=
ster Branch for fixes.
>
> I'll triple check here in a f30 container just in case meanwhile.
>
> Thanks,
>
> - Arnaldo
> >
> >[root@linuxkit-025000000001 perf]# make -j1
> >...
> >trace/beauty/ioctl.c: In function =E2=80=98ioctl__scnprintf_kvm_cmd=E2=
=80=99:
> >trace/beauty/ioctl.c:85:82: error: array subscript [-2147483648, -1]
> >is outside array bounds of =E2=80=98const char *[0]=E2=80=99 [-Werror=3D=
array-bounds]
> >   85 |  if (nr < strarray__kvm_ioctl_cmds.nr_entries &&
> >strarray__kvm_ioctl_cmds.entries[nr] !=3D NULL)
> >      |
> >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> >In file included from trace/beauty/ioctl.c:82:
> >/tmp/linux-4.19.44/tools/perf/trace/beauty/generated/ioctl/kvm_ioctl_arr=
ay.c:1:20:
> >note: while referencing =E2=80=98kvm_ioctl_cmds=E2=80=99
> >    1 | static const char *kvm_ioctl_cmds[] =3D {
> >      |                    ^~~~~~~~~~~~~~
> >In file included from /usr/include/string.h:494,
> >                 from util/debug.h:7,
> >                 from builtin-help.c:15:
> >In function =E2=80=98strncpy=E2=80=99,
> >    inlined from =E2=80=98add_man_viewer=E2=80=99 at builtin-help.c:192:=
2,
> >    inlined from =E2=80=98perf_help_config=E2=80=99 at builtin-help.c:28=
4:3:
> >/usr/include/bits/string_fortified.h:106:10: error:
> >=E2=80=98__builtin_strncpy=E2=80=99 output truncated before terminating =
nul copying as
> >many bytes from a string as its length [-Werror=3Dstringop-truncation]
> >106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos
> >(__dest));
> >|
> >^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >builtin-help.c: In function =E2=80=98perf_help_config=E2=80=99:
> >builtin-help.c:187:15: note: length computed here
> >  187 |  size_t len =3D strlen(name);
> >      |               ^~~~~~~~~~~~
> >trace/beauty/ioctl.c: In function =E2=80=98ioctl__scnprintf_perf_cmd=E2=
=80=99:
> >trace/beauty/ioctl.c:109:84: error: array subscript [-2147483648, -1]
> >is outside array bounds of =E2=80=98const char *[0]=E2=80=99 [-Werror=3D=
array-bounds]
> >  109 |  if (nr < strarray__perf_ioctl_cmds.nr_entries &&
> >strarray__perf_ioctl_cmds.entries[nr] !=3D NULL)
> >      |
> >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> >In file included from trace/beauty/ioctl.c:106:
> >/tmp/linux-4.19.44/tools/perf/trace/beauty/generated/ioctl/perf_ioctl_ar=
ray.c:1:20:
> >note: while referencing =E2=80=98perf_ioctl_cmds=E2=80=99
> >    1 | static const char *perf_ioctl_cmds[] =3D {
> >      |                    ^~~~~~~~~~~~~~~
> >cc1: all warnings being treated as errors
> >
> >> > about the -Wmissing-attributes I cleaned, they were these:
> >>
> >> > a6e60d84989f ("include/linux/module.h: copy __init/__exit attrs to
> >> > init/cleanup_module")
> >> > c0d9782f5b6d ("Compiler Attributes: add support for __copy (gcc >=3D
> >9)")
> >> > ff98e20ef208 ("lib/crc32.c: mark crc32_le_base/__crc32c_le_base
> >> > aliases as __pure")
> >> >
> >> > Cheers,
> >> > Miguel
> >>
> >> --
> >>
> >> - Arnaldo
>
