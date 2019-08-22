Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4E223404
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507781;
	bh=ilHMvL/Cbmj1krdeFKhMg1Wesm0n0CXeisge1wjytN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMX+e0S4JXBIMs32FvNMFqmzCr5s8P61N56fFE24zERUcPfcpHUWrNnYHrRgz/ggl
	 GVirEzZK9dtm2HIx6gJT1KMZtrZ/hLvzbTEqT7xbVDvxPpZ18EGz06NFrsv46SCJCt
	 7odvuWzuLy8IzILDZj8PYGQz1TZ5RQIlcm+2rLkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393555AbfHVVC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393544AbfHVVC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:57 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37AAB23405;
        Thu, 22 Aug 2019 21:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507776;
        bh=ilHMvL/Cbmj1krdeFKhMg1Wesm0n0CXeisge1wjytN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzzLLQS9vIroxb9bY4l+W/0E0qJyZNrgAiPMHv6o8uRhNpAhNcMKURItI54a2jsCN
         ciNiE+QvIO37UUfIV4R+kNGJweb8zXiIO7J88XHwHQTr/NK3RxxlRq/Ftgjms2XD2O
         +0/dZVmpjx3OGcJGucUFs/BFgWSTM/kyEMe0wL8E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Gerald BAEZA <gerald.baeza@st.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/25] libperf: Fix alignment trap with xyarray contents in 'perf stat'
Date:   Thu, 22 Aug 2019 18:01:00 -0300
Message-Id: <20190822210100.3461-26-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald BAEZA <gerald.baeza@st.com>

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
---
 tools/perf/lib/include/internal/xyarray.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/include/internal/xyarray.h b/tools/perf/lib/include/internal/xyarray.h
index 3bf70e4d474c..51e35d6c8ec4 100644
--- a/tools/perf/lib/include/internal/xyarray.h
+++ b/tools/perf/lib/include/internal/xyarray.h
@@ -2,6 +2,7 @@
 #ifndef __LIBPERF_INTERNAL_XYARRAY_H
 #define __LIBPERF_INTERNAL_XYARRAY_H
 
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
2.21.0

