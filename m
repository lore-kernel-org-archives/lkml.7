Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBBFFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A101F20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328202;
	bh=zciE6zvcpsijnNLJZWP6YJk7DXC8kCO7A8ZYz/9RWhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aI8rNPMR8fJ7an7NOjEx2kAWvBOWurgyw71YYoa5y4rhlROQBraPYmRkfEQotIVp3
	 81Rl9V7vemd0w62az377Us5naygrG3cfKqKJrnTPifVWfdkgPuL+kfIzlKDB14vPQu
	 GCqQV8GMqzflHexjHRUBMwIOhu8B218xXwMT/wgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439995AbfJQQDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfJQQDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:03:21 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4192321D7F;
        Thu, 17 Oct 2019 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328199;
        bh=zciE6zvcpsijnNLJZWP6YJk7DXC8kCO7A8ZYz/9RWhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRdcnRWOVUVXl4hfcDpnawnPF6DBJYq3BvqPa0Fz9xUuRZx4Ec3G1zB+Ke800j3az
         GvSkFxVdzffH98FrKCTSJ+E6g91rBbP8VZFMAJM2FflwV3ncWbPLPqbWaGEV0Dm0cc
         9sDxm4l6bcNjqiX8UbDD1J1UHCiNFNr1kxAEBkqg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Feilong Lin <linfeilong@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/11] perf tools: Fix resource leak of closedir() on the error paths
Date:   Thu, 17 Oct 2019 13:02:53 -0300
Message-Id: <20191017160301.20888-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

Both build_mem_topology() and rm_rf_depth_pat() have resource leaks of
closedir() on the error paths.

Fix this by calling closedir() before function returns.

Fixes: e2091cedd51b ("perf tools: Add MEM_TOPOLOGY feature to perf data file")
Fixes: cdb6b0235f17 ("perf tools: Add pattern name checking to rm_rf")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: http://lore.kernel.org/lkml/cd5f7cd2-b80d-6add-20a1-32f4f43e0744@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 4 +++-
 tools/perf/util/util.c   | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 86d9396cb131..becc2d109423 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1296,8 +1296,10 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 			continue;
 
 		if (WARN_ONCE(cnt >= size,
-			      "failed to write MEM_TOPOLOGY, way too many nodes\n"))
+			"failed to write MEM_TOPOLOGY, way too many nodes\n")) {
+			closedir(dir);
 			return -1;
+		}
 
 		ret = memory_node__read(&nodes[cnt++], idx);
 	}
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 5eda6e19c947..ae56c766eda1 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -154,8 +154,10 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
-		if (!match_pat(d->d_name, pat))
-			return -2;
+		if (!match_pat(d->d_name, pat)) {
+			ret =  -2;
+			break;
+		}
 
 		scnprintf(namebuf, sizeof(namebuf), "%s/%s",
 			  path, d->d_name);
-- 
2.21.0

