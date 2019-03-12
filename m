Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8A2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CB1214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356250;
	bh=HmyxYAABSjfV6HgMS6AkIUvMkc3zuiMUDRjNq6OKJdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wq8lou+MGOf21gcoruIYUS2w2MGmqJ0jIkV5CVHLV6iGBpJl9CTqEl5YpRQ/gnUtH
	 lh0FGinHLSQCTfWWKWErKD2Ig/CzSD7/L5UUhEFjHed36qM3ddaFhckZ146BrRkBqI
	 FplzSbTAwn+qm1lTyHTLLWPmp8KGZq8XnK0DTo34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfCLCEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfCLCEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:04:06 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2082171F;
        Tue, 12 Mar 2019 02:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356245;
        bh=HmyxYAABSjfV6HgMS6AkIUvMkc3zuiMUDRjNq6OKJdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=he1N7M956Z5EIYC7Y4yiaq2PIqmYS1TZnrFu/mjxiQFxCjgiMiJfrucyWvTOWnjDm
         B2vcqIjUvricLO+FBKSDK+YP4GI0ebOXQvvf1PmnlrYLp7OQcOkdpt3OFHQ0WOTcx6
         97oClkHRlLDAtQIh9qml53NSWtUu4vgAMIdFUf9A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/30] perf tools report: Add custom scripts to script menu
Date:   Mon, 11 Mar 2019 23:02:04 -0300
Message-Id: <20190312020204.22092-31-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
-- 
2.20.1

