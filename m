Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B48AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B10F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfCEQTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:19:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:41762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfCEQTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:19:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7199DAC38;
        Tue,  5 Mar 2019 16:19:05 +0000 (UTC)
Subject: Re: [PATCH v2 5/7] perf script python: add Python3 support to
 intel-pt-events.py
From:   Tony Jones <tonyj@suse.de>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-6-tonyj@suse.de>
 <6fe06c75-5f98-4829-e139-af2bfcda24f3@intel.com>
 <dfa719d4-0d9e-ad08-536f-17b3da116b19@suse.de>
 <18913237-75f2-731b-940d-1fccc43d1b4a@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tonyj@suse.de; prefer-encrypt=mutual; keydata=
 mQGiBEkQmbwRBACDch7wo/RzlNt2HA8jLICsO2w8yOkJ7UTzHYNn3Q83Ro0qev2KokfE3EDw
 il+vam9CDR7jIDmswHqaMe0/O+UnZtO5PlDgylZcrwNwbBzHfm/KGejbi1RBGAoETrvcfwGi
 w83bR/aDnoRXY5Ho1uphQ05/065EMpbJOOBdn9qQ4wCgv2Q6C/QeYDGsxJPRO+20nLu5K00D
 /Rde4OTZ5biM+vb6ObTmgPNeiMrTwGpMokN7audIl7njwvD+lYrlgQjmDzcaPFz29rYWwT7g
 6t6hcFgjpU1he/v3qxeQlTJoi2+u5Mqj42z//49h6DqNjT859Z/6h5IwKBo/EZC17iBIlS2G
 VXAstNiZASGiaIlONozWJ/GSjUaRA/9wZTV1nXF/+xX+qmc7SvTg1w6jWyjxVumQLoq2SeA4
 1Sy5X2IATkAGCCjbeoQGnFdbOnHRSJdlTazObgwreqGPlPnIROpr9QESkfxsaCkDiZfpl0xk
 6X069QMZBEwGAWILHYXL9UqlOjniZaU2BkVA11JEdBhyQorC8T/ji1edc7QaVG9ueSBKb25l
 cyA8dG9ueWpAc3VzZS5kZT6IYAQTEQIAIAUCSRCZvAIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheAAAoJELFYWyEf4koXGmYAoKCnbv9dhAB2vR6IvSJem1ws4HpfAJ9ZqTKiXcogBGfTPaJR
 GI9QhVUieLkCDQRJEJm8EAgAzr9Zd3v7B10ODtVc7XxbMe3W6o1FdClL9ZIgLv61zhWctafK
 DMu/MUSvxmYFq00pecD/SfX8oxArA02+sQ2E+/Zb4J7NAWIAxCfmy7VE0wDBrZH/hBapIx/L
 gVqYfZ9Rw+a4FXrlk1y8oQCwhvj+kWrm7V7olR0aPOy1NFGNUyTFSMj+pbmxiNOXdCxVUQe3
 UE1k9yA+mILjyaRanwkiCLCjNvRPL88Q017BdhVBWZmz8qhwXN/RrjCcDHsPX5O0ev68MLyu
 sh5mfukuvCqzW1Y3Ql+iwfwEw5lNmQGdoV9csg7JP7saDicSFO2KcZvMbvDMqtPFipdF5UWo
 fZKZ3wADBQf/b5cVNyb5i8QI0G7BPGBNn4VlQX5n66TsPBnrRNOi3MhTTVEBCp8s+jqUjJjX
 EjjA+O4hIm7Qqdsozurw7GlcQ0A06dIzO/1RUglZZMoC0JL43ZQmJ+3+yFrLjWgGH6ev6AOb
 YLH7ZujgAB5n0Hy2ZIChzsKLKbHptFtBvpDKB8updq+GunsY4oN3wGa67h9sHqDvjyp64Czg
 n8G5uGLwx3f/edbECKz5kPUSzChEk3suK742SEP01v4ra5WX88Hn81NjGByQMz9acJLdC7Ff
 LzXvbNa0KgvDaSllYfsJIoGCz3eKVOuTWXOiaEIKuy833+3mr2PulLCyLKysAEddKohJBBgR
 AgAJBQJJEJm8AhsMAAoJELFYWyEf4koXhgQAn1EGATLZPS53At9t+p3S8BkNI9yRAJ9A0OmL
 liv+rwEesYGlGeGNaKHTJw==
Message-ID: <fd26acf9-0c0f-717f-9664-a3c33043ce19@suse.de>
Date:   Tue, 5 Mar 2019 08:19:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <18913237-75f2-731b-940d-1fccc43d1b4a@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 8:10 AM, Tony Jones wrote:

> 
> Sure enough, I managed to attach the wrong patch. Sorry. I'll attach revised (v3) 
> to this thread as the change is trivial.

From: Tony Jones <tonyj@suse.de>
Date: Tue, 05 Mar 2019 08:31:30 -0800
Subject: [PATCH v3] perf script python: add Python3 support to intel-pt-events.py

Support both Python2 and Python3 in the intel-pt-events.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/intel-pt-events.py |   32 ++++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

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
@@ -22,34 +24,34 @@ sys.path.append(os.environ['PERF_EXEC_PA
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
