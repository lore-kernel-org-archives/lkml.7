Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F6BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39CD2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfB1HiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:38:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36901 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbfB1Hh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:37:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7bnPA2947122
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:37:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7bmYi2947118;
        Wed, 27 Feb 2019 23:37:48 -0800
Date:   Wed, 27 Feb 2019 23:37:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b00ccb27f97367d89e2d7b419ed198b0985be55d@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de, namhyung@kernel.org
Reply-To: jolsa@kernel.org, peterz@infradead.org, hpa@zytor.com,
          namhyung@kernel.org, tglx@linutronix.de, acme@redhat.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190219095815.15931-2-jolsa@kernel.org>
References: <20190219095815.15931-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf header: Fix wrong node write in NUMA_TOPOLOGY
 feature
Git-Commit-ID: b00ccb27f97367d89e2d7b419ed198b0985be55d
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

Commit-ID:  b00ccb27f97367d89e2d7b419ed198b0985be55d
Gitweb:     https://git.kernel.org/tip/b00ccb27f97367d89e2d7b419ed198b0985be55d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 19 Feb 2019 10:58:12 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Feb 2019 12:20:55 -0300

perf header: Fix wrong node write in NUMA_TOPOLOGY feature

We are currently passing the node index instead of the real node number.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: fbe96f29ce4b ("perf tools: Make perf.data more self-descriptive (v8)"
Link: http://lkml.kernel.org/r/20190219095815.15931-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 61ce197c5362..c66f26ec557a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -879,7 +879,7 @@ static int write_numa_topology(struct feat_fd *ff,
 		if (ret < 0)
 			break;
 
-		ret = write_topo_node(ff, i);
+		ret = write_topo_node(ff, j);
 		if (ret < 0)
 			break;
 	}
