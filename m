Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192D0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA872087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308565;
	bh=M/vwVB6QzwvIHH0Vg/5xg7oIMCtftMVor+9Icqm10u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R1Z0EOkfTrJJrRfIErf5D7eygcnP0c/rdH1Y5kHe/qIZLMBWHYFL0R/16KQFQo07F
	 xYkfd5c52rWaL34a9WfzScm0CmQHaSQq4hJZYcslNGLOjiRQZhlLYFWa2rvXm+d4j7
	 WoWYKx+q9Bwsa2H6IANqbh9K0EkjEv2BEyOqm13E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfHTNmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730682AbfHTNmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:42:42 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F9622DBF;
        Tue, 20 Aug 2019 13:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308561;
        bh=M/vwVB6QzwvIHH0Vg/5xg7oIMCtftMVor+9Icqm10u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKQmLuRBxq4z+p9G2FfqYbHchS1b4JACcAnFMSRVcu7b+VFk2GX3CYt7OJk3Dzk1m
         nmL/VJoXzu+3U6EhjiuE4W4Ds4ItygtK0S+HGBnWMel9ERkVFYXVgDkskWrGt6268i
         uPeSerHZv1beYCdPDHIIM1MlFVbZ/Nu6Q1o3j+6o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/27] i2c: rcar: avoid race when unregistering slave client
Date:   Tue, 20 Aug 2019 09:42:08 -0400
Message-Id: <20190820134213.11279-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134213.11279-1-sashal@kernel.org>
References: <20190820134213.11279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 7b814d852af6944657c2961039f404c4490771c0 ]

After we disabled interrupts, there might still be an active one
running. Sync before clearing the pointer to the slave device.

Fixes: de20d1857dd6 ("i2c: rcar: add slave support")
Reported-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 254e6219e5389..2c29f901d3090 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -139,6 +139,7 @@ struct rcar_i2c_priv {
 	enum dma_data_direction dma_direction;
 
 	struct reset_control *rstc;
+	int irq;
 };
 
 #define rcar_i2c_priv_to_dev(p)		((p)->adap.dev.parent)
@@ -859,9 +860,11 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 	WARN_ON(!priv->slave);
 
+	/* disable irqs and ensure none is running before clearing ptr */
 	rcar_i2c_write(priv, ICSIER, 0);
 	rcar_i2c_write(priv, ICSCR, 0);
 
+	synchronize_irq(priv->irq);
 	priv->slave = NULL;
 
 	pm_runtime_put(rcar_i2c_priv_to_dev(priv));
@@ -916,7 +919,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct device *dev = &pdev->dev;
 	struct i2c_timings i2c_t;
-	int irq, ret;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(struct rcar_i2c_priv), GFP_KERNEL);
 	if (!priv)
@@ -979,10 +982,10 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		pm_runtime_put(dev);
 
 
-	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(dev, irq, rcar_i2c_irq, 0, dev_name(dev), priv);
+	priv->irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(dev, priv->irq, rcar_i2c_irq, 0, dev_name(dev), priv);
 	if (ret < 0) {
-		dev_err(dev, "cannot get irq %d\n", irq);
+		dev_err(dev, "cannot get irq %d\n", priv->irq);
 		goto out_pm_disable;
 	}
 
-- 
2.20.1

