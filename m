Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EF0214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hAXquXTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfCLFa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:30:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57136 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbfCLFa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:30:58 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C5N2GY028701
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:30:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=upfBIjA0kNIbF6J4vlwNcA8+TUiRa80vcT3HjwmBI08=;
 b=hAXquXToYQ/aHdPpmkeU/HKFPTcBsG/DX8PAlqUjX5tDDtzP3Qkyvx/QptyPFDfIMhdU
 L2DKWuQ8rl97tQQ02/yUg8DyKRDe+9hYFuJhxNCnqlTEwxj1btHWy+nO38Llfi0Wj/tT
 uBk36d3+6FxOt8Lvps1Guoz8YJu7dnjCjfY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r62tvrryv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:30:56 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 22:30:55 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2BA5462E2019; Mon, 11 Mar 2019 22:30:55 -0700 (PDT)
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
Subject: [PATCH v9 perf,bpf 00/15] perf annotation of BPF programs
Date:   Mon, 11 Mar 2019 22:30:36 -0700
Message-ID: <20190312053051.2690567-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v8 to v9:
1. Rebase on top of torvalds/master:
    commit ea295481b6e313b4ea3ca2720ffcafd6005b5643 ;
2. Change perf-record option --bpf-event to --no-bpf-event.

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

Patch 1/15 changes --bpf-event option to --no-bpf-event;
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

This set is also available at:

https://github.com/liu-song-6/linux/tree/bpf-annotation-v9

Thanks!!

Song Liu (15):
  perf-record: replace option --bpf-event with --no-bpf-event
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

 tools/bpf/bpftool/prog.c     | 266 +++++++---------------------
 tools/build/Makefile.feature |   6 +-
 tools/lib/bpf/libbpf.c       | 251 ++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h       |  63 +++++++
 tools/lib/bpf/libbpf.map     |   3 +
 tools/perf/Makefile.config   |  10 +-
 tools/perf/builtin-record.c  |  11 +-
 tools/perf/builtin-top.c     |  10 +-
 tools/perf/perf.c            |   1 +
 tools/perf/perf.h            |   2 +-
 tools/perf/util/annotate.c   | 150 +++++++++++++++-
 tools/perf/util/bpf-event.c  | 330 ++++++++++++++++++++++++++---------
 tools/perf/util/bpf-event.h  |  33 +++-
 tools/perf/util/dso.c        |   1 +
 tools/perf/util/dso.h        |  32 ++--
 tools/perf/util/env.c        | 151 ++++++++++++++++
 tools/perf/util/env.h        |  24 +++
 tools/perf/util/evlist.c     | 119 +++++++++++++
 tools/perf/util/evlist.h     |  12 ++
 tools/perf/util/evsel.c      |   2 +-
 tools/perf/util/evsel.h      |   6 +
 tools/perf/util/header.c     | 238 ++++++++++++++++++++++++-
 tools/perf/util/header.h     |   2 +
 tools/perf/util/session.c    |   1 +
 tools/perf/util/symbol.c     |   1 +
 25 files changed, 1409 insertions(+), 316 deletions(-)

--
2.17.1
