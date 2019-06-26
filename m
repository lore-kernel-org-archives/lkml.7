Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C589AC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBA320B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520952;
	bh=DEHaS1WCbAKmb18G1DPPFqkRW3gzvPcfQg+Ij2jEycM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FMxTCt1wFV6qP0KCaLFXBp7ITzdEp1RGOaf0+P85cZ2C1ITc409RXELIa3TsHgAhX
	 LHTy46xH8NewQZpG/azgj9eEhhHSSSD2JSkGII5TD3eQ+jWX1MOSt4B/4PxsHWMF8t
	 K3KmFlEurk19gIHdA8A4EVlbffeL/syqqwof9qsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfFZDtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfFZDn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:43:56 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-98.mobile.att.net [107.77.172.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 061B320659;
        Wed, 26 Jun 2019 03:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520636;
        bh=DEHaS1WCbAKmb18G1DPPFqkRW3gzvPcfQg+Ij2jEycM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rd1P65itfTjVpWSNiZYdYnfPRXcIxFjcwoN6WRrdY7D0x1baHA9JqJsDn9orkGYRH
         0hDt7xHqArZ0JZm6aY79DwyanyH9O6M8YKpwv73y2oFqZPrceuIXh09t4evhlmu23z
         KKwP6V5I8CfM7NTp+Te138hCJ8imq6xQiZDhadJA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 10/34] drm/mediatek: call drm_atomic_helper_shutdown() when unbinding driver
Date:   Tue, 25 Jun 2019 23:43:11 -0400
Message-Id: <20190626034335.23767-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034335.23767-1-sashal@kernel.org>
References: <20190626034335.23767-1-sashal@kernel.org>
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
index bbe57ad9acf1..3df8a9dbccfe 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -310,6 +310,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 static void mtk_drm_kms_deinit(struct drm_device *drm)
 {
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
-- 
2.20.1

