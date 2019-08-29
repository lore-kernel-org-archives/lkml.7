Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22383C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49272342D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089599;
	bh=TochmD8e7qzqFLR0WCPOK49a7FZE2iB3hCnR623HysY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6IT46P9ag6wWTlAuLATOlh5FOgP0hLSACUg95NZEy1Dv4LJf+m8iv1ZySjTS7CWM
	 OJErcqRvkY3ttGaOAG6H7OhmjwgHpJGo85uDpHuwMlz1RbFCHoYr4vi9853r3/fgMt
	 fvUmSsd05P8rN+lVgO5953txdotliUZBpM5nOcpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfH2Oj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfH2Oj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:39:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AAB823426;
        Thu, 29 Aug 2019 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089594;
        bh=TochmD8e7qzqFLR0WCPOK49a7FZE2iB3hCnR623HysY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHb+YqYZ+60lmJgO25DJPhW/tocErLs2GmdmguqP7VVgb2yoVFm+Ss3H7x/sALLOf
         4/FlmUVMLsyMTmZaJq6ZCFYOXs6mC4rr04+wn1Th2vyA/im/MpAi1GA8o2LIcpdf0g
         4E53zwssAc8nYmeeHwqANZEajFDENHhKw7gz1dOQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Igor Lubashev <ilubashe@akamai.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/37] perf evsel: Kernel profiling is disallowed only when perf_event_paranoid > 1
Date:   Thu, 29 Aug 2019 11:38:44 -0300
Message-Id: <20190829143917.29745-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Lubashev <ilubashe@akamai.com>

Perf was too restrictive about sysctl kernel.perf_event_paranoid. The
kernel only disallows profiling when perf_event_paranoid > 1. Make perf
do the same.

Committer testing:

For a non-root user:

  $ id
  uid=1000(acme) gid=1000(acme) groups=1000(acme),10(wheel) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
  $

Before:

We were restricting it to just userspace (:u suffix) even for a
workload started by the user:

  $ perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (8 samples) ]
  $ perf evlist
  cycles:u
  $ perf evlist -v
  cycles:u: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
  $ perf report --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  # Total Lost Samples: 0
  #
  # Samples: 8  of event 'cycles:u'
  # Event count (approx.): 1040396
  #
  # Overhead  Command  Shared Object     Symbol
  # ........  .......  ................  ......................
  #
      68.36%  sleep    libc-2.29.so      [.] _dl_addr
      27.33%  sleep    ld-2.29.so        [.] dl_main
       3.80%  sleep    ld-2.29.so        [.] _dl_setup_hash
  #
  # (Tip: Order by the overhead of source file name and line number: perf report -s srcline)
  #
  $
  $

After:

When the kernel allows profiling the kernel in that scenario:

  $ perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.023 MB perf.data (11 samples) ]
  $ perf evlist
  cycles
  $ perf evlist -v
  cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
  $
  $ perf report --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  # Total Lost Samples: 0
  #
  # Samples: 11  of event 'cycles'
  # Event count (approx.): 1601964
  #
  # Overhead  Command  Shared Object     Symbol
  # ........  .......  ................  ..........................
  #
      28.14%  sleep    [kernel.vmlinux]  [k] __rb_erase_color
      27.21%  sleep    [kernel.vmlinux]  [k] unmap_page_range
      27.20%  sleep    ld-2.29.so        [.] __tunable_get_val
      15.24%  sleep    [kernel.vmlinux]  [k] thp_get_unmapped_area
       1.96%  perf     [kernel.vmlinux]  [k] perf_event_exec
       0.22%  perf     [kernel.vmlinux]  [k] native_sched_clock
       0.02%  perf     [kernel.vmlinux]  [k] intel_bts_enable_local
       0.00%  perf     [kernel.vmlinux]  [k] native_write_msr
  #
  # (Tip: Boolean options have negative forms, e.g.: perf report --no-children)
  #
  $

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1566869956-7154-4-git-send-email-ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7c704b8f0e5c..d4540bfe4574 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -282,7 +282,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 
 static bool perf_event_can_profile_kernel(void)
 {
-	return perf_event_paranoid_check(-1);
+	return perf_event_paranoid_check(1);
 }
 
 struct evsel *perf_evsel__new_cycles(bool precise)
-- 
2.21.0

