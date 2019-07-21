Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F351C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F7E2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708767;
	bh=q/TCGVlTK+GYh50cnF6hLvP3tzhbPVdmP6mPqvmcHq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cl9uZ7gpn3nDH8C856d2R+yGFWQ0iSNshZCR5XB3zYlTOXQletvr+PW3HtgnNICds
	 DXzG/wgq/lDzVqUkrF0R57EtzXCHB6gg3mhao93JcKiBbZOEeWn31M2RaECZPIrOJX
	 Ydi54WZu4yYp+OGBmqrLve0bgQOHzozbYeAiXZeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfGULcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:32:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:32:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5E4659455;
        Sun, 21 Jul 2019 11:32:45 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96F8B5D9D3;
        Sun, 21 Jul 2019 11:32:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 73/79] libperf: Add perf_cpu_map test
Date:   Sun, 21 Jul 2019 13:25:00 +0200
Message-Id: <20190721112506.12306-74-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 21 Jul 2019 11:32:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add simple perf_cpu_map tests.

Link: http://lkml.kernel.org/n/tip-143x51wped4tlsb06sapbfp0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/tests/Makefile      |  2 +-
 tools/perf/lib/tests/test-cpumap.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/lib/tests/test-cpumap.c

diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index de951ae38dea..b72c8c47df61 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
-TESTS =
+TESTS = test-cpumap
 
 TESTS_SO := $(addsuffix -so,$(TESTS))
 TESTS_A  := $(addsuffix -a,$(TESTS))
diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/perf/lib/tests/test-cpumap.c
new file mode 100644
index 000000000000..76a43cfb83a1
--- /dev/null
+++ b/tools/perf/lib/tests/test-cpumap.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/cpumap.h>
+#include <internal/tests.h>
+
+int main(int argc, char **argv)
+{
+	struct perf_cpu_map *cpus;
+
+	__T_START;
+
+	cpus = perf_cpu_map__dummy_new();
+	if (!cpus)
+		return -1;
+
+	perf_cpu_map__get(cpus);
+	perf_cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
+
+	__T_OK;
+	return 0;
+}
-- 
2.21.0

