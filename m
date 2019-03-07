Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0DE20661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980799;
	bh=L8NGBYGSYnFsb6TxiZ6I/ZECq138veLjsP9x+bBa8hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WdiUicUFPehQbD1Gsu1JAeLAtiHnQYHmUt4QtP7zdomWNEn0DvIi+sR2icRDNdJU8
	 qrv5iqVU3i5lOmx0hGuQuzUM/jLz0Htpa7ocbM2ndsOB0svQJUwJM7N+KAgi6glgVf
	 Bu51rx2rzvygee8iA3KLMOocDDhrG8M94W0lAwK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfCGRqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfCGRqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:32 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED712087C;
        Thu,  7 Mar 2019 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980792;
        bh=L8NGBYGSYnFsb6TxiZ6I/ZECq138veLjsP9x+bBa8hY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gV8hsupqFirlORScEkc5HncS4MeRcEZ7K7Ziodk1F3ZLZfmOZJSyy2C8I0NfC4bgI
         oplwha94i5qe7bE4P/HCR39q+8G1iHz7mGIK4tiR8K8aIaQfWmCO7B3hGW8siQoMnK
         UZ1zTjg+xbITdH4ChNG98NMOstUCcuJtSbHzY1H0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/35] perf script python: Add Python3 support to futex-contention.py
Date:   Thu,  7 Mar 2019 14:44:23 -0300
Message-Id: <20190307174433.28819-26-acme@kernel.org>
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

Support both Python2 and Python3 in the futex-contention.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Link: http://lkml.kernel.org/r/20190302011903.2416-3-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/futex-contention.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
index f221c62e0a10..0c4841acf75d 100644
--- a/tools/perf/scripts/python/futex-contention.py
+++ b/tools/perf/scripts/python/futex-contention.py
@@ -10,6 +10,8 @@
 #
 # Measures futex contention
 
+from __future__ import print_function
+
 import os, sys
 sys.path.append(os.environ['PERF_EXEC_PATH'] + '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 from Util import *
@@ -33,18 +35,18 @@ def syscalls__sys_enter_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
 
 def syscalls__sys_exit_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
 			     nr, ret):
-	if thread_blocktime.has_key(tid):
+	if tid in thread_blocktime:
 		elapsed = nsecs(s, ns) - thread_blocktime[tid]
 		add_stats(lock_waits, (tid, thread_thislock[tid]), elapsed)
 		del thread_blocktime[tid]
 		del thread_thislock[tid]
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	for (tid, lock) in lock_waits:
 		min, max, avg, count = lock_waits[tid, lock]
-		print "%s[%d] lock %x contended %d times, %d avg ns" % \
-			(process_names[tid], tid, lock, count, avg)
+		print("%s[%d] lock %x contended %d times, %d avg ns" %
+			(process_names[tid], tid, lock, count, avg))
 
-- 
2.20.1

