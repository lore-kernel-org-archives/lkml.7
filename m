Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E39C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A96F2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565290499;
	bh=vsblKgp+4ONMH5VzyB1/Vu6bvVvpUq7Ye68shjhsKbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wVt3F/6YqOK3tesyV7n8Bd6u4TvBubPzgA2e2iQwR6Jp+bk+neQSnhlGbUFAI5CsZ
	 y53BtKL18rXFeDNoeZ4l/U1i8rpLzyi+KzTwTIXu9egVt0c0tm/fEsmRNqnNVy3Ao8
	 R/trA+xPfWTtQavmzm3LeXcuoNlcDfIUbnNu5/Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390332AbfHHSy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390228AbfHHSy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:54:57 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.210.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549AF21880;
        Thu,  8 Aug 2019 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565290496;
        bh=vsblKgp+4ONMH5VzyB1/Vu6bvVvpUq7Ye68shjhsKbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b33icK0CJyCKlCJbYXMSwZvFDaUnrg6Du0ES4EcmDVHoOjUxBcBRgOVw4zwD/PcXR
         1nPk9PiFUFzxjjAv6M2PvfK3qxKefFuzyQ/g6Z2om8qte9osaHcPy8qyVe9oVouKuS
         PKQ7tJ2qEcFHEIXkScWnmA/Yl31CCJdrsFDT5XVE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        He Zhe <zhe.he@windriver.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/10] perf cpumap: Fix writing to illegal memory in handling cpumap mask
Date:   Thu,  8 Aug 2019 15:53:53 -0300
Message-Id: <20190808185358.20125-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

cpu_map__snprint_mask() would write to illegal memory pointed by
zalloc(0) when there is only one cpu.

This patch fixes the calculation and adds sanity check against the input
parameters.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Fixes: 4400ac8a9a90 ("perf cpumap: Introduce cpu_map__snprint_mask()")
Link: http://lkml.kernel.org/r/1564734592-15624-2-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 3acfbe34ebaf..39cce66b4ebc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -751,7 +751,10 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
 	unsigned char *bitmap;
 	int last_cpu = cpu_map__cpu(map, map->nr - 1);
 
-	bitmap = zalloc((last_cpu + 7) / 8);
+	if (buf == NULL)
+		return 0;
+
+	bitmap = zalloc(last_cpu / 8 + 1);
 	if (bitmap == NULL) {
 		buf[0] = '\0';
 		return 0;
-- 
2.21.0

