Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF30C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6448F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013649;
	bh=2Hmia6uVBT0pGAtAMw0KLOxb1KHmx2lNNMAxCv4+9AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IhjrfTWVJBLepSKhjStE9GvqHb8W7TuTaOJJgWRJoKN41Xc/qkyaBuNq0hjnhwUEC
	 tFOmLJ/pG9N++GoIucIGe6LWrLNOA1MClAFfFIrkPgf3frNGIqxm4VElEs2yZ2kGmq
	 WldJv6WnTvdoVa6seA0FNhxr6i9fsOXzCQfMwCaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfLJVeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729904AbfLJVeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:34:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A1B222C4;
        Tue, 10 Dec 2019 21:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013640;
        bh=2Hmia6uVBT0pGAtAMw0KLOxb1KHmx2lNNMAxCv4+9AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpLtngDt2oKsTXOBsbMQVcTRDRuMXXhWEKyBx6Gxk3UZppjQ4snuFIPXuULT2ygzq
         t4h5e7SrWbaZzpUoA8DaAFez0UwPeyPhNUlgkGkXV+GQhLNyvlV923v41Bh7Q1e9eW
         0PLO0kKz39rJYqi1jVXxvEmdS2PSuqqFaVU+GTn4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lingling Xu <ling_ling.xu@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 080/177] spi: sprd: adi: Add missing lock protection when rebooting
Date:   Tue, 10 Dec 2019 16:30:44 -0500
Message-Id: <20191210213221.11921-80-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index df5960bddfe61..f1fc2bde6ef30 100644
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

