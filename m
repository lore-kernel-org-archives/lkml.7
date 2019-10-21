Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14DDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918AC21A4A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfJVADn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:03:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfJVADl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:03:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxW-0004II-4L; Tue, 22 Oct 2019 01:19:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4071D1C04D4;
        Tue, 22 Oct 2019 01:19:21 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:20 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Allow to build with -ltcmalloc
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191013151427.11941-2-jolsa@kernel.org>
References: <20191013151427.11941-2-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157169996091.29376.4572878607006530735.tip-bot2@tip-bot2>
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

Commit-ID:     bb91a073ed124d3f6224d8ac37ecb536c01970c1
Gitweb:        https://git.kernel.org/tip/bb91a073ed124d3f6224d8ac37ecb536c01970c1
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 13 Oct 2019 17:14:25 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 08:36:22 -03:00

perf tools: Allow to build with -ltcmalloc

By using "make TCMALLOC=1" you can enable perf to be build for usage
with libtcmalloc.so (gperftools).

Get heap profile (tools/perf directory):

  $ <install gperftools>
  $ make TCMALLOC=1 DEBUG=1
  $ HEAPPROFILE=/tmp/heapprof ./perf ...
  $ pprof ./perf /tmp/heapprof.000*
  (pprof) top
  Total: 2335.5 MB
    1735.1  74.3%  74.3%   1735.1  74.3% memdup
     402.0  17.2%  91.5%    402.0  17.2% zalloc
     140.2   6.0%  97.5%    145.8   6.2% map__new
      33.6   1.4%  98.9%     33.6   1.4% symbol__new
      12.4   0.5%  99.5%     12.4   0.5% alloc_event
       6.2   0.3%  99.7%      6.2   0.3% nsinfo__new
       5.5   0.2% 100.0%      5.5   0.2% nsinfo__copy
       0.3   0.0% 100.0%      0.3   0.0% dso__new
       0.1   0.0% 100.0%      0.1   0.0% do_read_string
       0.0   0.0% 100.0%      0.0   0.0% __GI__IO_file_doallocate

See callstack:
  $ pprof --pdf ./perf /tmp/heapprof.00* > callstack.pdf
  $ pprof --web ./perf /tmp/heapprof.00*

Committer testing:

Install gperftools, on fedora:

  # dnf install gperftools-devel

Then build:

 $ make TCMALLOC=1 DEBUG=1 -C tools/perf O=/tmp/build/perf install-bin

Verify that it linked against the right library:

  $ ldd ~/bin/perf | grep tcma
	libtcmalloc.so.4 => /lib64/libtcmalloc.so.4 (0x00007fb2953a7000)
  $

Run 'perf trace' system wide for 1 minute:

  # HEAPPROFILE=/tmp/heapprof perf trace -a sleep 1m
  <SNIP>
   59985.524 ( 0.006 ms): Web Content/20354 recvmsg(fd: 9<socket:[1762817]>, msg: 0x7ffee5fdafb0) = -1 EAGAIN (Resource temporarily unavailable)
   59985.536 ( 0.005 ms): Web Content/20354 recvmsg(fd: 9<socket:[1762817]>, msg: 0x7ffee5fdafc0) = -1 EAGAIN (Resource temporarily unavailable)
   59981.956 (10.143 ms): SCTP timer/21716  ... [continued]: select())                            = 0 (Timeout)
   59985.549 (         ): Web Content/20354 poll(ufds: 0x7f1df38af180, nfds: 3, timeout_msecs: 4294967295) ...
       0.926 (59999.481 ms): sleep/29764  ... [continued]: nanosleep())                           = 0
   59992.133 (         ): SCTP timer/21716 select(tvp: 0x7ff5bf7fee80)                            ...
   60000.477 ( 0.009 ms): sleep/29764 close(fd: 1)                                                = 0
   60000.493 ( 0.005 ms): sleep/29764 close(fd: 2)                                                = 0
   60000.514 (         ): sleep/29764 exit_group()                                                = ?
  Dumping heap profile to /tmp/heapprof.0001.heap (Exiting, 3 MB in use)
[root@quaco ~]#

Install pprof:

  # dnf install pprof

And run it:

  # pprof ~/bin/perf /tmp/heapprof.0001.heap
  Using local file /root/bin/perf.
  Using local file /tmp/heapprof.0001.heap.
  Welcome to pprof!  For help, type 'help'.
  (pprof) top
  Total: 4.0 MB
       1.7  42.0%  42.0%      2.2  54.1% map__new
       0.9  23.3%  65.3%      0.9  23.3% zalloc
       0.5  11.4%  76.7%      0.5  11.4% dso__new
       0.2   5.6%  82.3%      0.3   8.5% trace__sys_enter
       0.2   4.9%  87.2%      0.2   4.9% __GI___strdup
       0.2   3.8%  91.0%      0.2   3.8% new_term
       0.1   2.2%  93.2%      0.4  10.1% __perf_pmu__new_alias
       0.0   1.0%  94.3%      0.0   1.2% event_read_fields
       0.0   0.8%  95.1%      0.0   0.8% nsinfo__new
       0.0   0.7%  95.8%      0.1   3.2% trace__read_syscall_info
  (pprof)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191013151427.11941-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 5 +++++
 tools/perf/Makefile.perf   | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 063202c..1783427 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -265,6 +265,11 @@ LDFLAGS += -Wl,-z,noexecstack
 
 EXTLIBS = -lpthread -lrt -lm -ldl
 
+ifneq ($(TCMALLOC),)
+  CFLAGS += -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free
+  EXTLIBS += -ltcmalloc
+endif
+
 ifeq ($(FEATURES_DUMP),)
 include $(srctree)/tools/build/Makefile.feature
 else
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a099a8a..8f1ba98 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -114,6 +114,8 @@ include ../scripts/utilities.mak
 # Define NO_LIBZSTD if you do not want support of Zstandard based runtime
 # trace compression in record mode.
 #
+# Define TCMALLOC to enable tcmalloc heap profiling.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
