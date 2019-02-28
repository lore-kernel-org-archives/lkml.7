Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD88C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDF4218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366596;
	bh=adc0ewNQgrwWLEQlAiEqC0OMasUXRc21drMbgwWYs2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JebjIDW1mNM0RzdD5MS0aqM/ESYDhtLFw0hpLfn3yKWBdmLBKIO8hDM7RrZ/h+Tpw
	 3zqCrjiLvYozfs3Jq+thQXKpj4fDC7wZxuECD/TeMuIJld8j/Ih8pjmBpaA99bkvSw
	 QBpkcvMHQnCQ1MmEQZuf08zSIMvR4t1rmCzeMuRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbfB1PJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:09:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387593AbfB1PJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44DF8218AE;
        Thu, 28 Feb 2019 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366590;
        bh=adc0ewNQgrwWLEQlAiEqC0OMasUXRc21drMbgwWYs2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9BIF6Zd3VWoSCYYmW4064FZZoVHbIHfHoN+Itb3oDMkDE2cjTHaKveqVdna1Aur7
         /B5E7+BFm4CudumLnjkmaLk+0DhRLe39+sKi36vKYoXyx25GK/So014UYdlVeUNOi1
         bpEKageuFjrari59+6KLG75qta4t4xHan0gz/q0I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 52/81] drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init
Date:   Thu, 28 Feb 2019 10:07:44 -0500
Message-Id: <20190228150813.10256-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit b14e945bda8ae227d1bf2b1837c0c4a61721cd1a ]

When initializing clocks, a reference to the TCON channel 0 clock is
obtained. However, the clock is never prepared and enabled later.
Switching from simplefb to DRM actually disables the clock (that was
usually configured by U-Boot) because of that.

On the V3s, this results in a hang when writing to some mixer registers
when switching over to DRM from simplefb.

Fix this by preparing and enabling the clock when initializing other
clocks. Waiting for sun4i_tcon_channel_enable to enable the clock is
apparently too late and results in the same mixer register access hang.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190131132550.26355-1-paul.kocialkowski@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index f949287d926cd..4e0562aa2cc90 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -760,6 +760,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 			return PTR_ERR(tcon->sclk0);
 		}
 	}
+	clk_prepare_enable(tcon->sclk0);
 
 	if (tcon->quirks->has_channel_1) {
 		tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
@@ -774,6 +775,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 
 static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
 {
+	clk_disable_unprepare(tcon->sclk0);
 	clk_disable_unprepare(tcon->clk);
 }
 
-- 
2.19.1

