Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CF2218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366984;
	bh=HD0ZgtkClz+U54CZRrOFB8omyqUPYJImcmwtLfKc3cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vD0phGo3phRbXprdxI7tAcn7rgBlsrplSZ6Pjgv4aWKgXxLc+iQBQVTJcC/C2mHD0
	 XwogeoustocqtuJbsJJ8BZuhym2QonFG1cbA8BuDCFLxwIeyGt6T/97Shd/wVlElGn
	 UpaIAQbZV1pzCu0E6KYIzS4+on8N65Vqt9Z6HqdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbfB1PQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:16:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389005AbfB1PQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:16:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C677218EA;
        Thu, 28 Feb 2019 15:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366979;
        bh=HD0ZgtkClz+U54CZRrOFB8omyqUPYJImcmwtLfKc3cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+KP9Nwvu7Ey1a4530Y3m6zf/J+rPXqHWb/fFAJ3oQKaxR/NuevT56WyxM1JB7r3R
         qfQtuMmwWCT/Vcf4aXsNespW5ghrQBnAn+mxCSIThohl8rn4fRs1gw0BeXDno31jCA
         SOLMQdhzHrWV3X4YmRHSN5EFasiQ3a7XPfB+oObo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 4/8] dmaengine: dmatest: Abort test in case of mapping error
Date:   Thu, 28 Feb 2019 10:16:08 -0500
Message-Id: <20190228151614.13022-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151614.13022-1-sashal@kernel.org>
References: <20190228151614.13022-1-sashal@kernel.org>
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
index 6796eb1a8a4cb..884aecebb249b 100644
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

