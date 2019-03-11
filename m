Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C76C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAFB2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfCKUZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:25:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:37486 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbfCKUYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:24:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="306300709"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2019 13:24:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A709A301E34; Mon, 11 Mar 2019 13:24:48 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 02/10] perf, tools, stat: Avoid memory overrun with -r
Date:   Mon, 11 Mar 2019 13:24:38 -0700
Message-Id: <20190311202446.10210-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When -r is used memory would get corrupted because the evsel->id array
would get overrun. evsel->ids is a running counter of the last id.
Normally this works fine, but with -r the same event is initialized
multiple times, but not this counter, so it would keep growing
beyond the array limit and corrupt random memory.

Always reinitialize ->ids, and also add an assert to catch
such overruns in the future.

This fixes a perf segfault when running it from toplev.

Before:

$ valgrind perf stat -r2 -e '{cycles,cycles,cycles,cycles}' true
==27012== Memcheck, a memory error detector
==27012== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==27012== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
==27012== Command: perf stat -r2 -e {cycles,cycles,cycles,cycles} true
==27012==
==27012== Invalid write of size 8
==27012==    at 0x33090F: perf_evlist__id_add_fd (in /usr/bin/perf)
==27012==    by 0x33C99B: perf_evsel__store_ids (in /usr/bin/perf)
==27012==    by 0x2B7E1D: ??? (in /usr/bin/perf)
==27012==    by 0x2B97DE: cmd_stat (in /usr/bin/perf)
==27012==    by 0x31BFC0: ??? (in /usr/bin/perf)
==27012==    by 0x29C7A9: main (in /usr/bin/perf)
==27012==  Address 0x13182be8 is 0 bytes after a block of size 8 alloc'd
==27012==    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
==27012==    by 0x33C921: perf_evsel__store_ids (in /usr/bin/perf)
==27012==    by 0x2B7E1D: ??? (in /usr/bin/perf)
==27012==    by 0x2B97DE: cmd_stat (in /usr/bin/perf)
==27012==    by 0x31BFC0: ??? (in /usr/bin/perf)
==27012==    by 0x29C7A9: main (in /usr/bin/perf)
==27012==
...

After:

$ valgrind ./perf stat -r2 -e '{cycles,cycles,cycles,cycles}' true
==27026== Memcheck, a memory error detector
==27026== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==27026== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
==27026== Command: ./perf stat -r2 -e {cycles,cycles,cycles,cycles} true
==27026==

 Performance counter stats for 'true' (2 runs):

...

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evlist.c | 1 +
 tools/perf/util/evsel.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ed20f4379956..4f02bccba204 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -529,6 +529,7 @@ void perf_evlist__id_add(struct perf_evlist *evlist, struct perf_evsel *evsel,
 			 int cpu, int thread, u64 id)
 {
 	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
+	assert(evsel->ids < evsel->sample_id->max_x * evsel->sample_id->max_y);
 	evsel->id[evsel->ids++] = id;
 }
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3bbf73e979c0..686318f69b1d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3001,5 +3001,7 @@ int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
 	if (perf_evsel__alloc_id(evsel, cpus->nr, threads->nr))
 		return -ENOMEM;
 
+	evsel->ids = 0;
+
 	return store_evsel_ids(evsel, evlist);
 }
-- 
2.20.1

