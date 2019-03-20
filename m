Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA10C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2512146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N4ewvYYj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N4ewvYYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfCTJty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:49:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50436 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:49:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E70856118C; Wed, 20 Mar 2019 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075387;
        bh=IV7tUmqAOcOybIWc52/kxVT+D89R6Hy8mjlfXdDcBx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4ewvYYjEq5SNt+QfxgbKWj219wZqEDViPQ9LMDO/hZlHAvM+pvDYpY+l2nRbmi5c
         jzuMDcKVEWgdd2KKw4Ep6E5Panyjj2VD7jv56/XP4idM+KULM+NR1Jszo8lk/9JzYR
         m8TNGt9bBmU1pfvYHbpFSohjpmArUWdVO2sOlysk=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F21360FEA;
        Wed, 20 Mar 2019 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075387;
        bh=IV7tUmqAOcOybIWc52/kxVT+D89R6Hy8mjlfXdDcBx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4ewvYYjEq5SNt+QfxgbKWj219wZqEDViPQ9LMDO/hZlHAvM+pvDYpY+l2nRbmi5c
         jzuMDcKVEWgdd2KKw4Ep6E5Panyjj2VD7jv56/XP4idM+KULM+NR1Jszo8lk/9JzYR
         m8TNGt9bBmU1pfvYHbpFSohjpmArUWdVO2sOlysk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F21360FEA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, dianders@chromium.org, rafael@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC v2 03/11] tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
Date:   Wed, 20 Mar 2019 15:19:10 +0530
Message-Id: <20190320094918.20234-4-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

geni serial needs to express a perforamnce state requirement on CX
depending on the frequency of the clock rates. Use OPP table from
DT to register with OPP framework and use dev_pm_opp_set_rate() to
set the clk/perf state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3bcec1c20219..422852911141 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/qcom-geni-se.h>
 #include <linux/serial.h>
@@ -115,6 +116,7 @@ struct qcom_geni_serial_port {
 	bool brk;
 
 	unsigned int tx_remaining;
+	struct device *dev;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -961,7 +963,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		goto out_restart_rx;
 
 	uport->uartclk = clk_rate;
-	clk_set_rate(port->se.clk, clk_rate);
+	dev_pm_opp_set_rate(port->dev, clk_rate);
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
@@ -1198,8 +1200,10 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
 		geni_se_resources_on(&port->se);
 	else if (new_state == UART_PM_STATE_OFF &&
-			old_state == UART_PM_STATE_ON)
+			old_state == UART_PM_STATE_ON) {
+		dev_pm_opp_set_rate(port->dev, 0);
 		geni_se_resources_off(&port->se);
+	}
 }
 
 static const struct uart_ops qcom_geni_console_pops = {
@@ -1265,6 +1269,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid line %d\n", line);
 		return PTR_ERR(port);
 	}
+	port->dev = &pdev->dev;
 
 	uport = &port->uport;
 	/* Don't allow 2 drivers to access the same port */
@@ -1286,6 +1291,12 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		return -EINVAL;
 	uport->mapbase = res->start;
 
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to init OPP table: %d\n", ret);
+		return ret;
+	}
+
 	port->tx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
 	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
 	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

