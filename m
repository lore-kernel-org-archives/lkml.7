Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A31C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8723120661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980844;
	bh=DZicw97hCTLOW7TQvUtJJlHs9QiNS2ot294pvV8tQpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YtAOAqGfYvot5bbosNPuBDiZCRZlHcAwAQgVQznBvm0O/5ASMJq9u4ANQjqsS2T41
	 QIzvE7LXPJB3fQfu6LXgOX/zHbUHehd2S7GnkyxL0crQK5n0B0QiiL4DuJTrfF62W9
	 Sjau98BHkNYU2iEkWXIEVJbRmeyWVWjWLHYvBFEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCGRrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfCGRrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:47:18 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E1FB20854;
        Thu,  7 Mar 2019 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980838;
        bh=DZicw97hCTLOW7TQvUtJJlHs9QiNS2ot294pvV8tQpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsIHjzv2PvYUZPZqCZgEEkqFsxS3i5LIYdSUyL2f5SVdRIHKVJQ0b7AiKzhiI39cp
         uZhzsP/dMGFkQ29aRlIABKO7GixYoFVkvQc/llzEuVOEqa8NZiKLGrL36diTCkAexa
         6njMcNvNOfFeWVOJHlJzVMKiC5nED0hF6FvzI9xM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 35/35] perf data: Force perf_data__open|close zero data->file.path
Date:   Thu,  7 Mar 2019 14:44:33 -0300
Message-Id: <20190307174433.28819-36-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Making sure the data->file.path is zeroed on perf_data__open error path
and in perf_data__close, so we don't double free it in case someone call
it twice.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190305152536.21035-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 7bd5ddeb7a41..e098e189f93e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -237,7 +237,7 @@ static int open_file(struct perf_data *data)
 	     open_file_read(data) : open_file_write(data);
 
 	if (fd < 0) {
-		free(data->file.path);
+		zfree(&data->file.path);
 		return -1;
 	}
 
@@ -270,7 +270,7 @@ int perf_data__open(struct perf_data *data)
 
 void perf_data__close(struct perf_data *data)
 {
-	free(data->file.path);
+	zfree(&data->file.path);
 	close(data->file.fd);
 }
 
-- 
2.20.1

