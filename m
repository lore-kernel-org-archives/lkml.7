Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DE2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634682075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715127;
	bh=x4MhSkptBmrxmSueydlgZ0nCt+DZJXIU//L7kIRqYOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PALpHnWADMe/5DrdnDGpfq7ht5sVSsY3u9U7jPzX+/m0zJ1/tSt7bdvzQ+tT5jGSY
	 EsALPq/jNqGFlWFAJmgqecarNS2HqtdW2fF3hc+0ZiagacaR3TXYWPus8/vmzqNDwA
	 iLJw3cAkrOFcqtxH5kCqePmPtGxfbJUSAO8xLvzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfC0TcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731437AbfC0SCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1591217D7;
        Wed, 27 Mar 2019 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709765;
        bh=x4MhSkptBmrxmSueydlgZ0nCt+DZJXIU//L7kIRqYOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEe68W/BEdGdR4yA7sUrV41xKOqUG0dxAidPaE7JoCEcvLIrmuVlKkiEF+HUEtOkJ
         8fXIwOnhvroSOG+gF2o/AiFwPRC25JiSdyhzkDSrvu6NVR2nFzSUV51SbdzH7K5t8A
         tHzlipfhpbSlMBolFmapfaNhs75I1wfMCl57+U0E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 029/262] perf c2c: Fix c2c report for empty numa node
Date:   Wed, 27 Mar 2019 13:58:04 -0400
Message-Id: <20190327180158.10245-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

[ Upstream commit e34c940245437f36d2c492edd1f8237eff391064 ]

Ravi Bangoria reported that we fail with an empty NUMA node with the
following message:

  $ lscpu
  NUMA node0 CPU(s):
  NUMA node1 CPU(s):   0-4

  $ sudo ./perf c2c report
  node/cpu topology bugFailed setup nodes

Fix this by detecting the empty node and keeping its CPU set empty.

Reported-by: Nageswara R Sastry <nasastry@in.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190305152536.21035-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-c2c.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d340d2e42776..13758a0b367b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2055,6 +2055,12 @@ static int setup_nodes(struct perf_session *session)
 		if (!set)
 			return -ENOMEM;
 
+		nodes[node] = set;
+
+		/* empty node, skip */
+		if (cpu_map__empty(map))
+			continue;
+
 		for (cpu = 0; cpu < map->nr; cpu++) {
 			set_bit(map->map[cpu], set);
 
@@ -2063,8 +2069,6 @@ static int setup_nodes(struct perf_session *session)
 
 			cpu2node[map->map[cpu]] = node;
 		}
-
-		nodes[node] = set;
 	}
 
 	setup_nodes_header();
-- 
2.19.1

