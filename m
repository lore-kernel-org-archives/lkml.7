Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA7C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9D3205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520730;
	bh=tOC3eF55wDr3CD1/ajWuQsH75cuj4apVTdjNE2tn8Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SLnEvyp18epQCNbAadOKu7VLHzHslx+TDv3GyUTw/yBah/PVjEESmRd0l6+gDRgRx
	 xjKxh7VfrOdTM7nSn+hiTfYUfQ+s4K/CDWczBDGS5Zwaa+oj2+ihvGrc3J3n9WB/6l
	 KYIY10o8lvqFT/oz+EcL5QE5vZC41enc5WPpapl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfFZDp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfFZDpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:45:23 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E9520659;
        Wed, 26 Jun 2019 03:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520723;
        bh=tOC3eF55wDr3CD1/ajWuQsH75cuj4apVTdjNE2tn8Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUGBESJCp6bso1rhJFJ3k/Xj/1Zbrh9DAt9tx2AVXVbykvaBaQyVPQAZZwIhLi8xc
         +bFYsP9NOTTVfLVdeVqx4x2IhMedhSjGoyGYgx97VN1RNccl3My4BVaJlmtpYvnK95
         kz/80bs8wmKQRVdgHcFOGlr9BJc7W3q0drMeuKo8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 07/21] drm/mediatek: call drm_atomic_helper_shutdown() when unbinding driver
Date:   Tue, 25 Jun 2019 23:44:52 -0400
Message-Id: <20190626034506.24125-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034506.24125-1-sashal@kernel.org>
References: <20190626034506.24125-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hsin-Yi Wang <hsinyi@chromium.org>

[ Upstream commit cf49b24ffa62766f8f04cd1c4cf17b75d29b240a ]

shutdown all CRTC when unbinding drm driver.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a2ca90fc403c..cada1c75c41c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -270,6 +270,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 static void mtk_drm_kms_deinit(struct drm_device *drm)
 {
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
-- 
2.20.1

