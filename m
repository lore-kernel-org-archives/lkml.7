Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BE9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCFD22CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfH2TCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:02:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51476 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfH2TCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3Pg3-00051f-S7; Thu, 29 Aug 2019 21:01:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5DB431C0DE6;
        Thu, 29 Aug 2019 21:01:47 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:47 -0000
From:   "tip-bot2 for Igor Lubashev" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Kernel profiling is disallowed only when
 perf_event_paranoid > 1
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1566869956-7154-4-git-send-email-ilubashe@akamai.com>
References: <1566869956-7154-4-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Message-ID: <156710530726.10517.14742815139500868393.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     aa97293ff129f504e7c8589e56007ecfe3e3e835
Gitweb:        https://git.kernel.org/tip/aa97293ff129f504e7c8589e56007ecfe3e3e835
Author:        Igor Lubashev <ilubashe@akamai.com>
AuthorDate:    Mon, 26 Aug 2019 21:39:14 -04:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 28 Aug 2019 17:19:05 -03:00

perf evsel: Kernel profiling is disallowed only when perf_event_paranoid > 1

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
index 7c704b8..d4540bf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -282,7 +282,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 
 static bool perf_event_can_profile_kernel(void)
 {
-	return perf_event_paranoid_check(-1);
+	return perf_event_paranoid_check(1);
 }
 
 struct evsel *perf_evsel__new_cycles(bool precise)
