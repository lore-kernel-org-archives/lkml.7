Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B8C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E46A2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAALm67O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGXL0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:26:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35911 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGXL0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:26:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so20810938pfl.3;
        Wed, 24 Jul 2019 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7rxIecE1+hcOWYBkK6fDvRfNcPOFXL9RSiYVbCBgkeA=;
        b=qAALm67O+kCcLf4/HPKiSZjGsgoR/l31ZwmhZH5IPGarRAPjGvWxCFUnmZMisIPHAk
         cdRMwKkjX4KEIRrkaZKbrQOI58SaMZSkudT4VzMyjQ30XEC6P5zyWCBAu6UEQT82BK58
         h6uJ/N6uGdMizz6GBZsU6Zn+dWO1BEbqMvz1CeSQG9y6WNnqjJQlE5oVfqIoGerduGFb
         H7CjhAfoPfd2rPTmgZc6quRB3+mlezxmi1YcerJ+C1YbHtr3nHpdwBdggHLtOYO+Trgj
         VAW2i7UpuI9Po8BjacnJrL4pctGgt/9wv9bquzTlju9++nX0vBf15JCpp5L2ErMN5Up0
         VB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7rxIecE1+hcOWYBkK6fDvRfNcPOFXL9RSiYVbCBgkeA=;
        b=TSCT314SR3SAXum+mLICOJg2nvdfKui+QqaSvXQyOzqjQbCwJXOrJXVQqE8g775wTD
         1C+K/oigzyMJX+Nmug4/CzV0++Vu+xWZ8VunUeKpqW2R3+KLIElgr9Q45jtHIvwBHZVx
         4DYZtui07MGbGYUtAuvkmxUdxlhK4veBHxV2DREnVH6tcoCyNHdhMA+F+gZskDli5kYw
         ZDNdfdbtZmD1aZuw1FTMqVw9FJQzpvFTKCAPqpXsy8POOTUxcTn+Pj6mk2EUu+i119G3
         TwBZ4W13kAJxnrQlVv7GoOc4nwDfj/cES4QDxWzZrPjg8dCglS86MfxBkhZZoe3d5G/H
         V+nA==
X-Gm-Message-State: APjAAAU0sHO1d5MRcNYtbOQ48n6ZlbEhoTaV5axNzoDou6shUmAhYwqQ
        OH+PEcrc2ciEcZha0DAGUVHa64Edwjs=
X-Google-Smtp-Source: APXvYqxjPiqiuZQF5UMjeiHZXgvvuxIqssYurYIYT/8eert/NOH2faoWr0/syhTWNsSpPif3D8T0Iw==
X-Received: by 2002:a63:d555:: with SMTP id v21mr58678772pgi.179.1563967612956;
        Wed, 24 Jul 2019 04:26:52 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id 4sm55761778pfc.92.2019.07.24.04.26.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 04:26:52 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH net-next 02/10] forcedeth: Use dev_get_drvdata where possible
Date:   Wed, 24 Jul 2019 19:26:48 +0800
Message-Id: <20190724112648.13186-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/ethernet/nvidia/forcedeth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index b327b29f5d57..ecca794c55e2 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -6126,8 +6126,7 @@ static void nv_remove(struct pci_dev *pci_dev)
 #ifdef CONFIG_PM_SLEEP
 static int nv_suspend(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
+	struct net_device *dev = dev_get_drvdata(device);
 	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base = get_hwbase(dev);
 	int i;
-- 
2.20.1

