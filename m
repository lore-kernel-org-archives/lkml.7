Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FCBCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEF7222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwVGwpyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442005AbfJRFYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:24:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39793 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395042AbfJRFYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:24:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so3112736pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDq5W42aFu1uYq0Wf8hvxLigwHa6+BiXckCc47UbuNo=;
        b=pwVGwpyvQv+pshWx85LTbypti0ekQXXbxw/w/zZDphsXBvkSuLrySfri6X+lvRjV7h
         nClLK/yOUe7XNSihPqlLnE94DyXPhNlUmpufyT5aTtKMpbsDctNH9upkqD0akX9BaghO
         nva/hRKa/F2qh8c5AHFeNg/SJYT7fStW+H0c7oEZlONcl3bPHhCVVqMS1/MB+OCE2EqJ
         2SdnSUZcub8AxIvp1baJmgKYKpaJPEjWFFf6oe8QcG/FIzl/Wh/Lb4C0j+B+xYfGsvVJ
         gY95+KKx0ad0wMuuD/8V2Q8n1uw9BqYeYwehpOXYbWqVzpyGArmAmWC1Pp3tm0VhLdK3
         lCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDq5W42aFu1uYq0Wf8hvxLigwHa6+BiXckCc47UbuNo=;
        b=NvqrjdP/2+ufGWKYPc7YWET75qifrrbKMN9wQ7LV52CqVvQT9h+X66JEPa1WeJA6UG
         Qv+wOeqxY4OHUN2FdmMlN6P4ox1KNOl2cRipwBNQ4Jf5UfQubrYy3zrgme7jJf1V0+jS
         j1/y6N/AuSFrAwDXAyzsPrehTvBKG2v81+BkWsikcAux2Dkm9gXvB9gIqyTUQ4iqhl2d
         QOeBS9UKPjw+e1VAkmpY+qm40oSeUGCZuO0ySNY2CfKNBQlLfcHQgcuHqReNb8Jk8uxQ
         zPe0ohHGPrSqCO3Ob53c5TnkVsWnY2+VLp7Gi1xzd8f2EiN+xkp7VkKLCyAbbqHgch/q
         vUgg==
X-Gm-Message-State: APjAAAWl10GxJiMmFuVeyR+twa/1OY3TE4fLdSkKoV4pW9wuf2yZZ30v
        vSa/t0qSUTVM56Y72wKZm0EQYA==
X-Google-Smtp-Source: APXvYqyezGIQ7Ue9t3Jo96VVHFYoqaoyr2+zBXKnyVoWMT90aSE0pee2gnV+wwaa5VzK53ZQsh8lWQ==
X-Received: by 2002:a62:1a15:: with SMTP id a21mr4491058pfa.5.1571376249793;
        Thu, 17 Oct 2019 22:24:09 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u11sm2178760pgc.61.2019.10.17.22.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 22:24:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: hci_qca: Update regulator_set_load() usage
Date:   Thu, 17 Oct 2019 22:24:01 -0700
Message-Id: <20191018052405.3693555-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
References: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the introduction of '5451781dadf8 ("regulator: core: Only count
load for enabled consumers")' in v5.0, the requested load of a regulator
consumer is only accounted for when said consumer is voted enabled.

So there's no need to vote for load ever time the regulator is
enabled or disabled.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e3164c200eac..c07c529b0d81 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1393,13 +1393,6 @@ static int qca_enable_regulator(struct qca_vreg vregs,
 	if (ret)
 		return ret;
 
-	if (vregs.load_uA)
-		ret = regulator_set_load(regulator,
-					 vregs.load_uA);
-
-	if (ret)
-		return ret;
-
 	return regulator_enable(regulator);
 
 }
@@ -1409,8 +1402,6 @@ static void qca_disable_regulator(struct qca_vreg vregs,
 {
 	regulator_disable(regulator);
 	regulator_set_voltage(regulator, 0, vregs.max_uV);
-	if (vregs.load_uA)
-		regulator_set_load(regulator, 0);
 
 }
 
@@ -1462,18 +1453,30 @@ static int qca_power_setup(struct hci_uart *hu, bool on)
 static int qca_init_regulators(struct qca_power *qca,
 				const struct qca_vreg *vregs, size_t num_vregs)
 {
+	struct regulator_bulk_data *bulk;
+	int ret;
 	int i;
 
-	qca->vreg_bulk = devm_kcalloc(qca->dev, num_vregs,
-				      sizeof(struct regulator_bulk_data),
-				      GFP_KERNEL);
-	if (!qca->vreg_bulk)
+	bulk = devm_kcalloc(qca->dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
+	if (!bulk)
 		return -ENOMEM;
 
 	for (i = 0; i < num_vregs; i++)
-		qca->vreg_bulk[i].supply = vregs[i].name;
+		bulk[i].supply = vregs[i].name;
+
+	ret = devm_regulator_bulk_get(qca->dev, num_vregs, bulk);
+	if (ret < 0)
+		return ret;
 
-	return devm_regulator_bulk_get(qca->dev, num_vregs, qca->vreg_bulk);
+	for (i = 0; i < num_vregs; i++) {
+		ret = regulator_set_load(bulk[i].consumer, vregs[i].load_uA);
+		if (ret)
+			return ret;
+	}
+
+	qca->vreg_bulk = bulk;
+
+	return 0;
 }
 
 static int qca_serdev_probe(struct serdev_device *serdev)
-- 
2.23.0

