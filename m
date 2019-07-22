Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6443BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD4521985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbfGVWWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGVWWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:22:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1DCC308421A;
        Mon, 22 Jul 2019 22:22:15 +0000 (UTC)
Received: from krava (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id AF977600C4;
        Mon, 22 Jul 2019 22:22:12 +0000 (UTC)
Date:   Tue, 23 Jul 2019 00:22:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 39/79] libperf: Add perf_evlist__add function
Message-ID: <20190722222211.GB1152@krava>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-40-jolsa@kernel.org>
 <20190722190935.GU3624@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722190935.GU3624@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 22 Jul 2019 22:22:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:09:35PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> 
> Right after applying this patch my alias for building perf crashes:
> 
> I.e. I have:
> 
> alias m='perf stat -e cycles:u,instructions:u make -k O=/tmp/build/perf  -C tools/perf install-bin'
> 
> And I'm applyin your series patch by patch, it stopped working when I
> tried to build the next patch in this series, as the previous one caused
> the segfault below, investigating...
> 
> (gdb) run stat sleep 1
> Starting program: /root/bin/perf stat sleep 1
> Missing separate debuginfos, use: dnf debuginfo-install glibc-2.29-15.fc30.x86_64
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00000000004f6b55 in __perf_evlist__propagate_maps (evlist=0xbb34c0, evsel=0x0) at util/evlist.c:161
> 161		if (!evsel->own_cpus || evlist->has_user_cpus) {
> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-29.fc30.x86_64 elfutils-libelf-0.176-3.fc30.x86_64 elfutils-libs-0.176-3.fc30.x86_64 glib2-2.60.4-1.fc30.x86_64 libbabeltrace-1.5.6-2.fc30.x86_64 libgcc-9.1.1-1.fc30.x86_64 libunwind-1.3.1-2.fc30.x86_64 libuuid-2.33.2-1.fc30.x86_64 libxcrypt-4.4.6-2.fc30.x86_64 libzstd-1.4.0-1.fc30.x86_64 numactl-libs-2.0.12-2.fc30.x86_64 pcre-8.43-2.fc30.x86_64 perl-libs-5.28.2-436.fc30.x86_64 popt-1.16-17.fc30.x86_64 python2-libs-2.7.16-2.fc30.x86_64 slang-2.3.2-5.fc30.x86_64 xz-libs-5.2.4-5.fc30.x86_64 zlib-1.2.11-15.fc30.x86_64
> (gdb) p evsel
> $1 = (struct evsel *) 0x0
> (gdb) p evlist
> $2 = (struct evlist *) 0xbb34c0
> (gdb) bt
> #0  0x00000000004f6b55 in __perf_evlist__propagate_maps (evlist=0xbb34c0, evsel=0x0) at util/evlist.c:161
> #1  0x00000000004f6c7a in perf_evlist__propagate_maps (evlist=0xbb34c0) at util/evlist.c:178
> #2  0x00000000004f955e in perf_evlist__set_maps (evlist=0xbb34c0, cpus=0x0, threads=0x0) at util/evlist.c:1128
> #3  0x00000000004f66f8 in evlist__init (evlist=0xbb34c0, cpus=0x0, threads=0x0) at util/evlist.c:52
> #4  0x00000000004f6790 in evlist__new () at util/evlist.c:64
> #5  0x0000000000456071 in cmd_stat (argc=3, argv=0x7fffffffd670) at builtin-stat.c:1705
> #6  0x00000000004dd0fa in run_builtin (p=0xa21e00 <commands+288>, argc=3, argv=0x7fffffffd670) at perf.c:304
> #7  0x00000000004dd367 in handle_internal_command (argc=3, argv=0x7fffffffd670) at perf.c:356
> #8  0x00000000004dd4ae in run_argv (argcp=0x7fffffffd4cc, argv=0x7fffffffd4c0) at perf.c:400
> #9  0x00000000004dd81a in main (argc=3, argv=0x7fffffffd670) at perf.c:522
> (gdb)

hum, with the previous fix of yours applied I dont see this crash

jirka
