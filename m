Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28217C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC4020449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbfDDJYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:24:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733160AbfDDJOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 948DE308CF85;
        Thu,  4 Apr 2019 09:14:48 +0000 (UTC)
Received: from krava (unknown [10.40.205.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 28BC417D42;
        Thu,  4 Apr 2019 09:14:44 +0000 (UTC)
Date:   Thu, 4 Apr 2019 11:14:38 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Message-ID: <20190404091438.GB31233@krava>
References: <20190403143738.GB32001@krava>
 <20190403145353.GE32553@kernel.org>
 <20190403151548.GF32553@kernel.org>
 <B07CAAC3-D085-443D-BB0C-05E9A8F3AFB2@fb.com>
 <20190403185053.GH32553@kernel.org>
 <124332A9-146A-446F-A82A-910C8319170E@fb.com>
 <425141B8-8908-4D48-90FD-8806BA9E9E12@fb.com>
 <A476B82A-4550-45F1-9A31-B1AA63C07489@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A476B82A-4550-45F1-9A31-B1AA63C07489@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 04 Apr 2019 09:14:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 09:48:23PM +0000, Song Liu wrote:

SNIP

> >>>>> commit 011318ccc2024ba03e96c32a06f74ca5d6ab5503
> >>>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>>>> Date:   Wed Apr 3 12:05:15 2019 -0300
> >>>>> 
> >>>>> perf record: Do not synthesize BPF records when --no-bpf-event is used
> >>>>> 
> >>>>> By default we synthesize and ask the kernel for BPF events, having a
> >>>>> --no-bpf-event option to disable that, which can be useful, for
> >>>>> instance, if there are still bugs in that code, which seems to be the
> >>>>> case as reported by Jiri Olsa in:
> >>>>> 
> >>>>>   "[BUG] perf: intel_pt won't display kernel function"
> >>>>>   https://lore.kernel.org/lkml/20190403143738.GB32001@krava
> >>>>> 
> >>>>> So add the check for record_opts.no_bpf_event when considering
> >>>>> synthesizing BPF events for pre-existing BPF programs in 'perf record'.
> >>>>> 
> >>>>> The reported bug needs further analysis and is a separate matter.
> >>>>> 
> >>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
> >>>>> Cc: Alexei Starovoitov <ast@kernel.org>
> >>>>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >>>>> Cc: Jiri Olsa <jolsa@kernel.org>
> >>>>> Cc: Martin KaFai Lau <kafai@fb.com>
> >>>>> Cc: Namhyung Kim <namhyung@kernel.org>
> >>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>>> Cc: Song Liu <songliubraving@fb.com>
> >>>>> Cc: Yonghong Song <yhs@fb.com>
> >>>>> Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
> >>>>> Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org
> >>>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>>>> 
> >>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> >>>>> index 4e2d953d4bc5..17d772f192ad 100644
> >>>>> --- a/tools/perf/builtin-record.c
> >>>>> +++ b/tools/perf/builtin-record.c
> >>>>> @@ -1114,10 +1114,11 @@ static int record__synthesize(struct record *rec, bool tail)
> >>>>> 		return err;
> >>>>> 	}
> >>>>> 
> >>>>> -	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
> >>>>> -						machine, opts);
> >>>>> -	if (err < 0)
> >>>>> -		pr_warning("Couldn't synthesize bpf events.\n");
> >>>>> +	if (!opts->no_bpf_event) {
> >>>>> +		err = perf_event__synthesize_bpf_events(session, process_synthesized_event, machine, opts);
> >>>>> +		if (err < 0)
> >>>>> +			pr_warning("Couldn't synthesize bpf events.\n");
> >>>>> +	}
> >>>>> 
> >>>>> 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
> >>>>> 					    process_synthesized_event, opts->sample_address,
> >>> 
> >>> -- 
> >>> 
> >>> - Arnaldo
> 
> Yet another version, with commit message and a little more logic:
> 
> 
> From 8c842b52905e747487447a014cef8c98d0db94ef Mon Sep 17 00:00:00 2001
> From: Song Liu <songliubraving@fb.com>
> Date: Wed, 3 Apr 2019 14:24:02 -0700
> Subject: [PATCH] perf util: check maps for bpf programs
> 
> As reported by Jiri Olsa in:
> 
>   "[BUG] perf: intel_pt won't display kernel function"
>   https://lore.kernel.org/lkml/20190403143738.GB32001@krava
> 
> Recent changes to support PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT
> broke --kallsyms option. This is because it broke test __map__is_kmodule.
> 
> This patch fixes this by adding check for bpf program, so that these maps
> are not mistaken as kernel modules.
> 
> Reported-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Fixes: 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
> Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/map.c | 16 ++++++++++++++++
>  tools/perf/util/map.h |  4 +++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index e32628cd20a7..28d484ef74ae 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -261,6 +261,22 @@ bool __map__is_extra_kernel_map(const struct map *map)
>         return kmap && kmap->name[0];
>  }
> 
> +bool __map__is_bpf_prog(const struct map *map)
> +{
> +       const char *name;
> +
> +       if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
> +               return true;
> +
> +       /*
> +        * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
> +        * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
> +        * guess the type based on name.
> +        */
> +       name = map->dso->short_name;
> +       return name && (strstr(name, "bpf_prog_") == name);
> +}
> +
>  bool map__has_symbols(const struct map *map)
>  {
>         return dso__has_symbols(map->dso);
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 0e20749f2c55..01079f1f4375 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -159,10 +159,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
> 
>  bool __map__is_kernel(const struct map *map);
>  bool __map__is_extra_kernel_map(const struct map *map);
> +bool __map__is_bpf_prog(const struct map *map);
> 
>  static inline bool __map__is_kmodule(const struct map *map)
>  {
> -       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map);
> +       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map) &&
> +               !__map__is_bpf_prog(map);
>  }
> 
>  bool map__has_symbols(const struct map *map);

it shows the kernel portion now, but it segfaults on me
in ksymbol map processing

recorded data with:

# perf-with-kcore record pt -e intel_pt// -- sleep 1

gdb session:

(gdb) r script -i pt/perf.data --kallsyms=./pt/kcore_dir/kallsyms
Starting program: /home/jolsa/bin/perf script -i pt/perf.data --kallsyms=./pt/kcore_dir/kallsyms

...

Program received signal SIGABRT, Aborted.
0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-29.fc30.x86_64 elfutils-libelf-0.176-1.fc30.x86_64 elfutils-libs-0.176-1.fc30.x86_64 libgcc-9.0.1-0.10.fc30.x86_64 libunwind-1.3.1-2.fc30.x86_64 libxcrypt-4.4.4-2.fc30.x86_64 numactl-libs-2.0.12-2.fc30.x86_64 perl-libs-5.28.1-434.fc30.x86_64 python2-libs-2.7.16-1.fc30.x86_64 slang-2.3.2-5.fc30.x86_64 xz-libs-5.2.4-5.fc30.x86_64 zlib-1.2.11-15.fc30.x86_64
(gdb) bt
#0  0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
#1  0x00007ffff75d0895 in abort () from /lib64/libc.so.6
#2  0x00007ffff75d0769 in __assert_fail_base.cold () from /lib64/libc.so.6
#3  0x00007ffff75de596 in __assert_fail () from /lib64/libc.so.6
#4  0x00000000004fc006 in refcount_sub_and_test (i=1, r=0x1224e88) at /home/jolsa/linux/tools/include/linux/refcount.h:131
#5  refcount_dec_and_test (r=0x1224e88) at /home/jolsa/linux/tools/include/linux/refcount.h:148
#6  map__put (map=0x1224df0) at util/map.c:299
#7  0x00000000004fdb95 in __maps__remove (map=0x1224df0, maps=0xb17d80) at util/map.c:953
#8  maps__remove (maps=0xb17d80, map=0x1224df0) at util/map.c:959
#9  0x00000000004f7d8a in map_groups__remove (map=<optimized out>, mg=<optimized out>) at util/map_groups.h:65
#10 machine__process_ksymbol_unregister (sample=<optimized out>, event=0x7ffff7279670, machine=<optimized out>) at util/machine.c:728
#11 machine__process_ksymbol (machine=<optimized out>, event=0x7ffff7279670, sample=<optimized out>) at util/machine.c:741
#12 0x00000000004fffbb in perf_session__deliver_event (session=0xb11390, event=0x7ffff7279670, tool=0x7fffffffc7b0, file_offset=13936) at util/session.c:1362
#13 0x00000000005039bb in do_flush (show_progress=false, oe=0xb17e80) at util/ordered-events.c:243
#14 __ordered_events__flush (oe=0xb17e80, how=OE_FLUSH__ROUND, timestamp=<optimized out>) at util/ordered-events.c:322
#15 0x00000000005005e4 in perf_session__process_user_event (session=session@entry=0xb11390, event=event@entry=0x7ffff72a4af8,
    file_offset=file_offset@entry=191224) at util/session.c:1402
#16 0x000000000050091e in perf_session__process_event (file_offset=191224, event=0x7ffff72a4af8, session=0xb11390) at util/session.c:1529
#17 process_simple (session=session@entry=0xb11390, event=event@entry=0x7ffff72a4af8, file_offset=file_offset@entry=191224) at util/session.c:1962
#18 0x0000000000501f44 in reader__process_events (prog=0x7fffffffc680, session=0xb11390, rd=<synthetic pointer>) at util/session.c:1931
#19 __perf_session__process_events (session=0xb11390) at util/session.c:1985
#20 perf_session__process_events (session=0xb11390) at util/session.c:2018
#21 0x000000000045bb42 in __cmd_script (script=0x7fffffffc7b0) at builtin-script.c:2429
#22 cmd_script (argc=<optimized out>, argv=<optimized out>) at builtin-script.c:3770
#23 0x00000000004a65cb in run_builtin (p=p@entry=0x994918 <commands+408>, argc=argc@entry=4, argv=argv@entry=0x7fffffffe160) at perf.c:303
#24 0x000000000042da1e in handle_internal_command (argv=0x7fffffffe160, argc=4) at perf.c:355
#25 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:399
#26 main (argc=4, argv=0x7fffffffe160) at perf.c:521

jirka
