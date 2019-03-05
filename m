Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA78C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D802087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfCEOst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:48:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:28781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfCEOsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:48:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 06:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="121150044"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 05 Mar 2019 06:48:14 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A530F301BC6; Tue,  5 Mar 2019 06:48:14 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 13/15] perf tools report: Add custom scripts to script menu
Date:   Tue,  5 Mar 2019 06:47:56 -0800
Message-Id: <20190305144758.12397-14-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305144758.12397-1-andi@firstfloor.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a way to define custom scripts through ~/.perfconfig, which
are then added to the scripts menu. The scripts get the same
arguments as perf script, in particular -i, --cpu, --tid.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-config.txt |  8 ++++++++
 tools/perf/ui/browsers/scripts.c         | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 86f3dcc15f83..dc1009e334e8 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -584,6 +584,14 @@ llvm.*::
 	llvm.opts::
 		Options passed to llc.
 
+script.*::
+
+	Any option defines a script that is added to the scripts menu
+	in the interactive perf browser and whose output is displayed.
+	The name of the option is the name, the value is a script command line.
+	The script gets the same options passed as a full perf script,
+	in particular -i perfdata file, --cpu, --tid
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index cdba58447b85..5d407ab834b5 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -6,6 +6,7 @@
 #include "../../util/symbol.h"
 #include "../browser.h"
 #include "../libslang.h"
+#include "config.h"
 
 #define SCRIPT_NAMELEN	128
 #define SCRIPT_MAX_NO	64
@@ -53,6 +54,24 @@ static int add_script_option(const char *name, const char *opt,
 	return 0;
 }
 
+static int scripts_config(const char *var, const char *value, void *data)
+{
+	struct script_config *c = data;
+
+	if (!strstarts(var, "script."))
+		return -1;
+	if (c->index >= SCRIPT_MAX_NO)
+		return -1;
+	c->names[c->index] = strdup(var + 7);
+	if (!c->names[c->index])
+		return -1;
+	if (asprintf(&c->paths[c->index], "%s %s", value,
+		     c->extra_format) < 0)
+		return -1;
+	c->index++;
+	return 0;
+}
+
 /*
  * When success, will copy the full path of the selected script
  * into  the buffer pointed by script_name, and return 0.
@@ -87,6 +106,7 @@ static int list_scripts(char *script_name, bool *custom,
 			  &scriptc);
 	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
 			  &scriptc);
+	perf_config(scripts_config, &scriptc);
 	custom_perf = scriptc.index;
 	add_script_option("Show samples with custom perf script arguments", "", &scriptc);
 	i = scriptc.index;
-- 
2.20.1

