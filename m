Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6726CC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F422133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MB2m26w1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfHPU7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:59:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:59:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKwqKW2960440
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:58:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKwqKW2960440
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565989133;
        bh=ilS4+94NnHnkQhl6aKtXvDjnsQvJbiSk1iI6W72350M=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=MB2m26w1spJ+8uE+r8/ljZG2DvH/m9xXWVTrWyAMtiT+wJ13AS9ArAyDb5pva3JyV
         9Bq6/SKdTmWwWJhFQAsygAPJ0D/D8JYtTE3Wg20hjR0XNsKJgMNzgJeLXBAFecQhEx
         O1EZsDN1cuCNx/4d6mbQaG08AqNEUjUwH8tbrXr031Ee8FydoigqgwG/dYUnuxuaHZ
         zGBAoUbH5Q8xaah/Fw2deA1CL/rKlJ95VrREp2FQldzinhsM312HzNouYh/OXca+zr
         ZEpMFZhmG7ZYY4kN9CsjHKaQ/x+GXDzyUPYY+B2QbAVeH+NT87j+dZxTS+Vnv7FjJI
         61I8CPkdcYXwQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKwqQh2960436;
        Fri, 16 Aug 2019 13:58:52 -0700
Date:   Fri, 16 Aug 2019 13:58:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-408hvumcnyn93a0auihnawew@git.kernel.org>
Cc:     fweimer@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
        hpa@zytor.com, wcohen@redhat.com, mingo@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
          hpa@zytor.com, wcohen@redhat.com, adrian.hunter@intel.com,
          fweimer@redhat.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Add --switch-on/--switch-off events
Git-Commit-ID: ef4b1a539f4b8776701752c5a09ee741a4232ae6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ef4b1a539f4b8776701752c5a09ee741a4232ae6
Gitweb:     https://git.kernel.org/tip/ef4b1a539f4b8776701752c5a09ee741a4232ae6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Aug 2019 18:18:58 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Aug 2019 12:14:33 -0300

perf report: Add --switch-on/--switch-off events

Since 'perf top' shares the histogram browser with 'perf report', then
the same explanation in the previous cset applies.

An additional example uses a pair of SDT events available for systemtap:

  # perf probe --exec=/usr/bin/stap '%*:*'
  Added new events:
    sdt_stap:benchmark__thread__start (on %* in /usr/bin/stap)
    sdt_stap:benchmark   (on %* in /usr/bin/stap)
    sdt_stap:benchmark__thread__end (on %* in /usr/bin/stap)
    sdt_stap:pass6__start (on %* in /usr/bin/stap)
    sdt_stap:pass6__end  (on %* in /usr/bin/stap)
    sdt_stap:pass5__start (on %* in /usr/bin/stap)
    sdt_stap:pass5__end  (on %* in /usr/bin/stap)
    sdt_stap:pass0__start (on %* in /usr/bin/stap)
    sdt_stap:pass0__end  (on %* in /usr/bin/stap)
    sdt_stap:pass1a__start (on %* in /usr/bin/stap)
    sdt_stap:pass1b__start (on %* in /usr/bin/stap)
    sdt_stap:pass1__end  (on %* in /usr/bin/stap)
    sdt_stap:pass2__start (on %* in /usr/bin/stap)
    sdt_stap:pass2__end  (on %* in /usr/bin/stap)
    sdt_stap:pass3__start (on %* in /usr/bin/stap)
    sdt_stap:pass3__end  (on %* in /usr/bin/stap)
    sdt_stap:pass4__start (on %* in /usr/bin/stap)
    sdt_stap:pass4__end  (on %* in /usr/bin/stap)
    sdt_stap:benchmark__start (on %* in /usr/bin/stap)
    sdt_stap:benchmark__end (on %* in /usr/bin/stap)
    sdt_stap:cache__get  (on %* in /usr/bin/stap)
    sdt_stap:cache__clean (on %* in /usr/bin/stap)
    sdt_stap:cache__add__module (on %* in /usr/bin/stap)
    sdt_stap:cache__add__source (on %* in /usr/bin/stap)
    sdt_stap:stap_system__complete (on %* in /usr/bin/stap)
    sdt_stap:stap_system__start (on %* in /usr/bin/stap)
    sdt_stap:stap_system__spawn (on %* in /usr/bin/stap)
    sdt_stap:stap_system__fork (on %* in /usr/bin/stap)
    sdt_stap:intern_string (on %* in /usr/bin/stap)
    sdt_stap:client__start (on %* in /usr/bin/stap)
    sdt_stap:client__end (on %* in /usr/bin/stap)

  You can now use it in all perf tools, such as:

  	perf record -e sdt_stap:client__end -aR sleep 1

  #

From these we're use the two below to run systemtap's test suite:

  # perf record -e sdt_stap:pass2__*,cycles:P make installcheck > /dev/null
  ^C[ perf record: Woken up 8 times to write data ]
  [ perf record: Captured and wrote 2.691 MB perf.data (39638 samples) ]
  Terminated
  # perf script | grep sdt_stap
              stap 28979 [000] 19424.302660: sdt_stap:pass2__start: (561b9a537de3) arg1=140730364262544
              stap 28979 [000] 19424.333083:   sdt_stap:pass2__end: (561b9a53a9e1) arg1=140730364262544
              stap 29045 [006] 19424.933460: sdt_stap:pass2__start: (563edddcede3) arg1=140722674883152
              stap 29045 [006] 19424.963794:   sdt_stap:pass2__end: (563edddd19e1) arg1=140722674883152
  # perf script | grep cycles |  wc -l
  39634
  #

Looking at the whole perf.data file:

  [root@quaco testsuite]# perf report | grep cycles:P -A25
  # Samples: 39K of event 'cycles:P'
  # Event count (approx.): 34044267368
  #
  # Overhead  Command  Shared Object         Symbol
  # ........  .......  ....................  ................................
  #
       3.50%  cc1      cc1                   [.] ht_lookup_with_hash
       3.04%  cc1      cc1                   [.] _cpp_lex_token
       2.11%  cc1      cc1                   [.] ggc_internal_alloc
       1.83%  cc1      cc1                   [.] cpp_get_token_with_location
       1.68%  cc1      libc-2.29.so          [.] _int_malloc
       1.41%  cc1      cc1                   [.] linemap_position_for_column
       1.25%  cc1      cc1                   [.] ggc_internal_cleared_alloc
       1.20%  cc1      cc1                   [.] c_lex_with_flags
       1.18%  cc1      cc1                   [.] get_combined_adhoc_loc
       1.05%  cc1      libc-2.29.so          [.] malloc
       1.01%  cc1      libc-2.29.so          [.] _int_free
       0.96%  stap     stap                  [.] std::_Hashtable<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, std::__detail::_Identity, std::equal_to<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, stringtable_hash, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, std::__detail::_Prime_rehash_policy, std::__detail::_Hashtable_traits<true, true, true> >::_M_insert<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::__detail::_AllocNode<std::allocator<std::__detail::_Hash_node<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, true> > > >
       0.78%  stap     stap                  [.] lexer::scan
       0.74%  cc1      cc1                   [.] _cpp_lex_direct
       0.70%  cc1      cc1                   [.] pop_scope
       0.70%  cc1      cc1                   [.] c_parser_declspecs
       0.69%  stap     libc-2.29.so          [.] _int_malloc
       0.68%  cc1      cc1                   [.] htab_find_slot
       0.68%  cc1      [kernel.vmlinux]      [k] prepare_exit_to_usermode
       0.64%  cc1      [kernel.vmlinux]      [k] clear_page_erms
  [root@quaco testsuite]#

And now only what happens in slices demarcated by those start/end SDT
events:

  [root@quaco testsuite]# perf report --switch-on=sdt_stap:pass2__start --switch-off=sdt_stap:pass2__end | grep cycles:P -A100
  # Samples: 240  of event 'cycles:P'
  # Event count (approx.): 206491934
  #
  # Overhead  Command  Shared Object        Symbol
  # ........  .......  ...................  ................................................
  #
      38.99%  stap     stap                 [.] systemtap_session::register_library_aliases
      19.47%  stap     stap                 [.] match_key::operator<
      15.01%  stap     libc-2.29.so         [.] __memcmp_avx2_movbe
       5.19%  stap     libc-2.29.so         [.] _int_malloc
       2.50%  stap     libstdc++.so.6.0.26  [.] std::_Rb_tree_insert_and_rebalance
       2.30%  stap     stap                 [.] match_node::build_no_more
       2.07%  stap     libc-2.29.so         [.] malloc
       1.66%  stap     stap                 [.] std::_Rb_tree<match_key, std::pair<match_key const, match_node*>, std::_Select1st<std::pair<match_key const, match_node*> >, std::less<match_key>, std::allocator<std::pair<match_key const, match_node*> > >::find
       1.66%  stap     stap                 [.] match_node::bind
       1.58%  stap     [kernel.vmlinux]     [k] prepare_exit_to_usermode
       1.17%  stap     [kernel.vmlinux]     [k] native_irq_return_iret
       0.87%  stap     stap                 [.] 0x0000000000032ec4
       0.77%  stap     libstdc++.so.6.0.26  [.] std::_Rb_tree_increment
       0.47%  stap     stap                 [.] std::vector<derived_probe_builder*, std::allocator<derived_probe_builder*> >::_M_realloc_insert<derived_probe_builder* const&>
       0.47%  stap     [kernel.vmlinux]     [k] get_page_from_freelist
       0.47%  stap     [kernel.vmlinux]     [k] swapgs_restore_regs_and_return_to_usermode
       0.47%  stap     [kernel.vmlinux]     [k] do_user_addr_fault
       0.46%  stap     [kernel.vmlinux]     [k] __pagevec_lru_add_fn
       0.46%  stap     stap                 [.] std::_Rb_tree<match_key, std::pair<match_key const, match_node*>, std::_Select1st<std::pair<match_key const, match_node*> >, std::less<match_key>, std::allocator<std::pair<match_key const, match_node*> > >::_M_emplace_unique<std::pair<match_key, match_node*> >
       0.42%  stap     libstdc++.so.6.0.26  [.] 0x00000000000c18fa
       0.40%  stap     [kernel.vmlinux]     [k] interrupt_entry
       0.40%  stap     [kernel.vmlinux]     [k] update_load_avg
       0.40%  stap     [kernel.vmlinux]     [k] __intel_pmu_disable_all
       0.40%  stap     [kernel.vmlinux]     [k] clear_page_erms
       0.39%  stap     [kernel.vmlinux]     [k] __mod_node_page_state
       0.39%  stap     [kernel.vmlinux]     [k] error_entry
       0.39%  stap     [kernel.vmlinux]     [k] sync_regs
       0.38%  stap     [kernel.vmlinux]     [k] __handle_mm_fault
       0.38%  stap     stap                 [.] derive_probes

  #
  # (Tip: System-wide collection from all CPUs: perf record -a)
  #
  [root@quaco testsuite]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-408hvumcnyn93a0auihnawew@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 17 +++++++++++++++++
 tools/perf/builtin-report.c              | 10 ++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 987261d158d4..7315f155803f 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -438,6 +438,23 @@ OPTIONS
 
 	  perf report --time 0%-10%,30%-40%
 
+--switch-on EVENT_NAME::
+	Only consider events after this event is found.
+
+	This may be interesting to measure a workload only after some initialization
+	phase is over, i.e. insert a perf probe at that point and then using this
+	option with that probe.
+
+--switch-off EVENT_NAME::
+	Stop considering events after this event is found.
+
+--show-on-off-events::
+	Show the --switch-on/off events too. This has no effect in 'perf report' now
+	but probably we'll make the default not to show the switch-on/off events
+        on the --group mode and if there is only one event besides the off/on ones,
+	go straight to the histogram browser, just like 'perf report' with no events
+	explicitely specified does.
+
 --itrace::
 	Options for decoding instruction tracing data. The options are:
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index d4288dcce156..5e003d02821e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -25,6 +25,7 @@
 #include "util/debug.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/evswitch.h"
 #include "util/header.h"
 #include "util/session.h"
 #include "util/tool.h"
@@ -60,6 +61,7 @@
 struct report {
 	struct perf_tool	tool;
 	struct perf_session	*session;
+	struct evswitch		evswitch;
 	bool			use_tui, use_gtk, use_stdio;
 	bool			show_full_info;
 	bool			show_threads;
@@ -243,6 +245,9 @@ static int process_sample_event(struct perf_tool *tool,
 		return 0;
 	}
 
+	if (evswitch__discard(&rep->evswitch, evsel))
+		return 0;
+
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_debug("problem processing %d event, skipping it.\n",
 			 event->header.type);
@@ -1189,6 +1194,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_CALLBACK(0, "time-quantum", &symbol_conf.time_quantum, "time (ms|us|ns|s)",
 		     "Set time quantum for time sort key (default 100ms)",
 		     parse_time_quantum),
+	OPTS_EVSWITCH(&report.evswitch),
 	OPT_END()
 	};
 	struct perf_data data = {
@@ -1257,6 +1263,10 @@ repeat:
 	if (session == NULL)
 		return -1;
 
+	ret = evswitch__init(&report.evswitch, session->evlist, stderr);
+	if (ret)
+		return ret;
+
 	if (zstd_init(&(session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed. Reported data may be incomplete.\n");
 
