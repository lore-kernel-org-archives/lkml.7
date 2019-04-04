Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251E3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E992B206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfDDRiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:38:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfDDRiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:38:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 723BA3167E50;
        Thu,  4 Apr 2019 17:38:08 +0000 (UTC)
Received: from krava (unknown [10.40.205.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id EB4631001E9A;
        Thu,  4 Apr 2019 17:38:05 +0000 (UTC)
Date:   Thu, 4 Apr 2019 19:38:04 +0200
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
Message-ID: <20190404173804.GB16733@krava>
References: <20190403145353.GE32553@kernel.org>
 <20190403151548.GF32553@kernel.org>
 <B07CAAC3-D085-443D-BB0C-05E9A8F3AFB2@fb.com>
 <20190403185053.GH32553@kernel.org>
 <124332A9-146A-446F-A82A-910C8319170E@fb.com>
 <425141B8-8908-4D48-90FD-8806BA9E9E12@fb.com>
 <A476B82A-4550-45F1-9A31-B1AA63C07489@fb.com>
 <20190404091438.GB31233@krava>
 <20190404122530.GC31233@krava>
 <678C87FF-A33E-477C-94C1-533026400B95@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678C87FF-A33E-477C-94C1-533026400B95@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 04 Apr 2019 17:38:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 05:08:55PM +0000, Song Liu wrote:
> 
> 
> > On Apr 4, 2019, at 5:25 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Thu, Apr 04, 2019 at 11:14:38AM +0200, Jiri Olsa wrote:
> > 
> > SNIP
> > 
> >> Program received signal SIGABRT, Aborted.
> >> 0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
> >> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-29.fc30.x86_64 elfutils-libelf-0.176-1.fc30.x86_64 elfutils-libs-0.176-1.fc30.x86_64 libgcc-9.0.1-0.10.fc30.x86_64 libunwind-1.3.1-2.fc30.x86_64 libxcrypt-4.4.4-2.fc30.x86_64 numactl-libs-2.0.12-2.fc30.x86_64 perl-libs-5.28.1-434.fc30.x86_64 python2-libs-2.7.16-1.fc30.x86_64 slang-2.3.2-5.fc30.x86_64 xz-libs-5.2.4-5.fc30.x86_64 zlib-1.2.11-15.fc30.x86_64
> >> (gdb) bt
> >> #0  0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
> >> #1  0x00007ffff75d0895 in abort () from /lib64/libc.so.6
> >> #2  0x00007ffff75d0769 in __assert_fail_base.cold () from /lib64/libc.so.6
> >> #3  0x00007ffff75de596 in __assert_fail () from /lib64/libc.so.6
> >> #4  0x00000000004fc006 in refcount_sub_and_test (i=1, r=0x1224e88) at /home/jolsa/linux/tools/include/linux/refcount.h:131
> >> #5  refcount_dec_and_test (r=0x1224e88) at /home/jolsa/linux/tools/include/linux/refcount.h:148
> >> #6  map__put (map=0x1224df0) at util/map.c:299
> >> #7  0x00000000004fdb95 in __maps__remove (map=0x1224df0, maps=0xb17d80) at util/map.c:953
> >> #8  maps__remove (maps=0xb17d80, map=0x1224df0) at util/map.c:959
> >> #9  0x00000000004f7d8a in map_groups__remove (map=<optimized out>, mg=<optimized out>) at util/map_groups.h:65
> >> #10 machine__process_ksymbol_unregister (sample=<optimized out>, event=0x7ffff7279670, machine=<optimized out>) at util/machine.c:728
> >> #11 machine__process_ksymbol (machine=<optimized out>, event=0x7ffff7279670, sample=<optimized out>) at util/machine.c:741
> >> #12 0x00000000004fffbb in perf_session__deliver_event (session=0xb11390, event=0x7ffff7279670, tool=0x7fffffffc7b0, file_offset=13936) at util/session.c:1362
> >> #13 0x00000000005039bb in do_flush (show_progress=false, oe=0xb17e80) at util/ordered-events.c:243
> >> #14 __ordered_events__flush (oe=0xb17e80, how=OE_FLUSH__ROUND, timestamp=<optimized out>) at util/ordered-events.c:322
> >> #15 0x00000000005005e4 in perf_session__process_user_event (session=session@entry=0xb11390, event=event@entry=0x7ffff72a4af8,
> >>    file_offset=file_offset@entry=191224) at util/session.c:1402
> >> #16 0x000000000050091e in perf_session__process_event (file_offset=191224, event=0x7ffff72a4af8, session=0xb11390) at util/session.c:1529
> >> #17 process_simple (session=session@entry=0xb11390, event=event@entry=0x7ffff72a4af8, file_offset=file_offset@entry=191224) at util/session.c:1962
> >> #18 0x0000000000501f44 in reader__process_events (prog=0x7fffffffc680, session=0xb11390, rd=<synthetic pointer>) at util/session.c:1931
> >> #19 __perf_session__process_events (session=0xb11390) at util/session.c:1985
> >> #20 perf_session__process_events (session=0xb11390) at util/session.c:2018
> >> #21 0x000000000045bb42 in __cmd_script (script=0x7fffffffc7b0) at builtin-script.c:2429
> >> #22 cmd_script (argc=<optimized out>, argv=<optimized out>) at builtin-script.c:3770
> >> #23 0x00000000004a65cb in run_builtin (p=p@entry=0x994918 <commands+408>, argc=argc@entry=4, argv=argv@entry=0x7fffffffe160) at perf.c:303
> >> #24 0x000000000042da1e in handle_internal_command (argv=0x7fffffffe160, argc=4) at perf.c:355
> >> #25 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:399
> >> #26 main (argc=4, argv=0x7fffffffe160) at perf.c:521
> > 
> 
> For some reason, I cannot repro this issue. I tried to load two
> bpf programs with same name, but that doesn't trigger it either. 

for some reason I see multiple same name of bpf programs
on my setup.. need to check for the reason

> 
> 
> > 
> > we dont increase the map's reference for same name,
> > which we need to.. I assume we we re able to hit this
> > path with bpf maps/dso with same name
> > 
> > jirka
> 
> Does the following change fix the issue on your side?

yes, I'll post full patch later

jirka
