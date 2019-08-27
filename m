Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDE02173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893579;
	bh=ufF3t1CWQkT46mQdMzFeTuoDkBirTgFqwuYqOxLy9ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z0rgzTkW3zgPCIfWrVggva+hVwclIWCFTbnLI+6/b5eACyZzAS+uj1mAPVkkeIOqz
	 swgILyuWmU8XAR4Q78bHgV0PVIrMUn7BKMiDhBi7fLWOLbwzTUnGRbzaMpoZqiX/Rn
	 2Aln1xgZQ7JV267coSAGCUWRdma6Nk4RD4NqhRoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfH0IM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731060AbfH0H6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:58:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19194206BF;
        Tue, 27 Aug 2019 07:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892723;
        bh=ufF3t1CWQkT46mQdMzFeTuoDkBirTgFqwuYqOxLy9ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EtiHT/XyiaR8hJex5onwV+d5RTxZLee+P/TF8A/wOxj3j8DiwUZyQetH6Yb6DIDOB
         6n5Ro7CzFPxsI3gU/J0KzQa8ypsf9Xg3G5XHnDJhCBqFxoTSfL4A3vYGT9R7xMQcCE
         5tJ1zrNugw6CidNGe6Jc81Vlzdo6xDk6qoD9jWx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, He Zhe <zhe.he@windriver.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 54/98] perf cpumap: Fix writing to illegal memory in handling cpumap mask
Date:   Tue, 27 Aug 2019 09:50:33 +0200
Message-Id: <20190827072721.174204857@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5f5e25f1c7933a6e1673515c0b1d5acd82fea1ed ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cpumap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 383674f448fcd..f93846edc1e0d 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -701,7 +701,10 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
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
2.20.1



