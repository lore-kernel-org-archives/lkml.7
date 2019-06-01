Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C6C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5535927505
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396031;
	bh=Hshb00E3YY/ALIe4BTZ8oT6UxHJVL0f6jBjud6JkyMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BNmkZDAKWH/F2ok1+fGA93mPMDQMYgrB5VEyS5j5IvrJYMZMWDkhjR2rrNHvHvQ5w
	 5hqEc94cNRPy/EwFRoyE3iZydVjaWUoiE2R2pei2wqA7rWjmOdDBL/Uo3NOutiV5SC
	 sHMaKc4+6k7wn2tF4YoLzQdek20MNR4akGabsfYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfFANdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbfFANY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:24:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A074264C3;
        Sat,  1 Jun 2019 13:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395466;
        bh=Hshb00E3YY/ALIe4BTZ8oT6UxHJVL0f6jBjud6JkyMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkV3nr5LinVpG768tK3MAMC9UuHjNinEBMESJ+lvBJWPnTw0EvO0ZcRHotu4K5V2Y
         +20rVVd5h8XW4SDF9Tow7dRd4wPHB0mHIyiRBpuHNGrYmio/B4+74denU0DVUD8jOk
         33mLTzEeBhlFPi0XnT/R7VIy9uuTbdAC49C4CbBA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Gomez <dagmcr@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 16/99] mfd: tps65912-spi: Add missing of table registration
Date:   Sat,  1 Jun 2019 09:22:23 -0400
Message-Id: <20190601132346.26558-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132346.26558-1-sashal@kernel.org>
References: <20190601132346.26558-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Gomez <dagmcr@gmail.com>

[ Upstream commit 9e364e87ad7f2c636276c773d718cda29d62b741 ]

MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
OF mathing mechanism and register it.

Before this patch:
modinfo drivers/mfd/tps65912-spi.ko | grep alias
alias:          spi:tps65912

After this patch:
modinfo drivers/mfd/tps65912-spi.ko | grep alias
alias:          of:N*T*Cti,tps65912C*
alias:          of:N*T*Cti,tps65912
alias:          spi:tps65912

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps65912-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps65912-spi.c b/drivers/mfd/tps65912-spi.c
index 3bd75061f7776..f78be039e4637 100644
--- a/drivers/mfd/tps65912-spi.c
+++ b/drivers/mfd/tps65912-spi.c
@@ -27,6 +27,7 @@ static const struct of_device_id tps65912_spi_of_match_table[] = {
 	{ .compatible = "ti,tps65912", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, tps65912_spi_of_match_table);
 
 static int tps65912_spi_probe(struct spi_device *spi)
 {
-- 
2.20.1

