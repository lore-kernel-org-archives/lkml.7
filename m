Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E48C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C87825F5C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxvvJPDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfE3SU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:20:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37146 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfE3SUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:20:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id h19so7014608ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ksgNqXYuq7eYRSzBEvTxTsDgmGrsQMBHFwlmQvvNPkE=;
        b=GxvvJPDKMnF2Hc4YuIT4oM82YGKw8EcaMBLqKbLD6yc2xy1Jwtfbwfeyw6rJBMcxpP
         /8u5FHFV1Sy3qbcFK5Wmocu4voUWgTi5jFxXDOxc+ngyfsy4lqfvlE7oHUr+L6qZH+eX
         ueuXJk6RvJCOHnaTzXvc+TlemnLRktzO0mQfYVU9yC3NpOn2npdhCibuxqDZHEu55r80
         3ZvBQY3uUcxW/C9LniDNuWN/a3zoHFJ2gJI3hYCe/2Td//7W/9ecVrlJaVueUFNuH3iF
         nCFCRSOlgR596k+Vvo6qoZ/d/mlLBZ1dEtqBninfkrngveooWNd17Db8p+jox/7w0ASv
         o/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ksgNqXYuq7eYRSzBEvTxTsDgmGrsQMBHFwlmQvvNPkE=;
        b=kmGB2EHT3toJ28yH793Iq2JZCHpL82yNdt7QI3r6pR0OnTIrmtH5OTkcsi8jT/umyn
         clwbwD7/m+bFTeO47YQQRHuuvADqw2hbF2478AiZ1fo5SdxH1Hsu6heeQ4jKczel5DCq
         Rrh59tND4fSCsF02p38S8HpM03yHjBKKmQY9uufMI8ZYVRzQ+MjavvwHwb/Yf+FHaqzb
         u/PYdWTe19+TlroZCO1YxgL8uOE85LnGcuzSMAZ3wE+RF70KbhLGWCw7cuyIZq8OF+n3
         M/Hs5mofL97wzfXedUKLAQDIwchWRCDTEuK33cZZpT3ctaoUOGiSgJpK2dxdSeHka4BB
         9fwA==
X-Gm-Message-State: APjAAAUomEYhOoUbT8/z6jRKIXkoDglyopx8216cl4U9DQcSqueSjZgK
        Uf//pwGjuvJt9tKi1OOKSLLZng==
X-Google-Smtp-Source: APXvYqy7hb7ALHTHh96K5zrKV05mrOIrhkcfG5OPW6qXfaO6Jy/BSI/AMhpabp61GGx5Y2leoIFiTA==
X-Received: by 2002:a2e:88c7:: with SMTP id a7mr2713139ljk.118.1559240453797;
        Thu, 30 May 2019 11:20:53 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id v7sm388946lfe.11.2019.05.30.11.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:20:53 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next 3/7] net: ethernet: ti: cpsw: use cpsw as drv data
Date:   Thu, 30 May 2019 21:20:35 +0300
Message-Id: <20190530182039.4945-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
References: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to set ndev for drvdata when mainly cpsw reference is needed,
so correct this legacy decision.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 6d3f1f3f90cb..3430503e1053 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2265,8 +2265,7 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 
 static void cpsw_remove_dt(struct platform_device *pdev)
 {
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+	struct cpsw_common *cpsw = platform_get_drvdata(pdev);
 	struct cpsw_platform_data *data = &cpsw->data;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *slave_node;
@@ -2477,7 +2476,7 @@ static int cpsw_probe(struct platform_device *pdev)
 		goto clean_cpts;
 	}
 
-	platform_set_drvdata(pdev, ndev);
+	platform_set_drvdata(pdev, cpsw);
 	priv = netdev_priv(ndev);
 	priv->cpsw = cpsw;
 	priv->ndev = ndev;
@@ -2570,9 +2569,8 @@ static int cpsw_probe(struct platform_device *pdev)
 
 static int cpsw_remove(struct platform_device *pdev)
 {
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-	int ret;
+	struct cpsw_common *cpsw = platform_get_drvdata(pdev);
+	int i, ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
@@ -2580,9 +2578,9 @@ static int cpsw_remove(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (cpsw->data.dual_emac)
-		unregister_netdev(cpsw->slaves[1].ndev);
-	unregister_netdev(ndev);
+	for (i = 0; i < cpsw->data.slaves; i++)
+		if (cpsw->slaves[i].ndev)
+			unregister_netdev(cpsw->slaves[i].ndev);
 
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);
-- 
2.17.1

