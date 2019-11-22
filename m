Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40948C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C46620672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421909;
	bh=jklRnbWyUn1g3R8PppErtgWOyC8AuluYe2sHZYjRpM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l17fN6iJoJm3SXY4jrQcRK6spjopQNX2ebZhB7zTruZEuF9Xj4iPCrrF1NoWW+/F3
	 r0Q54y7x/1VXAqhA7Fjt+QhXzdojikOYizQ3NiWv1yJHxfX5vXxGczsFSrGAqakmO4
	 L5dBjZEO3cvBi/p3wWNuEOI8scyQAXBfM9FkMlng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfKVLZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:25:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfKVKhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:37:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40B0420717;
        Fri, 22 Nov 2019 10:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419035;
        bh=jklRnbWyUn1g3R8PppErtgWOyC8AuluYe2sHZYjRpM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YT02dLuLbed0FVIOWSTvd8jsjumiEF7p/nGIcXy2IGga+F6hNzzAp/PckjC5Ta8g4
         bW+OLIgF+wbaeRqGwp7xpRxehwqhy+UtuQ8jBR7txxvm12PBqyXUImyAfGbEVSUBW3
         nwNkp2PSgDOQCCOCzlxMrcSuYmqRTuh2vMOq3RSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rami Rosen <ramirose@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 136/159] dmaengine: ioat: fix prototype of ioat_enumerate_channels
Date:   Fri, 22 Nov 2019 11:28:47 +0100
Message-Id: <20191122100835.835464207@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rami Rosen <ramirose@gmail.com>

[ Upstream commit f4d34aa8c887a8a2d23ef546da0efa10e3f77241 ]

Signed-off-by: Rami Rosen <ramirose@gmail.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ioat/init.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 106fa9b327d92..92b0a7a042ee0 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -128,7 +128,7 @@ static void
 ioat_init_channel(struct ioatdma_device *ioat_dma,
 		  struct ioatdma_chan *ioat_chan, int idx);
 static void ioat_intr_quirk(struct ioatdma_device *ioat_dma);
-static int ioat_enumerate_channels(struct ioatdma_device *ioat_dma);
+static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma);
 static int ioat3_dma_self_test(struct ioatdma_device *ioat_dma);
 
 static int ioat_dca_enabled = 1;
@@ -593,7 +593,7 @@ static void ioat_dma_remove(struct ioatdma_device *ioat_dma)
  * ioat_enumerate_channels - find and initialize the device's channels
  * @ioat_dma: the ioat dma device to be enumerated
  */
-static int ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
+static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 {
 	struct ioatdma_chan *ioat_chan;
 	struct device *dev = &ioat_dma->pdev->dev;
@@ -612,7 +612,7 @@ static int ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 	xfercap_log = readb(ioat_dma->reg_base + IOAT_XFERCAP_OFFSET);
 	xfercap_log &= 0x1f; /* bits [4:0] valid */
 	if (xfercap_log == 0)
-		return 0;
+		return;
 	dev_dbg(dev, "%s: xfercap = %d\n", __func__, 1 << xfercap_log);
 
 	for (i = 0; i < dma->chancnt; i++) {
@@ -629,7 +629,6 @@ static int ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 		}
 	}
 	dma->chancnt = i;
-	return i;
 }
 
 /**
-- 
2.20.1



