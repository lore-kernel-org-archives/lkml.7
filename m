Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E9DC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850782168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948931;
	bh=z6WyRdHEuXM4BX+2/G9Bv1TDJ64UqpMMW83Y8th40I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIRnesHhjPY7uKdaJhD5cwn/Arz2CR8sZQlODHo+HRAB0JVMSm4v256Yf0gJKNZBn
	 YfnohByY1sH6CTzQ6n2EEwmlB2klniLFGJnqqUNegrqpIj4me6El1eWCc12l+Os499
	 Lgzk5gGhUDsWA+FC+5ZyPjVEaKQDHLd9jk1Dq3XI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbfJAQz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732158AbfJAQmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:42:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2517A21920;
        Tue,  1 Oct 2019 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948165;
        bh=z6WyRdHEuXM4BX+2/G9Bv1TDJ64UqpMMW83Y8th40I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbBqqh8YNcTRXxoNDYx+qbsvXVi/noLyRvycl4EDUbKusrR3VxQdqNJMtoUIaaj9l
         Mgunod3pGGM/O5wcUjp4Y2S5oONSbvmDFHQmxhpD6oZwGNluL4fJBiFKlef4hrXcl/
         FGIiGMPT+lhjlkkDXvRu/bLaqwFTrK/EyPWNbS10=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 51/63] i2c: qcom-geni: Disable DMA processing on the Lenovo Yoga C630
Date:   Tue,  1 Oct 2019 12:41:13 -0400
Message-Id: <20191001164125.15398-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index db075bc0d9525..715ddc5d0eac9 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -354,11 +354,13 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
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
@@ -393,11 +395,13 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
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

