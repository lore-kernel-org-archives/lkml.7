Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6487DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B10721900
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfCPORv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:17:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:17683 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfCPORu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:17:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Mar 2019 07:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,486,1544515200"; 
   d="scan'208";a="125993796"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2019 07:17:49 -0700
Received: from [10.252.10.233] (abudanko-mobl.ccr.corp.intel.com [10.252.10.233])
        by linux.intel.com (Postfix) with ESMTP id C3CDC580310;
        Sat, 16 Mar 2019 07:17:47 -0700 (PDT)
Subject: [PATCH v9 11/12] perf inject: enable COMPRESSED records decompression
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7b39b723-ff32-3dfd-54f8-81ce6163952f@linux.intel.com>
Date:   Sat, 16 Mar 2019 17:17:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Initialized decompression part of Zstd based API so COMPRESSED records
would be decompressed into the resulting output data file.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-inject.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 24086b7f1b14..8e0e06d3edfc 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -837,6 +837,9 @@ int cmd_inject(int argc, const char **argv)
 	if (inject.session == NULL)
 		return -1;
 
+	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
+		pr_warning("Decompression initialization failed.\n");
+
 	if (inject.build_ids) {
 		/*
 		 * to make sure the mmap records are ordered correctly
@@ -867,6 +870,7 @@ int cmd_inject(int argc, const char **argv)
 	ret = __cmd_inject(&inject);
 
 out_delete:
+	zstd_fini(&(inject.session->zstd_data));
 	perf_session__delete(inject.session);
 	return ret;
 }
-- 
2.20.1

