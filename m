Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAADC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CAE218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpQOKq46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLRTJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:09:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35287 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfLRTJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:09:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so1741440pfo.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=j0zBkq0VgJoL6PSpb9mhqIxD+Izq0jA3YTPBw0iDOVI=;
        b=cpQOKq46F3NoaI609tjoxOTU4bqZ6/gguyChGCfNtNNp+G9VmpWSMl3ctH9P3EEHOt
         SUDVzO2PqPC+yeJFDiQSXPvK1akjj7zKG55VVCamYt+/1mymm5EY8Bsg/+tyRSnk717B
         bb/DOkEwp52gHt5Xx8ueGKentiKKJkzpKsnjs4xxo/bZynRzSehP+skC+Y9HYTMxGwDj
         eqLFU9QXeHAU3MaMuWqvVt7nMCi3+kQYStuaPygHgwsgQD2td4jjVS/zvexgb6ElB1/9
         Jsf4OukzbhjBfubeQCH038G2vSBZ1odepyBe02+V0UBagJQdzpwoX5iXNUDn2nFFaQIM
         QfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j0zBkq0VgJoL6PSpb9mhqIxD+Izq0jA3YTPBw0iDOVI=;
        b=O+TQim9dWhSpVXa2hBJ35IsbdYQOxFjnxG3FrpuSLpSTRxG2qKIZoKNPeUywlYhJu1
         GGUdLiddhnb8tqT4PDBFJilrOJw46YgklpY5US5z36x1CPSRzkD+NPcy4xAKqXFEiQkD
         1wRwCAx4jN+zW9wm7hPiXqac5TcwMxl+cgZx7o7h10I18HAc5ZgHPTX8b+BDPFRc7p/W
         86GM337GPPd7VilM1cMCs1MzbHw1qb0UCPIKbUCQlHyjxW81jIo7D+g7CS27/D5oH3S1
         oS91NHHD/NnXX7j8v4LXxfoiL4U+oMwuMj+kOk5TG78WQ4EiC0lceFXp34j/T9xGS0VR
         +fZg==
X-Gm-Message-State: APjAAAV7U+NnwWEmOb0d4AjfgzkITTwOzGBVCtcOYFSaEDfjvmDeXAMk
        Zp1Q6B8ZVpj2hznlT1Xs/BIz4FBqTnI=
X-Google-Smtp-Source: APXvYqxHKPx9oJncAqOZSvlZDU+b6hC8CJR05VxvwFjY+yLFMVdyoo1P4k1hS1WOwawqq6M7cbqOFQ==
X-Received: by 2002:aa7:8299:: with SMTP id s25mr4610914pfm.261.1576696149859;
        Wed, 18 Dec 2019 11:09:09 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r6sm4376396pfh.91.2019.12.18.11.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:09:09 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, ryan@edited.us,
        aserbinski@gmail.com, dmaengine@vger.kernel.org
Subject: [PATCH] k3dma: Avoid null pointer traversal
Date:   Wed, 18 Dec 2019 19:09:06 +0000
Message-Id: <20191218190906.6641-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases we seem to submit two transactions in a row, which
causes us to lose track of the first. If we then cancel the
request, we may still get an interrupt, which traverses a null
ds_run value.

So try to avoid starting a new transaction if the ds_run value
is set.

While this patch avoids the null pointer crash, I've had some
reports of the k3dma driver still getting confused, which
suggests the ds_run/ds_done value handling still isn't quite
right. However, I've not run into an issue recently with it
so I think this patch is worth pushing upstream to avoid the
crash.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: ryan@edited.us
Cc: aserbinski@gmail.com
Cc: dmaengine@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma/k3dma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index adecea51814f..c5c1aa0dcaed 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -229,9 +229,11 @@ static irqreturn_t k3_dma_int_handler(int irq, void *dev_id)
 			c = p->vchan;
 			if (c && (tc1 & BIT(i))) {
 				spin_lock_irqsave(&c->vc.lock, flags);
-				vchan_cookie_complete(&p->ds_run->vd);
-				p->ds_done = p->ds_run;
-				p->ds_run = NULL;
+				if (p->ds_run != NULL) {
+					vchan_cookie_complete(&p->ds_run->vd);
+					p->ds_done = p->ds_run;
+					p->ds_run = NULL;
+				}
 				spin_unlock_irqrestore(&c->vc.lock, flags);
 			}
 			if (c && (tc2 & BIT(i))) {
@@ -271,6 +273,10 @@ static int k3_dma_start_txd(struct k3_dma_chan *c)
 	if (BIT(c->phy->idx) & k3_dma_get_chan_stat(d))
 		return -EAGAIN;
 
+	/* Avoid losing track of  ds_run if a transaction is in flight */
+	if (c->phy->ds_run)
+		return -EAGAIN;
+
 	if (vd) {
 		struct k3_dma_desc_sw *ds =
 			container_of(vd, struct k3_dma_desc_sw, vd);
-- 
2.17.1

