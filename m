Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981D0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E37207FA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="JSbL/zNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfK2VVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:21:35 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:52258 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbfK2VVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xIt2KAWv08Ks4SoHFbcybKRUuKLcopyb30N+8C+J2a4=; b=JSbL/zNkilynp04KxFvYFosgHc
        JU68tl8T4t2OKetgqFkRnQnI4Ev+HUW7Xui5lMVQRHAghP1ITLot1S4MlHfVSWSKgxQlsKnWBrDUj
        UOU0QDKP3g/BDhUrR3SZ8zTQUtamp2Ret2AjYFY+sMJjj6kb2vzGb6N7YM97xi3+sBqE=;
Received: from p200300ccff0871001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:7100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ianhe-0001yw-Ag; Fri, 29 Nov 2019 22:21:26 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1ianhe-0004mf-1q; Fri, 29 Nov 2019 22:21:26 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 5/6] mfd: rn5t618: add more subdevices
Date:   Fri, 29 Nov 2019 22:20:44 +0100
Message-Id: <20191129212045.18325-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129212045.18325-1-andreas@kemnade.info>
References: <20191129212045.18325-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rc5t619 has a rtc which is missing in the
rn5t618. Add it as subdevice to prepare for their implementation

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v3:
- alignment cleanup
 drivers/mfd/rn5t618-core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rn5t618-core.c b/drivers/mfd/rn5t618-core.c
index fe56c5a50563..d3f137796cab 100644
--- a/drivers/mfd/rn5t618-core.c
+++ b/drivers/mfd/rn5t618-core.c
@@ -21,6 +21,12 @@ static const struct mfd_cell rn5t618_cells[] = {
 	{ .name = "rn5t618-wdt" },
 };
 
+static const struct mfd_cell rc5t619_cells[] = {
+	{ .name = "rn5t618-regulator" },
+	{ .name = "rc5t619-rtc" },
+	{ .name = "rn5t618-wdt" },
+};
+
 static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -117,8 +123,14 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
-				   ARRAY_SIZE(rn5t618_cells), NULL, 0, NULL);
+	if (priv->variant == RC5T619)
+		ret = devm_mfd_add_devices(&i2c->dev, -1, rc5t619_cells,
+					   ARRAY_SIZE(rc5t619_cells),
+					   NULL, 0, NULL);
+	else
+		ret = devm_mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
+					   ARRAY_SIZE(rn5t618_cells),
+					   NULL, 0, NULL);
 	if (ret) {
 		dev_err(&i2c->dev, "failed to add sub-devices: %d\n", ret);
 		return ret;
-- 
2.20.1

