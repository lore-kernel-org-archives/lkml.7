Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D97C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9BA218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQQfbMt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCPIGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:06:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40304 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfCPIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:06:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id y124so7903235pfy.7;
        Sat, 16 Mar 2019 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ha/i8rYzGwGm+ewBPjtdzX3l0vL0qvUcZXJSCRU5t+8=;
        b=LQQfbMt0hs9eFMe6p/pdNrtAva1A7ywAd0VOZXyxUscK5ppd1G98PrL9yV2pGFDVy/
         n6hqrQD2icuq98D3os6zXOlGqB+SeG909TJ+eDSayGTbtLA2EX5Tt4IDFQ6cST9GUhSK
         2LKkyNl8J/GphCPmFBoxjeXjC4aC2G7he/oQry1xwF5v2cFt8J25RRRSSCc9MiDzW72g
         CdTl1FITOo9j17mbZnSQMPa7u0izDjgeYHexU+znsseg1UKvKdqd5PJ77la7ITNxe5II
         4XjCPUK6U4vta6VVcFFfYT8forz69SerXK7ySoFRHfyWs1qiI5yRoeCYxUGYJyhFMn2/
         04Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ha/i8rYzGwGm+ewBPjtdzX3l0vL0qvUcZXJSCRU5t+8=;
        b=RAKpKy6IgvW1fvQ6KfjCJ0BcY/4MTv0K1RHMbaczjmBceAnbrBO2pFvbXYEDZig3Ev
         AJejKLA6Xs+aeHR2+q5nRoubUSaAe10QStI5BewQ9kOYYwO3nNsObefbJ/WPf6yFFwsT
         4wVVAIxSvjfsl2JJb93sEQ0qlpDq7tC7YwDv0Apo+NIA62HH+L3vVMWI5oPNQFPQv/tn
         busutzDbYaQiFxRwFtUl8mhEtp30pXLiq82GaWMJKvPbNC08tRzWiYNFbCxt1iNI0ABC
         aI0OiYA3u5NdNHpvz4DWLZ56wCYv2mDOOyloa1CGkhfzYoBt46PXtpv8N9bvsazM/vM0
         KAwg==
X-Gm-Message-State: APjAAAWeH1cI9kqbvUOxSIut5CpVjjAk4SXEbH2F3MFei9+ffrfEku3E
        PG6Ob/CW7ZhGj95oiig9ew4=
X-Google-Smtp-Source: APXvYqxzZRb9jvGpUQUmytWcBlStBJBKj+58iSg2kFR4P4l2rtupaef7xl7aQtro02gerreD6aaJcQ==
X-Received: by 2002:a63:6881:: with SMTP id d123mr7486070pgc.10.1552723576432;
        Sat, 16 Mar 2019 01:06:16 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:06:15 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 00/16] fix some perf issues detected by ASan
Date:   Sat, 16 Mar 2019 16:05:40 +0800
Message-Id: <20190316080556.3075-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
very useful tools to detect program bugs. This series fixed some issues
disclosed by ASan.

AddressSanitizer (or ASan) is a GCC feature that detects memory corruption bugs
such as buffer overflows or memory leaks.
  $ cd tools/perf
  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
  $ ASAN_OPTIONS=log_path=asan.log ./perf record -a
ASan outputs all detected issues into log file 'asan.log.<pid>'.

Note that this only fixes parts of the detected issues. There are many remaining
to be fixed[1].

[1] http://104.238.181.70:8080/asan.log.32555.txt

Changbin Du (16):
  perf: add doc for how to build perf with Asan and UBSan
  perf: list: fix memory leak in function is_event_supported
  perf: fix errors under optimization level '-Og'
  perf: fix an error in config template
  perf: fix a memory leak in collect_config
  perf: fix memory leak in print_sdt_events()
  perf: top: fix heap-use-after-free issue
  perf: top: fix error handing in cmd_top()
  perf: missed a map__put() in error case
  perf: remove map from names tree in __maps__remove
  perf: purge all maps from the names tree
  perf: top: fix global-buffer-overflow issue
  perf: free all counts in perf_evsel__exit
  perf: fix a memory leak of cpu_map object
  perf: fix memory leak by expr__find_other
  perf: fix a memory leak in test__perf_evsel__tp_sched_test

 tools/lib/bpf/libbpf.c                     |  2 +-
 tools/perf/Documentation/Build.txt         | 20 +++++++++
 tools/perf/Documentation/perf-config.txt   |  2 +-
 tools/perf/bench/epoll-ctl.c               |  2 +-
 tools/perf/bench/epoll-wait.c              |  2 +-
 tools/perf/builtin-top.c                   | 47 ++++++++++------------
 tools/perf/tests/backward-ring-buffer.c    |  2 +-
 tools/perf/tests/evsel-tp-sched.c          |  1 +
 tools/perf/tests/expr.c                    |  5 ++-
 tools/perf/tests/openat-syscall-all-cpus.c |  4 +-
 tools/perf/util/build-id.c                 |  1 +
 tools/perf/util/config.c                   |  3 +-
 tools/perf/util/counts.c                   | 18 +++++++++
 tools/perf/util/counts.h                   |  4 ++
 tools/perf/util/evsel.c                    |  2 +
 tools/perf/util/hist.c                     |  4 +-
 tools/perf/util/map.c                      | 18 +++++++++
 tools/perf/util/ordered-events.c           |  2 +
 tools/perf/util/parse-events.c             |  2 +
 tools/perf/util/stat.c                     | 18 ---------
 20 files changed, 106 insertions(+), 53 deletions(-)

-- 
2.19.1

