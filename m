Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB22C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52842070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfH0NoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:44:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfH0NoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:44:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6C708980E4;
        Tue, 27 Aug 2019 13:44:09 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-23.phx2.redhat.com [10.3.112.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6731F19D7A;
        Tue, 27 Aug 2019 13:44:08 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 6DEC012E; Tue, 27 Aug 2019 10:44:04 -0300 (BRT)
Date:   Tue, 27 Aug 2019 10:44:04 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] perf util: kernel profiling is disallowed only when
 perf_event_paranoid > 1
Message-ID: <20190827134404.GB8761@redhat.com>
References: <1566869956-7154-1-git-send-email-ilubashe@akamai.com>
 <1566869956-7154-4-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566869956-7154-4-git-send-email-ilubashe@akamai.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 27 Aug 2019 13:44:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 26, 2019 at 09:39:14PM -0400, Igor Lubashev escreveu:
> Perf was too restrictive about sysctl kernel.perf_event_paranoid. The
> kernel only disallows profiling when perf_event_paranoid > 1. Make perf do
> the same.

Thanks for following up on this, I added these notes to this cset commit
log message:

--------------------------------- 8< ------------------------------------

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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1566869956-7154-4-git-send-email-ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Author:    Igor Lubashev <ilubashe@akamai.com>
# Date:      Mon Aug 26 21:39:14 2019 -0400
#
# On branch perf/core
# Changes to be committed:
#	modified:   tools/perf/util/evsel.c
#
# Untracked files:
#	a
#	a.c
#	bla
#	f_mode
#	perf.data
#	perf.data.old
#	q
#
# ------------------------ >8 ------------------------
# Do not modify or remove the line above.
# Everything below it will be ignored.
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
