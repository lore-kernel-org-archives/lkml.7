Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42959C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A53214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfCLNM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:12:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36947 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfCLNM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:12:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E2D3C05FBC5;
        Tue, 12 Mar 2019 13:12:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id EAA6C648C2;
        Tue, 12 Mar 2019 13:12:51 +0000 (UTC)
Date:   Tue, 12 Mar 2019 14:12:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 00/15] perf annotation of BPF programs
Message-ID: <20190312131251.GC3034@krava>
References: <20190312053051.2690567-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312053051.2690567-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 12 Mar 2019 13:12:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:30:36PM -0700, Song Liu wrote:
> Changes v8 to v9:
> 1. Rebase on top of torvalds/master:
>     commit ea295481b6e313b4ea3ca2720ffcafd6005b5643 ;
> 2. Change perf-record option --bpf-event to --no-bpf-event.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks for bearing with me ;-)

jirka


> 
> Changes v7 to v8:
> 1. Address issues suggested by Jiri and Stanislav.
> 
> Changes v6 to v7:
> 1. Fix minor issues suggested by Jiri.
> 
> Changes v5 to v6:
> 1. Improve side band evlist interface;
> 2. Minor style fixes.
> 
> Changes v4 to v5:
> 1. Rebase to latest bpf-next;
> 2. Add dependency of 94816add0005 from Arnaldo's tree;
> 3. More details in change logs;
> 4. Add perf_env__init() to init bpf related lock and rbtrees;
> 5. Small clean ups.
> 
> Changes v3 to v4:
> 1. Incorporate feedbacks from Jiri and Namhyung;
> 2. Fixed compilation error with different feature-disassembler-four-args;
> 3. Split some patches to smaller patches;
> 4. Improved error handleing in symbol__disassemble_bpf();
> 5. Made side band thread more generic;
> 6. Added comments as suggested.
> 
> Changes v2 to v3:
> 1. Remove unnecessary include in header files;
> 2. Improved error handling;
> 3. Better naming of functions, variables, etc.;
> 4. Enable bpf events by default for perf-top.
> 
> Changes v1 to v2:
> 1. Fix compilation error with different feature-disassembler-four-args;
> 2. Fix a segfault in perf-record;
> 3. Split patches 5/9 and 6/9 so that perf_env changes and perf.data changes
>    are in separate patches.
> 
> This series enables annotation of BPF programs in perf.
> 
> perf tool gathers information via sys_bpf and (optionally) stores them in
> perf.data as headers.
> 
> Patch 1/15 changes --bpf-event option to --no-bpf-event;
> Patch 2/15 to 4/15 introduce new helper functions and use them in perf and
>      bpftool;
> Patch 5/15 to 9/15 saves information of bpf program in perf_env;
> Patch 10/15 adds --bpf-event options to perf-top;
> Patch 11/15 to 13/15 enables annotation of bpf progs based on information
>      gathered in 5/15 to 9/15;
> Patch 14/15 introduces side band polling thread that gathers information
>      for special kernel events during perf-record or perf-top.
> Patch 15/15 handles information of short living BPF program using the new
>      side band polling thread.
> 
> Commands tested during developments are perf-top, perf-record, perf-report,
> and perf-annotate.
> 
> This set is also available at:
> 
> https://github.com/liu-song-6/linux/tree/bpf-annotation-v9
> 
> Thanks!!
> 
> Song Liu (15):
>   perf-record: replace option --bpf-event with --no-bpf-event
>   bpf: libbpf: introduce bpf_program__get_prog_info_linear()
>   bpf: bpftool: use bpf_program__get_prog_info_linear() in
>     prog.c:do_dump()
>   perf, bpf: synthesize bpf events with
>     bpf_program__get_prog_info_linear()
>   perf: change prototype of perf_event__synthesize_bpf_events()
>   perf, bpf: save bpf_prog_info in a rbtree in perf_env
>   perf, bpf: save bpf_prog_info information as headers to perf.data
>   perf, bpf: save btf in a rbtree in perf_env
>   perf, bpf: save btf information as headers to perf.data
>   perf-top: add option --no-bpf-event
>   perf: add -lopcodes to feature-libbfd
>   perf, bpf: enable annotation of bpf program
>   perf, bpf: process PERF_BPF_EVENT_PROG_LOAD for annotation
>   perf: introduce side band thread
>   perf, bpf: save bpf_prog_info and btf of short living bpf programs
> 
>  tools/bpf/bpftool/prog.c     | 266 +++++++---------------------
>  tools/build/Makefile.feature |   6 +-
>  tools/lib/bpf/libbpf.c       | 251 ++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h       |  63 +++++++
>  tools/lib/bpf/libbpf.map     |   3 +
>  tools/perf/Makefile.config   |  10 +-
>  tools/perf/builtin-record.c  |  11 +-
>  tools/perf/builtin-top.c     |  10 +-
>  tools/perf/perf.c            |   1 +
>  tools/perf/perf.h            |   2 +-
>  tools/perf/util/annotate.c   | 150 +++++++++++++++-
>  tools/perf/util/bpf-event.c  | 330 ++++++++++++++++++++++++++---------
>  tools/perf/util/bpf-event.h  |  33 +++-
>  tools/perf/util/dso.c        |   1 +
>  tools/perf/util/dso.h        |  32 ++--
>  tools/perf/util/env.c        | 151 ++++++++++++++++
>  tools/perf/util/env.h        |  24 +++
>  tools/perf/util/evlist.c     | 119 +++++++++++++
>  tools/perf/util/evlist.h     |  12 ++
>  tools/perf/util/evsel.c      |   2 +-
>  tools/perf/util/evsel.h      |   6 +
>  tools/perf/util/header.c     | 238 ++++++++++++++++++++++++-
>  tools/perf/util/header.h     |   2 +
>  tools/perf/util/session.c    |   1 +
>  tools/perf/util/symbol.c     |   1 +
>  25 files changed, 1409 insertions(+), 316 deletions(-)
> 
> --
> 2.17.1
