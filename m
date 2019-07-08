Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88980C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D9021537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600271;
	bh=B3BWwCuukbc3fMSFs7l/VP/ypQsliVWsYqplb8DYBWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JS/U2IagR0j3PJS2IcinDGHKtLK54x/0vwyuN+4Uemrc1VOjoUh4tfUH/DQ6iV1pN
	 pnk8vPidNCGJqubxUblPbHBJnKUxKTKbkp+JoRDzBMRaenuP+IAHW2mMaHrARObwbx
	 1R7eV3jHunUA+yT2nd/J4in+l9O/19N88W4P6Tb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbfGHPhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389730AbfGHPbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:31:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39931216F4;
        Mon,  8 Jul 2019 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599884;
        bh=B3BWwCuukbc3fMSFs7l/VP/ypQsliVWsYqplb8DYBWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bi22uf/P+knrg3Cura0AHXOWLJKZGocY3naQIS7fYD7NVc34Oc6OHCPU6yoLZ0gCD
         6On4LdOS3clRXTpvrsQsCFRV3U6a42IL8mBa5WGNuqzYis4LftvRRRBD7eYUMJVMgb
         C6rEJ4OvM3nIV2qzw5IxH01Hy39j3voMtN2U7gJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 21/96] drm/mediatek: call drm_atomic_helper_shutdown() when unbinding driver
Date:   Mon,  8 Jul 2019 17:12:53 +0200
Message-Id: <20190708150527.588499671@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e7362bdafa82..8718d123ccaa 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -311,6 +311,7 @@ err_config_cleanup:
 static void mtk_drm_kms_deinit(struct drm_device *drm)
 {
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
-- 
2.20.1



