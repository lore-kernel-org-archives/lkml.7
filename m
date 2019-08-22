Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BFCC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DE022CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566472305;
	bh=19iZdFhsHC3kst2fKrbMNa2UgDq07taI/yF3mZqTuM8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tLcEmXlqt2WdG7Wg5LMAVeX9gOhD22xFnCe2M1EmO3hWi9MSstYSIg/My/zamK/zb
	 FdOB6I5o0qZbGj7Z6aRMiAJ9DQ7Kj3ut4fWoyWdrnOjSN+/btUzWj3uOvIQ/UfLr/A
	 iqjTUYe78CfPKUmEz5ueQeGEL36fHk+oMLACodM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbfHVLLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:11:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388071AbfHVLLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:11:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE2D08AC6FB;
        Thu, 22 Aug 2019 11:11:43 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02C251001B32;
        Thu, 22 Aug 2019 11:11:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 0/5] tools,libperf: Assorted fixes
Date:   Thu, 22 Aug 2019 13:11:36 +0200
Message-Id: <20190822111141.25823-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Thu, 22 Aug 2019 11:11:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending fixes for tools and libperf.

thanks,
jirka


---
Jiri Olsa (5):
      tools: Add missing perf_event.h include
      libperf: Use perf_cpu_map__nr instead of cpu_map__nr
      libperf: Move cpu_map__empty to perf_cpu_map__empty
      libperf: Move cpu_map__idx to perf_cpu_map__idx
      libperf: Add perf_thread_map__nr/perf_thread_map__pid functions

 tools/include/linux/ring_buffer.h                      |  1 +
 tools/perf/arch/arm/util/cs-etm.c                      | 12 ++++++------
 tools/perf/arch/x86/util/intel-bts.c                   |  4 ++--
 tools/perf/arch/x86/util/intel-pt.c                    | 10 +++++-----
 tools/perf/builtin-c2c.c                               |  2 +-
 tools/perf/builtin-ftrace.c                            |  2 +-
 tools/perf/builtin-script.c                            |  4 ++--
 tools/perf/builtin-stat.c                              |  8 ++++----
 tools/perf/builtin-trace.c                             |  4 ++--
 tools/perf/lib/cpumap.c                                | 17 +++++++++++++++++
 tools/perf/lib/include/internal/cpumap.h               |  2 ++
 tools/perf/lib/include/perf/cpumap.h                   |  2 ++
 tools/perf/lib/include/perf/threadmap.h                |  2 ++
 tools/perf/lib/libperf.map                             |  3 +++
 tools/perf/lib/threadmap.c                             | 10 ++++++++++
 tools/perf/tests/thread-map.c                          |  6 +++---
 tools/perf/util/auxtrace.c                             |  4 ++--
 tools/perf/util/cpumap.c                               | 20 ++++----------------
 tools/perf/util/cpumap.h                               | 13 +------------
 tools/perf/util/event.c                                | 10 +++++-----
 tools/perf/util/evlist.c                               | 30 +++++++++++++++---------------
 tools/perf/util/evsel.c                                |  4 ++--
 tools/perf/util/mmap.c                                 |  2 +-
 tools/perf/util/record.c                               |  2 +-
 tools/perf/util/scripting-engines/trace-event-python.c |  2 +-
 tools/perf/util/stat-display.c                         |  6 +++---
 tools/perf/util/stat.c                                 |  6 +++---
 tools/perf/util/thread_map.c                           |  4 ++--
 tools/perf/util/thread_map.h                           | 10 ----------
 29 files changed, 103 insertions(+), 99 deletions(-)
