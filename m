Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0DAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290D8214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356179;
	bh=4dV8mTbsNPNKZ39ADX1qjVPYHKHeC2PTdOOpVaPi9Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kM1xb0nR6u2ZidwUJhYKjhnY6jkBZqtqLxdn/9zSXCyYztLUNebPAXv3LbooldCfP
	 a7SwRhpgo8nqp7AzyHTvILtz2a15POGI8DA6Aazejn5WLtfRlUzoUmhe6RHKrv161Z
	 OyPalWZm8Kw7P2onCXNI2aP3ExmLsMIRDmwtJgHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfCLCC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfCLCCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:02:55 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662962175B;
        Tue, 12 Mar 2019 02:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356175;
        bh=4dV8mTbsNPNKZ39ADX1qjVPYHKHeC2PTdOOpVaPi9Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UhM6ye+HRpua/AtpPHKwmWzaYTQpOVNJjU9yCGvVgQa9ontYffCmo/rwZKj9BSYgw
         MEAZDhgS3ImOhKQmU4NMMP3cVECfsjJ/ZISFAYcTIxgGY32OoVgo7xUIRSJYK2N2lJ
         vdqlH8xW3CpQuyi92XJHS7VsEiEMcHzk70hadgYI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/30] perf data: Add perf_data__update_dir() function
Date:   Mon, 11 Mar 2019 23:01:44 -0300
Message-Id: <20190312020204.22092-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add perf_data__update_dir() to update the size for every file within the
perf.data directory.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 20 ++++++++++++++++++++
 tools/perf/util/data.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 18fa8d4614eb..5d0f26aef77f 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -124,6 +124,26 @@ int perf_data__open_dir(struct perf_data *data)
 	return ret;
 }
 
+int perf_data__update_dir(struct perf_data *data)
+{
+	int i;
+
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		struct perf_data_file *file = &data->dir.files[i];
+		struct stat st;
+
+		if (fstat(file->fd, &st))
+			return -1;
+
+		file->size = st.st_size;
+	}
+
+	return 0;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 06aefeda311f..0deeb1af9f54 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -79,4 +79,5 @@ int perf_data__switch(struct perf_data *data,
 int perf_data__create_dir(struct perf_data *data, int nr);
 int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
+int perf_data__update_dir(struct perf_data *data);
 #endif /* __PERF_DATA_H */
-- 
2.20.1

