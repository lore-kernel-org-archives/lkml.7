Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1153CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D719120848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551799545;
	bh=gSSi9xW8COlghtU0dRARMX/o1jhIhhQzrhY60N5GY2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GqT0RcqFwtPQ59bfDp+Y36sqsw9e8GwoMp0LU7eNb/XvWPos0JvnslblB59I95q1R
	 gW2Q5sCa5bWP7l73E74r5DYmI48+YW6ONIi5wvX4Zgqh4FXCmNzOARc4PNIJi8Rm3t
	 d9pYXlelz6ZrA31UoqV3hmvu9D1pZm7cR1qZu+64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfCEPZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:25:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfCEPZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:25:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80FEC88304;
        Tue,  5 Mar 2019 15:25:42 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 391231001E61;
        Tue,  5 Mar 2019 15:25:40 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/8] perf c2c: Fix c2c report for empty numa node
Date:   Tue,  5 Mar 2019 16:25:29 +0100
Message-Id: <20190305152536.21035-2-jolsa@kernel.org>
In-Reply-To: <20190305152536.21035-1-jolsa@kernel.org>
References: <20190305152536.21035-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 05 Mar 2019 15:25:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Ravi Bangoria reported that we fail with empty
numa node with following message:

  $ lscpu
  NUMA node0 CPU(s):
  NUMA node1 CPU(s):   0-4

  $ sudo ./perf c2c report
  node/cpu topology bugFailed setup nodes

Fixing this by detecting empty node and keeping
its cpu set empty.

Reported-by: Nageswara R Sastry <nasastry@in.ibm.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/n/tip-dyq5jo6pn1j3yqavb5ukjwwu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-c2c.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4272763a5e96..9e6cc868bdb4 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2056,6 +2056,12 @@ static int setup_nodes(struct perf_session *session)
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
 
@@ -2064,8 +2070,6 @@ static int setup_nodes(struct perf_session *session)
 
 			cpu2node[map->map[cpu]] = node;
 		}
-
-		nodes[node] = set;
 	}
 
 	setup_nodes_header();
-- 
2.17.2

