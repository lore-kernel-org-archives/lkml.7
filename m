Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4423FC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 03:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B2C2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 03:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHDAywr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbfJADUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 23:20:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36623 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbfJADUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 23:20:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so6903030pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 20:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PuoqAp9qX8pwNv4tb/VbIy0buezWiVz/aAqYJPqG2KY=;
        b=hHDAywr1OfZXaJom2Hymah+0U2SOU5KARwToBvv/UPbd9/Pj4OMGKQIVAqAWaN59Tf
         PpSFx1l2DMcRzceHxHoZkHWqfoqQpaWYq9A0ExT9JzFQTNP/D/dfGacgyuO40voTdwE3
         QL1e/TaFQduLrokMtrhSMZQzq+1WQQYWtLqIPttBPWFGtqUZE9B/xD5u/e+DshSkmhJY
         JauX/pwFPcwuv6zTNiH2W/o2NmeF9J9kpqpisTPKOuMC9o6+R1Lx8TIi78kWUzaPMWsK
         5B9Usou3P7j9LizZ3IcZdsQqrThsMuUmn3wlgg8tFU7/AjvrhI+zq6qFajhL2I8XBCxI
         yAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PuoqAp9qX8pwNv4tb/VbIy0buezWiVz/aAqYJPqG2KY=;
        b=YifdBWOg+rrQGH00Vnv7C34Sfxn3+HqpvNFqMxJZJ+ys+ZGqpqW2lPwI3YYuUzBsTu
         EIzms+h09jdCxNqBi4+ciasX2XTdv9bl8phaTydDWgCP64KEFziduZAQcaN6fyYzSs6t
         pr1gX+UQq0D8YvLM7ToOrrcN1nQYkV/RWJISmnuS2ndUUVH+wgvkWQRUezFCwzZxZT3y
         UzHLzYSI+i1egdz+uksgo032HW3ZkXpnBTafGIzNw5QeQv3PAjWCBez+k4YKagGaXOjP
         pbxNVWjYQZFJIHK3/M7pW6MIfhAabl3bFaP0dRCE2Ch1W/HBPH4OehdpH9f3gaqyIKoo
         SYEw==
X-Gm-Message-State: APjAAAXw70jUJBaMcO/s5Uzt/bDDPyFH5AsuiFyQ9NJ1Jr03L5Ibb6Bz
        RFVbAOO+BZCpR/4+XAuYMCE=
X-Google-Smtp-Source: APXvYqxCcSm1lb+wjUN2A1480TgOqsBvzHDkI4dpvfIYTmeHgIUjmF+Gzm2/bIZXbCVxSwx2AAulYA==
X-Received: by 2002:aa7:98d2:: with SMTP id e18mr25365605pfm.188.1569899998287;
        Mon, 30 Sep 2019 20:19:58 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id d5sm19391905pfa.180.2019.09.30.20.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 20:19:57 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tonyj@suse.com, mgorman@techsingularity.net, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>, Tony Jones <tonyj@suse.de>
Subject: [PATCH v2] perf script python: integrate page reclaim analyze script
Date:   Mon, 30 Sep 2019 23:19:44 -0400
Message-Id: <1569899984-16272-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new perf script page-reclaim is introduced in this patch. This new script
is used to report the page reclaim details. The possible usage of this
script is as bellow,
- identify latency spike caused by direct reclaim
- whehter the latency spike is relevant with pageout
- why is page reclaim requested, i.e. whether it is because of memory
  fragmentation
- page reclaim efficiency
etc
In the future we may also enhance it to analyze the memcg reclaim.

Bellow is how to use this script,
    # Record, one of the following
    $ perf record -e 'vmscan:mm_vmscan_*' ./workload
    $ perf script record page-reclaim

    # Report
    $ perf script report page-reclaim

    # Report per process latency
    $ perf script report page-reclaim -- -p

    # Report per process latency details. At what time and how long it
    # stalls at each time.
    $ perf script report page-reclaim -- -v

An example of doing mmtests,
    $ perf script report page-reclaim
    Direct reclaims: 4924
    Direct latency (ms)        total         max         avg         min
        	          177823.211    6378.977      36.114       0.051
    Direct file reclaimed 22920
    Direct file scanned 28306
    Direct file sync write I/O 0
    Direct file async write I/O 0
    Direct anon reclaimed 212567
    Direct anon scanned 1446854
    Direct anon sync write I/O 0
    Direct anon async write I/O 278325
    Direct order      0     1     3
        	   4870    23    31
    Wake kswapd requests 716
    Wake order      0     1
        	  715     1

    Kswapd reclaims: 9
    Kswapd latency (ms)        total         max         avg         min
       	                   86353.046   42128.816    9594.783     120.736
    Kswapd file reclaimed 366461
    Kswapd file scanned 369554
    Kswapd file sync write I/O 0
    Kswapd file async write I/O 0
    Kswapd anon reclaimed 362594
    Kswapd anon scanned 693938
    Kswapd anon sync write I/O 0
    Kswapd anon async write I/O 330663
    Kswapd order      0     1     3
       	              3     1     5
    Kswapd re-wakes 705

    $ perf script report page-reclaim -- -p
    # besides the above basic output, it will also summary per task
    # latency
    Per process latency (ms):
         pid[comm]             total         max         avg         min
           1[systemd]        276.764     248.933       21.29       0.293
         163[kswapd0]      86353.046   42128.816    9594.783     120.736
        7241[bash]         12787.749     859.091      94.028       0.163
        1592[master]          81.604      70.811      27.201       2.906
        1595[pickup]         496.162     374.168     165.387      14.478
        1098[auditd]           19.32       19.32       19.32       19.32
        1120[irqbalance]    5232.331    1386.352     158.555       0.169
        7236[usemem]        79649.04    1763.281      24.921       0.051
        1605[sshd]           1344.41     645.125      34.472        0.16
        7238[bash]           1158.92    1023.307     231.784       0.067
        7239[bash]         15100.776     993.447      82.069       0.145
        ...

    $ per script report page-reclaim -- -v
    # Besides the basic output, it will asl show per task latency details
    Per process latency (ms):
         pid[comm]             total         max         avg         min
               timestamp  latency(ns)
           1[systemd]        276.764     248.933       21.29       0.293
           3406860552338: 16819800
           3406877381650: 5532855
           3407458799399: 929517
           3407459796042: 916682
           3407460763220: 418989
           3407461250236: 332355
           3407461637534: 401731
           3407462092234: 449219
           3407462605855: 292857
           3407462952343: 372700
           3407463364947: 414880
           3407463829547: 949162
           3407464813883: 248933444
         163[kswapd0]      86353.046   42128.816    9594.783     120.736
           3357637025977: 1026962745
           3358915619888: 41268642175
           3400239664127: 42128816204
           3443784780373: 679641989
           3444847948969: 120735792
           3445001978784: 342713657
           3445835850664: 316851589
           3446865035476: 247457873
           3449355401352: 221223878
          ...

This script must be in sync with bellow vmscan tracepoints,
	mm_vmscan_direct_reclaim_begin
	mm_vmscan_direct_reclaim_end
	mm_vmscan_kswapd_wake
	mm_vmscan_kswapd_sleep
	mm_vmscan_wakeup_kswapd
	mm_vmscan_lru_shrink_inactive
	mm_vmscan_writepage

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Tony Jones <tonyj@suse.de>
Cc: Mel Gorman <mgorman@techsingularity.net>
---
v1->v2: verified it with python2.7 and python3.6.
        add vmscan tracepoints comments in this script

---
 tools/perf/scripts/python/bin/page-reclaim-record |   2 +
 tools/perf/scripts/python/bin/page-reclaim-report |   4 +
 tools/perf/scripts/python/page-reclaim.py         | 393 ++++++++++++++++++++++
 3 files changed, 399 insertions(+)
 create mode 100644 tools/perf/scripts/python/bin/page-reclaim-record
 create mode 100644 tools/perf/scripts/python/bin/page-reclaim-report
 create mode 100644 tools/perf/scripts/python/page-reclaim.py

diff --git a/tools/perf/scripts/python/bin/page-reclaim-record b/tools/perf/scripts/python/bin/page-reclaim-record
new file mode 100644
index 0000000..5a16a23
--- /dev/null
+++ b/tools/perf/scripts/python/bin/page-reclaim-record
@@ -0,0 +1,2 @@
+#!/bin/bash
+perf record -e vmscan:mm_vmscan_direct_reclaim_begin -e vmscan:mm_vmscan_direct_reclaim_end -e vmscan:mm_vmscan_kswapd_wake -e vmscan:mm_vmscan_kswapd_sleep -e vmscan:mm_vmscan_wakeup_kswapd -e vmscan:mm_vmscan_lru_shrink_inactive -e vmscan:mm_vmscan_writepage $@
diff --git a/tools/perf/scripts/python/bin/page-reclaim-report b/tools/perf/scripts/python/bin/page-reclaim-report
new file mode 100644
index 0000000..b74e197
--- /dev/null
+++ b/tools/perf/scripts/python/bin/page-reclaim-report
@@ -0,0 +1,4 @@
+#!/bin/bash
+#description: display page reclaim details
+#args: [-h] [-p] [-v]
+perf script -s "$PERF_EXEC_PATH"/scripts/python/page-reclaim.py $@
diff --git a/tools/perf/scripts/python/page-reclaim.py b/tools/perf/scripts/python/page-reclaim.py
new file mode 100644
index 0000000..df40d79
--- /dev/null
+++ b/tools/perf/scripts/python/page-reclaim.py
@@ -0,0 +1,393 @@
+# SPDX-License-Identifier: GPL-2.0
+# Perf script to help analyze page reclaim with vmscan tracepoints
+# e.g. to capture the latency spike caused by direct reclaim.
+#
+# This script must be in sync with bellow vmscan tracepoints,
+# 	mm_vmscan_direct_reclaim_begin
+# 	mm_vmscan_direct_reclaim_end
+# 	mm_vmscan_kswapd_wake
+# 	mm_vmscan_kswapd_sleep
+# 	mm_vmscan_wakeup_kswapd
+# 	mm_vmscan_lru_shrink_inactive
+# 	mm_vmscan_writepage
+#
+# This script is motivated by Mel's trace-vmscan-postprocess.pl.
+#
+# Author: Yafang Shao <laoar.shao@gmail.com>
+
+import os
+import sys
+import getopt
+import signal
+
+signal.signal(signal.SIGPIPE, signal.SIG_DFL)
+
+usage = "usage: perf script report page-reclaim -- [-h] [-p] [-v]\n"
+
+latency_metric = ['total', 'max', 'avg', 'min']
+reclaim_path = ['Kswapd', 'Direct']
+sync_io = ['async', 'sync']
+lru = ['anon', 'file']
+
+class Show:
+	DEFAULT = 0
+	PROCCESS = 1
+	VERBOSE = 2
+
+show_opt = Show.DEFAULT
+
+def ns(sec, nsec):
+	return (sec * 1000000000) + nsec
+
+def ns_to_ms(ns):
+	return round(ns / 1000000.0, 3)
+
+# Format:
+# 	title valueX valueY
+def print_list_in_line(__list, title, padding):
+	line = title
+	for v in __list:
+		line += str(v).rjust(padding)
+
+	print(line)
+
+# Format:
+#	title	nameX	 nameY
+#		valueX	valueY
+def print_list_in_table(__list, title, padding):
+	width = len(title) + 1
+	header = title.ljust(width)
+	line = ''.ljust(width)
+
+	for v in __list:
+		header += str(v[0]).rjust(padding)
+		line += str(v[1]).rjust(padding)
+
+	print(header)
+	print(line)
+
+class Trace:
+	def __init__(self, secs, nsecs):
+		self.begin = ns(secs, nsecs)
+
+	def complete(self, secs, nsecs):
+		self.ns = ns(secs, nsecs) - self.begin
+
+class Stat:
+	def __init__(self):
+		self.stats = {}
+		self.stats['file'] = {}
+		self.stats['file']['reclaimed'] = 0
+		self.stats['file']['scanned'] = 0
+		self.stats['file']['sync'] = 0
+		self.stats['file']['async'] = 0
+		self.stats['anon'] = {}
+		self.stats['anon']['reclaimed'] = 0
+		self.stats['anon']['scanned'] = 0
+		self.stats['anon']['sync'] = 0
+		self.stats['anon']['async'] = 0
+
+		# including reclaimed slab caches
+		self.stats['reclaimed'] = 0
+
+		# The MAX_ORDER in kernel is configurable
+		self.stats['order'] = {}
+
+		self.stats['latency'] = {}
+		self.stats['latency']['total'] = 0.0
+		self.stats['latency']['max'] = 0.0
+		self.stats['latency']['avg'] = 0.0
+		self.stats['latency']['min'] = float("inf")
+		self.stats['count'] = 0
+
+	def add_latency(self, val, order):
+		self.stats['latency']['total'] += val
+		_max = self.stats['latency']['max']
+		_min = self.stats['latency']['min']
+		if val > _max:
+			self.stats['latency']['max'] = val
+		if val < _min:
+			self.stats['latency']['min'] = val
+
+		self.stats['count'] += 1
+		self.stats['order'][order] = self.stats['order'].get(order, 0) + 1
+
+	def add_page(self, _lru, scanned, reclaimed):
+		self.stats[_lru]['scanned'] += scanned
+		self.stats[_lru]['reclaimed'] += reclaimed
+
+	def inc_write_io(self, _lru, _io):
+		self.stats[_lru][_io] += 1
+
+	def convert_latency(self):
+		count = self.stats['count']
+		if count:
+			self.stats['latency']['avg'] =	\
+				self.stats['latency']['total'] / count
+		for i, v in self.stats['latency'].items():
+			 self.stats['latency'][i] = ns_to_ms(v)
+
+		latency_list = sorted(self.stats['latency'].items(),
+			key=lambda i:latency_metric.index(i[0]))
+
+		return latency_list
+
+	def show_stats(self, key):
+		count = self.stats['count']
+		print("%s reclaims: %d" % (key, count))
+
+		# Format latency output
+		# Print latencys in milliseconds:
+		# title total  max  avg  min
+		#	    v    v    v    v
+		latency_list = self.convert_latency()
+		print_list_in_table(latency_list, key + " latency (ms)", 12)
+
+		for _lru in ['file', 'anon']:
+			for action in ['reclaimed', 'scanned']:
+				print("%s %s %s %d" % (key, _lru, action, self.stats[_lru][action]))
+			for _io in ['sync', 'async']:
+				print("%s %s %s write I/O %d" % (key, _lru, _io, self.stats[_lru][_io]))
+
+		# Format order output
+		# Similar with /proc/buddyinfo:
+		# title	order-N ...
+		# 	  v     ...
+		# N.B. v is a non-zero value
+		order_list = sorted(self.stats['order'].items())
+		print_list_in_table(order_list, key + ' order', 6)
+
+class Vmscan:
+	events = {}
+	stat = {}
+	stat['Direct'] = Stat()
+	stat['Kswapd'] = Stat()
+	# for re-wake the kswapd
+	rewake = 0
+
+	@classmethod
+	def direct_begin(cls, pid, comm, start_secs, start_nsecs, order):
+		event = cls.events.get(pid)
+		if event is None:
+			#new vmscan instance
+			event = cls.events[pid] = Vmscan(comm, pid)
+		event.vmscan_trace_begin(start_secs, start_nsecs, order, 1)
+
+	@classmethod
+	def direct_end(cls, pid, secs, nsecs, reclaimed):
+		event = cls.events.get(pid)
+		if event and event.tracing():
+			event.vmscan_trace_end(secs, nsecs)
+
+	@classmethod
+	def kswapd_wake(cls, pid, comm, start_secs, start_nsecs, order):
+		event = cls.events.get(pid)
+		if event is None:
+			# new vmscan instance
+			event = cls.events[pid] = Vmscan(comm, pid)
+
+		if event.tracing() is False:
+			event.vmscan_trace_begin(start_secs, start_nsecs, order, 0)
+		# kswapd is already running
+		else:
+			cls.rewake_kswapd(order)
+
+	@classmethod
+	def rewake_kswapd(cls, order):
+		cls.rewake += 1
+
+	@classmethod
+	def show_rewakes(cls):
+		print("Kswapd re-wakes %d" % (cls.rewake))
+
+	@classmethod
+	def kswapd_sleep(cls, pid, secs, nsecs):
+		event = cls.events.get(pid)
+		if event and event.tracing():
+			event.vmscan_trace_end(secs, nsecs)
+
+	@classmethod
+	def shrink_inactive(cls, pid, scanned, reclaimed, flags):
+		event = cls.events.get(pid)
+		if event and event.tracing():
+			# RECLAIM_WB_ANON 0x1
+			# RECLAIM_WB_FILE 0x2
+			_type = (flags & 0x2) >> 1
+			event.process_lru(lru[_type], scanned, reclaimed)
+
+	@classmethod
+	def writepage(cls, pid, flags):
+		event = cls.events.get(pid)
+		if event and event.tracing():
+			# RECLAIM_WB_ANON 0x1
+			# RECLAIM_WB_FILE 0x2
+			# RECLAIM_WB_SYNC 0x4
+			# RECLAIM_WB_ASYNC 0x8
+			_type = (flags & 0x2) >> 1
+			_io = (flags & 0x4) >> 2
+
+			event.process_writepage(lru[_type], sync_io[_io])
+
+	@classmethod
+	def iterate_proc(cls):
+		if show_opt != Show.DEFAULT:
+			print("\nPer process latency (ms):")
+			_str = 'pid'.rjust(8) + '[comm]'.ljust(12)
+			print_list_in_line(latency_metric, _str, 12)
+
+			if show_opt == Show.VERBOSE:
+				print("%20s  %s" % ('timestamp','latency(ns)'))
+
+			for i in cls.events:
+				yield cls.events[i]
+
+	def __init__(self, comm, pid):
+		self.comm = comm
+		self.pid = pid
+		self.trace = None
+		self._list = []
+		self.stat = Stat()
+		self.direct = 0
+		self.order = 0
+
+	def vmscan_trace_begin(self, secs, nsecs, order, direct):
+		self.trace = Trace(secs, nsecs)
+		self.direct = direct
+		self.order = order
+
+	def vmscan_trace_end(self, secs, nsecs):
+		path = reclaim_path[self.direct]
+		self.trace.complete(secs, nsecs)
+
+		Vmscan.stat[path].add_latency(self.trace.ns, self.order)
+		if show_opt != Show.DEFAULT:
+			self.stat.add_latency(self.trace.ns, self.order)
+			if show_opt == Show.VERBOSE:
+				self._list.append(self.trace)
+
+		self.trace = None
+
+	def process_lru(self, lru, scanned, reclaimed):
+		path = reclaim_path[self.direct]
+		Vmscan.stat[path].add_page(lru, scanned, reclaimed)
+
+	def process_writepage(self, lru, io):
+		path = reclaim_path[self.direct]
+		Vmscan.stat[path].inc_write_io(lru, io)
+
+	def tracing(self):
+		return self.trace != None
+
+	def display_proc(self):
+		self.stat.convert_latency()
+		_list = sorted(list(self.stat.stats['latency'].values()), reverse = True)
+		if _list:
+			comm = '[' + self.comm[0:10] + ']'
+			proc =  str(self.pid).rjust(8) + comm.ljust(12)
+			print_list_in_line(_list, proc, 12)
+
+	def display_proc_detail(self):
+		if show_opt == Show.VERBOSE:
+			for i, v in enumerate(self._list):
+				print("%20d: %d" % (v.begin, v.ns))
+
+# Wake kswpad request
+class Wakeup:
+	wakes = 0
+	orders = {}
+
+	@classmethod
+	def wakeup_kswapd(cls, order):
+		cls.wakes += 1
+		cls.orders[order] = cls.orders.get(order, 0) + 1
+
+	@classmethod
+	def show_wakes(cls):
+		print("Wake kswapd requests %d" % (cls.wakes))
+
+		order_list = sorted(cls.orders.items())
+		print_list_in_table(order_list, 'Wake order', 6)
+
+def trace_end():
+	Vmscan.stat['Direct'].show_stats('Direct')
+	Wakeup.show_wakes()
+	print('')
+
+	Vmscan.stat['Kswapd'].show_stats('Kswapd')
+	Vmscan.show_rewakes()
+
+	# show process details if requested
+	for i in Vmscan.iterate_proc():
+		i.display_proc(),
+		i.display_proc_detail()
+
+def vmscan__mm_vmscan_direct_reclaim_begin(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, order, gfp_flags):
+
+	Vmscan.direct_begin(common_pid, common_comm, common_secs,
+			     common_nsecs, order)
+
+def vmscan__mm_vmscan_direct_reclaim_end(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, nr_reclaimed):
+
+	Vmscan.direct_end(common_pid, common_secs, common_nsecs, nr_reclaimed)
+
+def vmscan__mm_vmscan_kswapd_wake(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, nid, zid, order):
+
+	Vmscan.kswapd_wake(common_pid, common_comm, common_secs, common_nsecs, order)
+
+def vmscan__mm_vmscan_kswapd_sleep(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, nid):
+
+	Vmscan.kswapd_sleep(common_pid, common_secs, common_nsecs)
+
+def vmscan__mm_vmscan_wakeup_kswapd(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, nid, zid, order, gfp_flags):
+
+	Wakeup.wakeup_kswapd(order)
+
+def vmscan__mm_vmscan_lru_shrink_inactive(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, nid, nr_scanned, nr_reclaimed, nr_dirty,
+	nr_writeback, nr_congested, nr_immediate, nr_activate_anon,
+	nr_activate_file, nr_ref_keep, nr_unmap_fail, priority, flags):
+
+	Vmscan.shrink_inactive(common_pid, nr_scanned, nr_reclaimed, flags)
+
+def vmscan__mm_vmscan_writepage(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, pfn, reclaim_flags):
+
+	Vmscan.writepage(common_pid, reclaim_flags)
+
+def print_help():
+	global usage
+	print(usage)
+	print(" -p    show process latency (ms)")
+	print(" -v    show process latency (ns) with timestamp")
+
+def option_parse():
+	try:
+		opts, args = getopt.getopt(sys.argv[1:], "pvh")
+	except getopt.GetoptError:
+		print('Bad option!')
+		exit(1)
+
+	global show_opt
+	for opt, arg in opts:
+		if opt == "-h":
+			print_help()
+			exit(0)
+		elif opt == "-p":
+			show_opt = Show.PROCCESS
+		elif opt == '-v':
+			show_opt = Show.VERBOSE
+
+option_parse()
+
-- 
1.8.3.1

