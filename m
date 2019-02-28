Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A12C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5220D2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366756;
	bh=Xb76yS9w443TXhagUleUKmbz2W3IwgHIzq9I8qrGjjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iUgj07Ts8qcE7UT5U7jhbIuHs5FdXmpmvSG1NXqmsqAwMgwssFDwgeqKkxY2ngvjr
	 Mdev9uPlxQUd7CKkua1dj6CtUmfHsg6Pp/YyuBXK2E6tUOCGZABGwBP/lQdx/ei0Kz
	 HEtSqBuhJmtwjg/9oJ8mUs80nz1MlYOeDz/p/1kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbfB1PMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:12:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388260AbfB1PMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:12:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A05E0214D8;
        Thu, 28 Feb 2019 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366744;
        bh=Xb76yS9w443TXhagUleUKmbz2W3IwgHIzq9I8qrGjjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1028kQNCg3/l9Gjtv1WNIaziFD51IZ4o1UlQt9I61BoGO2KZk2WZvUwp/10Ib2pUj
         l8zBIsl8fGK+Y/hwo+WSGNmoJ+2KO3u7icQvVRizg9rND0RcdkuNe2hbLzKTfiFg6V
         srjePD51uRz++RvUrxXC9ILN7R5GfD0y6V5DWeEs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 43/64] dmaengine: dmatest: Abort test in case of mapping error
Date:   Thu, 28 Feb 2019 10:10:44 -0500
Message-Id: <20190228151105.11277-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 6454368a804c4955ccd116236037536f81e5b1f1 ]

In case of mapping error the DMA addresses are invalid and continuing
will screw system memory or potentially something else.

[  222.480310] dmatest: dma0chan7-copy0: summary 1 tests, 3 failures 6 iops 349 KB/s (0)
...
[  240.912725] check: Corrupted low memory at 00000000c7c75ac9 (2940 phys) = 5656000000000000
[  240.921998] check: Corrupted low memory at 000000005715a1cd (2948 phys) = 279f2aca5595ab2b
[  240.931280] check: Corrupted low memory at 000000002f4024c0 (2950 phys) = 5e5624f349e793cf
...

Abort any test if mapping failed.

Fixes: 4076e755dbec ("dmatest: convert to dmaengine_unmap_data")
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dmatest.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index aa1712beb0cc3..7b7fba0c92532 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -642,11 +642,9 @@ static int dmatest_func(void *data)
 			srcs[i] = um->addr[i] + src_off;
 			ret = dma_mapping_error(dev->dev, um->addr[i]);
 			if (ret) {
-				dmaengine_unmap_put(um);
 				result("src mapping error", total_tests,
 				       src_off, dst_off, len, ret);
-				failed_tests++;
-				continue;
+				goto error_unmap_continue;
 			}
 			um->to_cnt++;
 		}
@@ -661,11 +659,9 @@ static int dmatest_func(void *data)
 					       DMA_BIDIRECTIONAL);
 			ret = dma_mapping_error(dev->dev, dsts[i]);
 			if (ret) {
-				dmaengine_unmap_put(um);
 				result("dst mapping error", total_tests,
 				       src_off, dst_off, len, ret);
-				failed_tests++;
-				continue;
+				goto error_unmap_continue;
 			}
 			um->bidi_cnt++;
 		}
@@ -693,12 +689,10 @@ static int dmatest_func(void *data)
 		}
 
 		if (!tx) {
-			dmaengine_unmap_put(um);
 			result("prep error", total_tests, src_off,
 			       dst_off, len, ret);
 			msleep(100);
-			failed_tests++;
-			continue;
+			goto error_unmap_continue;
 		}
 
 		done->done = false;
@@ -707,12 +701,10 @@ static int dmatest_func(void *data)
 		cookie = tx->tx_submit(tx);
 
 		if (dma_submit_error(cookie)) {
-			dmaengine_unmap_put(um);
 			result("submit error", total_tests, src_off,
 			       dst_off, len, ret);
 			msleep(100);
-			failed_tests++;
-			continue;
+			goto error_unmap_continue;
 		}
 		dma_async_issue_pending(chan);
 
@@ -725,16 +717,14 @@ static int dmatest_func(void *data)
 			dmaengine_unmap_put(um);
 			result("test timed out", total_tests, src_off, dst_off,
 			       len, 0);
-			failed_tests++;
-			continue;
+			goto error_unmap_continue;
 		} else if (status != DMA_COMPLETE) {
 			dmaengine_unmap_put(um);
 			result(status == DMA_ERROR ?
 			       "completion error status" :
 			       "completion busy status", total_tests, src_off,
 			       dst_off, len, ret);
-			failed_tests++;
-			continue;
+			goto error_unmap_continue;
 		}
 
 		dmaengine_unmap_put(um);
@@ -779,6 +769,12 @@ static int dmatest_func(void *data)
 			verbose_result("test passed", total_tests, src_off,
 				       dst_off, len, 0);
 		}
+
+		continue;
+
+error_unmap_continue:
+		dmaengine_unmap_put(um);
+		failed_tests++;
 	}
 	ktime = ktime_sub(ktime_get(), ktime);
 	ktime = ktime_sub(ktime, comparetime);
-- 
2.19.1

