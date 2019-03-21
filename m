Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150BA21902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMMY17lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfCUShU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:37:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36299 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfCUShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:37:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so4792315pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jm/p59tqtKTujnCT99TbmZq6pyF5sCVco9IlDI3kpp0=;
        b=DMMY17lYBFqvic3FLsoBbzum6zr4czlLtg0kOagHe9ugWkVk0eESrmf3deiOBOkX8a
         kGPL2JAJPTRiyhHvawNYcsiIgw/p2PRgnyf7UNibRziacKr4BWBJZKyNvzljfTeI/ElO
         29UG0IHGr6MIfyGzS3tjEigf80CwEl+v6AyBvUt19K3WUY6I1V4HApTIrt+gc/NAsxaD
         eWPvTW3JvDb2M5Es3lFE+JnsOVWjglL3vLTZJjdc0VizAlryLq+FCDxwireKBNZRtcHH
         M+gJ0AKDHiVfE6/20eGUeAwow7L6P9tMLi6Dj+H3yz9agoIXSGQgux/5Fak5gSt/uf1m
         k8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jm/p59tqtKTujnCT99TbmZq6pyF5sCVco9IlDI3kpp0=;
        b=mGrNCI1L+B4K5s2Ep4g6e6YE1rbAvwAuAsSi4fFnGGERq/0PXyWsrkCTn7/nsVxRQG
         Ou9si2XgaDcwDfJtsHT+SWT5BnbqnfbbI0wMVbKvGuMVqLeJ/+j/qqPOfe0PUQJxr6Cd
         ZcS/f4K7s1Uyu/RPKKorlCqgHTEKgVj1vKg0Ftd+NT0P8YV7PT3hDdW/WqDvAfgt42Ai
         vA2b5cUKXTpAzAjA9gbs8PyHN1RJ60lvoMBba3RNnPdQ5kf5mzRrNgVjHT25WNE6jlvH
         qoEJaMCtmAWkUdIjM4XLwGNsYWrIzstsIDJ6RjBq031bzfsdKaK3Xkff+RXGfu9Hji/K
         ZpgQ==
X-Gm-Message-State: APjAAAXBq43+tblMbXpu7ZOv2DXROIP+ft9S5qs2OD4PNAW7zkRXDOrS
        HzlX3Pt7F3tkg/I0NW5npas=
X-Google-Smtp-Source: APXvYqzbI11nG+B3q5mGTYljGebSS3wgW2yuC+nS4wuVpTl6UM8Q51b0hu1GQ01+SQi4vK/Z0JuUDA==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr5001268plv.157.1553193437848;
        Thu, 21 Mar 2019 11:37:17 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.35])
        by smtp.gmail.com with ESMTPSA id n23sm6244502pgv.86.2019.03.21.11.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 11:37:17 -0700 (PDT)
Date:   Fri, 22 Mar 2019 00:07:10 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, christian@lkamp.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ralink-gdma: Prefer u32 over uint32_t
Message-ID: <20190321183710.GA8472@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change uint32_t to u32

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index d78042e..2c19287 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -361,7 +361,7 @@ static int rt3883_gdma_start_transfer(struct gdma_dmaengine_chan *chan)
 	struct gdma_dma_dev *dma_dev = gdma_dma_chan_get_dev(chan);
 	dma_addr_t src_addr, dst_addr;
 	struct gdma_dma_sg *sg;
-	uint32_t ctrl0, ctrl1;
+	u32 ctrl0, ctrl1;
 
 	/* verify chan is already stopped */
 	ctrl0 = gdma_dma_read(dma_dev, GDMA_REG_CTRL0(chan->id));
-- 
2.7.4

