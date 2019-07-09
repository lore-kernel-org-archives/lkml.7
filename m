Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7BCC004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3095620844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PJZadRXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGILbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:31:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34857 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGILbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:31:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BVNN81893010
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:31:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BVNN81893010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562671884;
        bh=0e+XPDH4aHASh91juGttkdYHOkd+mmDsf6hGC986u4I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PJZadRXOUtMebLqtly3iD/DbKFj2/zkRRmQ9a+AyZnaIH0G61n3Ar3XBZ/lM0rbpn
         WkU48mtftE5iOGvI4aNlLRG1DXFbynk0OTIicTLOXTG7Yh7pcMUdCRKt4HyOSnEJKd
         UGzJcWfmNj8H8HOfeqh6e6B7y32es5++DkvtbnS2crdcmJ05Z5q428SXOY39ic29qV
         vJTqKDiU7X11T7JaUTTrcpXrWpKUG4JdGlfri0j8Q/K3El72yOM3rPkgCqI1L3+bi0
         0Srq/K2vTFMwZQgx6e71VXT+gQzGbEBR72ArkZmAjGxzcjez7VtNTrjx+wTKzuVjq3
         nHBzCbi8fhJdw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BVNDR1893007;
        Tue, 9 Jul 2019 04:31:23 -0700
Date:   Tue, 9 Jul 2019 04:31:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Seeteena Thoufeek <tipbot@zytor.com>
Message-ID: <tip-bff5a556c149804de29347a88a884d25e4e4e3a2@git.kernel.org>
Cc:     mpetlan@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, kim.phillips@amd.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        jolsa@redhat.com, brueckner@linux.ibm.com, namhyung@kernel.org,
        acme@redhat.com, s1seetee@linux.vnet.ibm.com,
        sandipan@linux.ibm.com
Reply-To: kim.phillips@amd.com, hpa@zytor.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          mpetlan@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
          s1seetee@linux.vnet.ibm.com, sandipan@linux.ibm.com,
          brueckner@linux.ibm.com, namhyung@kernel.org
In-Reply-To: <1561630614-3216-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1561630614-3216-1-git-send-email-s1seetee@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Fix record+probe_libc_inet_pton.sh for
 powerpc64
Git-Commit-ID: bff5a556c149804de29347a88a884d25e4e4e3a2
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

Commit-ID:  bff5a556c149804de29347a88a884d25e4e4e3a2
Gitweb:     https://git.kernel.org/tip/bff5a556c149804de29347a88a884d25e4e4e3a2
Author:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
AuthorDate: Thu, 27 Jun 2019 15:46:54 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 6 Jul 2019 14:31:01 -0300

perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64

'probe libc's inet_pton & backtrace it with ping' testcase sometimes
fails on powerpc because distro ping binary does not have symbol
information and thus it prints "[unknown]" function name in the
backtrace.

Accept "[unknown]" as valid function name for powerpc as well.

 # perf test -v "probe libc's inet_pton & backtrace it with ping"

Before:

  59: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 79695
  ping 79718 [077] 96483.787025: probe_libc:inet_pton: (7fff83a754c8)
  7fff83a754c8 __GI___inet_pton+0x8 (/usr/lib64/power9/libc-2.28.so)
  7fff83a2b7a0 gaih_inet.constprop.7+0x1020
  (/usr/lib64/power9/libc-2.28.so)
  7fff83a2c170 getaddrinfo+0x160 (/usr/lib64/power9/libc-2.28.so)
  1171830f4 [unknown] (/usr/bin/ping)
  FAIL: expected backtrace entry
  ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
  got "1171830f4 [unknown] (/usr/bin/ping)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

After:

  59: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 79085
  ping 79108 [045] 96400.214177: probe_libc:inet_pton: (7fffbb9654c8)
  7fffbb9654c8 __GI___inet_pton+0x8 (/usr/lib64/power9/libc-2.28.so)
  7fffbb91b7a0 gaih_inet.constprop.7+0x1020
  (/usr/lib64/power9/libc-2.28.so)
  7fffbb91c170 getaddrinfo+0x160 (/usr/lib64/power9/libc-2.28.so)
  132e830f4 [unknown] (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Fixes: 1632936480a5 ("perf tests: Fix record+probe_libc_inet_pton.sh without ping's debuginfo")
Link: http://lkml.kernel.org/r/1561630614-3216-1-git-send-email-s1seetee@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 61c9f8fc6fa1..58a99a292930 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -44,7 +44,7 @@ trace_libc_inet_pton_backtrace() {
 		eventattr='max-stack=4'
 		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
 		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		echo ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	*)
 		eventattr='max-stack=3'
