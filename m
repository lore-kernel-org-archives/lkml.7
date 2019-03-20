Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F90FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF94213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVkj4XMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCTQuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:50:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37038 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfCTQuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:50:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id v21so2609708edq.4;
        Wed, 20 Mar 2019 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X6IZ0kdG9aeVwwBEHw4YFMvSu0VQ1Omdeh0RqqU4m+M=;
        b=iVkj4XMQjA3YdGcG4sLh/P4h2F/vjrWVJBiZGfV4BtaqgFTd+n2oiQsB8tqQk2dKjh
         XTub/1asRnhyZ9xOJH5Ce8rn6Gy1lWxKbRwWxrPYZ8MWuZim6mo0R8bARUBUXf8W2YSP
         fibkb+Z1M+YChp+LKczyBYfCtHueeRNjVHIO33nGu0zMgcm9ac3ElrJ324MRsWyRlxi9
         RNC5YEuog17+otmi51Kyyi6+BsUX++ZuC2m1fg8h498kJC2fm4TMW4b7bjelZMj59SFS
         0mojySkaEX412KE/GwTEZ22OFF+9VS0lxDEXIqsZT713K54FCEIdJ6KDwDozYCl87Shx
         UdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X6IZ0kdG9aeVwwBEHw4YFMvSu0VQ1Omdeh0RqqU4m+M=;
        b=efO0et9oulBL24vdfAhpvHRsPCih1AyusQcKXGYY7L6pELNrTuEm62A+B10DxeT1IA
         4aMziTrtfNQybMAfueZEGVnvrMIKPc7WXsRYt1PtIpwyqCAAYH/Vz43iWhOpHPo/MBmY
         iQTptsk0FlAa+Z8+DhyLXWw1OOuBsMHQcPImuFBx/KVUqK4C1LZW/XYe0/25d0+GIgQM
         6/qzvmA7dnkt1ZBKtw8WxvhKJTye6p3M4DH0RiZ0zRKWZeA2k6M57qMxG2tx8APfq/6i
         PupuHalX2jYo/bPuxlbDMG+2QLNWVhhfQYI3u9ukh68vdnXJ7T8iO7qu37e5sl8ea3j+
         m0zg==
X-Gm-Message-State: APjAAAVD0p/COpX8UMBkCEvjSHKTx2LsgTylNsOXqoA9YiyFLWhRvk0Z
        rfSdrpowHWsSmv4KGQPZod7gPnKz
X-Google-Smtp-Source: APXvYqxL6SkEBwzv2tvC8ZNITZUPGsxMq+BWJwMyrTmbbymmjJD99AiN4xQ39n6o8c6AwLWJhu5adQ==
X-Received: by 2002:a17:906:518:: with SMTP id j24mr17503865eja.26.1553100638648;
        Wed, 20 Mar 2019 09:50:38 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f5sm808254ede.94.2019.03.20.09.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:50:38 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM SYSTEMPORT
        ETHERNET DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/3] net: systemport:  Remove print of base address
Date:   Wed, 20 Mar 2019 09:45:17 -0700
Message-Id: <20190320164517.29608-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190320164517.29608-1-f.fainelli@gmail.com>
References: <20190320164517.29608-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
pointers are being hashed when printed. Displaying the virtual memory at
bootup time is not helpful, especially given we use a dev_info() which
already displays the platform device's address.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index bc3ac369cbe3..c86515f7fd2f 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2599,11 +2599,11 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 
 	priv->rev = topctrl_readl(priv, REV_CNTL) & REV_MASK;
 	dev_info(&pdev->dev,
-		 "Broadcom SYSTEMPORT%s" REV_FMT
-		 " at 0x%p (irqs: %d, %d, TXQs: %d, RXQs: %d)\n",
+		 "Broadcom SYSTEMPORT%s " REV_FMT
+		 " (irqs: %d, %d, TXQs: %d, RXQs: %d)\n",
 		 priv->is_lite ? " Lite" : "",
 		 (priv->rev >> 8) & 0xff, priv->rev & 0xff,
-		 priv->base, priv->irq0, priv->irq1, txq, rxq);
+		 priv->irq0, priv->irq1, txq, rxq);
 
 	return 0;
 
-- 
2.17.1

