Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63769C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC472087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="k2uFbgh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfCKT4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:56:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48108 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728622AbfCKT4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BJrjMU025263
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:56:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=xxB3WvskLd3cg7Z8vVFEaTibMD+cpeDi88ixq69puvc=;
 b=k2uFbgh5DhtNyVOj8gKW0fbVWQGAzYg0FmRweV8K5amFCcONPBEI9bj5wZ94dneBoV/S
 +Dg3QmAZyKHoRn+Q9e7kXZh5ajxx7zTKPhwDbknnXPQgNH9AYfGNB72nRy6yG+fOj8w9
 Fh2s93KbOZAwlTXLva9ATLtkbFRchAH6AtE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5v488gxw-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:56:19 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 12:56:17 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id ACCFB62E1B7E; Mon, 11 Mar 2019 12:56:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v8 perf,bpf 00/15] perf annotation of BPF programs
Date:   Mon, 11 Mar 2019 12:55:40 -0700
Message-ID: <20190311195555.889995-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v7 to v8:
1. Address issues suggested by Jiri and Stanislav.

Changes v6 to v7:
1. Fix minor issues suggested by Jiri.

Changes v5 to v6:
1. Improve side band evlist interface;
2. Minor style fixes.

Changes v4 to v5:
1. Rebase to latest bpf-next;
2. Add dependency of 94816add0005 from Arnaldo's tree;
3. More details in change logs;
4. Add perf_env__init() to init bpf related lock and rbtrees;
5. Small clean ups.

Changes v3 to v4:
1. Incorporate feedbacks from Jiri and Namhyung;
2. Fixed compilation error with different feature-disassembler-four-args;
3. Split some patches to smaller patches;
4. Improved error handleing in symbol__disassemble_bpf();
5. Made side band thread more generic;
6. Added comments as suggested.

Changes v2 to v3:
1. Remove unnecessary include in header files;
2. Improved error handling;
3. Better naming of functions, variables, etc.;
4. Enable bpf events by default for perf-top.

Changes v1 to v2:
1. Fix compilation error with different feature-disassembler-four-args;
2. Fix a segfault in perf-record;
3. Split patches 5/9 and 6/9 so that perf_env changes and perf.data changes
   are in separate patches.

This series enables annotation of BPF programs in perf.

perf tool gathers information via sys_bpf and (optionally) stores them in
perf.data as headers.

Patch 1/15 fixes a minor issue in kernel;
Patch 2/15 to 4/15 introduce new helper functions and use them in perf and
     bpftool;
Patch 5/15 to 9/15 saves information of bpf program in perf_env;
Patch 10/15 adds --bpf-event options to perf-top;
Patch 11/15 to 13/15 enables annotation of bpf progs based on information
     gathered in 5/15 to 9/15;
Patch 14/15 introduces side band polling thread that gathers information
     for special kernel events during perf-record or perf-top.
Patch 15/15 handles information of short living BPF program using the new
     side band polling thread.

Commands tested during developments are perf-top, perf-record, perf-report,
and perf-annotate.

===================== Note on patch dependency  ========================
This set has dependency in both bpf-next tree and tip/perf/core. Current
version is developed on bpf-next tree with the following commits
cherry-picked from tip/perf/core (or acme/perf/core):

(from 1/11 to 11/11)
commit 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
commit d764ac646491 ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
commit 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
commit df063c83aa2c ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
commit 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
commit 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
commit 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
commit a40b95bcd30c ("perf top: Synthesize BPF events for pre-existing loaded BPF programs")
commit 6934058d9fb6 ("bpf: Add module name [bpf] to ksymbols for bpf programs")
commit 811184fb6977 ("perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT")
comimt 94816add0005 ("perf tools: Add perf_exe() helper to find perf binary")
========================================================================

This set is also available at:

https://github.com/liu-song-6/linux/tree/bpf-annotation

Thanks!!

Song Liu (15):
  perf, bpf: consider events with attr.bpf_event as side-band events
  bpf: libbpf: introduce bpf_program__get_prog_info_linear()
  bpf: bpftool: use bpf_program__get_prog_info_linear() in
    prog.c:do_dump()
  perf, bpf: synthesize bpf events with
    bpf_program__get_prog_info_linear()
  perf: change prototype of perf_event__synthesize_bpf_events()
  perf, bpf: save bpf_prog_info in a rbtree in perf_env
  perf, bpf: save bpf_prog_info information as headers to perf.data
  perf, bpf: save btf in a rbtree in perf_env
  perf, bpf: save btf information as headers to perf.data
  perf-top: add option --no-bpf-event
  perf: add -lopcodes to feature-libbfd
  perf, bpf: enable annotation of bpf program
  perf, bpf: process PERF_BPF_EVENT_PROG_LOAD for annotation
  perf: introduce side band thread
  perf, bpf: save bpf_prog_info and btf of short living bpf programs

 kernel/events/core.c         |   3 +-
 tools/bpf/bpftool/prog.c     | 266 +++++++---------------------
 tools/build/Makefile.feature |   6 +-
 tools/lib/bpf/libbpf.c       | 251 +++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h       |  63 +++++++
 tools/lib/bpf/libbpf.map     |   3 +
 tools/perf/Makefile.config   |  10 +-
 tools/perf/builtin-record.c  |   9 +-
 tools/perf/builtin-top.c     |  12 +-
 tools/perf/perf.c            |   1 +
 tools/perf/util/annotate.c   | 150 +++++++++++++++-
 tools/perf/util/bpf-event.c  | 327 ++++++++++++++++++++++++++---------
 tools/perf/util/bpf-event.h  |  33 +++-
 tools/perf/util/dso.c        |   1 +
 tools/perf/util/dso.h        |  33 ++--
 tools/perf/util/env.c        | 151 ++++++++++++++++
 tools/perf/util/env.h        |  24 +++
 tools/perf/util/evlist.c     | 119 +++++++++++++
 tools/perf/util/evlist.h     |  12 ++
 tools/perf/util/evsel.h      |   6 +
 tools/perf/util/header.c     | 241 +++++++++++++++++++++++++-
 tools/perf/util/header.h     |   2 +
 tools/perf/util/session.c    |   1 +
 tools/perf/util/symbol.c     |   1 +
 tools/perf/util/top.h        |   1 +
 25 files changed, 1413 insertions(+), 313 deletions(-)

--
2.17.1
