Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D63C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3145021871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124549;
	bh=kYNNnTVusaKzqFKhMtG1xMqObGAGIPB0g+azlIzMGwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mVqjyBJrD3YN9FdF13es5z1j4wus7OBwP4iUFnnA9l2vhaCX1s5T31pY16n4Jsuhl
	 O/nWJSw4wxxiD5O11La/czQ2vVXxj5LU2XIpFF9uywZgAjzB3oEcuuhmNLhKCrychL
	 85N4GdUDVRM61qZAGNj7yQEQxMkuCqCNxfb32ok4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfGCD3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfGCD3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:29:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A6A218A5;
        Wed,  3 Jul 2019 03:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124543;
        bh=kYNNnTVusaKzqFKhMtG1xMqObGAGIPB0g+azlIzMGwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oDI/LywGOReWG32PEigvwpFMLn0T3fLjKccpR0OAPvsgQ6p7GGUZYgR9jJLYUET65
         Hy0uujKonrve0x9bU7EPx8+wkMngaTEcF/kkXY1A+UK4/tPrq8dy3jpHRzZNjeeJk5
         FraIzgGxNKuPyXSG60TFMse82VJjg+OV2b9v+n8M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/18] perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64
Date:   Wed,  3 Jul 2019 00:27:45 -0300
Message-Id: <20190703032746.21692-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>

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
index 9b7632ff70aa..f12a4e217968 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -45,7 +45,7 @@ trace_libc_inet_pton_backtrace() {
 		eventattr='max-stack=4'
 		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
 		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		echo ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	*)
 		eventattr='max-stack=3'
-- 
2.20.1

