Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8004ECA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BD921783
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665130;
	bh=h54UrCeTyAZNpYI4zfzYG/EmOT3ZDn//g6SUVu6FPyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e6rJ1ge2zrasat/rX2lscSC1pcluu/H39Fm0WytSilPf0DaosXj+OQZt5xWnN5e1l
	 uH5yJjdr/xehpnWaI2dZkvB6KGeijjo9C1MPkMkhjGYl+OIE4j38vIwARQElsDRPdp
	 yYpw5vQD8pRWvbMI+2AnpNTfDKDc3HT1LUzjj2kQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfJUNit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfJUNis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:38:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A52A20873;
        Mon, 21 Oct 2019 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665126;
        bh=h54UrCeTyAZNpYI4zfzYG/EmOT3ZDn//g6SUVu6FPyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbWDGlfoq6vnQ8QCycV7siX24oo4u9ITaKM/vVGZ6fD6cYtNpthR2cL60IuqU932q
         sG/fiCGYjnyKVs3oODQdTkp4rEBz1bK+ISEmVPBCy7nb327z4uhGNsK2QYt1MWVvw+
         tii1cMYh1y3SF6akLxVT3C20dvp+5Q4MHjHQIn4M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 01/57] perf tools: Allow to build with -ltcmalloc
Date:   Mon, 21 Oct 2019 10:37:38 -0300
Message-Id: <20191021133834.25998-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
index 063202c53b64..1783427da9b0 100644
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
index a099a8a89447..8f1ba986d3bf 100644
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
-- 
2.21.0

