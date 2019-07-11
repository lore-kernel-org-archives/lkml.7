Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D6BC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ACD208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfGKIhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:37:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:39699 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfGKIhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:37:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 01:37:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="171170846"
Received: from intel10-debian.sh.intel.com ([10.239.53.1])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2019 01:37:11 -0700
From:   Zhengjun Xing <zhengjun.xing@linux.intel.com>
To:     rostedt@goodmis.org, mingo@redhat.com, tom.zanussi@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, zhengjun.xing@linux.intel.com,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2] tracing: Add verbose gfp_flag printing to synthetic events
Date:   Thu, 11 Jul 2019 16:46:42 +0800
Message-Id: <20190711084642.28785-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add on top of 'trace:add "gfp_t" support in synthetic_events'.

Prints the gfp flags as hex in addition to the human-readable flag
string.  Example output:

  whoopsie-630 [000] ...1 78.969452: testevent: bar=b20 (GFP_ATOMIC|__GFP_ZERO)
    rcuc/0-11  [000] ...1 81.097555: testevent: bar=a20 (GFP_ATOMIC)
    rcuc/0-11  [000] ...1 81.583123: testevent: bar=a20 (GFP_ATOMIC)

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ca6b0dff60c5..938ef3f54c5c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -13,6 +13,10 @@
 #include <linux/rculist.h>
 #include <linux/tracefs.h>
 
+/* for gfp flag names */
+#include <linux/trace_events.h>
+#include <trace/events/mmflags.h>
+
 #include "tracing_map.h"
 #include "trace.h"
 #include "trace_dynevent.h"
@@ -752,6 +756,8 @@ static int synth_field_size(char *type)
 		size = sizeof(unsigned long);
 	else if (strcmp(type, "pid_t") == 0)
 		size = sizeof(pid_t);
+	else if (strcmp(type, "gfp_t") == 0)
+		size = sizeof(gfp_t);
 	else if (synth_field_is_string(type))
 		size = synth_field_string_size(type);
 
@@ -792,6 +798,8 @@ static const char *synth_field_fmt(char *type)
 		fmt = "%lu";
 	else if (strcmp(type, "pid_t") == 0)
 		fmt = "%d";
+	else if (strcmp(type, "gfp_t") == 0)
+		fmt = "%x";
 	else if (synth_field_is_string(type))
 		fmt = "%s";
 
@@ -834,9 +838,20 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 					 i == se->n_fields - 1 ? "" : " ");
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
+			struct trace_print_flags __flags[] = {
+			    __def_gfpflag_names, {-1, NULL} };
+
 			trace_seq_printf(s, print_fmt, se->fields[i]->name,
 					 entry->fields[n_u64],
 					 i == se->n_fields - 1 ? "" : " ");
+
+			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
+				trace_seq_puts(s, " (");
+				trace_print_flags_seq(s, "|",
+						      entry->fields[n_u64],
+						      __flags);
+				trace_seq_putc(s, ')');
+			}
 			n_u64++;
 		}
 	}
-- 
2.14.1

