Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE32C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B0220644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564669608;
	bh=+9UAlX25s5bQX60iPJY+LjwdNV9o20Cq2esbTNNP+wA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JZgXXdLW7F2cREvTKBdUAvyEFi9MkxFgfnuUF+VMn5M8xnTAX+qcyhsVKb7/FaZib
	 fZJA09DaQEsmAt91PLCaMSeZ05eLcI41/x5L7NzsFT8muu8p2q1RV6nGMxMDTXZ1/q
	 ZC4U3r3f0/cCjmTpbm1PzCsT3ORMjkKfs0ScVoYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbfHAO0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbfHAO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:26:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 640F030020C0;
        Thu,  1 Aug 2019 14:26:45 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 422B6600C4;
        Thu,  1 Aug 2019 14:26:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf bench numa: Fix cpu0 binding
Date:   Thu,  1 Aug 2019 16:26:42 +0200
Message-Id: <20190801142642.28004-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 01 Aug 2019 14:26:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael reported an issue with perf bench numa failing with
binding to cpu0 with '-0' option.

  # perf bench numa mem -p 3 -t 1 -P 512 -s 100 -zZcm0 --thp 1 -M 1 -ddd
  # Running 'numa/mem' benchmark:

   # Running main, "perf bench numa numa-mem -p 3 -t 1 -P 512 -s 100 -zZcm0 --thp 1 -M 1 -ddd"
  binding to node 0, mask: 0000000000000001 => -1
  perf: bench/numa.c:356: bind_to_memnode: Assertion `!(ret)' failed.
  Aborted (core dumped)

This happens when the cpu0 is not part of node0,
which is the benchmark assumption and we can see
that's not the case for some powerpc servers.

Using correct node for cpu0 binding.

Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Reported-by: Michael Petlan <mpetlan@redhat.com>
Link: http://lkml.kernel.org/n/tip-9m9j1xm3xjaa1sogvbva0o8i@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/bench/numa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index a640ca7aaada..513cb2f2fa32 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -379,8 +379,10 @@ static u8 *alloc_data(ssize_t bytes0, int map_flags,
 
 	/* Allocate and initialize all memory on CPU#0: */
 	if (init_cpu0) {
-		orig_mask = bind_to_node(0);
-		bind_to_memnode(0);
+		int node = numa_node_of_cpu(0);
+
+		orig_mask = bind_to_node(node);
+		bind_to_memnode(node);
 	}
 
 	bytes = bytes0 + HPSIZE;
-- 
2.21.0

