Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F17C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFE321743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565336286;
	bh=eEfBiOqceaUs54hxS2mvioQdvqdD5U2JbF1RwFVOym8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i+wZSmUZw80qHWOJoNn+B3IYQkQXq5ZGFkyY/7B56uFXbZKYWkLoDOnl8pKULnvvy
	 K0AR6jqXyuFQ1Sxt2e1hxiUPEZjDAiuJlggixHhKAIKy01Zw165iaEkzSbARP97T0k
	 5Hp52XmfIgOfkZgvVQPu7BLiu6dz041Niu6YeRLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405937AbfHIHiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfHIHiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:38:02 -0400
Received: from localhost.localdomain (unknown [122.167.65.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7934921743;
        Fri,  9 Aug 2019 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565336281;
        bh=eEfBiOqceaUs54hxS2mvioQdvqdD5U2JbF1RwFVOym8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLw7z2SPjZQKd1d+HKGa5ZwRjCu6Zr2wTlAW4oiDIkZYylXi6DSnlHqwCQGgjQQhu
         tV8FtDnpsRoBD/6INIe/YUPr69WtcRT/6n0IC0v4gr741LzI5ABb1wTZt1KD0fBKrO
         Z8zWCVkDVzjg52Hy6n2ITO9CwaOTvcIIlRqHm55w=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/4] regulator: qcom-rpmh: Fix pmic5_bob voltage count
Date:   Fri,  9 Aug 2019 13:06:15 +0530
Message-Id: <20190809073616.1235-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809073616.1235-1-vkoul@kernel.org>
References: <20190809073616.1235-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmic5_bob voltages count is 136 [0,135] so update it

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 0ef2716da3bd..391ed844a251 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -698,7 +698,7 @@ static const struct rpmh_vreg_hw_data pmic5_bob = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_bypass_ops,
 	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 135, 32000),
-	.n_voltages = 135,
+	.n_voltages = 136,
 	.pmic_mode_map = pmic_mode_map_pmic4_bob,
 	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
 };
-- 
2.20.1

