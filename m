Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AC7C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAEB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808283;
	bh=PmQkUTXNDpQDQMp/sDyeIwxyXuij3/hzlkYfi9zN5vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1NSK3eNxjzvbPKE+P4rxri4u01Kc0+J2hU7iLHYQtC8iPX2h9InNF500T0iXXEllJ
	 9sFUSz6fY48fNxwWLlSjwQwKSx9SSEoZqemcL5obXKh8obakwgj/6UDu3UvTNNYWeG
	 KwFw779D4QhHRb3qyV2kbsuP9tghsrPm671YqhRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfHNSom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbfHNSom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:44:42 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8CF2084F;
        Wed, 14 Aug 2019 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808281;
        bh=PmQkUTXNDpQDQMp/sDyeIwxyXuij3/hzlkYfi9zN5vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3YiUgwyj5AKUTXO38KvYTTQq8WNljSdzXJI+fgCDR1nhiydri9RnD0CBnqwUijPX
         2vj9vXdoP0E61lf9ZGOzPcWbNYWU+fo1/ENaYCuA33InoobCy5qlWqpSiTuKopUvbK
         nNeEM+FktIv5m7SyfOkRVwiH4Dq22bkolsNSN2o0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        James Morris <jmorris@namei.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>
Subject: [PATCH 17/28] perf ftrace: Improve error message about capability to use ftrace
Date:   Wed, 14 Aug 2019 15:40:40 -0300
Message-Id: <20190814184051.3125-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If we link against libcap, then we can state that CAP_SYS_ADMIN is
needed, if not, fallback to telling the user it needs to be root, as was
before linking against libcap.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-hhnbjdo8r67054of9zm2kxtl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-ftrace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 01a5bb58eb04..1367bb5046a7 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -284,7 +284,13 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	};
 
 	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
-		pr_err("ftrace only works for root!\n");
+		pr_err("ftrace only works for %s!\n",
+#ifdef HAVE_LIBCAP_SUPPORT
+		"users with the SYS_ADMIN capability"
+#else
+		"root"
+#endif
+		);
 		return -1;
 	}
 
-- 
2.21.0

