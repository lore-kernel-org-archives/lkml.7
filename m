Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3456C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981EC2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153255;
	bh=HKr3hqy4CNS7D6Dwt058z5eD/4MNsVs+G2b1az8XFF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7X0JuduVtvvrLNNczVfd5Ey60WJdLmwprsYCgpkcpRerrsiIeMgJJuow/0TL6hDq
	 vn64Yq4raLTSzkbzTIpOYvLgA1cTm15YI7P+SfJJJSUpiNhApqz1s1N7lfVpYajRFt
	 iCM46Uc5VEN1KS5PX6L/3diOwaZfqnxbdPWTPt1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfKGTAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:00:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfKGTAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:00:54 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E3D621882;
        Thu,  7 Nov 2019 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153253;
        bh=HKr3hqy4CNS7D6Dwt058z5eD/4MNsVs+G2b1az8XFF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiIu0mES+cciuQpIxEDvxhso90nk0Aok1M/aBzV1O5qOlS5qyM5fCD5NExEduEYNQ
         JE4tXswcxMctijdforJhcZcJRodkGUhR9xfFdnv9UgW5BIswFIhkzoGp1A0NJyrKKg
         ENHlPHCh1v/kkGv9FkXQGr+ZegmP5emnQiLiokho=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/63] perf data: Rename directory "header" file to "data"
Date:   Thu,  7 Nov 2019 15:59:11 -0300
Message-Id: <20191107190011.23924-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation to support a single file directory format, rename "header"
to "data" because "header" is a mis-leading name when there is only 1 file.
Note, in the multi-file case, the "header" file also contains data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191004083121.12182-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 2 +-
 tools/perf/util/util.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 8993253c5564..df173f0bf654 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -306,7 +306,7 @@ static int open_dir(struct perf_data *data)
 	 * So far we open only the header, so we can read the data version and
 	 * layout.
 	 */
-	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
+	if (asprintf(&data->file.path, "%s/data", data->path) < 0)
 		return -1;
 
 	if (perf_data__is_write(data) &&
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index ae56c766eda1..3096654377c2 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -185,7 +185,7 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 int rm_rf_perf_data(const char *path)
 {
 	const char *pat[] = {
-		"header",
+		"data",
 		"data.*",
 		NULL,
 	};
-- 
2.21.0

