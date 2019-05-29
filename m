Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC20C07542
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC56208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QyM70De9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE2HiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:38:24 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:60186 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfE2HiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:38:23 -0400
X-Greylist: delayed 919 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 03:38:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=BX/qclNsTllMYtxUyN
        znnvi5uS276rsIV4MQsuNVavs=; b=QyM70De9F0iMSyvqNNouTCOiJTuwr4OeBO
        tRvrY6YIgMJK2lLrr1Kv1dqX+NKVLeOJCn3iKHH0bYZxNg2Dii5xxVEYcc9/rHyh
        hbe++uFPovLA1MzgC+EIa35iVdvnpSNHi56FKlgYr4CACknYBEGWQ9rGOv/VEpxL
        SKXKI3Aog=
Received: from localhost.localdomain (unknown [218.106.182.173])
        by smtp16 (Coremail) with SMTP id GtxpCgBXE7M_M+5cnbSYAA--.352S3;
        Wed, 29 May 2019 15:22:44 +0800 (CST)
From:   Xidong Wang <wangxidong_97@163.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Xidong Wang <wangxidong_97@163.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] rtc: rv3028: check return value
Date:   Wed, 29 May 2019 15:22:20 +0800
Message-Id: <1559114540-30878-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: GtxpCgBXE7M_M+5cnbSYAA--.352S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWUAFyUuF48ZF4DWrW7urg_yoW3GFX_Ka
        4ayryfJa4DGF1YgwnrZr95ZryUKF40qryIvr1xKa93Aw47JFn2vas7uFZrJw1DWry8Z3yY
        grnruryxurnxJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRZqXtUUUUU==
X-Originating-IP: [218.106.182.173]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/xtbBFQTD81XlgQH9kgAAs+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rv3028_probe(), the return value of devm_regmap_init_i2c() should
be checked before it is used.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/rtc/rtc-rv3028.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index 06884eb..29a8c4e 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -626,6 +626,10 @@ static int rv3028_probe(struct i2c_client *client)
 
 	rv3028->regmap = devm_regmap_init_i2c(client, &regmap_config);
 
+	if (IS_ERR(rv3028->regmap)) {
+		return PTR_ERR(rv3028->regmap);
+	}
+
 	i2c_set_clientdata(client, rv3028);
 
 	ret = regmap_read(rv3028->regmap, RV3028_STATUS, &status);
-- 
2.7.4

