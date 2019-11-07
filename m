Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D2C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174C6222C9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153709;
	bh=ktNzO+S3HJOSvFkixFTw2IvreLtpRPHA/eNUz53iQEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E3iIpbDQUYHH7F9wMIzqEJGDbblAp/1Lo91Ru2yweINLhi6HL9OnVzMai/g5IPjnV
	 noxNZtX6YLU5wZAQjmPY1nlsmCKR0Oec0BnD7+1OjypZry2DlG8S6DyRl3DRzqdheV
	 OnfTuQfWOvJrXC/bhWRfMmcnYq1A1I0V7Kb9kpuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfKGTIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:08:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfKGTIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:18 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2EAD2166E;
        Thu,  7 Nov 2019 19:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153698;
        bh=ktNzO+S3HJOSvFkixFTw2IvreLtpRPHA/eNUz53iQEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYxh1Q493NootHMv8zLKNiIVTC4g8yJAzggBtIuQpxUrErluygEuXJxqNWCELSszx
         TuY0wKlQ8gsbZTJcZPh8kB5Tor1i15d8mnc9ZbtB5tcWpHn+dV+BnXaY0Byg1GFGe6
         iZmvzv7/GPhoYxrrRPlxwcHvB8LnGXvkhGjWFfgc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 49/63] perf annotate: Fix heap overflow
Date:   Thu,  7 Nov 2019 15:59:57 -0300
Message-Id: <20191107190011.23924-50-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

Fix expand_tabs that copies the source lines '\0' and then appends
another '\0' at a potentially out of bounds address.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191026035644.217548-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ef1866a902c4..bee0fee122f8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1892,7 +1892,7 @@ static char *expand_tabs(char *line, char **storage, size_t *storage_len)
 	}
 
 	/* Expand the last region. */
-	len = line_len + 1 - src;
+	len = line_len - src;
 	memcpy(&new_line[dst], &line[src], len);
 	dst += len;
 	new_line[dst] = '\0';
-- 
2.21.0

