Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A92C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2372520850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255686;
	bh=WdqLbqJkFHVwc1azsUfHBZQoBOBNhlRhtPNBrvhR8MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kfCx202Fu8/cRgMVy4PENdC7tqFe8IJduSvOGa74KesK2OfXNRgTVfLQu+HfHFLzr
	 XhSgGpsZTwZ+z1PxQsCGSk/vCy6KElZ4VHzTxXGXD86APBix76nmMXXlQ8pyLATyUd
	 Zli8d40RsrZZBKKdlr0zoOqrqEB4XvCnEQQsI08U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbfCVLyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732577AbfCVLyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:54:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C106F2082C;
        Fri, 22 Mar 2019 11:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255678;
        bh=WdqLbqJkFHVwc1azsUfHBZQoBOBNhlRhtPNBrvhR8MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2HKGvXml/ZBNLwFdqHav8/Zh3QwFwgALJwpXcFmW4avjYV+gxX7Ac4Y5g5+lr2Ov
         deZMQ05WnbDGgmaccHvbY+q8wtlT39UXvPP8zRZoHf/VPstDtYSPSxVfsT+tE+q4NF
         vSKL3aA8XwJpq8KYH2G+F/3OnwWwn9uYjDq6wobM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.14 165/183] perf intel-pt: Fix overlap calculation for padding
Date:   Fri, 22 Mar 2019 12:16:33 +0100
Message-Id: <20190322111253.860239461@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 5a99d99e3310a565b0cf63f785b347be9ee0da45 upstream.

Auxtrace records might have up to 7 bytes of padding appended. Adjust
the overlap accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190206103947.15750-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   36 ++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -26,6 +26,7 @@
 
 #include "../cache.h"
 #include "../util.h"
+#include "../auxtrace.h"
 
 #include "intel-pt-insn-decoder.h"
 #include "intel-pt-pkt-decoder.h"
@@ -2558,6 +2559,34 @@ static int intel_pt_tsc_cmp(uint64_t tsc
 	}
 }
 
+#define MAX_PADDING (PERF_AUXTRACE_RECORD_ALIGNMENT - 1)
+
+/**
+ * adj_for_padding - adjust overlap to account for padding.
+ * @buf_b: second buffer
+ * @buf_a: first buffer
+ * @len_a: size of first buffer
+ *
+ * @buf_a might have up to 7 bytes of padding appended. Adjust the overlap
+ * accordingly.
+ *
+ * Return: A pointer into @buf_b from where non-overlapped data starts
+ */
+static unsigned char *adj_for_padding(unsigned char *buf_b,
+				      unsigned char *buf_a, size_t len_a)
+{
+	unsigned char *p = buf_b - MAX_PADDING;
+	unsigned char *q = buf_a + len_a - MAX_PADDING;
+	int i;
+
+	for (i = MAX_PADDING; i; i--, p++, q++) {
+		if (*p != *q)
+			break;
+	}
+
+	return p;
+}
+
 /**
  * intel_pt_find_overlap_tsc - determine start of non-overlapped trace data
  *                             using TSC.
@@ -2608,8 +2637,11 @@ static unsigned char *intel_pt_find_over
 
 			/* Same TSC, so buffers are consecutive */
 			if (!cmp && rem_b >= rem_a) {
+				unsigned char *start;
+
 				*consecutive = true;
-				return buf_b + len_b - (rem_b - rem_a);
+				start = buf_b + len_b - (rem_b - rem_a);
+				return adj_for_padding(start, buf_a, len_a);
 			}
 			if (cmp < 0)
 				return buf_b; /* tsc_a < tsc_b => no overlap */
@@ -2672,7 +2704,7 @@ unsigned char *intel_pt_find_overlap(uns
 		found = memmem(buf_a, len_a, buf_b, len_a);
 		if (found) {
 			*consecutive = true;
-			return buf_b + len_a;
+			return adj_for_padding(buf_b + len_a, buf_a, len_a);
 		}
 
 		/* Try again at next PSB in buffer 'a' */


