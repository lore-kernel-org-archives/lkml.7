Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157E2C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58FE24683
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576837063;
	bh=Ck3ilHyvx6XvHA65br3cwI6dDkzvtwpztH+Uhmy2tGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q6/NkY8/7y+b0iHLZxHVh/JWkscLAlMbtm6177gt89COI4M5wBeuVlR8I6L1hstIL
	 ri/al4ArMgwJAKOh1uzgmU9UET+jxetvkcPAMl4HTUE2PtGomJXPHbB6WirgMveJbf
	 O2BPZiHnA6hPnN3sR8lSmVxUd2sp6VAtjyJ0tbcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLTKRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfLTKRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:17:42 -0500
Received: from localhost.localdomain (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C32424682;
        Fri, 20 Dec 2019 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576837061;
        bh=Ck3ilHyvx6XvHA65br3cwI6dDkzvtwpztH+Uhmy2tGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/zZDE4n02b82w4qCokUUQjSkUgLZwjv5e9nYqSUAfE2q2owaqqvaS3AF/cUOvdjo
         g5afNUbO3sB9dU/TtmkVlAQ8BVSKRaVjvOhcwUfVlDkdaxp72791c0zBTYM3nZZsls
         ty+wyajBHF3lWNajncHVZ6hMXVgq6u63SMDr45JU=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 1/5] phy: qcom-qmp: Increase PHY ready timeout
Date:   Fri, 20 Dec 2019 15:47:15 +0530
Message-Id: <20191220101719.3024693-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191220101719.3024693-1-vkoul@kernel.org>
References: <20191220101719.3024693-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

It's typical for the QHP PHY to take slightly above 1ms to initialize,
so increase the timeout of the PHY ready check to 10ms - as already done
in the downstream PCIe driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Evan Green <evgreen@chromium.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 091e20303a14..66f91726b8b2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -66,7 +66,7 @@
 /* QPHY_V3_PCS_MISC_CLAMP_ENABLE register bits */
 #define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
 
-#define PHY_INIT_COMPLETE_TIMEOUT		1000
+#define PHY_INIT_COMPLETE_TIMEOUT		10000
 #define POWER_DOWN_DELAY_US_MIN			10
 #define POWER_DOWN_DELAY_US_MAX			11
 
-- 
2.23.0

