Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEBBC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841132184D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178722;
	bh=B05maExQbhzmRz3QtW0v5BieCGz5HdQQOqgZortZCcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1AwlM0LTsKDFi9YRGZYYCDJOAhIqcVYrcLmHbjTai7gOQ4Oz9far4T/FKSITstdIP
	 mGGNnLk3CGKoXdxLmRsrPS1MpuWhjdmLd7RF1hzYpxiiZtW32ZHdfpVIbBbm+l4vwS
	 hnjx7GYLfHQUl4YzCVDyNf10CVLt4x0UgAU4xx9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438802AbfIVS6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394892AbfIVS6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:58:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DC3F206C2;
        Sun, 22 Sep 2019 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178716;
        bh=B05maExQbhzmRz3QtW0v5BieCGz5HdQQOqgZortZCcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQv+/P4GBItlOqyw9ID5/r++/HxYX4eyvvwH7/PfvItReCppfhO3Ib4+1NGt4tMzl
         oNuijWYFeFcfCXOV3kc6IkT0rQY9uMKM4zrlkjN09JdgPfKC2MMMh5KslQ99Z18UTN
         4/iMaWGnNgsftJXrl9PnioojWJ7Id62cykARbSJA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gerald BAEZA <gerald.baeza@st.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 49/89] libperf: Fix alignment trap with xyarray contents in 'perf stat'
Date:   Sun, 22 Sep 2019 14:56:37 -0400
Message-Id: <20190922185717.3412-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald BAEZA <gerald.baeza@st.com>

[ Upstream commit d9c5c083416500e95da098c01be092b937def7fa ]

Following the patch 'perf stat: Fix --no-scale', an alignment trap
happens in process_counter_values() on ARMv7 platforms due to the
attempt to copy non 64 bits aligned double words (pointed by 'count')
via a NEON vectored instruction ('vld1' with 64 bits alignment
constraint).

This patch sets a 64 bits alignment constraint on 'contents[]' field in
'struct xyarray' since the 'count' pointer used above points to such a
structure.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1566464769-16374-1-git-send-email-gerald.baeza@st.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/xyarray.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/xyarray.h b/tools/perf/util/xyarray.h
index 7ffe562e7ae7f..2627b038b6f2a 100644
--- a/tools/perf/util/xyarray.h
+++ b/tools/perf/util/xyarray.h
@@ -2,6 +2,7 @@
 #ifndef _PERF_XYARRAY_H_
 #define _PERF_XYARRAY_H_ 1
 
+#include <linux/compiler.h>
 #include <sys/types.h>
 
 struct xyarray {
@@ -10,7 +11,7 @@ struct xyarray {
 	size_t entries;
 	size_t max_x;
 	size_t max_y;
-	char contents[];
+	char contents[] __aligned(8);
 };
 
 struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
-- 
2.20.1

