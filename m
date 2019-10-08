Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F6DC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ED920679
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfJHLxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:53:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:14418 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHLxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:53:32 -0400
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXuMPvtxBR0Q=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.28.0 AUTH)
        with ESMTPSA id L0811cv98BrU8B7
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 8 Oct 2019 13:53:30 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] phy: qcom-usb-hs: Fix extcon double register after power cycle
Date:   Tue,  8 Oct 2019 13:52:08 +0200
Message-Id: <20191008115208.149987-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f0b5c2c96370 ("phy: qcom-usb-hs: Replace the extcon API")
switched from extcon_register_notifier() to the resource-managed
API, i.e. devm_extcon_register_notifier().

This is problematic in this case, because the extcon notifier
is dynamically registered/unregistered whenever the PHY is powered
on/off. The resource-managed API does not unregister the notifier
until the driver is removed, so as soon as the PHY is power cycled,
attempting to register the notifier again results in:

	double register detected
	WARNING: CPU: 1 PID: 182 at kernel/notifier.c:26 notifier_chain_register+0x74/0xa0
	Call trace:
	 ...
	 extcon_register_notifier+0x74/0xb8
	 devm_extcon_register_notifier+0x54/0xb8
	 qcom_usb_hs_phy_power_on+0x1fc/0x208
	 ...

... and USB stops working after plugging the cable out and in
another time.

The easiest way to fix this is to make a partial revert of
commit f0b5c2c96370 ("phy: qcom-usb-hs: Replace the extcon API")
and avoid using the resource-managed API in this case.

Fixes: f0b5c2c96370 ("phy: qcom-usb-hs: Replace the extcon API")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
An other way to fix this would be keep the extcon notifier
permanently registered, and check in qcom_usb_hs_phy_vbus_notifier
if the PHY is currently powered on.
---
 drivers/phy/qualcomm/phy-qcom-usb-hs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs.c b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
index b163b3a1558d..61054272a7c8 100644
--- a/drivers/phy/qualcomm/phy-qcom-usb-hs.c
+++ b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
@@ -158,8 +158,8 @@ static int qcom_usb_hs_phy_power_on(struct phy *phy)
 		/* setup initial state */
 		qcom_usb_hs_phy_vbus_notifier(&uphy->vbus_notify, state,
 					      uphy->vbus_edev);
-		ret = devm_extcon_register_notifier(&ulpi->dev, uphy->vbus_edev,
-				EXTCON_USB, &uphy->vbus_notify);
+		ret = extcon_register_notifier(uphy->vbus_edev, EXTCON_USB,
+					       &uphy->vbus_notify);
 		if (ret)
 			goto err_ulpi;
 	}
@@ -180,6 +180,9 @@ static int qcom_usb_hs_phy_power_off(struct phy *phy)
 {
 	struct qcom_usb_hs_phy *uphy = phy_get_drvdata(phy);
 
+	if (uphy->vbus_edev)
+		extcon_unregister_notifier(uphy->vbus_edev, EXTCON_USB,
+					   &uphy->vbus_notify);
 	regulator_disable(uphy->v3p3);
 	regulator_disable(uphy->v1p8);
 	clk_disable_unprepare(uphy->sleep_clk);
-- 
2.23.0

