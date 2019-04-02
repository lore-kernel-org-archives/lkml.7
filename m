Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0342084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221231;
	bh=4IqEwhmO9QvlXk21vTmTmytABNCvMPx0CQi6SpZ1EWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M87/XwEEFOOsDIuWf8bZ4b4rRLzBTMYQYjhgP2x2F1lRZ0tsAR2mxdJTFGBcTY8dN
	 IA2bnmfPvXYRgMQplZOTOUpRAijdkhfIp7f+Cq/XObv23ph/OuoigIspjaMP2WNJ8L
	 ms9ohm0sr/VpqWQP1dES5NVb251x37FuFHE9OsAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfDBQHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731198AbfDBQHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:07 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43706214AF;
        Tue,  2 Apr 2019 16:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221227;
        bh=4IqEwhmO9QvlXk21vTmTmytABNCvMPx0CQi6SpZ1EWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYBJTE2HmRM/fV3Xnja8WMQRucJsJ82bEX9hhZBL7XgnVn3d1BoFawa9geQ5XyTYP
         lCjictHh8De5yVfyTzOIw/c1G5D0TicMrvr6yxe3TDX7ih4Gdx7aGMITzVuLHPggss
         oAFjcodocL9tBtuYsoqmbwzvJeo0e2mF6vDVDiKo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/44] tools lib traceevent: Remove call to exit() from tep_filter_add_filter_str()
Date:   Tue,  2 Apr 2019 13:05:25 -0300
Message-Id: <20190402160549.13544-21-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch removes call to exit() from tep_filter_add_filter_str(). A
library function should not force the application to exit. In the
current implementation tep_filter_add_filter_str() calls exit() when a
special "test_filters" mode is set, used only for debugging purposes.
When this mode is set and a filter is added - its string is printed to
the console and exit() is called. This patch changes the logic - when in
"test_filters" mode, the filter string is still printed, but the exit()
is not called. It is up to the application to track when "test_filters"
mode is set and to call exit, if needed.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190326154328.28718-9-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190401164344.121717482@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/parse-filter.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 4ffd8b25a852..3320c0a0e343 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1346,9 +1346,6 @@ enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
 
 	free_events(events);
 
-	if (rtn >= 0 && pevent->test_filters)
-		exit(0);
-
 	return rtn;
 }
 
-- 
2.20.1

