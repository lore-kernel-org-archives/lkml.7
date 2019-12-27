Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F22C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68A620CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="EHSHlxdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfL0NFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:05:37 -0500
Received: from ms11p00im-qufo17281801.me.com ([17.58.38.55]:49954 "EHLO
        ms11p00im-qufo17281801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbfL0NFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 08:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1577451350; bh=s9hWzN0zP5CsOxxqgzn7glLJPvL9xTBIozfC5xBGCng=;
        h=From:To:Subject:Date:Message-Id;
        b=EHSHlxdOHGLsDRMX4sTnrG3ZjycRyeAShNv+o0sXspi31MBNtjgFtN+t6FbRg+dyQ
         2lhrT+62Aq6Hd5YJBCGbdZkuXigdG4Yayggtjss9UCo+c6NagDngmetYZoc9y3Kjx0
         szdC+6KwV/x7VZ4p7NV2VHr63n+KdU+7zpuO/cEbZ4XHxcJaZJ9YhL+ZsvxrBdP0hy
         6Hn9+E0ikI1LJPoot8rtrsxETls5TufEs/h979iOmOfvVOSBjZb2TxbJ6bnO2foXjx
         UXvhRExb2D8QyNYgId2MTgUuOj+R7OwhpcGtGC05UNvmMsMBXFRmUd7VzM3i/Lg3pB
         TBryUKpGB+4hw==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by ms11p00im-qufo17281801.me.com (Postfix) with ESMTPSA id AFF821007B4;
        Fri, 27 Dec 2019 12:55:49 +0000 (UTC)
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Vijay Thakkar <vijaythakkar@me.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf vendor events amd: restrict model detection for zen1 based processors
Date:   Fri, 27 Dec 2019 07:55:34 -0500
Message-Id: <20191227125536.1091387-2-vijaythakkar@me.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191227125536.1091387-1-vijaythakkar@me.com>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912270111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the previous blanket detection of AMD Family 17h
processors to be more specific to Zen1 core based products only by
replacing model detection regex pattern [[:xdigit:]]+ with [01][18],
restricting to models 01, 08, 11 and 18 only.

This change is required to allow for the addition of separate PMU events
for Zen2 core based models in the following patches as those belong to family
17h but have different PMCs. Current PMU events directory has also been
renamed to "amdzen1" from "amdfam17h" to reflect this specificity.

Note that although this change does not break PMU counters for existing
zen1 based systems, it does disable the current set of counters for zen2
based systems. Counters for zen2 have been added in the following
patches in this patchset.

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
---
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json  | 0
 tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json | 0
 .../arch/x86/{amdfam17h => amdzen1}/floating-point.json         | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json  | 0
 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 7 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/branch.json b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/branch.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/cache.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/core.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/core.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/memory.json b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/memory.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/other.json b/tools/perf/pmu-events/arch/x86/amdzen1/other.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/other.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/other.json
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 745ced083844..cb1454017557 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -36,4 +36,4 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
-AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
+AuthenticAMD-23-[01][18],v1,amdzen1,core
-- 
2.24.1

