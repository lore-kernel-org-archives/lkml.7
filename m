Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADE3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208BA2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153391;
	bh=WQsm6XqG70t+XfvQv1jGxEyDb5o7ywD3/Cm2xSeLvLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nDdrH4vA0dc8G8XaJvanNAQ6C7uRJS1/NSaxyrkmsgTvie7VT1nikJimwuALrolyf
	 xpYLTQih3YIVwDSM1Mx6AmQPCf2a3XiwyBHG6M4ClBQ7rDMbki7BMuezpjEMFXcJOv
	 Sc2+egb+IUC/MQCMecuuRwIbWH1KLZAvDNshp2oE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKGTDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfKGTDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:03:09 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FBBF218AE;
        Thu,  7 Nov 2019 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153388;
        bh=WQsm6XqG70t+XfvQv1jGxEyDb5o7ywD3/Cm2xSeLvLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vdnb5Vc4/zM3mbZwM2RMpZxww/LfAB67btTHfN5D5pYl6h5SRxtg2xpdd8M7DJOnY
         4MbIMV/3shd0KrI4dGSWWKVujNLWkfxVypu4YV67qBYYCrH31PQ3j+kPXtShVKQS3o
         iGPS/gtXSS8n55vV1JNEurcNTpBlMwWHruvIBEpY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Feilong Lin <linfeilong@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Luke Mujica <lukemujica@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/63] perf jevents: Fix resource leak in process_mapfile() and main()
Date:   Thu,  7 Nov 2019 15:59:26 -0300
Message-Id: <20191107190011.23924-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

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
---
 tools/perf/pmu-events/jevents.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 7d69727f44bd..079c77b6a2fd 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -772,6 +772,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	char *line, *p;
 	int line_num;
 	char *tblname;
+	int ret = 0;
 
 	pr_info("%s: Processing mapfile %s\n", prog, fpath);
 
@@ -783,6 +784,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	if (!mapfp) {
 		pr_info("%s: Error %s opening %s\n", prog, strerror(errno),
 				fpath);
+		free(line);
 		return -1;
 	}
 
@@ -809,7 +811,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
 			/* TODO Deal with lines longer than 16K */
 			pr_info("%s: Mapfile %s: line %d too long, aborting\n",
 					prog, fpath, line_num);
-			return -1;
+			ret = -1;
+			goto out;
 		}
 		line[strlen(line)-1] = '\0';
 
@@ -839,7 +842,9 @@ static int process_mapfile(FILE *outfp, char *fpath)
 
 out:
 	print_mapping_table_suffix(outfp);
-	return 0;
+	fclose(mapfp);
+	free(line);
+	return ret;
 }
 
 /*
@@ -1136,6 +1141,7 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	} else if (rc < 0) {
 		/* Make build fail */
+		fclose(eventsfp);
 		free_arch_std_events();
 		return 1;
 	} else if (rc) {
@@ -1148,6 +1154,7 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	} else if (rc < 0) {
 		/* Make build fail */
+		fclose(eventsfp);
 		free_arch_std_events();
 		return 1;
 	} else if (rc) {
@@ -1165,6 +1172,8 @@ int main(int argc, char *argv[])
 	if (process_mapfile(eventsfp, mapfile)) {
 		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
 		/* Make build fail */
+		fclose(eventsfp);
+		free_arch_std_events();
 		return 1;
 	}
 
-- 
2.21.0

