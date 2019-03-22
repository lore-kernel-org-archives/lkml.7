Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA939C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E78A21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfCVWRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:17:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45445 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:17:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMHkC7749728
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:17:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMHkWG749725;
        Fri, 22 Mar 2019 15:17:46 -0700
Date:   Fri, 22 Mar 2019 15:17:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-e3b74de50a5f8bbfacbd772874c8b5d9220ebcdb@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, hpa@zytor.com,
        ak@linux.intel.com
Reply-To: hpa@zytor.com, ak@linux.intel.com, tglx@linutronix.de,
          jolsa@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
          acme@redhat.com
In-Reply-To: <20190311144502.15423-10-andi@firstfloor.org>
References: <20190311144502.15423-10-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools report: Add custom scripts to script
 menu
Git-Commit-ID: e3b74de50a5f8bbfacbd772874c8b5d9220ebcdb
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

Commit-ID:  e3b74de50a5f8bbfacbd772874c8b5d9220ebcdb
Gitweb:     https://git.kernel.org/tip/e3b74de50a5f8bbfacbd772874c8b5d9220ebcdb
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 11 Mar 2019 07:45:00 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:33:20 -0300

perf tools report: Add custom scripts to script menu

Add a way to define custom scripts through ~/.perfconfig, which are then
added to the scripts menu. The scripts get the same arguments as 'perf
script', in particular -i, --cpu, --tid.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-10-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  8 ++++++++
 tools/perf/ui/browsers/scripts.c         | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 2d0fb7613134..95054a8176a2 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -590,6 +590,14 @@ samples.*::
 		Define how many ns worth of time to show
 		around samples in perf report sample context browser.
 
+scripts.*::
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
index 96e5cd3b0eee..27cf3ab88d13 100644
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
+	if (!strstarts(var, "scripts."))
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
