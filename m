Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB985C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C7E2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817270;
	bh=uiyb9SpszJ9UNaXRZ5p1Odgp4bBrWvQnD28YHueCz40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OEVJOA5oFyS3PRlZQMSg3OuD/FwwXz9TTSIMH6R9I/D4Gjv8APf6+Wh10XSsj1Pz1
	 O8kf86iZRl8Z1/GCQfFD0/TP4oYEY8dViXF+Hundseuk/Ok4I+VWT34Pavod2vUN5U
	 MM/6Kna9/ET/7b222uatI0ELrakm1H6Gk2LAWiSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbfGVRlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfGVRlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:41:08 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B71421955;
        Mon, 22 Jul 2019 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817267;
        bh=uiyb9SpszJ9UNaXRZ5p1Odgp4bBrWvQnD28YHueCz40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHvnQ5NZOkfX4xqt1FSsBw1bjY/3dSXY3L62WKBPQhQmGmEuziyg8dIp/ZpJZOpCT
         KyIt9WRi1Lz2fnSnz+5axgwAF/ifrV5nwV5g/+xOoWDZBON8/Lw1AhLCU5cdsDwsK/
         58O1ocJTgrRmwemsRDmzOhdk4Tah4XX/K5flJH3Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 19/37] perf tools: Fix proper buffer size for feature processing
Date:   Mon, 22 Jul 2019 14:38:21 -0300
Message-Id: <20190722173839.22898-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

After Song Liu's segfault fix for pipe mode, Arnaldo reported following
error:

  # perf record -o - | perf script
  0x514 [0x1ac]: failed to process type: 80

It's caused by wrong buffer size setup in feature processing, which
makes cpu topology feature fail, because it's using buffer size to
recognize its header version.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Fixes: e9def1b2e74e ("perf tools: Add feature header record to pipe-mode")
Link: http://lkml.kernel.org/r/20190715140426.32509-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c24db7f4909c..20111f8da5cb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3747,7 +3747,7 @@ int perf_event__process_feature(struct perf_session *session,
 		return 0;
 
 	ff.buf  = (void *)fe->data;
-	ff.size = event->header.size - sizeof(event->header);
+	ff.size = event->header.size - sizeof(*fe);
 	ff.ph = &session->header;
 
 	if (feat_ops[feat].process(&ff, NULL))
-- 
2.21.0

