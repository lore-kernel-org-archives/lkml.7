Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A70C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA87F207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfCIUGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:06:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCIUGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:06:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K5cKM3205722
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:05:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K5beh3205719;
        Sat, 9 Mar 2019 12:05:37 -0800
Date:   Sat, 9 Mar 2019 12:05:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e34c940245437f36d2c492edd1f8237eff391064@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jonas.rabenstein@studium.uni-erlangen.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        nasastry@in.ibm.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, peterz@infradead.org,
        ravi.bangoria@linux.ibm.com
Reply-To: ravi.bangoria@linux.ibm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          ak@linux.intel.com, peterz@infradead.org, nasastry@in.ibm.com,
          jolsa@redhat.com, namhyung@kernel.org,
          jonas.rabenstein@studium.uni-erlangen.de,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          jolsa@kernel.org, acme@redhat.com
In-Reply-To: <20190305152536.21035-2-jolsa@kernel.org>
References: <20190305152536.21035-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf c2c: Fix c2c report for empty numa node
Git-Commit-ID: e34c940245437f36d2c492edd1f8237eff391064
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

Commit-ID:  e34c940245437f36d2c492edd1f8237eff391064
Gitweb:     https://git.kernel.org/tip/e34c940245437f36d2c492edd1f8237eff391064
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Tue, 5 Mar 2019 16:25:29 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:15:24 -0300

perf c2c: Fix c2c report for empty numa node

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
