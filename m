Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2589C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8644521848
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869853;
	bh=BseOfP8rbHdL8pWH4tbfi/dgm6vzQ7GrYHC3zERQXNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g8J57ueFPTmUAfZpTWf5VkBh8LECwBxb/Eg1sRrqJridixyniluD0Wf3Zt9cgF4eZ
	 WrX2PrmIjAj0FjYe70QsZFwsIgue4GxDo+Wo7fVK34ym4lT77VezdpowoTt+RrVu2B
	 96c01GHaBfYMz0K1G7rchfxoI7N0HmWQqwQ309Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfH0Bhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbfH0Bh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A005A2080C;
        Tue, 27 Aug 2019 01:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869846;
        bh=BseOfP8rbHdL8pWH4tbfi/dgm6vzQ7GrYHC3zERQXNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjSi+5R9wHN2pxhO9qZO5e0mTBONN5esEf/qw8baQyvORtPNV2EVRT4htm1UdUs/X
         1kjKALynBTwDb/wBSqdTVaEEPKlOEWo6+joPd9FtxsHAIgjwi6PmfOCn86asJEj87h
         KmW3Ry+PkY8AeRnT/hCcgf0BriJifpP07fyuGsSg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/33] perf report: Fix --ns time sort key output
Date:   Mon, 26 Aug 2019 22:36:16 -0300
Message-Id: <20190827013634.3173-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

If the user specified --ns, the column to print the sort time stamp
wasn't wide enough to actually print the full nanoseconds.

Widen the time key column width when --ns is specified.

Before:

  % perf record -a sleep 1
  % perf report --sort time,overhead,symbol --stdio --ns
  ...
       2.39%  187851.10000  [k] smp_call_function_single   -      -
       1.53%  187851.10000  [k] intel_idle                 -      -
       0.59%  187851.10000  [.] __wcscmp_ifunc             -      -
       0.33%  187851.10000  [.] 0000000000000000           -      -
       0.28%  187851.10000  [k] cpuidle_enter_state        -      -

After:

  % perf report --sort time,overhead,symbol --stdio --ns
  ...
       2.39%  187851.100000000  [k] smp_call_function_single   -      -
       1.53%  187851.100000000  [k] intel_idle                 -      -
       0.59%  187851.100000000  [.] __wcscmp_ifunc             -      -
       0.33%  187851.100000000  [.] 0000000000000000           -      -
       0.28%  187851.100000000  [k] cpuidle_enter_state        -      -

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190823210338.12360-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 8efbf58dc3d0..33702675073c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -193,7 +193,10 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
-	hists__new_col_len(hists, HISTC_TIME, 12);
+	if (symbol_conf.nanosecs)
+		hists__new_col_len(hists, HISTC_TIME, 16);
+	else
+		hists__new_col_len(hists, HISTC_TIME, 12);
 
 	if (h->srcline) {
 		len = MAX(strlen(h->srcline), strlen(sort_srcline.se_header));
-- 
2.21.0

