Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CD1C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B64206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfD0PUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:20:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33958 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727588AbfD0PPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:34 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP35-0000zG-Dk; Sat, 27 Apr 2019 16:15:31 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004Vm-CQ; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.474763181@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 092/202] dmaengine: dmatest: unmap data on a single
 code-path when xfer done
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

commit 0255200bd29afc320c6ea4c1adf8bdc13a9b3c15 upstream.

After the DMA transfer is done, we don't need to call the un-mapping code
in 3 places. One is enough.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[bwh: Backported to 3.16 as dependency of commit 6454368a804c
 "dmaengine: dmatest: Abort test in case of mapping error"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/dma/dmatest.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -638,14 +638,14 @@ static int dmatest_func(void *data)
 
 		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
 
+		dmaengine_unmap_put(um);
+
 		if (!done->done) {
-			dmaengine_unmap_put(um);
 			result("test timed out", total_tests, src_off, dst_off,
 			       len, 0);
 			failed_tests++;
 			continue;
 		} else if (status != DMA_COMPLETE) {
-			dmaengine_unmap_put(um);
 			result(status == DMA_ERROR ?
 			       "completion error status" :
 			       "completion busy status", total_tests, src_off,
@@ -654,8 +654,6 @@ static int dmatest_func(void *data)
 			continue;
 		}
 
-		dmaengine_unmap_put(um);
-
 		if (params->noverify) {
 			verbose_result("test passed", total_tests, src_off,
 				       dst_off, len, 0);

