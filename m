Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B03C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AF7206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfFMP2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:28:09 -0400
Received: from ns.iliad.fr ([212.27.33.1]:60940 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728966AbfFMLcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:32:09 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 322AA20A7E;
        Thu, 13 Jun 2019 13:32:08 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 1A28220514;
        Thu, 13 Jun 2019 13:32:08 +0200 (CEST)
To:     Kishon Vijay Abraham <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1] phy: qcom-qmp: Raise qcom_qmp_phy_enable() polling delay
Message-ID: <92d97c68-d226-6290-37d6-f46f42ea604b@free.fr>
Date:   Thu, 13 Jun 2019 13:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jun 13 13:32:08 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

readl_poll_timeout() calls usleep_range() to sleep between reads.
usleep_range() doesn't work efficiently for tiny values.

Raise the polling delay in qcom_qmp_phy_enable() to bring it in line
with the delay in qcom_qmp_phy_com_init().

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
Vivek, do you remember why you didn't use the same delay value in
qcom_qmp_phy_enable) and qcom_qmp_phy_com_init() ?
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index bb522b915fa9..34ff6434da8f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1548,7 +1548,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
 	status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
 	mask = cfg->mask_pcs_ready;
 
-	ret = readl_poll_timeout(status, val, val & mask, 1,
+	ret = readl_poll_timeout(status, val, val & mask, 10,
 				 PHY_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		dev_err(qmp->dev, "phy initialization timed-out\n");
-- 
2.17.1
