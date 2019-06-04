Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B317DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B19920863
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMsYJVyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfFDXYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:24:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41680 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfFDXYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so4435371pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=obi0eC193ooLcTgT4aYZ/LPXcwma3pGIiVwdm+ZLW/M=;
        b=AMsYJVyx1E2PhELXukpwNv2QK5/j+6HSE907U0nWeM+7fJtL4qVUauTtrcKUP+BaC+
         m2/USB/fiddVi/6q4IG+znP1gen+av+vkXXnsNxm8HJNIpni7r08iMzsp0FuiNV8R7l4
         9ZoDiTfjoshVEVjPRbbCIy/iCssV/bDqKmHtiyNdGGOkzD0CW78bP3Fl/jKruoOSqRX0
         CXNFL4NnIkhJcABp/CU32yr2Ry2TZrxwIp0JGDcF+kguGOTkgxLbT1csaoGpdA/WGQrV
         9edE+Cp8TjvESqm45wBW7DaVmLH+Pnc0gCgp556wP1QNcJtF0VpcYt8e4+9oCRkhZyMj
         VUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=obi0eC193ooLcTgT4aYZ/LPXcwma3pGIiVwdm+ZLW/M=;
        b=jRjsfUHOtLJ+yYQnlL7IeO9bejf4goT8ejqCL7n+YIKc2etZQyB+zjV+gowBNjC0Uf
         CP9ODpSmXtgDjod0BghPbbGnJBCDJq94RSqsoqrw2dmgmtzWo8MRwsF2IHComZpjnRYH
         oIVQEkh390Hv8oO31JZw1z8Wa5yP6s+3fb0MT3rtv+pj/3M8CQRxt+/taM8L2H+SHBmU
         s/h56GXGJYwu5H3tIovpoxWShh+Aa+2lZ9ZjF/jDu5N0DXsjY2UNuY9BDFJSYzTeBFbu
         wD/IIY3BwSX/RygvB/8YxKA8o5XTdb6aRL/N3k2z5blmLokbwi13YZMmAGZRcIGoeeOW
         Qfeg==
X-Gm-Message-State: APjAAAWU0VaF3XCYTadGL7CiyM04SuSK8/8wpNd+Z8y2kJp5WadB/Lvh
        T/9jBpHaSzDfpDv0mlpLNtEw6g==
X-Google-Smtp-Source: APXvYqzc51fTaTIgg/ow8Ex4x4MVEvU2ihME1m+3cZIGivXIS4txaovlrwAaauamX4wW1lcT1BU2ZQ==
X-Received: by 2002:a63:de43:: with SMTP id y3mr361411pgi.271.1559690686503;
        Tue, 04 Jun 2019 16:24:46 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a12sm19244474pgq.0.2019.06.04.16.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 16:24:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH] phy: qcom-qmp: Correct READY_STATUS poll break condition
Date:   Tue,  4 Jun 2019 16:24:43 -0700
Message-Id: <20190604232443.3417-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After issuing a PHY_START request to the QMP, the hardware documentation
states that the software should wait for the PCS_READY_STATUS to become
1.

With the introduction of c9b589791fc1 ("phy: qcom: Utilize UFS reset
controller") an additional 1ms delay was introduced between the start
request and the check of the status bit. This greatly increases the
chances for the hardware to actually becoming ready before the status
bit is read.

The result can be seen in that UFS PHY enabling is now reported as a
failure in 10% of the boots on SDM845, which is a clear regression from
the previous rare/occasional failure.

This patch fixes the "break condition" of the poll to check for the
correct state of the status bit.

Unfortunately PCIe on 8996 and 8998 does not specify the mask_pcs_ready
register, which means that the code checks a bit that's always 0. So the
patch also fixes these, in order to not regress these targets.

Cc: stable@vger.kernel.org
Cc: Evan Green <evgreen@chromium.org>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
Fixes: 73d7ec899bd8 ("phy: qcom-qmp: Add msm8998 PCIe QMP PHY support")
Fixes: e78f3d15e115 ("phy: qcom-qmp: new qmp phy driver for qcom-chipsets")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

@Kishon, this is a regression spotted in v5.2-rc1, so please consider applying
this towards v5.2.

 drivers/phy/qualcomm/phy-qcom-qmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index cd91b4179b10..43abdfd0deed 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1074,6 +1074,7 @@ static const struct qmp_phy_cfg msm8996_pciephy_cfg = {
 
 	.start_ctrl		= PCS_START | PLL_READY_GATE_EN,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.mask_pcs_ready		= PHYSTATUS,
 	.mask_com_pcs_ready	= PCS_READY,
 
 	.has_phy_com_ctrl	= true,
@@ -1253,6 +1254,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 
 	.start_ctrl             = SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.mask_pcs_ready		= PHYSTATUS,
 	.mask_com_pcs_ready	= PCS_READY,
 };
 
@@ -1547,7 +1549,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
 	status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
 	mask = cfg->mask_pcs_ready;
 
-	ret = readl_poll_timeout(status, val, !(val & mask), 1,
+	ret = readl_poll_timeout(status, val, val & mask, 1,
 				 PHY_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		dev_err(qmp->dev, "phy initialization timed-out\n");
-- 
2.18.0

