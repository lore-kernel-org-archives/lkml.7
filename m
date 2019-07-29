Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2119AC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD8C216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfG2H2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:28:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:17257 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfG2H2j (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:28:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 00:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,321,1559545200"; 
   d="scan'208";a="370391093"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2019 00:28:36 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf pmu-events: Fix the missing "cpu_clk_unhalted.core"
Date:   Mon, 29 Jul 2019 15:27:55 +0800
Message-Id: <20190729072755.2166-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The events defined in pmu-events JSON are parsed and added into
perf tool. For fixed counters, we handle the encodings between
JSON and perf by using a static array fixed[].

But the fixed[] has missed an important event "cpu_clk_unhalted.core".

For example, on tremont platform,

[root@localhost ~]# perf stat -e cpu_clk_unhalted.core -a
event syntax error: 'cpu_clk_unhalted.core'
                     \___ parser error

With this patch, the event cpu_clk_unhalted.core can be parsed.

[root@localhost perf]# ./perf stat -e cpu_clk_unhalted.core -a -vvv
------------------------------------------------------------
perf_event_attr:
  type                             4
  size                             112
  config                           0x3c
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
...

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 1a91a197cafb..d413761621b0 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -453,6 +453,7 @@ static struct fixed {
 	{ "inst_retired.any_p", "event=0xc0" },
 	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
 	{ "cpu_clk_unhalted.thread", "event=0x3c" },
+	{ "cpu_clk_unhalted.core", "event=0x3c" },
 	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
 	{ NULL, NULL},
 };
-- 
2.17.1

