Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D436AC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD20E21D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572977927;
	bh=QqPFE194ZJaaFvk5H6asJVIqrWzLHI3+MZdoRYh0BYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d2bCHcW66KaiW29T5PsLfv0LNdHOkIDSwLdmJ1xZM2IASYOlIu0I+yRVUP99EKBcI
	 FyJVOReehKn5Z9zMwDRgcgcevmBVtUe/9XRSUhwWkEbsjexyOegx6HXBute2S6Jwnu
	 HswDehmieC8ac7BgkKDOL0Wcc63fU7QaHMe1ryM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390757AbfKESSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390672AbfKESSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:18:46 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.215.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09608214D8;
        Tue,  5 Nov 2019 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572977925;
        bh=QqPFE194ZJaaFvk5H6asJVIqrWzLHI3+MZdoRYh0BYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5CPskWpW0ovJSRoxRFzG85gshdkDieKT1ULcbk3kVxWlJ6FBSZtWA/6izYkon4jr
         H6BZ8TtuO3Gw/hQIJ/3Fmja1FmGzlTpnYcv8DHIG9P1U8zEugHDaKtIt8HlbhzfQ0S
         bH5XuQIToawEhp2cpExqLvpyMbfunyiDGX8QAmxw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/3] perf tools: Fix time sorting
Date:   Tue,  5 Nov 2019 15:18:18 -0300
Message-Id: <20191105181818.26748-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181818.26748-1-acme@kernel.org>
References: <20191105181818.26748-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The final sort might get confused when the comparison is done over
bigger numbers than int like for -s time.

Check the following report for longer workloads:

  $ perf report -s time -F time,overhead --stdio

Fix hist_entry__sort() to properly return int64_t and not possible cut
int.

Fixes: 043ca389a318 ("perf tools: Use hpp formats to sort final output")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org # v3.16+
Link: http://lore.kernel.org/lkml/20191104232711.16055-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 679a1d75090c..7b6eaf5e0bda 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1625,7 +1625,7 @@ int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
 	return 0;
 }
 
-static int hist_entry__sort(struct hist_entry *a, struct hist_entry *b)
+static int64_t hist_entry__sort(struct hist_entry *a, struct hist_entry *b)
 {
 	struct hists *hists = a->hists;
 	struct perf_hpp_fmt *fmt;
-- 
2.21.0

