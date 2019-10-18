Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3C5CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD02222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUpMW9IO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504026AbfJRFYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:24:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34671 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442014AbfJRFYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:24:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id k7so2290015pll.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvdpNgVZVW1ID8m+eY6Fjz43lKaX01Op/76I7ccP//M=;
        b=nUpMW9IOCBO3b7o+mUbj+BZ/SJeboSTEvqdXBozkFKDFOiB6KkrRWZGxA+dXTVLvnc
         NbZ+eEP57xv1HtIhnVhA+gr7WYS3+2M2XwG7OQ55FkY5WCFeNKCoDJxDzm3HFrXL9x7X
         0LCoL+jG3ra1twhebvIy4bOiBLVhvfDuS7ImW1cMdF53D5ou5RBBAqxI3QyLx2OaYkyH
         31ODpZTkZdbK8X92s2MC2r62YjEeoycIwMpdt0pbniQ/OHHx2+95DFy+DpugK8oKRmXm
         mwOO5WDUkdtBOc4qctdK9eDW0n6QxbnbANPl+cGYr0NjzX56aJXnW6ixP+iBRmP/EeGL
         27Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvdpNgVZVW1ID8m+eY6Fjz43lKaX01Op/76I7ccP//M=;
        b=d5BCcXvSYO2O4Q+LVcy1YSgpQ/+yjaXQWumA4p+yFgAmaVrmvuCTdySsQ53Tt0yGpi
         MCAtvzuCE/uckyqgj9GB4kq1dOQ9Fnj0HlDM9robrdPZ+TDFqgfxRPq/8lngP99jH9Xq
         VSf7AVy1+yr0evOMlemrOZuqo5Ff91Sghv/gO/T82grCf6NTIKn9Xue8w3H+pEBSaP69
         FigtIXa/+AaoK/tbW+Azdddddf8mg2BWOfbHe9B2IXMhapDZhcw5AhlJUdxblig50etY
         +RzEtj7tmIcm0XondsmBIaqiPqyAbW3FO6US5u2FFEKzbzeVIHWnrfISrJ5TFilf7tbz
         ZA+w==
X-Gm-Message-State: APjAAAWqBdQs/iwEpmP4JEapdh1pKC3e/UmY2mgRYIbmVrCCDdn/p3Af
        CI/jgAtWG/3eNXMDi1bRIgdkug==
X-Google-Smtp-Source: APXvYqwC1onVuDy1d+iHyUXB3LLxKvj824dBaXqO2hYPZD/2/qHNLyvqj3pyRlJuy5HWMKZ2OpfDvw==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr7661064plo.247.1571376252173;
        Thu, 17 Oct 2019 22:24:12 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u11sm2178760pgc.61.2019.10.17.22.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 22:24:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: hci_qca: Use regulator bulk enable/disable
Date:   Thu, 17 Oct 2019 22:24:03 -0700
Message-Id: <20191018052405.3693555-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
References: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the regulator_set_load() and regulator_set_voltage() out of the
enable/disable code paths the code can now use the standard
regulator bulk enable/disable API.

By cloning num_vregs into struct qca_power there's no need to lug around
a reference to the struct qca_vreg_data, which further simplifies
qca_power_setup().

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 55 +++++++++----------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 54aafcc69d06..01f941e9adf3 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -144,8 +144,8 @@ struct qca_vreg_data {
  */
 struct qca_power {
 	struct device *dev;
-	const struct qca_vreg_data *vreg_data;
 	struct regulator_bulk_data *vreg_bulk;
+	int num_vregs;
 	bool vregs_on;
 };
 
@@ -1381,63 +1381,34 @@ static int qca_power_off(struct hci_dev *hdev)
 	return 0;
 }
 
-static int qca_enable_regulator(struct qca_vreg vregs,
-				struct regulator *regulator)
-{
-	return regulator_enable(regulator);
-
-}
-
-static void qca_disable_regulator(struct qca_vreg vregs,
-				  struct regulator *regulator)
-{
-	regulator_disable(regulator);
-
-}
-
 static int qca_power_setup(struct hci_uart *hu, bool on)
 {
-	struct qca_vreg *vregs;
 	struct regulator_bulk_data *vreg_bulk;
 	struct qca_serdev *qcadev;
-	int i, num_vregs, ret = 0;
+	int num_vregs;
+	int ret = 0;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	if (!qcadev || !qcadev->bt_power || !qcadev->bt_power->vreg_data ||
-	    !qcadev->bt_power->vreg_bulk)
+	if (!qcadev || !qcadev->bt_power || !qcadev->bt_power->vreg_bulk)
 		return -EINVAL;
 
-	vregs = qcadev->bt_power->vreg_data->vregs;
 	vreg_bulk = qcadev->bt_power->vreg_bulk;
-	num_vregs = qcadev->bt_power->vreg_data->num_vregs;
-	BT_DBG("on: %d", on);
+	num_vregs = qcadev->bt_power->num_vregs;
+	BT_DBG("on: %d (%d regulators)", on, num_vregs);
 	if (on && !qcadev->bt_power->vregs_on) {
-		for (i = 0; i < num_vregs; i++) {
-			ret = qca_enable_regulator(vregs[i],
-						   vreg_bulk[i].consumer);
-			if (ret)
-				break;
-		}
+		ret = regulator_bulk_enable(num_vregs, vreg_bulk);
+		if (ret)
+			return ret;
 
-		if (ret) {
-			BT_ERR("failed to enable regulator:%s", vregs[i].name);
-			/* turn off regulators which are enabled */
-			for (i = i - 1; i >= 0; i--)
-				qca_disable_regulator(vregs[i],
-						      vreg_bulk[i].consumer);
-		} else {
-			qcadev->bt_power->vregs_on = true;
-		}
+		qcadev->bt_power->vregs_on = true;
 	} else if (!on && qcadev->bt_power->vregs_on) {
 		/* turn off regulator in reverse order */
-		i = qcadev->bt_power->vreg_data->num_vregs - 1;
-		for ( ; i >= 0; i--)
-			qca_disable_regulator(vregs[i], vreg_bulk[i].consumer);
+		regulator_bulk_disable(num_vregs, vreg_bulk);
 
 		qcadev->bt_power->vregs_on = false;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int qca_init_regulators(struct qca_power *qca,
@@ -1465,6 +1436,7 @@ static int qca_init_regulators(struct qca_power *qca,
 	}
 
 	qca->vreg_bulk = bulk;
+	qca->num_vregs = num_vregs;
 
 	return 0;
 }
@@ -1493,7 +1465,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return -ENOMEM;
 
 		qcadev->bt_power->dev = &serdev->dev;
-		qcadev->bt_power->vreg_data = data;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);
 		if (err) {
-- 
2.23.0

