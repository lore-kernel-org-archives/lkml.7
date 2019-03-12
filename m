Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9655921741
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410918;
	bh=kKRXxVlhedt0LxUb7F9TwIv2Jc8pRKwQk5/lvBoImxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0uqjdpExP/m4rl2UPpi1CRG620lEnp+TK69s75tRP4nugmOxV/KKFjefvKfG1KAwP
	 uYr6/2MMCS3KhrkEyAQ6xDfiae17btvjROHNZ7JhyW26K3g3te0mjTxi7/8jrDp8lJ
	 UYbai9jdVEye99JaBGz2tdCd88HW1Puxpxpk6dhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfCLRPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbfCLROc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:32 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1254B2173C;
        Tue, 12 Mar 2019 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410871;
        bh=kKRXxVlhedt0LxUb7F9TwIv2Jc8pRKwQk5/lvBoImxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zI4UETDtQsr9gt+bm4nDRImpVx+FFy3qeUaiwTpeuQNjE6R4HdKmwFCHaPf6OEBCH
         DKmH++Yru4dButDcKSEa9uLi9lW/x234KFrE7sznHW/86MHzxyhd2eB7FsPnTTho1F
         lk2IH3XeGunKdsYxH8uk6EAphOQCvmAzJuUDC7Y8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/149] wlcore: sdio: Fixup power on/off sequence
Date:   Tue, 12 Mar 2019 10:08:11 -0700
Message-Id: <20190312170355.754717265@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 13e62626c578d9889ebbda7c521be5adff9bef8e ]

During "wlan-up", we are programming the FW into the WiFi-chip. However,
re-programming the FW doesn't work, unless a power cycle of the WiFi-chip
is made in-between the programmings.

To conform to this requirement and to fix the regression in a simple way,
let's start by allowing that the SDIO card (WiFi-chip) may stay powered on
(runtime resumed) when wl12xx_sdio_power_off() returns. The intent with the
current code is to treat this scenario as an error, but unfortunate this
doesn't work as expected, so let's fix this.

The other part is to guarantee that a power cycle of the SDIO card has been
completed when wl12xx_sdio_power_on() returns, as to allow the FW
programming to succeed. However, relying solely on runtime PM to deal with
this isn't sufficient. For example, userspace may prevent runtime suspend
via sysfs for the device that represents the SDIO card, leading to that the
mmc core also keeps it powered on. For this reason, let's instead do a
brute force power cycle in wl12xx_sdio_power_on().

Fixes: 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wlcore/sdio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index 750bea3574ee..627df164b7b6 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -164,6 +164,12 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
 	}
 
 	sdio_claim_host(func);
+	/*
+	 * To guarantee that the SDIO card is power cycled, as required to make
+	 * the FW programming to succeed, let's do a brute force HW reset.
+	 */
+	mmc_hw_reset(card->host);
+
 	sdio_enable_func(func);
 	sdio_release_host(func);
 
@@ -174,20 +180,13 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
 {
 	struct sdio_func *func = dev_to_sdio_func(glue->dev);
 	struct mmc_card *card = func->card;
-	int error;
 
 	sdio_claim_host(func);
 	sdio_disable_func(func);
 	sdio_release_host(func);
 
 	/* Let runtime PM know the card is powered off */
-	error = pm_runtime_put(&card->dev);
-	if (error < 0 && error != -EBUSY) {
-		dev_err(&card->dev, "%s failed: %i\n", __func__, error);
-
-		return error;
-	}
-
+	pm_runtime_put(&card->dev);
 	return 0;
 }
 
-- 
2.19.1



