Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20B9C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8866E2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808412;
	bh=CJhC+yEJkjbu6GxuLOJBXyjcalbFEy1FjFZZiQpyy3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i71Kf6UGTd7tJEetMgHADrHrd0vJIogykWoTr/RKw4SarVsFXcopEC+ZrghqwjsFU
	 NmNdzKcCM9/zlHlaIzhqlonmaPcczqL9xiy1JFkv96peGoLO3sdLStZG57n8P3OMZz
	 Fg2NZss17TMbY4MZ469Pm6bwNkETZSFcTm/LrJF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfHNSqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfHNSqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:46:51 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF5C921721;
        Wed, 14 Aug 2019 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808409;
        bh=CJhC+yEJkjbu6GxuLOJBXyjcalbFEy1FjFZZiQpyy3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEE7QFTpc/SSyqsoq5Y9tsVNWR9iJyiFsLrHhnfqjxQaaf4pIJ4kcGN82iI7J4qUc
         SFtpdnC0iS3B1auGyjT9w5ZnvG0oN7SsyjV2FwxC14Lu/X7mJRb6QAFnDwIYWYpmvP
         35PvfFLUWhQ5DmeagcJIcF9UfuHtYqaSEC10otXY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Vince Weaver <vincent.weaver@maine.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Chong Jiang <chongjiang@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Simon Que <sque@chromium.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/28] perf.data documentation: Clarify HEADER_SAMPLE_TOPOLOGY format
Date:   Wed, 14 Aug 2019 15:40:49 -0300
Message-Id: <20190814184051.3125-27-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vince Weaver <vincent.weaver@maine.edu>

The perf.data file format documentation for HEADER_SAMPLE_TOPOLOGY
specifies the layout in a confusing manner that doesn't match the rest
of the document.  This patch attempts to describe things consistent with
the rest of the file.

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1908011425240.14303@macbook-air
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/perf.data-file-format.txt   | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index d030c87ed9f5..b0152e1095c5 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -298,16 +298,21 @@ Physical memory map and its node assignments.
 
 The format of data in MEM_TOPOLOGY is as follows:
 
-   0 - version          | for future changes
-   8 - block_size_bytes | /sys/devices/system/memory/block_size_bytes
-  16 - count            | number of nodes
-
-For each node we store map of physical indexes:
-
-  32 - node id          | node index
-  40 - size             | size of bitmap
-  48 - bitmap           | bitmap of memory indexes that belongs to node
-                        | /sys/devices/system/node/node<NODE>/memory<INDEX>
+	u64 version;            // Currently 1
+	u64 block_size_bytes;   // /sys/devices/system/memory/block_size_bytes
+	u64 count;              // number of nodes
+
+struct memory_node {
+        u64 node_id;            // node index
+        u64 size;               // size of bitmap
+        struct bitmap {
+		/* size of bitmap again */
+                u64 bitmapsize;
+		/* bitmap of memory indexes that belongs to node     */
+		/* /sys/devices/system/node/node<NODE>/memory<INDEX> */
+                u64 entries[(bitmapsize/64)+1];
+        }
+}[count];
 
 The MEM_TOPOLOGY can be displayed with following command:
 
-- 
2.21.0

