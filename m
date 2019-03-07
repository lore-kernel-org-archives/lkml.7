Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21472C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D859220661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980808;
	bh=SZ1TAKThlMHmWVC5jTjJcqrqdWhOtkB0jf/vy9LDWIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LBOpQz9PlOVLgyTVO0aiSS0naCBSgnUAkZsEVs+ti3If3QpIe9BToo71M3W11zJze
	 QNBt3AbXTX42nkLsndMpe5jXm4N3U7G2fLTDB4tySi5BRHg5drSxoLWcf27h/M5Krc
	 aD/ULbODs3axwVUlxn+K1Z2snwRWXK3S+FTJ0vOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfCGRqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfCGRqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:45 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4785F20661;
        Thu,  7 Mar 2019 17:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980803;
        bh=SZ1TAKThlMHmWVC5jTjJcqrqdWhOtkB0jf/vy9LDWIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYsYuNL9JetSqrxa3o20T+yrRSluzD1cgnkSBtPjsKCOJ3JxSjTaqH5w8jEGzqZmO
         4geiY75YiKkbOwDbQmnUV059UG2Pnz9c0KuJzefrH7/+nhgucAfm+9+v8F/rNv7POd
         9KatAgz2Gb8fj/R0ED0p0957aZWvA8bY3uMCxFFg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/35] perf script python: Add Python3 support to intel-pt-events.py
Date:   Thu,  7 Mar 2019 14:44:26 -0300
Message-Id: <20190307174433.28819-29-acme@kernel.org>
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

Support both Python2 and Python3 in the intel-pt-events.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/fd26acf9-0c0f-717f-9664-a3c33043ce19@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/intel-pt-events.py | 32 ++++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 2177722f509e..a73847c8f548 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -10,6 +10,8 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -22,34 +24,34 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 #from Core import *
 
 def trace_begin():
-	print "Intel PT Power Events and PTWRITE"
+	print("Intel PT Power Events and PTWRITE")
 
 def trace_end():
-	print "End"
+	print("End")
 
 def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
+		print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
 
 def print_ptwrite(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
 	flags = data[0]
 	payload = data[1]
 	exact_ip = flags & 1
-	print "IP: %u payload: %#x" % (exact_ip, payload),
+	print("IP: %u payload: %#x" % (exact_ip, payload), end=' ')
 
 def print_cbr(raw_buf):
 	data = struct.unpack_from("<BBBBII", raw_buf)
 	cbr = data[0]
 	f = (data[4] + 500) / 1000
 	p = ((cbr * 1000 / data[2]) + 5) / 10
-	print "%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p),
+	print("%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p), end=' ')
 
 def print_mwait(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
 	payload = data[1]
 	hints = payload & 0xff
 	extensions = (payload >> 32) & 0x3
-	print "hints: %#x extensions: %#x" % (hints, extensions),
+	print("hints: %#x extensions: %#x" % (hints, extensions), end=' ')
 
 def print_pwre(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
@@ -57,13 +59,14 @@ def print_pwre(raw_buf):
 	hw = (payload >> 7) & 1
 	cstate = (payload >> 12) & 0xf
 	subcstate = (payload >> 8) & 0xf
-	print "hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
+	print("hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
+		end=' ')
 
 def print_exstop(raw_buf):
 	data = struct.unpack_from("<I", raw_buf)
 	flags = data[0]
 	exact_ip = flags & 1
-	print "IP: %u" % (exact_ip),
+	print("IP: %u" % (exact_ip), end=' ')
 
 def print_pwrx(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
@@ -71,18 +74,21 @@ def print_pwrx(raw_buf):
 	deepest_cstate = payload & 0xf
 	last_cstate = (payload >> 4) & 0xf
 	wake_reason = (payload >> 8) & 0xf
-	print "deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason),
+	print("deepest cstate: %u last cstate: %u wake reason: %#x" %
+		(deepest_cstate, last_cstate, wake_reason), end=' ')
 
 def print_common_start(comm, sample, name):
 	ts = sample["time"]
 	cpu = sample["cpu"]
 	pid = sample["pid"]
 	tid = sample["tid"]
-	print "%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
+	print("%16s %5u/%-5u [%03u] %9u.%09u %7s:" %
+		(comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
+		end=' ')
 
 def print_common_ip(sample, symbol, dso):
 	ip = sample["ip"]
-	print "%16x %s (%s)" % (ip, symbol, dso)
+	print("%16x %s (%s)" % (ip, symbol, dso))
 
 def process_event(param_dict):
 	event_attr = param_dict["attr"]
@@ -92,12 +98,12 @@ def process_event(param_dict):
 	name	   = param_dict["ev_name"]
 
 	# Symbol and dso info are not always resolved
-	if (param_dict.has_key("dso")):
+	if "dso" in param_dict:
 		dso = param_dict["dso"]
 	else:
 		dso = "[unknown]"
 
-	if (param_dict.has_key("symbol")):
+	if "symbol" in param_dict:
 		symbol = param_dict["symbol"]
 	else:
 		symbol = "[unknown]"
-- 
2.20.1

