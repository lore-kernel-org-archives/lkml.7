Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A24C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5396E20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611025;
	bh=XtkRlcktCWQ8+EOLffFMgO1nRouaL51g2wov3tbRxNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PUzz7H8ybP0T7d3zvUdHEhIBj5yE9jiNoDd6tQOI0zVOvMFaongD/sVP4uqdY1ipO
	 hiVxkVoYXYyd28EAx2s1ZwRt3Iptw9+PGxtX246lz01ODiTbBigksd+wn9FS12CG0h
	 Z/KxPzP2c5DlkLQnRcJ8ctotPXNc26eKFP5aaMD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404123AbfDRSKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404106AbfDRSKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A93120652;
        Thu, 18 Apr 2019 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611020;
        bh=XtkRlcktCWQ8+EOLffFMgO1nRouaL51g2wov3tbRxNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0WB0YM88nV4e+xva5FAJX+8A8G5S+Hh+suD5tKqHVodfO4DGxZnUNb0KcrRtU2vi
         Xf81LrnWa7yA80VdzYNYzcayycjzXPvP5L94S2DvH7EGxf2O3nx12TNGqg8Tf8YrAN
         rlA/a2fEpqYBk6gACFuysI8Krjau/OR5+WUq1Vcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 05/93] perf data: Dont store auxtrace index for directory data file
Date:   Thu, 18 Apr 2019 19:56:43 +0200
Message-Id: <20190418160437.573320142@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 882285fb9f64..3fd154f1701b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -386,7 +386,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	size_t padding;
 	u8 pad[8] = {0};
 
-	if (!perf_data__is_pipe(data)) {
+	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
 		off_t file_offset;
 		int fd = perf_data__fd(data);
 		int err;
-- 
2.19.1



