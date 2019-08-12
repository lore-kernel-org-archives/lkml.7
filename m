Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CF5C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1BF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfHLJKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:10:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:23185 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfHLJKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:10:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 02:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,376,1559545200"; 
   d="scan'208";a="193915180"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2019 02:10:42 -0700
Subject: Re: [RFC] perf_sample_id::idx
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190809092736.GA9377@krava>
 <363DA0ED52042842948283D2FC38E4649C5B1DB0@IRSMSX106.ger.corp.intel.com>
 <20190809160421.GB9280@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <83ff264f-84c3-5372-8976-dd9293d20c6f@intel.com>
Date:   Mon, 12 Aug 2019 12:09:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809160421.GB9280@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/08/19 7:04 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 09, 2019 at 03:20:14PM +0000, Hunter, Adrian escreveu:
> 
>> It will be used for AUX area sampling.  A sample will have AUX area
>> data that will be queued for decoding, where there are separate queues
>> for each CPU (per-cpu tracing) or task (per-thread tracing).  The
>> sample ID can be used to lookup 'idx' which is effectively the queue
>> number.
> 
> Would be good to have this as a comment in the perf_sample_id struct
> definition :-)


From 45d57bd7b25c9864f21e25534274ea461ff83d9d Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Mon, 12 Aug 2019 12:06:31 +0300
Subject: [PATCH] perf tools: Add comment for idx in struct perf_sample_id

'idx' was added as preparation for AUX area sampling. Add a comment to
describe why.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evsel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cad54e8ba522..ba13eb771775 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -22,6 +22,13 @@ struct perf_sample_id {
 	struct hlist_node 	node;
 	u64		 	id;
 	struct perf_evsel	*evsel;
+	/*
+	 * 'idx' will be used for AUX area sampling. A sample will have AUX area
+	 * data that will be queued for decoding, where there are separate
+	 * queues for each CPU (per-cpu tracing) or task (per-thread tracing).
+	 * The sample ID can be used to lookup 'idx' which is effectively the
+	 * queue number.
+	 */
 	int			idx;
 	int			cpu;
 	pid_t			tid;
-- 
2.17.1

