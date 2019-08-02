Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B16C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8515A2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752129;
	bh=OZA6NO+8QUk59yoqI9RwcIIrHZcQonBj5aVJgTWokqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hNVpetUY+m6NVgG0jkOrvA7jajKRRBm6lzJL47vwQHNcbatMKJvkP+8RlvYJUIlun
	 e81GU1kXa7mQwV3Cx9icInjnGbkyjbXp89EyF90gWpzH+779niQc0kqeQfSzxHRgoS
	 OFTbJR7AeJ+nAdRHUaeLkUtODLF5uKSzWS/YR/4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393709AbfHBNWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393693AbfHBNWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:22:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C5920880;
        Fri,  2 Aug 2019 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752123;
        bh=OZA6NO+8QUk59yoqI9RwcIIrHZcQonBj5aVJgTWokqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KY6/vmGBpUU4EP0OOit7cpKROsgVNslMwanoFCbsXr5GfkwkVBFyFR9bWu7gMSia4
         HnOKqP7RboEteKJp6JwLVkpZBmUtCAXl6fI+4KUSHM21EzhcjJndLkCO2lFb7Lpibn
         HtG1mT/k5H+mgy5BexoJSlOSSulGkuxDybYLAHmI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 53/76] perf tools: Fix proper buffer size for feature processing
Date:   Fri,  2 Aug 2019 09:19:27 -0400
Message-Id: <20190802131951.11600-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 79b2fe5e756163897175a8f57d66b26cd9befd59 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b82d4577d9694..e84b70be3fc11 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3666,7 +3666,7 @@ int perf_event__process_feature(struct perf_session *session,
 		return 0;
 
 	ff.buf  = (void *)fe->data;
-	ff.size = event->header.size - sizeof(event->header);
+	ff.size = event->header.size - sizeof(*fe);
 	ff.ph = &session->header;
 
 	if (feat_ops[feat].process(&ff, NULL))
-- 
2.20.1

