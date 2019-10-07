Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F2ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAFF20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452960;
	bh=xOeaTpvaEoqk/W7lXC/TnkCzgH/tr2B+ZlugEsJY8zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wt/xGl3u+aZs6PAlRrY2cJ7Hsh9JhDv35+2fpRxBCS5AjkVSI3X3Wy40/7/h19Dsb
	 ChtEPXMzb3sGJjUoylNzL7RDU5WZkpFBfZ/e9+Ns2sOp4xr9hRO47hz8TI/ffZXSj7
	 J6VsxpZz2n4yunC0EqrGKAb13qwFWy9pg/RnAuHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfJGMyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbfJGMyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C025520FE;
        Mon,  7 Oct 2019 12:54:03 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2810A5D9CC;
        Mon,  7 Oct 2019 12:54:02 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 08/36] perf tools: Use perf_mmap way to detect aux mmap
Date:   Mon,  7 Oct 2019 14:53:16 +0200
Message-Id: <20191007125344.14268-9-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Mon, 07 Oct 2019 12:54:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will move this code to libperf shortly, so we need to free it of
'struct auxtrace_mmap' usage, because it won't be available in libperf
(for now).

The perf_event_mmap_page::aux_size is set when the aux mmap is mapped,
so the check is equivalent.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-48-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 9f150d50cea5..f246dd403507 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -107,7 +107,9 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 
 static bool perf_mmap__empty(struct mmap *map)
 {
-	return perf_mmap__read_head(map) == map->core.prev && !map->auxtrace_mmap.base;
+	struct perf_event_mmap_page *pc = map->core.base;
+
+	return perf_mmap__read_head(map) == map->core.prev && !pc->aux_size;
 }
 
 void perf_mmap__consume(struct mmap *map)
-- 
2.21.0

