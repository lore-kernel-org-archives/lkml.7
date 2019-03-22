Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADF7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EABF2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260311;
	bh=scU4OgR9GIWiJf4zE44lO7KMoovVz12Tq270KDvNfX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OIklh39SIukHv9aNs+tQsPHYN3mYilYcsrcMTCnvv4kW8XnDP9jlNcBOvGpE+hSP0
	 quDmP8Pd8w/7B9Dj6KhcEcgJ1rxIXC7zbp+3TolOgbKjOScWBctYkwn/UnWsRlEvJ0
	 3M4Q6ZuMS/TQ3ig3t7RB9HDsRu/hdvF+Yqy5173k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfCVNLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbfCVLcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:32:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9617F20449;
        Fri, 22 Mar 2019 11:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254350;
        bh=scU4OgR9GIWiJf4zE44lO7KMoovVz12Tq270KDvNfX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J/vlUnzE3G8UUorH/yFKAZ+/VTrH03lk+CroKRmDFxtUFUR4Y2u2D0QTZg+9tBxYl
         SM3mrvePkTcSTfCphWBLL81kINKcLnLxt6MDOa6ve1vMv+8fj7eNgSgGST4yicKHPL
         iv77Hcjwhc8RuXzQVQJxYdB95SCZfuP28QrzvWY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 108/230] dmaengine: dmatest: Abort test in case of mapping error
Date:   Fri, 22 Mar 2019 12:14:06 +0100
Message-Id: <20190322111244.191942877@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 6796eb1a8a4c..884aecebb249 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -563,11 +563,9 @@ static int dmatest_func(void *data)
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
@@ -582,11 +580,9 @@ static int dmatest_func(void *data)
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
@@ -611,12 +607,10 @@ static int dmatest_func(void *data)
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
@@ -625,12 +619,10 @@ static int dmatest_func(void *data)
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
 
@@ -643,16 +635,14 @@ static int dmatest_func(void *data)
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
@@ -691,6 +681,12 @@ static int dmatest_func(void *data)
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
 	runtime = ktime_us_delta(ktime_get(), ktime);
 
-- 
2.19.1



