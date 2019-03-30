Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBDAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C048217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908076;
	bh=yqn5BA5jPL9u/0ljYsNfje1cy7vTvZn6nJUSSlowly8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k66lnSIlNj4DDUFj6pIfLJY8+1x/YFcjlNebhYFQsOZX8eQ8c2c+Kz6PSxTnzf1QJ
	 +eiJx71d4q70eh/2x+a2Svfrw1E6bmfDJetIDnL3oKvUYR12ul5s0FAmWH+qHp/WEL
	 jX/8YMSViFIwaiJXP1kREYx3zUe2JfPrMDV/POTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfC3BHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731192AbfC3AxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:53:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9757218E2;
        Sat, 30 Mar 2019 00:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907190;
        bh=yqn5BA5jPL9u/0ljYsNfje1cy7vTvZn6nJUSSlowly8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jdb760+FoqLMGJPA1QYOBnKoQ7KBtrnG6jiAkZyTOxQWITdMDF1U0CJoHruAI/DJq
         jQUOJMINlKCyhACWHQX9Cci8yNXTnor5ItJZmPpgo+t2Lc0zDL9iDKA/QeOcnSXmsT
         wkeuagKf2923pFbRSvvjijsDRgQNi38xqQR4XY2Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 05/52] perf data: Don't store auxtrace index for directory data file
Date:   Fri, 29 Mar 2019 20:52:12 -0400
Message-Id: <20190330005301.26868-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit cd3dd8dd8ff62374d90cb3f2e54b8c94106c7810 ]

We can't store the auxtrace index when we store into multiple files,
because we keep only offset for it, not the file.

The auxtrace data will be processed correctly in the 'pipe' mode.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 22ebeb92ac51..f5b438486a64 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -178,7 +178,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	size_t padding;
 	u8 pad[8] = {0};
 
-	if (!perf_data__is_pipe(data)) {
+	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
 		off_t file_offset;
 		int fd = perf_data__fd(data);
 		int err;
-- 
2.19.1

