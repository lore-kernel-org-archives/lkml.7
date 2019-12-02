Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B051C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0239E2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="lgAPnql8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfLBTuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:50:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34063 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfLBTuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:50:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id d202so866209qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 11:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHNPb3FLC4x3n00GepUbDZ2yCT5WS+KGqS9LSVotxtY=;
        b=lgAPnql8dHwMZCLrT0qLvZcjoN1Dg1TJUE3H5tCnNG6rIO2FQV9t+3RwqU8BPyTTwp
         r9s9z9+sE7Ljln+aLtz7khUHZdL0TRLE8gwyJDh5Tw5R4yzoBiJB25kbSdLHYchwYbuC
         j+RrX+zsadpbgr4nhIDxpiLZWwHAprr/1zDK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHNPb3FLC4x3n00GepUbDZ2yCT5WS+KGqS9LSVotxtY=;
        b=SEeJTD2r/O/rDzHJjSFQ7czNE7mAuhOXRvPekd9CMz4UpLDtN9kY8U9Yg6MZJujBr+
         iUXiJ8i+fYohd0zFi4JwyNazg9g97zpX+uW+YgvkQ4kCcvz2db3XATKOyx4mbamyutud
         bZj6u3xlLbiDItARZquSoE7OBKkTEe1p1zVSZBEmsJStfZQxG5yPO3n8ovChQMG8cfnl
         yONQ0DMoRPemJ6pl7luZL/U4m1s/Dbv5PQ/Zd1xCOR1B9eu5Y2EFWL/AvJInJC2/G/e4
         IpVdfHRRd7ZkI2r1dtHsVwtmFi5x3kkXIhfLQwOfqqupBTlw2m75rTfNsqQBZ0Hbo1YX
         KvGQ==
X-Gm-Message-State: APjAAAWncsqua+Dlf0iskwMDgAwNvXhcZJwR/HS0nvjyoMaIBWOKu95T
        bHofQTlE9XErDOH12c7CXO21SgQHwOl5/Wea6xOcDw==
X-Google-Smtp-Source: APXvYqx0DEyfma8k8YybLTXu3l+xR9GCfyIHNOtaUiX3mA3X2jD1Q9OtuYNtLOr3151thKQtS8lPz770KBn1Ac525Mk=
X-Received: by 2002:a05:620a:228:: with SMTP id u8mr733620qkm.88.1575316206112;
 Mon, 02 Dec 2019 11:50:06 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi2jvPUq128XDv_VbY=vFknFyJHbUR=0_K9WuA0mFTkPvg@mail.gmail.com>
 <CABWYdi3k9QvFOEd_hFG16LVE=BiokO4hWp50nZcxYwbWfxeE3g@mail.gmail.com>
 <20191129134929.GA26903@krava> <20191129151436.GB26963@kernel.org>
In-Reply-To: <20191129151436.GB26963@kernel.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 2 Dec 2019 11:49:55 -0800
Message-ID: <CABWYdi19LmOHC0Ect-8vNXz0uF2tNC1XmDQfMn0fmYOt2yJH9w@mail.gmail.com>
Subject: Re: perf is unable to read dward from go programs
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried building with libdw with mixed results:

1. I can see stacks from some Go programs that were invisible before (yay!)

2. Warnings like below still appear in great numbers for a system-wide
flamegraph:

BFD: Dwarf Error: found dwarf version '18345', this reader only
handles version 2, 3 and 4 information.

I'm not sure how to pinpoint this to a particular binary and would
appreciate some help with this.

3. It takes minutes to produce a flamegraph of a running system
whereas before it only took seconds. See this flamegraph of "perf
script" itself:

* https://gist.github.com/bobrik/a9c46cffe9daa5840abd137443d8bab0#file-flamegraph-perf-svg

Seems like there is no caching and debug info is getting reparsed
continuously for every stack. It's possible that it was not an issue
before, because we spent no time decompressing dwarf.

4. Pretty much all luajit frames stacks that were marked as unknown
before are now gone.

See before and after here: https://imgur.com/a/1LNfqAk

Before:

nginx-cache 94572 446642.722028:   10101010 cpu-clock:
            5607d8d56718 ngx_http_lua_shdict_lookup+0x48 (inlined)
            5607d8d5a09d ngx_http_lua_ffi_shdict_incr+0xcd
(/usr/local/nginx-cache/sbin/nginx-cache)
            560802fe58e4 [unknown] (/tmp/perf-94572.map)

After:

nginx-cache 94572 446543.008703:   10101010 cpu-clock:
            5607d8d56718 ngx_http_lua_shdict_lookup+0x48 (inlined)
            5607d8d59da7 ngx_http_lua_ffi_shdict_get+0x197
(/usr/local/nginx-cache/sbin/nginx-cache)

The key is /tmp/perf-*.map frame at the bottom. I don't know if it's
expected, but we grew dependent on knowing this.

5. Special [[stack]], [[heap]] and [anon] frames are also gone, and
you can see the following during "perf script" run:

open("[stack]", O_RDONLY)               = -1 ENOENT (No such file or directory)
open("[heap]", O_RDONLY)                = -1 ENOENT (No such file or directory)
open("//anon", O_RDONLY)                = -1 ENOENT (No such file or directory)

On Fri, Nov 29, 2019 at 7:14 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Nov 29, 2019 at 02:49:29PM +0100, Jiri Olsa escreveu:
> > On Wed, Nov 27, 2019 at 01:15:20PM -0800, Ivan Babrou wrote:
> > > There were no response in linux-perf-users@, so I think it's fair to
> > > ask maintainers.
> > >
> > > On Fri, Nov 8, 2019 at 3:53 PM Ivan Babrou <ivan@cloudflare.com> wrote:
> > > >
> > > > I have a simple piece of code that burns CPU for 1s:
> > > >
> > > > * https://gist.github.com/bobrik/cf022ff6950d09032fa13a984e2272ed
> > > >
> > > > I can build it just fine: go build -o /tmp/burn burn.go
> > > >
> > > > And I can see correct stacks if I record with fp:
> > > >
> > > > perf record -e cpu-clock -g -F 99 /tmp/burn
> > > >
> > > > But if I record with gwarf:
> > > >
> > > > perf record -e cpu-clock -g -F 99 --call-graph dwarf /tmp/burn
> > > >
> > > > Then stacks are lost with the following complaints during "perf script":
> > > >
> > > > BFD: Dwarf Error: found dwarf version '376', this reader only handles
> > > > version 2, 3 and 4 information.
> > > > BFD: Dwarf Error: found dwarf version '31863', this reader only
> > > > handles version 2, 3 and 4 information.
> > > > BFD: Dwarf Error: found dwarf version '65271', this reader only
> > > > handles version 2, 3 and 4 information.
> > > > BFD: Dwarf Error: found dwarf version '289', this reader only handles
> > > > version 2, 3 and 4 information.
> >
> > hi,
> > the binary generated by go has compressed debug info (on my setup)
> > and libunwind (default dwarf unwinder) does not seem to support that
> >
> > but when I compile perf with libdw unwind support:
> >
> >   $ make DEBUG=1 VF=1 NO_LIBUNWIND=1
> >
> > I'm getting proper backtraces (below), maybe it's time to change
> > the default dwarf unwinder ;-)
>
> we have some 'perf test' entries testing the unwinding routines, can you
> please check if those pass when switching to libdw's unwinder?
>
> - Arnaldo
>
> > thanks,
> > jirka
> >
> >
> > ---
> >     51.63%  ex       ex                [.] crypto/sha512.blockAVX2
> >             |
> >             ---crypto/sha512.blockAVX2
> >                |
> >                 --51.48%--crypto/sha512.block
> >                           crypto/sha512.(*digest).Write
> >                           crypto/sha512.(*digest).checkSum
> >                           crypto/sha512.(*digest).Sum
> >                           main.burn
> >                           main.main
> >                           runtime.main
> >                           runtime.goexit
> >
> >     11.55%  ex       ex                [.] runtime.mallocgc
> >             |
> >             ---runtime.mallocgc
> >                |
> >                |--7.45%--runtime.newobject
> >                |          |
> >                |           --7.45%--main.burn
> >                |                     main.main
> >                |                     runtime.main
> >                |                     runtime.goexit
> >                |
> >                 --3.40%--runtime.growslice
> >                           crypto/sha512.(*digest).Sum
> >                           main.burn
> >                           main.main
> >                           runtime.main
> >                           runtime.goexit
> >
> >      3.69%  ex       ex                [.] crypto/sha512.(*digest).Write
> >             |
> >             ---crypto/sha512.(*digest).Write
> >                |
> >                |--2.91%--crypto/sha512.(*digest).checkSum
> >                |          crypto/sha512.(*digest).Sum
> >                |          main.burn
> >                |          main.main
> >                |          runtime.main
> >                |          runtime.goexit
> >                |
> >                 --0.57%--main.burn
> >                           main.main
> >                           runtime.main
> >                           runtime.goexit
> >
> >      3.44%  ex       ex                [.] runtime.memclrNoHeapPointers
> >             |
> >             ---runtime.memclrNoHeapPointers
> >                |
> >                 --2.92%--runtime.(*mheap).alloc
> >                           runtime.(*mcentral).grow
> >                           runtime.(*mcentral).cacheSpan
> >                           runtime.(*mcache).refill
> >                           runtime.(*mcache).nextFree
> >                           runtime.mallocgc
> >                           |
> >                           |--2.27%--runtime.newobject
> >                           |          main.burn
> >                           |          main.main
> >                           |          runtime.main
> >                           |          runtime.goexit
> >                           |
> >                            --0.64%--runtime.growslice
> >                                      crypto/sha512.(*digest).Sum
> >                                      main.burn
> >                                      main.main
> >                                      runtime.main
> >                                      runtime.goexit
> > ...
>
> --
>
> - Arnaldo
