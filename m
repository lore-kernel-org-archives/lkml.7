Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F5AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 11:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F0320718
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 11:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TODrrMuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLaLBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 06:01:12 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:12639 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfLaLBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 06:01:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577790071; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Kmc1pm40+oqsnfrtH/wQUIISFbKnGIRxJs+3Ff34ObI=; b=TODrrMuLMSSmX/XIBVeIoIl/OkrE1CTZUUIDoGYgnOymCJ65YdfmZSYcFJ0B3UuGz2nUdqid
 yZMJTxCjBmhmcmUyIIFOI5YR36zawsn6GBXbTY58WX8oFRpG1l1DUakraPnjekkVh/xYYp9Y
 rJZQtUxiOFSt08Crm84DLmijVrY=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0b2a71.7efd9b854260-smtp-out-n02;
 Tue, 31 Dec 2019 11:01:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C884C447A3; Tue, 31 Dec 2019 11:01:04 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3A49C433CB;
        Tue, 31 Dec 2019 11:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3A49C433CB
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
Subject: [PATCH v1 1/2] clk: qcom: rpmh: skip undefined clocks when registering
Date:   Tue, 31 Dec 2019 16:30:47 +0530
Message-Id: <1577790048-18263-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577790048-18263-1-git-send-email-tdas@codeaurora.org>
References: <1577790048-18263-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When iterating over a platform's available clocks in clk_rpmh_probe(),
check for undefined (null) entries in the clocks array.  Not all
clock indexes necessarily have clocks defined. Also remove referencing
the clock name before valid hardware.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-rpmh.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 7ed313a..05cbe6f 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -431,11 +431,13 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 	hw_clks = desc->clks;

 	for (i = 0; i < desc->num_clks; i++) {
-		const char *name = hw_clks[i]->init->name;
 		u32 res_addr;
 		size_t aux_data_len;
 		const struct bcm_db *data;

+		if (!hw_clks[i])
+			continue;
+
 		rpmh_clk = to_clk_rpmh(hw_clks[i]);
 		res_addr = cmd_db_read_addr(rpmh_clk->res_name);
 		if (!res_addr) {
@@ -462,7 +464,8 @@ static int clk_rpmh_probe(struct platform_device *pdev)

 		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to register %s\n", name);
+			dev_err(&pdev->dev, "failed to register %s\n",
+							hw_clks[i]->init->name);
 			return ret;
 		}
 	}
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
