Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBA0C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3506E21929
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697060;
	bh=aH6ctXhIndO4xFNADjyeEW+RHGG7RRX4yg9ZHsOaVNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cN0X1J4cfBGz222vg9a9MSo8h2ISFnIeOEhReZxtQ0EJLZHHpDTxxpW3TszLGE2G8
	 LN3RWNWa11IitK9ORjiQ54JyIRuc52pitEDoAOjvkYpvCiZKMQ8DKvb3ps7mTrznkQ
	 Cw/0bGUMr3kfQ4YtyXee3Gy2JX1A8vMpK9vUBe5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfJJIoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387838AbfJJIoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:44:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD8E21929;
        Thu, 10 Oct 2019 08:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697056;
        bh=aH6ctXhIndO4xFNADjyeEW+RHGG7RRX4yg9ZHsOaVNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZETNqqyGFHTJVcCLBGc+ac/orl+ptqUekYmV6PsXOOhkwvRGAlLP328mm07hZH/7c
         QISX1spb9wZ+a0Ht4eL9Tly3nmvCOVnc5fLckczaV88vQQH2v7sKEEc+UENnjxO8ik
         /ePcXErit5gogOU7txtV+o68dvDW1G1GXdFLr7Kw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 131/148] i2c: qcom-geni: Disable DMA processing on the Lenovo Yoga C630
Date:   Thu, 10 Oct 2019 10:36:32 +0200
Message-Id: <20191010083620.317468522@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

[ Upstream commit 127068abe85bf3dee50df51cb039a5a987a4a666 ]

We have a production-level laptop (Lenovo Yoga C630) which is exhibiting
a rather horrific bug.  When I2C HID devices are being scanned for at
boot-time the QCom Geni based I2C (Serial Engine) attempts to use DMA.
When it does, the laptop reboots and the user never sees the OS.

Attempts are being made to debug the reason for the spontaneous reboot.
No luck so far, hence the requirement for this hot-fix.  This workaround
will be removed once we have a viable fix.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a89bfce5388ee..17abf60c94aeb 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -355,11 +355,13 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 {
 	dma_addr_t rx_dma;
 	unsigned long time_left;
-	void *dma_buf;
+	void *dma_buf = NULL;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
 
-	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+	if (!of_machine_is_compatible("lenovo,yoga-c630"))
+		dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+
 	if (dma_buf)
 		geni_se_select_mode(se, GENI_SE_DMA);
 	else
@@ -394,11 +396,13 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 {
 	dma_addr_t tx_dma;
 	unsigned long time_left;
-	void *dma_buf;
+	void *dma_buf = NULL;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
 
-	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+	if (!of_machine_is_compatible("lenovo,yoga-c630"))
+		dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+
 	if (dma_buf)
 		geni_se_select_mode(se, GENI_SE_DMA);
 	else
-- 
2.20.1



