Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6662AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FC42173C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121992;
	bh=UDo43vC2wVRmBPbLoisH72NfeNQ6hqjWGu6dozUZNnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JylHLZXW+ca+OWDbSbXdqE85KisDwupZ6dQ6m24XhS5qltkCnRQqGrfesgZb3zxU0
	 OKUzlmY9KxAO48q4zgQEAB0+/wdC9Ol89ddOTEGfILiq4mbOltkuZnnR5ongRawAbM
	 mERA5odN8M2TykIqu2QYl5muKdCp/B/FNPM52x+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfEQTjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbfEQTjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:39:49 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED35D2087B;
        Fri, 17 May 2019 19:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121989;
        bh=UDo43vC2wVRmBPbLoisH72NfeNQ6hqjWGu6dozUZNnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xeiLNrl7vGdsArQGEGv/dPrd/zObAQzpRT3oUTiCfM6ex1f6emreBnoB/2aeSHKCY
         OuIDjxwdgtEAtbXLd58i4OwiMP1CbD1tS1LT2vDyxAdbklZLEDNJrZYfBOmV5UlBVD
         LcxMKp9AlOs3SU8Eit3vdfBYIyONDBNOagIfo79o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 47/73] perf build tests: Add NO_LIBZSTD=1 to make_minimal
Date:   Fri, 17 May 2019 16:35:45 -0300
Message-Id: <20190517193611.4974-48-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can test the ifdef parts for this feature.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-7o65mfl10wlvm8v3f0ombxd1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index e46723568516..5363a12a8b9b 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -107,7 +107,7 @@ make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
-make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
+make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
 
 # $(run) contains all available tests
 run := make_pure
-- 
2.20.1

