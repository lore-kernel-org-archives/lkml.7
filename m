Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A6C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269F02070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nApa+VUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfFVGvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:51:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfFVGvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:51:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6pTAr2010600
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:51:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6pTAr2010600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561186289;
        bh=Nl7psbNUKkZ1PLz3JfKTQQKFsHfDlgj3uqW4W7PGTlA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=nApa+VUGsnzdCqVyuIvPF9egmQmh8UDmjfSp7fDLN+uf3uFdhro9tfStHf2jXEM2q
         i8kMqUetfE1WsGONke/r/OjtQOvQyhE4RekOLCxzJv2pUImH3Pv2/227Mc16nKV3/h
         CAQScyOBw3zzOfy/uoW/SmOXg6n/jHy/lCMeOXlcePQy5ECjJAvketRLYqIaFR6bQZ
         QlFuFEOgAswxR2sKwV4R4su3M+P2iAUrAnpX7QI0A6+1Eg1DOZmdqHMLS9MS74rFLg
         d9dwF1zFjKJmHST02oQwfzBOLePBUHqAzKUfYy5FRoPB60m1p/NcpROzeSsEnQ3I5w
         06qWw2alnDu4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6pTIi2010597;
        Fri, 21 Jun 2019 23:51:29 -0700
Date:   Fri, 21 Jun 2019 23:51:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ma4abk0utroiw4mwpmvnjlru@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, jolsa@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, acme@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de
Reply-To: acme@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
          alexey.budankov@linux.intel.com, jolsa@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools build: Fix the zstd test in the test-all.c
 common case feature test
Git-Commit-ID: 3469fa84c1631face938efc42b3f488a2c2504e0
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

Commit-ID:  3469fa84c1631face938efc42b3f488a2c2504e0
Gitweb:     https://git.kernel.org/tip/3469fa84c1631face938efc42b3f488a2c2504e0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Jun 2019 17:59:16 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Jun 2019 18:44:24 -0300

tools build: Fix the zstd test in the test-all.c common case feature test

We were renanimg 'main' to 'main_zstd' but then using 'main_libzstd();'
in the main() for test-all.c, causing this:

  $ cat /tmp/build/perf/feature/test-all.make.output
  test-all.c: In function ‘main’:
  test-all.c:236:2: error: implicit declaration of function ‘main_test_libzstd’; did you mean ‘main_test_zstd’? [-Werror=implicit-function-declaration]
    main_test_libzstd();
    ^~~~~~~~~~~~~~~~~
    main_test_zstd
  cc1: all warnings being treated as errors
  $

I.e. what was supposed to be the fast path feature test was _always_
failing, duh, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Fixes: 3b1c5d965971 ("tools build: Implement libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines")
Link: https://lkml.kernel.org/n/tip-ma4abk0utroiw4mwpmvnjlru@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 3b3d5d72124a..88145e8cde1a 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -186,7 +186,7 @@
 # include "test-disassembler-four-args.c"
 #undef main
 
-#define main main_test_zstd
+#define main main_test_libzstd
 # include "test-libzstd.c"
 #undef main
 
