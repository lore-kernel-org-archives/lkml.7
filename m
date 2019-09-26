Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58E1C4360D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4B4222C1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569457999;
	bh=hMcZV5FiCvCYw5u8wgL3m1i4SBxBtoEscsfcIGuYIUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v4vChtjVRPOL4fMnzrOl4C+4lMpTlVPQDCyO2ZjcxE2ma6JSzPIaY9Qy6lChZohbZ
	 tciqIybDSZKfmgnpEVfHfeWbsawuDPBEsHQTerwURPj1kJU5/fxz2FN6GqloT8UJKe
	 f1k4XRtAUz3oBiodiWeKO0kfxf29l3WrCbzXztJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfIZAdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfIZAdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:11 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83F7222C2;
        Thu, 26 Sep 2019 00:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569457990;
        bh=hMcZV5FiCvCYw5u8wgL3m1i4SBxBtoEscsfcIGuYIUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aInsk+aSiwcJarBV2x3Aka8tfKDufpECSpfdzkPwEl1XDiZ9aufMAJ66uAIIAkAeV
         re1dX0jiHaMBvtZSSbpL2tP1D30c8meP/Ei46ncl6sfv4btBLJRLZfGzSfu2Hpl6xi
         npbxc7NXsJ1BXX0tmb668YH/Ewo9sL3bvvA8V8FY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Janakarajan Natarajan <janakarajan.natarajan@amd.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Luke Mujica <lukemujica@google.com>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/66] perf vendor events amd: Add L3 cache events for Family 17h
Date:   Wed, 25 Sep 2019 21:31:41 -0300
Message-Id: <20190926003244.13962-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

Allow users to symbolically specify L3 events for Family 17h processors
using the existing AMD Uncore driver.

Source of events descriptions are from section 2.1.15.4.1 "L3 Cache PMC
Events" of the latest Family 17h PPR, available here:

  https://www.amd.com/system/files/TechDocs/55570-B1_PUB.zip

Opnly BriefDescriptions added, since they show with and without
the -v and --details flags.

Tested with:

 # perf stat -e l3_request_g1.caching_l3_cache_accesses,amd_l3/event=0x01,umask=0x80/,l3_comb_clstr_state.request_miss,amd_l3/event=0x06,umask=0x01/ perf bench mem memcpy -s 4mb -l 100 -f default
...
         7,006,831      l3_request_g1.caching_l3_cache_accesses
         7,006,830      amd_l3/event=0x01,umask=0x80/
           366,530      l3_comb_clstr_state.request_miss
           366,568      amd_l3/event=0x06,umask=0x01/

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Janakarajan Natarajan <janakarajan.natarajan@amd.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190919204306.12598-1-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/x86/amdfam17h/cache.json  | 42 +++++++++++++++++++
 tools/perf/pmu-events/jevents.c               |  1 +
 2 files changed, 43 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json b/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
index fad4af9142cb..6221a840fcea 100644
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
@@ -283,5 +283,47 @@
     "BriefDescription": "Total cycles spent with one or more fill requests in flight from L2.",
     "PublicDescription": "Total cycles spent with one or more fill requests in flight from L2.",
     "UMask": "0x1"
+  },
+  {
+    "EventName": "l3_request_g1.caching_l3_cache_accesses",
+    "EventCode": "0x01",
+    "BriefDescription": "Caching: L3 cache accesses",
+    "UMask": "0x80",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_l3_req_typs",
+    "EventCode": "0x04",
+    "BriefDescription": "All L3 Request Types",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.other_l3_miss_typs",
+    "EventCode": "0x06",
+    "BriefDescription": "Other L3 Miss Request Types",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.request_miss",
+    "EventCode": "0x06",
+    "BriefDescription": "L3 cache misses",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_sys_fill_latency",
+    "EventCode": "0x90",
+    "BriefDescription": "L3 Cache Miss Latency. Total cycles for all transactions divided by 16. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x00",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_ccx_sdp_req1.all_l3_miss_req_typs",
+    "EventCode": "0x9a",
+    "BriefDescription": "All L3 Miss Request Types. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x3f",
+    "Unit": "L3PMC"
   }
 ]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index d413761621b0..9e37287da924 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -239,6 +239,7 @@ static struct map {
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
+	{ "L3PMC", "amd_l3" },
 	{}
 };
 
-- 
2.21.0

