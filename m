Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0527BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22EA214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gNJtd1kI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLKVyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:54:44 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:36696 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfLKVye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kGD/toduG8NeGpobD+AS75VlJRn2io/48ZXs9RF9Hlc=; b=gNJtd1kIGwtSRJQsHaWd47kah
        KsWoRdX1NFmxwnKEM5U/7JsiyroEwpcfcNHjtGRvlb+GzKISeQeKoUZGB8VZ8YkoNYGrjcqehUgt2
        Ae2/mOk6SL6yzpjjI2QgBpldjM+3bN/c402vMsblDVY/GhDKxtGk4O3ey9Vf9yk9NQYVU=;
Received: from p5dcc331a.dip0.t-ipconnect.de ([93.204.51.26] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1if9wB-0002Ee-5L; Wed, 11 Dec 2019 22:54:28 +0100
Received: from andi by eeepc with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1if9wA-00005i-6N; Wed, 11 Dec 2019 22:54:26 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 4/5] mfd: rn5t618: add more subdevices
Date:   Wed, 11 Dec 2019 22:54:08 +0100
Message-Id: <20191211215409.32764-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191211215409.32764-1-andreas@kemnade.info>
References: <20191211215409.32764-1-andreas@kemnade.info>
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
 drivers/mfd/rn5t618.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index d78eb29b94a4..18d56a732b20 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -22,6 +22,12 @@ static const struct mfd_cell rn5t618_cells[] = {
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
@@ -173,8 +179,14 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
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
2.11.0

