Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2EEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3F020883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="JVsPp08x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDHIHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:07:15 -0400
Received: from mx08-00376f01.pphosted.com ([91.207.212.86]:32923 "EHLO
        mx08-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbfDHIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:07:15 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2019 04:07:13 EDT
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
        by mx08-00376f01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x387qx4M004343;
        Mon, 8 Apr 2019 09:01:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=dk201812;
 bh=4tnVAK4TQVHygCpQtVykR43NW2riV70ZeFYLvuTSJxU=;
 b=JVsPp08x1SaFZYicJASSAzMlHkbUXQTT+BCqGFOYUAow2nohPMdpCVrNCdeR7UPEfxo4
 qj2RSSGGjaD4AAJenpiT8UqAT1u3HWYLcMSte1GTKUs0Yui0panxY+IwQ5EYi33c9T/B
 b7scgpr0AQ6crw7cg+XTnRMZ7r4f07aGwqrQYnkRZ8Xszc+tRuS8064WmNTNB4DS3wnd
 3ENi/RmcpyNMMvx8LSAgFWK8Qc0MGC8ytYb2I8M7k7DHha5lab/8Q0C/km3NZztOif0g
 YPFW+FN0TMtvVH3sBqYKANMqOq1IwlSHu4ZSSgyzdSNtWIM2MsEPplvhXapZLc6DQJSS Dw== 
Received: from hhmail02.hh.imgtec.org ([217.156.249.195])
        by mx08-00376f01.pphosted.com with ESMTP id 2rpjcp9xt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Apr 2019 09:01:46 +0100
Received: from michael-imgtec.tp.imgtec.org (10.80.16.25) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 8 Apr 2019 09:01:45 +0100
From:   Michael Yang <michael.yang@imgtec.com>
To:     <sumit.semwal@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <gustavo@padovan.org>, <linux-media@vger.kernel.org>,
        <linaro-mm-sig@lists.linaro.org>, <michael.yang@imgtec.com>
Subject: [PATCH] sync_file: Return reasonable timestamp when merging signaled fences
Date:   Mon, 8 Apr 2019 16:01:35 +0800
Message-ID: <1554710495-6646-1-git-send-email-michael.yang@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.16.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all the sync points were signaled in both fences a and b,
there was only one sync point in merged fence which is a_fence[0].
The Fence structure in android framework might be confused about
timestamp if there were any sync points which were signaled after
a_fence[0]. It might be more reasonable to use timestamp of last signaled
sync point to represent the merged fence.
The issue can be found from EGL extension ANDROID_get_frame_timestamps.
Sometimes the return value of EGL_READS_DONE_TIME_ANDROID is head of
the return value of EGL_RENDERING_COMPLETE_TIME_ANDROID.
That means display/composition had been completed before rendering
was completed that is incorrect.

Some discussion can be found at:
https://android-review.googlesource.com/c/kernel/common/+/907009

Signed-off-by: Michael Yang <michael.yang@imgtec.com>
---
 drivers/dma-buf/sync_file.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 4f6305c..d46bfe1 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -274,8 +274,29 @@ static struct sync_file *sync_file_merge(const char *name, struct sync_file *a,
 	for (; i_b < b_num_fences; i_b++)
 		add_fence(fences, &i, b_fences[i_b]);
 
-	if (i == 0)
-		fences[i++] = dma_fence_get(a_fences[0]);
+	/* If all the sync pts were signaled, then adding the sync_pt who
+	 * was the last signaled to the fence.
+	 */
+	if (i == 0) {
+		struct dma_fence *last_signaled_sync_pt = a_fences[0];
+		int iter;
+
+		for (iter = 1; iter < a_num_fences; iter++) {
+			if (ktime_compare(last_signaled_sync_pt->timestamp,
+				a_fences[iter]->timestamp) < 0) {
+				last_signaled_sync_pt = a_fences[iter];
+			}
+		}
+
+		for (iter = 0; iter < b_num_fences; iter++) {
+			if (ktime_compare(last_signaled_sync_pt->timestamp,
+				b_fences[iter]->timestamp) < 0) {
+				last_signaled_sync_pt = b_fences[iter];
+			}
+		}
+
+		fences[i++] = dma_fence_get(last_signaled_sync_pt);
+	}
 
 	if (num_fences > i) {
 		nfences = krealloc(fences, i * sizeof(*fences),
-- 
2.7.4

