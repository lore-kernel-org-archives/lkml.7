Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC2BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2216820661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980794;
	bh=dpIeKwnQq3w0Pvmi06jEDScHujAnVGZgigucfJlY0vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I9BV5HQN659dIj/jkXbU0qr0xBt+eFfzipTTilrvb1ojz5O3IaIyRg2n2LAhHEWTg
	 oV8fMMhNkZsy5sUt0HE6q7Il0kfd0Co8Sc3hhlrHOFN6aEb+Ef2tXOHTFn1K/+jgOT
	 K7qtE9rOmKEdnVchla3FnfgVQ5OMbH8xTzPNnziY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfCGRqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbfCGRqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:30 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB20120851;
        Thu,  7 Mar 2019 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980788;
        bh=dpIeKwnQq3w0Pvmi06jEDScHujAnVGZgigucfJlY0vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUuphSMnVr0Uf7lecJToCMT6+u+STRr1mjkTSYgM5o9rNhHru3zP55z8VQhgKx2Kf
         sqDo3ymvwQGNpyJDVyyA1qEVjOIVSp5o23OZorQnMo911j3R30m7NM//jmUiTe80r/
         jBVGFDMDnLIESNqncYE9rz4GUq+zEuYLw97oYu88=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/35] perf script python: Remove mixed indentation
Date:   Thu,  7 Mar 2019 14:44:22 -0300
Message-Id: <20190307174433.28819-25-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Remove mixed indentation in Python scripts.  Revert to either all tabs
(most common form) or all spaces (4 or 8) depending on what was the
intent of the original commit.  This is necessary to complete Python3
support as it will flag an error if it encounters mixed indentation.

Signed-off-by: Tony Jones <tonyj@suse.de>
Link: http://lkml.kernel.org/r/20190302011903.2416-2-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/check-perf-trace.py | 65 +++++++++----------
 tools/perf/scripts/python/compaction-times.py |  8 +--
 .../scripts/python/event_analyzing_sample.py  |  6 +-
 .../scripts/python/failed-syscalls-by-pid.py  | 38 +++++------
 tools/perf/scripts/python/futex-contention.py |  2 +-
 tools/perf/scripts/python/intel-pt-events.py  | 32 ++++-----
 tools/perf/scripts/python/mem-phys-addr.py    |  7 +-
 tools/perf/scripts/python/net_dropmonitor.py  |  2 +-
 tools/perf/scripts/python/netdev-times.py     | 12 ++--
 tools/perf/scripts/python/sched-migration.py  |  6 +-
 tools/perf/scripts/python/sctop.py            | 13 ++--
 tools/perf/scripts/python/stackcollapse.py    |  2 +-
 .../scripts/python/syscall-counts-by-pid.py   | 47 +++++++-------
 tools/perf/scripts/python/syscall-counts.py   | 31 +++++----
 14 files changed, 136 insertions(+), 135 deletions(-)

diff --git a/tools/perf/scripts/python/check-perf-trace.py b/tools/perf/scripts/python/check-perf-trace.py
index 334599c6032c..f4838db3e518 100644
--- a/tools/perf/scripts/python/check-perf-trace.py
+++ b/tools/perf/scripts/python/check-perf-trace.py
@@ -23,60 +23,59 @@ def trace_begin():
 	pass
 
 def trace_end():
-        print_unhandled()
+	print_unhandled()
 
 def irq__softirq_entry(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, vec):
-		print_header(event_name, common_cpu, common_secs, common_nsecs,
-			common_pid, common_comm)
+		       common_secs, common_nsecs, common_pid, common_comm,
+		       common_callchain, vec):
+	print_header(event_name, common_cpu, common_secs, common_nsecs,
+		common_pid, common_comm)
 
-                print_uncommon(context)
+	print_uncommon(context)
 
-		print "vec=%s\n" % \
-		(symbol_str("irq__softirq_entry", "vec", vec)),
+	print "vec=%s\n" % (symbol_str("irq__softirq_entry", "vec", vec)),
 
 def kmem__kmalloc(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, call_site, ptr, bytes_req, bytes_alloc,
-	gfp_flags):
-		print_header(event_name, common_cpu, common_secs, common_nsecs,
-			common_pid, common_comm)
+		  common_secs, common_nsecs, common_pid, common_comm,
+		  common_callchain, call_site, ptr, bytes_req, bytes_alloc,
+		  gfp_flags):
+	print_header(event_name, common_cpu, common_secs, common_nsecs,
+		common_pid, common_comm)
 
-                print_uncommon(context)
+	print_uncommon(context)
 
-		print "call_site=%u, ptr=%u, bytes_req=%u, " \
+	print "call_site=%u, ptr=%u, bytes_req=%u, " \
 		"bytes_alloc=%u, gfp_flags=%s\n" % \
 		(call_site, ptr, bytes_req, bytes_alloc,
-
 		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)),
 
 def trace_unhandled(event_name, context, event_fields_dict):
-    try:
-        unhandled[event_name] += 1
-    except TypeError:
-        unhandled[event_name] = 1
+	try:
+		unhandled[event_name] += 1
+	except TypeError:
+		unhandled[event_name] = 1
 
 def print_header(event_name, cpu, secs, nsecs, pid, comm):
 	print "%-20s %5u %05u.%09u %8u %-20s " % \
-	(event_name, cpu, secs, nsecs, pid, comm),
+		(event_name, cpu, secs, nsecs, pid, comm),
 
 # print trace fields not included in handler args
 def print_uncommon(context):
-    print "common_preempt_count=%d, common_flags=%s, common_lock_depth=%d, " \
-        % (common_pc(context), trace_flag_str(common_flags(context)), \
-               common_lock_depth(context))
+	print "common_preempt_count=%d, common_flags=%s, " \
+		"common_lock_depth=%d, " % \
+		(common_pc(context), trace_flag_str(common_flags(context)),
+		common_lock_depth(context))
 
 def print_unhandled():
-    keys = unhandled.keys()
-    if not keys:
-        return
+	keys = unhandled.keys()
+	if not keys:
+		return
 
-    print "\nunhandled events:\n\n",
+	print "\nunhandled events:\n\n",
 
-    print "%-40s  %10s\n" % ("event", "count"),
-    print "%-40s  %10s\n" % ("----------------------------------------", \
-                                 "-----------"),
+	print "%-40s  %10s\n" % ("event", "count"),
+	print "%-40s  %10s\n" % ("----------------------------------------", \
+				"-----------"),
 
-    for event_name in keys:
-	print "%-40s  %10d\n" % (event_name, unhandled[event_name])
+	for event_name in keys:
+		print "%-40s  %10d\n" % (event_name, unhandled[event_name])
diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
index 239cb0568ec3..2560a042dc6f 100644
--- a/tools/perf/scripts/python/compaction-times.py
+++ b/tools/perf/scripts/python/compaction-times.py
@@ -216,15 +216,15 @@ def compaction__mm_compaction_migratepages(event_name, context, common_cpu,
 		pair(nr_migrated, nr_failed), None, None)
 
 def compaction__mm_compaction_isolate_freepages(event_name, context, common_cpu,
-        common_secs, common_nsecs, common_pid, common_comm,
-        common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
 
 	chead.increment_pending(common_pid,
 		None, pair(nr_scanned, nr_taken), None)
 
 def compaction__mm_compaction_isolate_migratepages(event_name, context, common_cpu,
-        common_secs, common_nsecs, common_pid, common_comm,
-        common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
 
 	chead.increment_pending(common_pid,
 		None, None, pair(nr_scanned, nr_taken))
diff --git a/tools/perf/scripts/python/event_analyzing_sample.py b/tools/perf/scripts/python/event_analyzing_sample.py
index 4e843b9864ec..2ec8915b74c5 100644
--- a/tools/perf/scripts/python/event_analyzing_sample.py
+++ b/tools/perf/scripts/python/event_analyzing_sample.py
@@ -37,7 +37,7 @@ con = sqlite3.connect("/dev/shm/perf.db")
 con.isolation_level = None
 
 def trace_begin():
-	print "In trace_begin:\n"
+        print "In trace_begin:\n"
 
         #
         # Will create several tables at the start, pebs_ll is for PEBS data with
@@ -102,7 +102,7 @@ def insert_db(event):
                                 event.ip, event.status, event.dse, event.dla, event.lat))
 
 def trace_end():
-	print "In trace_end:\n"
+        print "In trace_end:\n"
         # We show the basic info for the 2 type of event classes
         show_general_events()
         show_pebs_ll()
@@ -187,4 +187,4 @@ def show_pebs_ll():
              print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
 
 def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
+        print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
diff --git a/tools/perf/scripts/python/failed-syscalls-by-pid.py b/tools/perf/scripts/python/failed-syscalls-by-pid.py
index 3648e8b986ec..310efe5e7e23 100644
--- a/tools/perf/scripts/python/failed-syscalls-by-pid.py
+++ b/tools/perf/scripts/python/failed-syscalls-by-pid.py
@@ -58,22 +58,22 @@ def syscalls__sys_exit(event_name, context, common_cpu,
 	raw_syscalls__sys_exit(**locals())
 
 def print_error_totals():
-    if for_comm is not None:
-	    print("\nsyscall errors for %s:\n" % (for_comm))
-    else:
-	    print("\nsyscall errors:\n")
-
-    print("%-30s  %10s" % ("comm [pid]", "count"))
-    print("%-30s  %10s" % ("------------------------------", "----------"))
-
-    comm_keys = syscalls.keys()
-    for comm in comm_keys:
-	    pid_keys = syscalls[comm].keys()
-	    for pid in pid_keys:
-		    print("\n%s [%d]" % (comm, pid))
-		    id_keys = syscalls[comm][pid].keys()
-		    for id in id_keys:
-			    print("  syscall: %-16s" % syscall_name(id))
-			    ret_keys = syscalls[comm][pid][id].keys()
-			    for ret, val in sorted(syscalls[comm][pid][id].items(), key = lambda kv: (kv[1], kv[0]),  reverse = True):
-				    print("    err = %-20s  %10d" % (strerror(ret), val))
+	if for_comm is not None:
+		print("\nsyscall errors for %s:\n" % (for_comm))
+	else:
+		print("\nsyscall errors:\n")
+
+	print("%-30s  %10s" % ("comm [pid]", "count"))
+	print("%-30s  %10s" % ("------------------------------", "----------"))
+
+	comm_keys = syscalls.keys()
+	for comm in comm_keys:
+		pid_keys = syscalls[comm].keys()
+		for pid in pid_keys:
+			print("\n%s [%d]" % (comm, pid))
+			id_keys = syscalls[comm][pid].keys()
+			for id in id_keys:
+				print("  syscall: %-16s" % syscall_name(id))
+				ret_keys = syscalls[comm][pid][id].keys()
+				for ret, val in sorted(syscalls[comm][pid][id].items(), key = lambda kv: (kv[1], kv[0]), reverse = True):
+					print("    err = %-20s  %10d" % (strerror(ret), val))
diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
index 0f5cf437b602..f221c62e0a10 100644
--- a/tools/perf/scripts/python/futex-contention.py
+++ b/tools/perf/scripts/python/futex-contention.py
@@ -46,5 +46,5 @@ def trace_end():
 	for (tid, lock) in lock_waits:
 		min, max, avg, count = lock_waits[tid, lock]
 		print "%s[%d] lock %x contended %d times, %d avg ns" % \
-		      (process_names[tid], tid, lock, count, avg)
+			(process_names[tid], tid, lock, count, avg)
 
diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index b19172d673af..2177722f509e 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -85,22 +85,22 @@ def print_common_ip(sample, symbol, dso):
 	print "%16x %s (%s)" % (ip, symbol, dso)
 
 def process_event(param_dict):
-        event_attr = param_dict["attr"]
-        sample     = param_dict["sample"]
-        raw_buf    = param_dict["raw_buf"]
-        comm       = param_dict["comm"]
-        name       = param_dict["ev_name"]
-
-        # Symbol and dso info are not always resolved
-        if (param_dict.has_key("dso")):
-                dso = param_dict["dso"]
-        else:
-                dso = "[unknown]"
-
-        if (param_dict.has_key("symbol")):
-                symbol = param_dict["symbol"]
-        else:
-                symbol = "[unknown]"
+	event_attr = param_dict["attr"]
+	sample	 = param_dict["sample"]
+	raw_buf	= param_dict["raw_buf"]
+	comm	   = param_dict["comm"]
+	name	   = param_dict["ev_name"]
+
+	# Symbol and dso info are not always resolved
+	if (param_dict.has_key("dso")):
+		dso = param_dict["dso"]
+	else:
+		dso = "[unknown]"
+
+	if (param_dict.has_key("symbol")):
+		symbol = param_dict["symbol"]
+	else:
+		symbol = "[unknown]"
 
 	if name == "ptwrite":
 		print_common_start(comm, sample, name)
diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index fb0bbcbfa0f0..1f332e72b9b0 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -44,12 +44,13 @@ def print_memory_type():
 	print("%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"), end='')
 	print("%-40s  %10s  %10s\n" % ("----------------------------------------",
 					"-----------", "-----------"),
-                                        end='');
+					end='');
 	total = sum(load_mem_type_cnt.values())
 	for mem_type, count in sorted(load_mem_type_cnt.most_common(), \
 					key = lambda kv: (kv[1], kv[0]), reverse = True):
-		print("%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total),
-                        end='')
+		print("%-40s  %10d  %10.1f%%\n" %
+			(mem_type, count, 100 * count / total),
+			end='')
 
 def trace_begin():
 	parse_iomem()
diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
index 212557a02c50..101059971738 100755
--- a/tools/perf/scripts/python/net_dropmonitor.py
+++ b/tools/perf/scripts/python/net_dropmonitor.py
@@ -7,7 +7,7 @@ import os
 import sys
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-		'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 
 from perf_trace_context import *
 from Core import *
diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts/python/netdev-times.py
index 267bda49325d..ea0c8b90a783 100644
--- a/tools/perf/scripts/python/netdev-times.py
+++ b/tools/perf/scripts/python/netdev-times.py
@@ -124,14 +124,16 @@ def print_receive(hunk):
 		event = event_list[i]
 		if event['event_name'] == 'napi_poll':
 			print(PF_NAPI_POLL %
-			    (diff_msec(base_t, event['event_t']), event['dev']))
+				(diff_msec(base_t, event['event_t']),
+				event['dev']))
 			if i == len(event_list) - 1:
 				print("")
 			else:
 				print(PF_JOINT)
 		else:
 			print(PF_NET_RECV %
-			    (diff_msec(base_t, event['event_t']), event['skbaddr'],
+				(diff_msec(base_t, event['event_t']),
+				event['skbaddr'],
 				event['len']))
 			if 'comm' in event.keys():
 				print(PF_WJOINT)
@@ -256,7 +258,7 @@ def irq__irq_handler_exit(name, context, cpu, sec, nsec, pid, comm, callchain, i
 	all_event_list.append(event_info)
 
 def napi__napi_poll(name, context, cpu, sec, nsec, pid, comm, callchain, napi,
-                    dev_name, work=None, budget=None):
+		dev_name, work=None, budget=None):
 	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
 			napi, dev_name, work, budget)
 	all_event_list.append(event_info)
@@ -353,7 +355,7 @@ def handle_irq_softirq_exit(event_info):
 	if irq_list == [] or event_list == 0:
 		return
 	rec_data = {'sirq_ent_t':sirq_ent_t, 'sirq_ext_t':time,
-		    'irq_list':irq_list, 'event_list':event_list}
+			'irq_list':irq_list, 'event_list':event_list}
 	# merge information realted to a NET_RX softirq
 	receive_hunk_list.append(rec_data)
 
@@ -390,7 +392,7 @@ def handle_netif_receive_skb(event_info):
 		skbaddr, skblen, dev_name) = event_info
 	if cpu in net_rx_dic.keys():
 		rec_data = {'event_name':'netif_receive_skb',
-			    'event_t':time, 'skbaddr':skbaddr, 'len':skblen}
+				'event_t':time, 'skbaddr':skbaddr, 'len':skblen}
 		event_list = net_rx_dic[cpu]['event_list']
 		event_list.append(rec_data)
 		rx_skb_list.insert(0, rec_data)
diff --git a/tools/perf/scripts/python/sched-migration.py b/tools/perf/scripts/python/sched-migration.py
index 3984bf51f3c5..8196e3087c9e 100644
--- a/tools/perf/scripts/python/sched-migration.py
+++ b/tools/perf/scripts/python/sched-migration.py
@@ -14,10 +14,10 @@ import sys
 
 from collections import defaultdict
 try:
-    from UserList import UserList
+	from UserList import UserList
 except ImportError:
-    # Python 3: UserList moved to the collections package
-    from collections import UserList
+	# Python 3: UserList moved to the collections package
+	from collections import UserList
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
diff --git a/tools/perf/scripts/python/sctop.py b/tools/perf/scripts/python/sctop.py
index 987ffae7c8ca..6e0278dcb092 100644
--- a/tools/perf/scripts/python/sctop.py
+++ b/tools/perf/scripts/python/sctop.py
@@ -13,9 +13,9 @@ from __future__ import print_function
 import os, sys, time
 
 try:
-        import thread
+	import thread
 except ImportError:
-        import _thread as thread
+	import _thread as thread
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -75,11 +75,12 @@ def print_syscall_totals(interval):
 
 		print("%-40s  %10s" % ("event", "count"))
 		print("%-40s  %10s" %
-                        ("----------------------------------------",
-                        "----------"))
+			("----------------------------------------",
+			"----------"))
 
-		for id, val in sorted(syscalls.items(), key = lambda kv: (kv[1], kv[0]), \
-					      reverse = True):
+		for id, val in sorted(syscalls.items(),
+				key = lambda kv: (kv[1], kv[0]),
+				reverse = True):
 			try:
 				print("%-40s  %10d" % (syscall_name(id), val))
 			except TypeError:
diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
index 5e703efaddcc..b1c4def1410a 100755
--- a/tools/perf/scripts/python/stackcollapse.py
+++ b/tools/perf/scripts/python/stackcollapse.py
@@ -27,7 +27,7 @@ from collections import defaultdict
 from optparse import OptionParser, make_option
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-                '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 
 from perf_trace_context import *
 from Core import *
diff --git a/tools/perf/scripts/python/syscall-counts-by-pid.py b/tools/perf/scripts/python/syscall-counts-by-pid.py
index 42782487b0e9..f254e40c6f0f 100644
--- a/tools/perf/scripts/python/syscall-counts-by-pid.py
+++ b/tools/perf/scripts/python/syscall-counts-by-pid.py
@@ -39,11 +39,10 @@ def trace_end():
 	print_syscall_totals()
 
 def raw_syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, id, args):
-
+		common_secs, common_nsecs, common_pid, common_comm,
+		common_callchain, id, args):
 	if (for_comm and common_comm != for_comm) or \
-	   (for_pid  and common_pid  != for_pid ):
+		(for_pid and common_pid != for_pid ):
 		return
 	try:
 		syscalls[common_comm][common_pid][id] += 1
@@ -51,26 +50,26 @@ def raw_syscalls__sys_enter(event_name, context, common_cpu,
 		syscalls[common_comm][common_pid][id] = 1
 
 def syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, args):
+		common_secs, common_nsecs, common_pid, common_comm,
+		id, args):
 	raw_syscalls__sys_enter(**locals())
 
 def print_syscall_totals():
-    if for_comm is not None:
-	    print("\nsyscall events for %s:\n" % (for_comm))
-    else:
-	    print("\nsyscall events by comm/pid:\n")
-
-    print("%-40s  %10s" % ("comm [pid]/syscalls", "count"))
-    print("%-40s  %10s" % ("----------------------------------------",
-                            "----------"))
-
-    comm_keys = syscalls.keys()
-    for comm in comm_keys:
-	    pid_keys = syscalls[comm].keys()
-	    for pid in pid_keys:
-		    print("\n%s [%d]" % (comm, pid))
-		    id_keys = syscalls[comm][pid].keys()
-		    for id, val in sorted(syscalls[comm][pid].items(), \
-				  key = lambda kv: (kv[1], kv[0]),  reverse = True):
-			    print("  %-38s  %10d" % (syscall_name(id), val))
+	if for_comm is not None:
+		print("\nsyscall events for %s:\n" % (for_comm))
+	else:
+		print("\nsyscall events by comm/pid:\n")
+
+	print("%-40s  %10s" % ("comm [pid]/syscalls", "count"))
+	print("%-40s  %10s" % ("----------------------------------------",
+				"----------"))
+
+	comm_keys = syscalls.keys()
+	for comm in comm_keys:
+		pid_keys = syscalls[comm].keys()
+		for pid in pid_keys:
+			print("\n%s [%d]" % (comm, pid))
+			id_keys = syscalls[comm][pid].keys()
+			for id, val in sorted(syscalls[comm][pid].items(),
+				key = lambda kv: (kv[1], kv[0]), reverse = True):
+				print("  %-38s  %10d" % (syscall_name(id), val))
diff --git a/tools/perf/scripts/python/syscall-counts.py b/tools/perf/scripts/python/syscall-counts.py
index 0ebd89cfd42c..8adb95ff1664 100644
--- a/tools/perf/scripts/python/syscall-counts.py
+++ b/tools/perf/scripts/python/syscall-counts.py
@@ -36,8 +36,8 @@ def trace_end():
 	print_syscall_totals()
 
 def raw_syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, id, args):
+		common_secs, common_nsecs, common_pid, common_comm,
+		common_callchain, id, args):
 	if for_comm is not None:
 		if common_comm != for_comm:
 			return
@@ -47,20 +47,19 @@ def raw_syscalls__sys_enter(event_name, context, common_cpu,
 		syscalls[id] = 1
 
 def syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, args):
+		common_secs, common_nsecs, common_pid, common_comm, id, args):
 	raw_syscalls__sys_enter(**locals())
 
 def print_syscall_totals():
-    if for_comm is not None:
-	    print("\nsyscall events for %s:\n" % (for_comm))
-    else:
-	    print("\nsyscall events:\n")
-
-    print("%-40s  %10s" % ("event", "count"))
-    print("%-40s  %10s" % ("----------------------------------------",
-                              "-----------"))
-
-    for id, val in sorted(syscalls.items(), key = lambda kv: (kv[1], kv[0]), \
-				  reverse = True):
-	    print("%-40s  %10d" % (syscall_name(id), val))
+	if for_comm is not None:
+		print("\nsyscall events for %s:\n" % (for_comm))
+	else:
+		print("\nsyscall events:\n")
+
+	print("%-40s  %10s" % ("event", "count"))
+	print("%-40s  %10s" % ("----------------------------------------",
+				"-----------"))
+
+	for id, val in sorted(syscalls.items(),
+			key = lambda kv: (kv[1], kv[0]), reverse = True):
+		print("%-40s  %10d" % (syscall_name(id), val))
-- 
2.20.1

