Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A6DC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E7E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mF/ELEtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436632AbfFKVtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:49:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46700 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405081AbfFKVtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:49:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so7754969lfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i6GhLaflHxtAwL6Ad6Dr/C5ELNhP+vqOwXCPihJeLM8=;
        b=mF/ELEtx8NPOPG3GZNMj3xXssQs8CPSw6r9xXfmVWR6vI50hpVCFF8E++nxCQxBQty
         w1mqcgctM/qAYXwueTcmLS9XTrg9obZ0X9Z327VRyQK40aEuuqUysUhpRYW8PawxNHNy
         fzt9hcqJPCgMwkqup/JcNPCQt5Kq9clL6C7j6HhdRs+oH8OV2VgTQBC5eTjbGd/WN/tq
         vjw2gTYLwvqmwZDH6qYhRzUcNvSHLV7aRINd+jsgUmp2DSI0V6XgOwjNKJ+rdsrTc/jQ
         kLHDaBT3/z1E41YMfT7XPfdK57pKtlKK/9UsVkmWZgW0DRN9UIY4dQf5zKQv93moT2ZT
         vAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i6GhLaflHxtAwL6Ad6Dr/C5ELNhP+vqOwXCPihJeLM8=;
        b=jOuf3z8FuEJLf69aNZgqGJAVmV46G92ET2PEPXZFaj0KoS/w75tcnH5Fz/PsfX17xF
         wG9jtsRMce1qfaxbQ2rkQJMMhNJHvRyMPjT9365sAMSirQ+ILGJ4ksdwm7M/lQqpvGp/
         T9V7kt1PzAvRT9I6NCQZc/2Y6VQ+4OqZ7iaY81qt0Qb2BwixED/LTMz0dRDX48OqLo4j
         anvFQSUL2GjUG42ZAZamsiKHjmAdWOXsymLvPhBb6nVl9QZI9BtEKiaKoc2T2boOh4o9
         sJ/Be2DYRDPgvHEQ1m+IMYnrJLrpGlj8ILcqVa622Pat7kZ/leEL/xZEYPUjxBb8OgBX
         1m1g==
X-Gm-Message-State: APjAAAW2K00LqHlPQhsKu/z6vd1DyuyO1e4HtPNO36mIEUKCHq/R+ds+
        CTgfI/eG8IHCj6Md801dP89U5g==
X-Google-Smtp-Source: APXvYqw+qg4jwlO0JzvRQuQMV9ByejZJE+uZatTs0aps96wZ6LLBeiY1URuP4dn41RtClXDZDIa/dw==
X-Received: by 2002:ac2:514b:: with SMTP id q11mr5226108lfd.33.1560289748726;
        Tue, 11 Jun 2019 14:49:08 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id e26sm2787342ljl.33.2019.06.11.14.49.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:49:08 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: use cpsw as drv data
Date:   Wed, 12 Jun 2019 00:49:03 +0300
Message-Id: <20190611214903.32146-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to set ndev for drvdata when mainly cpsw reference is needed,
so correct this legacy decision.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

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

