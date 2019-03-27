Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95697C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A13205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712883;
	bh=mUEFH+d3CdeaqVJY27YOal7duMN9LbXFpzP6aGTJn7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qKfn5srESj+lNp3J3j20GlyKKHAvZEhW7DSiFkzTduq2jreDI7QF51orwyKqPBSGb
	 qmZ+OrzcMfg25mUg9juOF8e0w3U8bDvtzU65zzbB1YpFO3qyk8WUyNrU1JTP6zxqx6
	 v2uLPbqhU2FXJfdvm4vnp3mcEXydQZW4t3nPcm6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389363AbfC0SQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389854AbfC0SQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C0621738;
        Wed, 27 Mar 2019 18:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710611;
        bh=mUEFH+d3CdeaqVJY27YOal7duMN9LbXFpzP6aGTJn7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cgfn0wgSBDOJ/ZYJG4G+2zdJV98qDvLIOYkN3QmrwL5deyumHnHDWP27oor88F+JN
         4K51AcMu5tzGKfX/FMyb/LcOn5s/JxE3SVjwAd5qQQHYPG/P7XK8q4LFJPDrTXUzzB
         afbO72NziMddoi//3lHsXQZTBDSTzxk/kRaAIZ3g=
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
Subject: [PATCH AUTOSEL 4.14 014/123] perf c2c: Fix c2c report for empty numa node
Date:   Wed, 27 Mar 2019 14:14:38 -0400
Message-Id: <20190327181628.15899-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
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
index fb76423022e8..32e64a8a6443 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1935,6 +1935,12 @@ static int setup_nodes(struct perf_session *session)
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
 
@@ -1943,8 +1949,6 @@ static int setup_nodes(struct perf_session *session)
 
 			cpu2node[map->map[cpu]] = node;
 		}
-
-		nodes[node] = set;
 	}
 
 	setup_nodes_header();
-- 
2.19.1

