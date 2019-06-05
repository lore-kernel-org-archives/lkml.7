Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE5AC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D0C20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeKKL4uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfFENUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:20:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40595 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfFENUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:20:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so7890715ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 06:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mszTEyuZf7y7lIdYQewtMvW8UUIaYv1rPkX1Aw39++8=;
        b=GeKKL4uFsj2/YpNSdGplVaT5cKsjpFQjUhD224JDjupcB6mr9U156zGjxPD4bGUmXl
         xB/PoUc1l920zPS+AnJJUOr9ASZFlrKJHyoVjNuSmdT8879k0qfJ9qMZZ+CxTKOYYbT2
         DnBUQOhmdPXG6+ez1tunwdiZq5pICCDQjgjAeY2LzFhMwHW0ju/L4HO+RevJrWXifqBT
         Ox86+S/xgtHpy1qZNnStIiHq6Qm62g9w1K+rkaHKFRD/YXdbTQ1HpPL8lrj6ndFR3YVL
         dKcg7pP5myPZNZJlqjzpJQMtIGf/p0I/ZTCU0XPBvt2oIGCUCqu0hAR/kU1GDuzk7Rla
         1sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mszTEyuZf7y7lIdYQewtMvW8UUIaYv1rPkX1Aw39++8=;
        b=gnjH4g9ewO+hh2LQJeKsrTreTM99HieTBT67/p3ryDKEprzs2ptbseV3qDHiYzBrvP
         64cBFHHmNk1rXYcxu+P2EAIe6jPNzH8KZY+53PYdg2NoN+7pa3VsNeYruG1+rmjc63IJ
         +Zi5J+Ug4cyTVBG4VB7B393yU18kd/5o80z+NiHrD+FX8gdkSGifC9kMPEO2r6aQuLXs
         Dv1HHyJh3sJBKAYok1Iyw40IFSs1RPfAIyfBI6B1CstnJ7T12OaZfR9Z1Pgi5hKY7uTN
         +pNII34wpUg/DchW+buzPrtW3wEbHwpb8mBXLyOoxuhUrI2FHtTgPlHQwgAyjzSb5HCM
         Jqew==
X-Gm-Message-State: APjAAAWOn5fsBEvaPN/4tdIgtDYXZH+7N6E58cxGCUDMpK7X8NTEjwUc
        r660LbVFaphkJx3CzXLlVnxAvw==
X-Google-Smtp-Source: APXvYqx0Ver0O4/Equ6GVOE17NZ7KHBeKaZpaYrLCmxVRIpqH65BbJZz1P/KtdUw+kmPhT8rBHcJvQ==
X-Received: by 2002:a2e:7216:: with SMTP id n22mr6617872ljc.42.1559740818396;
        Wed, 05 Jun 2019 06:20:18 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id t3sm1893259lfk.59.2019.06.05.06.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:20:17 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 net-next 4/7] net: ethernet: ti: cpsw_ethtool: simplify slave loops
Date:   Wed,  5 Jun 2019 16:20:06 +0300
Message-Id: <20190605132009.10734-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605132009.10734-1-ivan.khoronzhuk@linaro.org>
References: <20190605132009.10734-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only for consistency reasons, do it like in main cpsw.c module
and use ndev reference but not by means of slave.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw_ethtool.c | 40 ++++++++++++++------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
index a4a7ec0d2531..3d5ae3fa5a8f 100644
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -458,7 +458,6 @@ int cpsw_nway_reset(struct net_device *ndev)
 static void cpsw_suspend_data_pass(struct net_device *ndev)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-	struct cpsw_slave *slave;
 	int i;
 
 	/* Disable NAPI scheduling */
@@ -467,12 +466,13 @@ static void cpsw_suspend_data_pass(struct net_device *ndev)
 	/* Stop all transmit queues for every network device.
 	 * Disable re-using rx descriptors with dormant_on.
 	 */
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++) {
-		if (!(slave->ndev && netif_running(slave->ndev)))
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		ndev = cpsw->slaves[i].ndev;
+		if (!(ndev && netif_running(ndev)))
 			continue;
 
-		netif_tx_stop_all_queues(slave->ndev);
-		netif_dormant_on(slave->ndev);
+		netif_tx_stop_all_queues(ndev);
+		netif_dormant_on(ndev);
 	}
 
 	/* Handle rest of tx packets and stop cpdma channels */
@@ -483,13 +483,14 @@ static int cpsw_resume_data_pass(struct net_device *ndev)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
 	struct cpsw_common *cpsw = priv->cpsw;
-	struct cpsw_slave *slave;
 	int i, ret;
 
 	/* Allow rx packets handling */
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++)
-		if (slave->ndev && netif_running(slave->ndev))
-			netif_dormant_off(slave->ndev);
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		ndev = cpsw->slaves[i].ndev;
+		if (ndev && netif_running(ndev))
+			netif_dormant_off(ndev);
+	}
 
 	/* After this receive is started */
 	if (cpsw->usage_count) {
@@ -502,9 +503,11 @@ static int cpsw_resume_data_pass(struct net_device *ndev)
 	}
 
 	/* Resume transmit for every affected interface */
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++)
-		if (slave->ndev && netif_running(slave->ndev))
-			netif_tx_start_all_queues(slave->ndev);
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		ndev = cpsw->slaves[i].ndev;
+		if (ndev && netif_running(ndev))
+			netif_tx_start_all_queues(ndev);
+	}
 
 	return 0;
 }
@@ -587,7 +590,7 @@ int cpsw_set_channels_common(struct net_device *ndev,
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
 	struct cpsw_common *cpsw = priv->cpsw;
-	struct cpsw_slave *slave;
+	struct net_device *sl_ndev;
 	int i, ret;
 
 	ret = cpsw_check_ch_settings(cpsw, chs);
@@ -604,20 +607,19 @@ int cpsw_set_channels_common(struct net_device *ndev,
 	if (ret)
 		goto err;
 
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++) {
-		if (!(slave->ndev && netif_running(slave->ndev)))
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		sl_ndev = cpsw->slaves[i].ndev;
+		if (!(sl_ndev && netif_running(sl_ndev)))
 			continue;
 
 		/* Inform stack about new count of queues */
-		ret = netif_set_real_num_tx_queues(slave->ndev,
-						   cpsw->tx_ch_num);
+		ret = netif_set_real_num_tx_queues(sl_ndev, cpsw->tx_ch_num);
 		if (ret) {
 			dev_err(priv->dev, "cannot set real number of tx queues\n");
 			goto err;
 		}
 
-		ret = netif_set_real_num_rx_queues(slave->ndev,
-						   cpsw->rx_ch_num);
+		ret = netif_set_real_num_rx_queues(sl_ndev, cpsw->rx_ch_num);
 		if (ret) {
 			dev_err(priv->dev, "cannot set real number of rx queues\n");
 			goto err;
-- 
2.17.1

