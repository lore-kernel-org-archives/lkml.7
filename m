Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79498C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434C620643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963302;
	bh=LSqPcGYBte/5EODLqxzqi8NE6nDqGEBNjyvrZqYI0kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=od54ubPu/gOFCqeyqep+EXg2o7ioR/RbQ1A/++vkL9cLnT54QqQr+QpO50uqudG0W
	 nsDF0qwuLC3vRewFgwHOHGuiFlyAZVDa4dBf7FlnskmxE1vMcY2akEul02vW4weCDo
	 3Vd7BeN9iVmu5nJnm9+H6F9xIsfcGiRHj/grAXVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfDVUBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbfDVTqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B812321902;
        Mon, 22 Apr 2019 19:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962410;
        bh=LSqPcGYBte/5EODLqxzqi8NE6nDqGEBNjyvrZqYI0kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfJbiRfWVdd45ZJb4c14mpdrty3FMsYANdLuYW/VY6sFiH018nZJN1JMmYaidMJcy
         /urDR7K9q+Aw/XbsJx/I4MgyiV2S0MKgp7w4toZG2hmPv8WtgH1kz/dflcnVprtmeU
         PYh6xu9nl5VrpiWUZAeBuHBSVpjMC8bIH6+7XiDU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 46/68] drm/meson: Uninstall IRQ handler
Date:   Mon, 22 Apr 2019 15:44:54 -0400
Message-Id: <20190422194516.11634-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

[ Upstream commit 2d8f92897ad816f5dda54b2ed2fd9f2d7cb1abde ]

meson_drv_unbind() doesn't unregister the IRQ handler, which can lead to
use-after-free if the IRQ fires after unbind:

[   64.656876] Unable to handle kernel paging request at virtual address ffff000011706dbc
...
[   64.662001] pc : meson_irq+0x18/0x30 [meson_drm]

I'm assuming that a similar problem could happen on the error path of
bind(), so uninstall the IRQ handler there as well.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190322152657.13752-2-jean-philippe.brucker@arm.com
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/gpu/drm/meson/meson_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 4a72fa53a1d5..588b3b0c8315 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -300,10 +300,12 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
-		goto free_drm;
+		goto uninstall_irq;
 
 	return 0;
 
+uninstall_irq:
+	drm_irq_uninstall(drm);
 free_drm:
 	drm_dev_put(drm);
 
@@ -321,6 +323,7 @@ static void meson_drv_unbind(struct device *dev)
 	struct drm_device *drm = priv->drm;
 
 	drm_dev_unregister(drm);
+	drm_irq_uninstall(drm);
 	drm_kms_helper_poll_fini(drm);
 	drm_fbdev_cma_fini(priv->fbdev);
 	drm_mode_config_cleanup(drm);
-- 
2.19.1

