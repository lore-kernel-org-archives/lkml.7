Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17733C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD18F218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uGnymoAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGCOSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:18:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60599 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:18:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EHnIj3323021
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:17:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EHnIj3323021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163470;
        bh=6lAI1sG1g75nJSYuKpqVd3oXQpCcWlyhv0uvn40JhGE=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=uGnymoAEFpmhp7EZ+NSApeoZqRbOfHdjKqVcfKYbf5AfEk1+6sqJkyb7ezDvrz0dt
         1dmRbLDo3d9MsYaXC5SHpzhFmUfSN0kzFQs9BQX4RHWHq6dDAkFzjJ3JdmQpgNmiqU
         8nX5AthmgNFHdP3jNyu6mqJqQxrXWVGpd37wk4laQHpcLuIwSeqKfdjE7IoF0GGm5B
         t7NSxWSOKzEqppvJ3BRsOq9OaTMQ+a/mESc0+LV8EtP2r8diNIp+5uS+GzjjSYZ/Ca
         UUz4bibDWF0ylqwp5kCTIRkSuNnTX3LWyaj+wgAKZtZvD5XIT1rl3+DeXGZvOZswEi
         zAjBqLs+6gN6A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EHnUC3323018;
        Wed, 3 Jul 2019 07:17:49 -0700
Date:   Wed, 3 Jul 2019 07:17:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ncpvp4eelf8fqhuy29uv56z9@git.kernel.org>
Cc:     acme@redhat.com, ak@linux.intel.com, mingo@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com
Reply-To: mingo@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
          acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Use recently introduced skip_spaces()
Git-Commit-ID: 810826acd122ed859e238bf1555a09b326c8fe23
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  810826acd122ed859e238bf1555a09b326c8fe23
Gitweb:     https://git.kernel.org/tip/810826acd122ed859e238bf1555a09b326c8fe23
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 21:28:49 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 21:28:49 -0300

perf stat: Use recently introduced skip_spaces()

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
