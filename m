Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D40C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8724D21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1fsnG/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGBH5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:57:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42540 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBH5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:57:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so3915113pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Nt9fr/v91i6Bje9ZeiTx2ofl3b2ND4f5m/8aFDYK+9M=;
        b=g1fsnG/2+TO9XIHytSmf569+7TbBI3Zst+QLNNdu4/tLR5Mw39FzGAMrWZOk6p6JDw
         kcr8TdC2ubXlX+bcmyiSyLtAovvjcb9lY76fP23xqK68q2adWMZtriAPJLetNXgplEIW
         qnYB12YrzHPXj4rNLgKYkv8+Rv9fp5dSzcyKcnHSRnRIGIGEZmp4/WV08BiDGYxip9kh
         NTrQLSMuKTMWJaFfe1tL2pKh54smRJ8AJV1g0DnXk+fa7XHj+u9OdoeO7JFl7CHJe8Pj
         yDNH5gr7KdkG/UQSQ+oryz44gafbzXEzigj7dRm4I7tD/erpxgUs5Cl7T/goa5kbCjJ/
         kWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nt9fr/v91i6Bje9ZeiTx2ofl3b2ND4f5m/8aFDYK+9M=;
        b=UQZYetaNWgZHgd/t9t6MhyEFZhxzW92bjTLVahfIrbIKNa7cBzm04fULW+FXPJmwRZ
         v9r4vpcQieluFbIuqnA5gasgSjU55+CO0yNLa3jjin8kYzCh4XqwDCN755Bbw2UlUfdC
         CFoy3QTCkjZRsPHR+N03NTTFhHNHpStzrdCo6bxzQVJZ8+o3XLxauisZGUsmEkd5BHbB
         Dt0oUD/iBedhEwvnQOG4ghsxeSFE4uRZ0oVC/XIq2Exp15zloldJ9a8YEGDE6efSbal6
         +b4WyS/7KGCAfv90Tk0R7C4G5HcA3i+QB7LqKQJkX02vvh/sYpR4wwdw8+gYygJ4eFly
         P/Fg==
X-Gm-Message-State: APjAAAWnBrVuH2s67Tn7gmbsWgRhXeCD2DzHzKhvOBTyP0j9OwRZzuFE
        1/Ebm5CGxAcL9hjVn/q3uzPv2cfgZxo=
X-Google-Smtp-Source: APXvYqysDSZZntgWIrL2DACMvTDnJ1oAyu1BRU+v5G7TtsEDTTz0/wLMMQbizzt1xZCa+G7V46Qzhg==
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr4136099pjr.113.1562054252889;
        Tue, 02 Jul 2019 00:57:32 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id g18sm2747520pgm.9.2019.07.02.00.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:57:32 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 06/27] dma: remove memset after dma_alloc_coherent/dmam_alloc_coherent
Date:   Tue,  2 Jul 2019 15:57:27 +0800
Message-Id: <20190702075727.23789-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent/dmam_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/dma/imx-sdma.c      | 4 ----
 drivers/dma/qcom/hidma_ll.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 99d9f431ae2c..54d86359bdf8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1886,10 +1886,6 @@ static int sdma_init(struct sdma_engine *sdma)
 	sdma->context_phys = ccb_phys +
 		MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control);
 
-	/* Zero-out the CCB structures array just allocated */
-	memset(sdma->channel_control, 0,
-			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control));
-
 	/* disable all channels */
 	for (i = 0; i < sdma->drvdata->num_events; i++)
 		writel_relaxed(0, sdma->regs + chnenbl_ofs(sdma, i));
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 5bf8b145c427..bb4471e84e48 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -749,7 +749,6 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 	if (!lldev->tre_ring)
 		return NULL;
 
-	memset(lldev->tre_ring, 0, (HIDMA_TRE_SIZE + 1) * nr_tres);
 	lldev->tre_ring_size = HIDMA_TRE_SIZE * nr_tres;
 	lldev->nr_tres = nr_tres;
 
@@ -769,7 +768,6 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 	if (!lldev->evre_ring)
 		return NULL;
 
-	memset(lldev->evre_ring, 0, (HIDMA_EVRE_SIZE + 1) * nr_tres);
 	lldev->evre_ring_size = HIDMA_EVRE_SIZE * nr_tres;
 
 	/* the EVRE ring has to be EVRE_SIZE aligned */
-- 
2.11.0

