Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55FAC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5592186A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034461;
	bh=qi4RzfOg15BIcQ1Q8ncfIwsnHMltU3479EES9sW9L+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V0FiDlQBB5dTmTsBiLXHu5GuExtgBfpcFOI2cI/7hEA3GOyhzGoYphvKlgU/yAbN0
	 iCn9wk8+lLJx8o0TX3t2nAigwf6OJdhTYPjZq0SSt4l7wp6IxF+rAWzYWcTEUFy9Yh
	 E/BeohlOKxi6BxGt7/kmbWMRp3MsWeU5xtW09G90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfGBC1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfGBC1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA6582184C;
        Tue,  2 Jul 2019 02:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034457;
        bh=qi4RzfOg15BIcQ1Q8ncfIwsnHMltU3479EES9sW9L+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJxEl8Vg098UyR/ae78yjtFbrbKWOhkoWSU5ExGcPA4mzbIDWBhSHY8rFap3YQe2+
         SVHG4xqukMEDvSyHnYaFDnXtxhmZrYTHXm+gEqrhvHnFJKRUtQm5Milt2CaEDxc2QO
         B2eRL5/BJnmX1UYlOrlV+M9UldLsOiTINnPPmWcM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 24/43] perf stat: Use recently introduced skip_spaces()
Date:   Mon,  1 Jul 2019 23:25:57 -0300
Message-Id: <20190702022616.1259-25-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No change in behaviour.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ncpvp4eelf8fqhuy29uv56z9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 992e327bce85..ce993d29cca5 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1,5 +1,6 @@
 #include <stdio.h>
 #include <inttypes.h>
+#include <linux/string.h>
 #include <linux/time64.h>
 #include <math.h>
 #include "color.h"
@@ -215,9 +216,7 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
-	while (isspace(*unit))
-		unit++;
-	fprintf(out, "%s%s%s%s", config->csv_sep, vals, config->csv_sep, unit);
+	fprintf(out, "%s%s%s%s", config->csv_sep, vals, config->csv_sep, skip_spaces(unit));
 }
 
 /* Filter out some columns that don't work well in metrics only mode */
-- 
2.20.1

