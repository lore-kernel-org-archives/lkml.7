Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571D1C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 06:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9C3214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 06:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fytAK2IB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLMGtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 01:49:47 -0500
Received: from m228-5.mailgun.net ([159.135.228.5]:54515 "EHLO
        m228-5.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLMGtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 01:49:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576219785; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=rsQgQXaQSRf07rNlF+2nEQlC5ph1o6pOgKqbbRi4Scw=; b=fytAK2IB8B26vFyoevdZZc/b6RZbnb1OSsmd/jRBLZsNAye6EurhQ9I/E4kmgeUSqEJ0G0SP
 N0QbderFdZCUfFwEVNisCihpZf+z97phY79cPhosvIHYJTZbs5Uv6ru8XKbTIl66922Cfv3z
 JvD7N33RJ73vNptADnDG+fTPi+U=
X-Mailgun-Sending-Ip: 159.135.228.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df33488.7f19e803cb58-smtp-out-n01;
 Fri, 13 Dec 2019 06:49:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D643C447A0; Fri, 13 Dec 2019 06:49:44 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60FC6C433CB;
        Fri, 13 Dec 2019 06:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60FC6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-watchdog@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] watchdog: qcom: Use platform_get_irq_optional() for bark irq
Date:   Fri, 13 Dec 2019 12:19:34 +0530
Message-Id: <20191213064934.4112-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() prints an error message when the interrupt
is not available. So on platforms where bark interrupt is
not specified, following error message is observed on SDM845.

[    2.975888] qcom_wdt 17980000.watchdog: IRQ index 0 not found

This is also seen on SC7180, SM8150 SoCs as well.
Fix this by using platform_get_irq_optional() instead.

Fixes: 36375491a4395654 ("watchdog: qcom: support pre-timeout when the bark irq is available")
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/watchdog/qcom-wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index a494543d3ae1..eb47fe5ed280 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -246,7 +246,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	}
 
 	/* check if there is pretimeout support */
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq > 0) {
 		ret = devm_request_irq(dev, irq, qcom_wdt_isr,
 				       IRQF_TRIGGER_RISING,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
