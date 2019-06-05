Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B74C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DEB20883
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ie/iVmmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfFENUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:20:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45368 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfFENUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:20:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so12023423lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 06:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CE8Iq8ZjUtNENgYj+FlGTMxcTQ2fFaeeS723D5LJTaU=;
        b=Ie/iVmmmXC6K55Uaa53Di3vSnNQfwFe1FvKFIdOAI2En/YaClJm3K8u2Hw01cBFi/b
         RytUn8xjSlb/3NQuDuoxQom0+Udw7r6FvZd18bSt7iyupgyOrRmKC+OMKowrKmAGRB63
         uBq2urzv3cyOApD2MKU65Q1u0P8ojAkvxcHiVqF/hBHGcihIQS4HMpqgWyZSZqd0nOo5
         8kESN0+fpHn6UddiWD8pg+cXV42hX8sHqS3r43SktDUC27osbBWxOGhPGHrNTC6FexB1
         pTr+tpVaOvaF68MfWcPNdljRzLk3X3EQymwMI5uA6DpySSsr+jKQRPsgpStETVz2sPXM
         w7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CE8Iq8ZjUtNENgYj+FlGTMxcTQ2fFaeeS723D5LJTaU=;
        b=F9Kc1hvNjAkt7rE1zBe7I3bmsJK/ld1BEjrTfKO1hmWOWzk7CRCMps/kClN1AFRJfd
         sviSwAxHQ50yXOAROh9E2cF6pLq7T5cX6yYPNO8jngVtCKbNVuhfahPPOWQH+5qtNYqt
         hXsQn1rHTYTs4FXFRdvVm3WD3li6oU7mG4jH/H0lRI1e3j1lqk8d988nvlHt0TwJrcKF
         YEbf4NuYnEnp3o7tLbu6UY39Xxmh9jHs2VqJz2pITxI3OITebEJy7BPISSrQ1GSqUeV6
         7ber9PYQ83Z8NmKqJnzDFWVg3NoTEExj/yy0852gwW5sCrqJJiGV6+CYR035iuDoYnS4
         8R+A==
X-Gm-Message-State: APjAAAVfwgofA6TqFHorD7/ou3B7tIlT02PTQydm7UbVKX0XtvRg/UQA
        HMAlCsU8yZYnuOHZudrn1Jhuow==
X-Google-Smtp-Source: APXvYqwAg/kj6/eR/82+VKecddOJZ5/OhEi893jm44m9NIXKkIXEJmyM0m/IMzZ9j+Pv/4znmdaVOw==
X-Received: by 2002:a19:7110:: with SMTP id m16mr20414541lfc.4.1559740817213;
        Wed, 05 Jun 2019 06:20:17 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id t3sm1893259lfk.59.2019.06.05.06.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:20:16 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 net-next 3/7] net: ethernet: ti: cpsw: use cpsw as drv data
Date:   Wed,  5 Jun 2019 16:20:05 +0300
Message-Id: <20190605132009.10734-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605132009.10734-1-ivan.khoronzhuk@linaro.org>
References: <20190605132009.10734-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to set ndev for drvdata when mainly cpsw reference is needed,
so correct this legacy decision.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
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

