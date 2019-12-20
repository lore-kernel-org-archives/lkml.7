Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3182DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0196524684
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ASNoFJRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLTMY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:24:57 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:48360 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfLTMY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q7Pl04+25XaAjE2x9uF6zsDQzpaHxRr7Osf7kSzlnZI=; b=ASNoFJRQG7/VkrK8hr04zadi7
        ZsALiXvrb3/UXcAzLbpnfRguYxa/13dnhb3ukoG07kjczAdxcoI7lhdLJhFOpiXrSsf3oF1GsFPaa
        4Coxq5bTIA6PM+ryOCA2GE16OXyhDGZQGnLimOxrmyqSs4c13JjjDqVTE666nYp/5mIEA=;
Received: from [2a02:790:ff:1019:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iiHKq-0001zU-UV; Fri, 20 Dec 2019 13:24:49 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iiHKo-0008Tl-K8; Fri, 20 Dec 2019 13:24:46 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v5 4/5] mfd: rn5t618: add more subdevices
Date:   Fri, 20 Dec 2019 13:24:15 +0100
Message-Id: <20191220122416.31881-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191220122416.31881-1-andreas@kemnade.info>
References: <20191220122416.31881-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RC5T619 has a RTC which is missing in the
RN5T618. Add it as subdevice to prepare for their implementation

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v3:
- alignment cleanup
 drivers/mfd/rn5t618.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 6bdc5a023cbf..ec378715137b 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -14,6 +14,7 @@
 #include <linux/mfd/rn5t618.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 
@@ -22,6 +23,12 @@ static const struct mfd_cell rn5t618_cells[] = {
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
@@ -173,8 +180,16 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
-				   ARRAY_SIZE(rn5t618_cells), NULL, 0, NULL);
+	if (priv->variant == RC5T619)
+		ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
+					   rc5t619_cells,
+					   ARRAY_SIZE(rc5t619_cells),
+					   NULL, 0, NULL);
+	else
+		ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
+					   rn5t618_cells,
+					   ARRAY_SIZE(rn5t618_cells),
+					   NULL, 0, NULL);
 	if (ret) {
 		dev_err(&i2c->dev, "failed to add sub-devices: %d\n", ret);
 		return ret;
-- 
2.11.0

