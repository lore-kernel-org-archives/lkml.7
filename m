Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5995C2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 11:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D2B206E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 11:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rLxxsHYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLaLBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 06:01:16 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:22936 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727070AbfLaLBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 06:01:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577790075; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=EuaD3sqTQ2Mb1L2LetavYIQctg0Kmht3QfCcxsN8GZA=; b=rLxxsHYPCde1IpTgLTFoRsl9WDfRhTT09pdVUUeH5mEIP9klpbFQXCKq3vdB4ujS3d0Ue/l2
 ash0vwgEpGt9AGCfi1FN2G/G+Uo3s1YIttDW0G40X7jlDzVNQjcALX2be37/zNHlqDF8/xD+
 7By/d6d++KbNtfcR3qi8Y2DAslE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0b2a77.7ff4dbd9ced8-smtp-out-n01;
 Tue, 31 Dec 2019 11:01:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19758C43383; Tue, 31 Dec 2019 11:01:10 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94571C433CB;
        Tue, 31 Dec 2019 11:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94571C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 2/2] clk: qcom: rpmh: Add IPA clock for SC7180
Date:   Tue, 31 Dec 2019 16:30:48 +0530
Message-Id: <1577790048-18263-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577790048-18263-1-git-send-email-tdas@codeaurora.org>
References: <1577790048-18263-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm IP Accelerator (IPA) clock resource that is managed by the BCM is
required by the IPA driver in order to scale its core clock.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-rpmh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 05cbe6f..b186479 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -396,6 +396,7 @@ static struct clk_hw *sc7180_rpmh_clocks[] = {
 	[RPMH_RF_CLK1_A]	= &sdm845_rf_clk1_ao.hw,
 	[RPMH_RF_CLK2]		= &sdm845_rf_clk2.hw,
 	[RPMH_RF_CLK2_A]	= &sdm845_rf_clk2_ao.hw,
+	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,
 };

 static const struct clk_rpmh_desc clk_rpmh_sc7180 = {
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
