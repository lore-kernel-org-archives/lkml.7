Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED082C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A20206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641182;
	bh=nPbKkTiUXTZbXtDFcv0qMIXx7RYcsCD2UZEM/RpLOtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vi2sT7pNAu2hO4qan37oI6KvnK4WK3/gLVjZ2Sk/fFk7rE3YgONaCNmVj5SOfTg2i
	 0uVuTq/KYcjSZTC1TJAN98vCXoV9jP4nunU1VpShgYX/ETJXsnMw5li27s0ZxdrYMo
	 kml3fkYlWClgI2eLm06QFizpOyUygYeuxPQSa7RE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfL2Rco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:32:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfL2Rci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:32:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C97720722;
        Sun, 29 Dec 2019 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640757;
        bh=nPbKkTiUXTZbXtDFcv0qMIXx7RYcsCD2UZEM/RpLOtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4HTLu5LdoYv4UTvISy+K3W+NNV/IbWdomgY1/RgazJZygijyg6PPKInmhnfmXfw1
         MBmW916K+pzaQ4bW3uowsS+mqbik+Z5vMZUFT7pVoHdZsGpxdWUrMaqvS9km0s0L6k
         W6FJT9Je3JukmoV0Mp+G4e8ggMNclGGQL5QO9OmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunfeng Ye <yeyunfeng@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Feilong Lin <linfeilong@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Luke Mujica <lukemujica@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 125/219] perf jevents: Fix resource leak in process_mapfile() and main()
Date:   Sun, 29 Dec 2019 18:18:47 +0100
Message-Id: <20191229162527.271168129@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

[ Upstream commit 1785fbb73896dbd9d27a406f0d73047df42db710 ]

There are memory leaks and file descriptor resource leaks in
process_mapfile() and main().

Fix this by adding free(), fclose() and free_arch_std_events() on the
error paths.

Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
Fixes: 3f056b66647b ("perf jevents: Make build fail on JSON parse error")
Fixes: e9d32c1bf0cd ("perf vendor events: Add support for arch standard events")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Link: http://lore.kernel.org/lkml/d7907042-ec9c-2bef-25b4-810e14602f89@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/jevents.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 6cd9623ebc93..38b5888ef7b3 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -754,6 +754,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	char *line, *p;
 	int line_num;
 	char *tblname;
+	int ret = 0;
 
 	pr_info("%s: Processing mapfile %s\n", prog, fpath);
 
@@ -765,6 +766,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	if (!mapfp) {
 		pr_info("%s: Error %s opening %s\n", prog, strerror(errno),
 				fpath);
+		free(line);
 		return -1;
 	}
 
@@ -791,7 +793,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
 			/* TODO Deal with lines longer than 16K */
 			pr_info("%s: Mapfile %s: line %d too long, aborting\n",
 					prog, fpath, line_num);
-			return -1;
+			ret = -1;
+			goto out;
 		}
 		line[strlen(line)-1] = '\0';
 
@@ -821,7 +824,9 @@ static int process_mapfile(FILE *outfp, char *fpath)
 
 out:
 	print_mapping_table_suffix(outfp);
-	return 0;
+	fclose(mapfp);
+	free(line);
+	return ret;
 }
 
 /*
@@ -1118,6 +1123,7 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	} else if (rc < 0) {
 		/* Make build fail */
+		fclose(eventsfp);
 		free_arch_std_events();
 		return 1;
 	} else if (rc) {
@@ -1130,6 +1136,7 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	} else if (rc < 0) {
 		/* Make build fail */
+		fclose(eventsfp);
 		free_arch_std_events();
 		return 1;
 	} else if (rc) {
@@ -1147,6 +1154,8 @@ int main(int argc, char *argv[])
 	if (process_mapfile(eventsfp, mapfile)) {
 		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
 		/* Make build fail */
+		fclose(eventsfp);
+		free_arch_std_events();
 		return 1;
 	}
 
-- 
2.20.1



