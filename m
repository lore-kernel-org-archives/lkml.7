Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA44C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426B521927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ykJZfsPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLSX6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 18:58:07 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37869 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLSX6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:58:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so6204211qky.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 15:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yw3O5tvrKa/tuY84h1bW6POzDBK9vjmE3rZGlxF9Nbo=;
        b=ykJZfsPB51XxyOthnSi1hLhPSr/5uBt8iAGjswUh77OTRxFDqUxJApenYmrvEK00P4
         bH94oOXU0Omp2octVHvtOmJsS7mykz7gHEIurJgGU0cJMvGNrLDogzEbV0GS1jXBnsvw
         yCyljks0JLQYHBFXg9bETc87tjfUoKGV+UIds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yw3O5tvrKa/tuY84h1bW6POzDBK9vjmE3rZGlxF9Nbo=;
        b=asUEQ8/6SyItmmhfYrvJEZFKD9YTvnOjQ07PJfsU/1w409Ozf7D/Lxv7TnheCd32W+
         vxcYwi4NPuOPAlX8rBL53beMWRhCNbIZ5zffmMiBdnXYqamdOm6yi0n5sibGWDmxowS+
         Vhum1T9ztywT+ypfEsMgPaS4dBkl8HEZpt9bVM25fwjLI4w8VEtTRrDAb94+L3tsiAtK
         iDR0GfEMrI85jOch6qy/ux8P/2Rxzr4qpkC5SMLQ4U6tFiVzT/6CTbE0tnEsZ6+Elom7
         BD3+Wma6xgtdJXp4YqQ0qzY9tiRJhJ2P3mG4XRYvqoxASmhBpp0UviRjpVS2vi5GWVw0
         QwXQ==
X-Gm-Message-State: APjAAAXhXvG7ei1mrtSEM1HL7FoN4AZSyI3aaEVQ5dbgQgkGlJaQ2KIK
        LhcPaS2K8smUZ6Di+IJYN7rzDa2fAOHyZpmRy6x1mEHTtVgQ0A==
X-Google-Smtp-Source: APXvYqzynucmnQJtoVUS8THYuUn6mrupw5UWxt4a0TiWLSAC5RYROswEyu4j7nq3HPYw5kXAKpEcTNsPpB0N+vs0zLM=
X-Received: by 2002:ae9:e513:: with SMTP id w19mr11021887qkf.34.1576799885374;
 Thu, 19 Dec 2019 15:58:05 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi2jvPUq128XDv_VbY=vFknFyJHbUR=0_K9WuA0mFTkPvg@mail.gmail.com>
 <CABWYdi3k9QvFOEd_hFG16LVE=BiokO4hWp50nZcxYwbWfxeE3g@mail.gmail.com>
 <20191129134929.GA26903@krava> <20191129151436.GB26963@kernel.org>
 <CABWYdi19LmOHC0Ect-8vNXz0uF2tNC1XmDQfMn0fmYOt2yJH9w@mail.gmail.com>
 <20191203102234.GE17468@krava> <CABWYdi2VugwNhJ6TBr4j7FUJi_uSk6__qu0PKAmW-H9MdoEkpw@mail.gmail.com>
In-Reply-To: <CABWYdi2VugwNhJ6TBr4j7FUJi_uSk6__qu0PKAmW-H9MdoEkpw@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 19 Dec 2019 15:57:54 -0800
Message-ID: <CABWYdi016dTvk-6cBTDEc+Bo5TVGiO9n5eK6LQ5q2WL9jz6PDQ@mail.gmail.com>
Subject: Re: perf is unable to read dward from go programs
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
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

Found a reproducer for missing /tmp/perf-XXX frames:

$ cat hello.java
class HelloWorld {
    public static void main(String args[]) {
        for (long i = 0; ; i++) {}
    }
}

Compile it:

$ javac hello.java

Run it:

$ java HelloWorld

Trace it with libdw:

$ sudo perf record -p $(pidof java) --call-graph dwarf -- sleep 1

Observe traces in perf script not having any frames:

java 61467 127535.601549:     149893 cycles:

java 61467 127535.601602:     606223 cycles:

java 61467 127535.601802:     890579 cycles:

java 61467 127535.602158:     840878 cycles:

java 61467 127535.602453:     809547 cycles:

java 61467 127535.602718:     794099 cycles:

java 61467 127535.602981:     777283 cycles:

Now trace it with libunwind:

$ sudo perf record -p $(pidof java) --call-graph dwarf -- sleep 1

And observe traces with /tmp/perf-XXX:

java 61467 127583.896584:     118386 cycles:
            7fcd55342ce8 [unknown] (/tmp/perf-61466.map)

java 61467 127583.896626:     537046 cycles:
            7fcd55342d17 [unknown] (/tmp/perf-61466.map)

java 61467 127583.896804:     866323 cycles:
            7fcd55342ce8 [unknown] (/tmp/perf-61466.map)

java 61467 127583.897091:     825548 cycles:
            7fcd55342d17 [unknown] (/tmp/perf-61466.map)

java 61467 127583.897361:     812276 cycles:
            7fcd55342d17 [unknown] (/tmp/perf-61466.map)

java 61467 127583.897627:     804520 cycles:
            7fcd55342ce5 [unknown] (/tmp/perf-61466.map)

This should cover all issues I mentioned.

On Thu, Dec 19, 2019 at 3:38 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> At first I thought it was related to C/Go interaction, but it looks
> even easier to trigger.
>
> Ok, I have a reproduction for both random dwarf versions and for
> uncached binary symbol resolution:
>
> $ cat /tmp/main.go
> package main
>
> func main() {
>   for {
>     src := make([]byte, 100*1024*1024)
>     dst := make([]byte, len(src))
>     copy(dst, src)
>   }
> }
>
> Compile and run it:
>
> $ go build -o /tmp/memmove /tmp/main.go && /tmp/memmove
>
> Then record a trace:
>
> $ sudo perf record -p $(pidof memmove) --call-graph dwarf -- sleep 1
>
> Getting stack traces generates warnings:
>
> $ sudo perf script > /dev/null
> BFD: Dwarf Error: found dwarf version '376', this reader only handles
> version 2, 3 and 4 information.
> BFD: Dwarf Error: found dwarf version '31863', this reader only
> handles version 2, 3 and 4 information.
> BFD: Dwarf Error: found dwarf version '65267', this reader only
> handles version 2, 3 and 4 information.
> BFD: Dwarf Error: found dwarf version '33833', this reader only
> handles version 2, 3 and 4 information.
> BFD: Dwarf Error: found dwarf version '41392', this reader only
> handles version 2, 3 and 4 information.
>
> Here's an example of raw perf script output where it generates the warning:
>
> memmove 254821 125950.754906:     174236 cycles: BFD: Dwarf Error:
> found dwarf version '33833', this reader only handles version 2, 3 and
> 4 information.
>
>                   44d549 runtime.memmove+0x4d9 (/tmp/memmove)
>                   452644 main.main+0x94 (/tmp/memmove)
>                   42668d runtime.main+0x21d (/tmp/memmove)
>                   44bef0 runtime.goexit+0x0 (/tmp/memmove)
>
> Timed execution shows quite a bit of time spent:
>
> $ time sudo perf script > /dev/null
> ... whole bunch of warnings about dwarf version here ..
>
> real 0m24.356s
> user 0m23.617s
> sys 0m0.723s
>
> And you can see object files being open over and over again:
>
> $ sudo bpftrace -e 'tracepoint:syscalls:sys_enter_open,
> tracepoint:syscalls:sys_enter_openat {
> @filename[str(args->filename)]++ }'
> ... some unrelated files here ...
> @filename[/lib/x86_64-linux-gnu/libpcre.so.3]: 595
> @filename[/usr/lib/locale/locale-archive]: 625
> @filename[/lib/x86_64-linux-gnu/libpthread.so.0]: 789
> @filename[/lib/x86_64-linux-gnu/libdl.so.2]: 838
> @filename[/var/log/journal/0bc45a9309f7404586bcddee0d45bf9d/system.journa]: 1044
> @filename[/lib/x86_64-linux-gnu/libc.so.6]: 1273
> @filename[/etc/ld.so.cache]: 1501
> @filename[/usr/lib/x86_64-linux-gnu/../lib/x86_64-linux-gnu/elfutils/libe]: 5784
> @filename[/usr/lib/x86_64-linux-gnu/elfutils/libebl_x86_64.so]: 5784
> @filename[/tmp/memmove]: 5789
>
> I'm going to guess that anything open for 5000+ times is related to
> perf script run, as I can also see those in strace.
>
> This is on Debian Stretch and Linux 5.4.5 (perf is from 5.4.5 as well).
>
> This should cover points 2 and 3, I'll have to get back to you on
> points 4 and 5, but those are separate.
>
> On Tue, Dec 3, 2019 at 2:22 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Dec 02, 2019 at 11:49:55AM -0800, Ivan Babrou wrote:
> > > I've tried building with libdw with mixed results:
> > >
> > > 1. I can see stacks from some Go programs that were invisible before (yay!)
> > >
> > > 2. Warnings like below still appear in great numbers for a system-wide
> > > flamegraph:
> > >
> > > BFD: Dwarf Error: found dwarf version '18345', this reader only
> > > handles version 2, 3 and 4 information.
> > >
> > > I'm not sure how to pinpoint this to a particular binary and would
> > > appreciate some help with this.
> >
> > I'd need some way of reproducing this, could you please
> > paste me command lines you used?
> >
> > >
> > > 3. It takes minutes to produce a flamegraph of a running system
> > > whereas before it only took seconds. See this flamegraph of "perf
> > > script" itself:
> > >
> > > * https://gist.github.com/bobrik/a9c46cffe9daa5840abd137443d8bab0#file-flamegraph-perf-svg
> > >
> > > Seems like there is no caching and debug info is getting reparsed
> > > continuously for every stack. It's possible that it was not an issue
> > > before, because we spent no time decompressing dwarf.
> >
> > possibly, if we have some clear reproducer we can hand it
> > to the libdw guy that helped us develop this
> >
> > >
> > > 4. Pretty much all luajit frames stacks that were marked as unknown
> > > before are now gone.
> > >
> > > See before and after here: https://imgur.com/a/1LNfqAk
> > >
> > > Before:
> > >
> > > nginx-cache 94572 446642.722028:   10101010 cpu-clock:
> > >             5607d8d56718 ngx_http_lua_shdict_lookup+0x48 (inlined)
> > >             5607d8d5a09d ngx_http_lua_ffi_shdict_incr+0xcd
> > > (/usr/local/nginx-cache/sbin/nginx-cache)
> > >             560802fe58e4 [unknown] (/tmp/perf-94572.map)
> > >
> > > After:
> > >
> > > nginx-cache 94572 446543.008703:   10101010 cpu-clock:
> > >             5607d8d56718 ngx_http_lua_shdict_lookup+0x48 (inlined)
> > >             5607d8d59da7 ngx_http_lua_ffi_shdict_get+0x197
> > > (/usr/local/nginx-cache/sbin/nginx-cache)
> > >
> > > The key is /tmp/perf-*.map frame at the bottom. I don't know if it's
> > > expected, but we grew dependent on knowing this.
> > >
> > > 5. Special [[stack]], [[heap]] and [anon] frames are also gone, and
> > > you can see the following during "perf script" run:
> > >
> > > open("[stack]", O_RDONLY)               = -1 ENOENT (No such file or directory)
> > > open("[heap]", O_RDONLY)                = -1 ENOENT (No such file or directory)
> > > open("//anon", O_RDONLY)                = -1 ENOENT (No such file or directory)
> >
> > strange, let's start with the reproducer and I'll check
> > on this if I see it
> >
> > thanks,
> > jirka
> >
