Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F86C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EB7222C3
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640689;
	bh=MhawG8QZC3stOTIhInpZcVq5xLaSqaA3HJfEOpjECK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=as5B7lPOfb9lbmb+xoGFuDyTS1aIoGRe/fyxg00vTYVRBfmFP19B8Yg377Lpe5Lqv
	 tFw9OjBXWXCBGW2tBsaTdcAMSUx5zXK67bUZxW+mC7I8ajO2ODfJXhHUdBvS7Tg6Qy
	 EHZDWb1LzLtGZtEyYYsQnammx+u7HqKsjWZ92310=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfL2Rb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:31:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbfL2RbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:31:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358C520722;
        Sun, 29 Dec 2019 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640684;
        bh=MhawG8QZC3stOTIhInpZcVq5xLaSqaA3HJfEOpjECK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygrBWKyS4kHEyC3VKuNrr/NKEDlpO6ObXralIVkDWlH/K9PLwZKM8zmF0iPnBdWso
         uPdM2WU/McHW3OCpOR8BLzreWoEiSlZe98Oz0S7IN5eFjNfLbnuzTH81OkYijwh7r2
         MpQVXLyKWfS1jKt+prMwmmPO8gv6HotNqIKokgp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lingling Xu <ling_ling.xu@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/219] spi: sprd: adi: Add missing lock protection when rebooting
Date:   Sun, 29 Dec 2019 18:18:19 +0100
Message-Id: <20191229162522.508931321@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lingling Xu <ling_ling.xu@unisoc.com>

[ Upstream commit 91ea1d70607e374b014b4b9bea771ce661f9f64b ]

When rebooting the system, we should lock the watchdog after
configuration to make sure the watchdog can reboot the system
successfully.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index df5960bddfe6..f1fc2bde6ef3 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -367,6 +367,9 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	val |= BIT_WDG_RUN | BIT_WDG_RST;
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
 
+	/* Lock the watchdog */
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, ~WDG_UNLOCK_KEY);
+
 	mdelay(1000);
 
 	dev_emerg(sadi->dev, "Unable to restart system\n");
-- 
2.20.1



