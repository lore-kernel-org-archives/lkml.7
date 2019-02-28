Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC24AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86D32184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbfB1JRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:17:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:29009 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732006AbfB1JRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:17:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 01:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,422,1544515200"; 
   d="scan'208";a="119754686"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2019 01:17:14 -0800
Received: from [10.251.86.205] (abudanko-mobl.ccr.corp.intel.com [10.251.86.205])
        by linux.intel.com (Postfix) with ESMTP id 1764458040E;
        Thu, 28 Feb 2019 01:17:11 -0800 (PST)
Subject: [PATCH v4 09/10] perf inject: enable COMPRESSED records decompression
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7913ce8c-2461-0461-612e-0fb35fa0d6d6@linux.intel.com>
Date:   Thu, 28 Feb 2019 12:17:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Initialized decompression API so COMPRESSED record would be
decompressed into the resulting output data file.

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
