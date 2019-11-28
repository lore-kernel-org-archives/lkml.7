Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3291BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D9D21787
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948442;
	bh=p2qO6JpwEIqwn/veRogA/Q49rMKk3TaNPlbdyr+QM60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M/w0Y1nk+SX4TZ+ZluxjVINuza8vkKTbbuysjw4lxmKZZuH9ZlLvj+JXeRH2GT+wr
	 bQPwfeEIEJKXWZV+hOdn3ECIU3JVMmwcjR4Wuq9zPKX8+L8YlK0bvnk1X7qCmGFrH+
	 zslmdTzKRrqesVt9w2MXrn2QfksJuiPmmlPJGhYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfK1Nkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1Nki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:40:38 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AAEC217BA;
        Thu, 28 Nov 2019 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948437;
        bh=p2qO6JpwEIqwn/veRogA/Q49rMKk3TaNPlbdyr+QM60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPlZnKAQnfjmpyq12jy6uQkd7kV63Qr8q/EIbnQuzCHDl1TnorVLFLw5LqoFIvCoW
         kUejKTjVm8vQuwIFKc8uArkXbLuB6bU5h/i1cMlq/fcWCEg2h5sHzAC5HIPOztbxXu
         yFfsaSUW0X9JuilOJPlJWa6p1kB5a1sTMG16i6zE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 01/22] perf script: Move map__fprintf_srccode() to near its only user
Date:   Thu, 28 Nov 2019 10:40:06 -0300
Message-Id: <20191128134027.23726-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need to have it elsewhere.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8cw846pudpxo0xdkvi9qnvrh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 42 ++++++++++++++++++++++++++++++++++
 tools/perf/util/map.c       | 45 -------------------------------------
 tools/perf/util/map.h       |  5 -----
 3 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f86c5cce5b2c..7b2f0922050c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -932,6 +932,48 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	return len;
 }
 
+static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srccode_state *state)
+{
+	char *srcfile;
+	int ret = 0;
+	unsigned line;
+	int len;
+	char *srccode;
+
+	if (!map || !map->dso)
+		return 0;
+	srcfile = get_srcline_split(map->dso,
+				    map__rip_2objdump(map, addr),
+				    &line);
+	if (!srcfile)
+		return 0;
+
+	/* Avoid redundant printing */
+	if (state &&
+	    state->srcfile &&
+	    !strcmp(state->srcfile, srcfile) &&
+	    state->line == line) {
+		free(srcfile);
+		return 0;
+	}
+
+	srccode = find_sourceline(srcfile, line, &len);
+	if (!srccode)
+		goto out_free_line;
+
+	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
+
+	if (state) {
+		state->srcfile = srcfile;
+		state->line = line;
+	}
+	return ret;
+
+out_free_line:
+	free(srcfile);
+	return ret;
+}
+
 static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 {
 	struct addr_location al;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 744bfbaf35cf..b59944eb469e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -433,51 +433,6 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 	return ret;
 }
 
-int map__fprintf_srccode(struct map *map, u64 addr,
-			 FILE *fp,
-			 struct srccode_state *state)
-{
-	char *srcfile;
-	int ret = 0;
-	unsigned line;
-	int len;
-	char *srccode;
-
-	if (!map || !map->dso)
-		return 0;
-	srcfile = get_srcline_split(map->dso,
-				    map__rip_2objdump(map, addr),
-				    &line);
-	if (!srcfile)
-		return 0;
-
-	/* Avoid redundant printing */
-	if (state &&
-	    state->srcfile &&
-	    !strcmp(state->srcfile, srcfile) &&
-	    state->line == line) {
-		free(srcfile);
-		return 0;
-	}
-
-	srccode = find_sourceline(srcfile, line, &len);
-	if (!srccode)
-		goto out_free_line;
-
-	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
-
-	if (state) {
-		state->srcfile = srcfile;
-		state->line = line;
-	}
-	return ret;
-
-out_free_line:
-	free(srcfile);
-	return ret;
-}
-
-
 void srccode_state_free(struct srccode_state *state)
 {
 	zfree(&state->srcfile);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 5e8899883231..1f110b53b5f3 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -138,11 +138,6 @@ char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
 
-struct srccode_state;
-
-int map__fprintf_srccode(struct map *map, u64 addr,
-			 FILE *fp, struct srccode_state *state);
-
 int map__load(struct map *map);
 struct symbol *map__find_symbol(struct map *map, u64 addr);
 struct symbol *map__find_symbol_by_name(struct map *map, const char *name);
-- 
2.21.0

