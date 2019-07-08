Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F5CC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C432F20651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600267;
	bh=ONtoK3BXZ/toMaRLrlTctSDqZ492BitQ+Z3AMHfxM84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G0Mt29JZm0Uu5Sgw8ymgHghOCTli+ycACSCDdD9RE1GE2WrStv4gi4yToIkSHfc9Q
	 AALcj1RMnD7uxcDe39RL2kmNVzX+DzBMifrVF9nkqFgfdwVRT76Qvwkvl8wCTNv5yr
	 ida+sRbc5c5UerxPBmZjyNvOgYm5HLsKcYyB2k2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbfGHPb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732229AbfGHPb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:31:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD24620665;
        Mon,  8 Jul 2019 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599887;
        bh=ONtoK3BXZ/toMaRLrlTctSDqZ492BitQ+Z3AMHfxM84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7BTSWC8ktSNbLI2FlQxdg5p2GbouLYKyXJHpSIBCBR4+yxkkOYzZXznzwhOrp2m8
         1pFflH2DEJ7xXaQeCZq+1tzjKetvez4Cb5H3k7HEaMxAJRtHmxoiWlS15O86yngW37
         v3PRnXnivnWJvPUwGvWr2R/aDgGGxBBSJQZ7K+io=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 22/96] drm/mediatek: clear num_pipes when unbind driver
Date:   Mon,  8 Jul 2019 17:12:54 +0200
Message-Id: <20190708150527.653822146@linuxfoundation.org>
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

[ Upstream commit a4cd1d2b016d5d043ab2c4b9c4ec50a5805f5396 ]

num_pipes is used for mutex created in mtk_drm_crtc_create(). If we
don't clear num_pipes count, when rebinding driver, the count will
be accumulated. From mtk_disp_mutex_get(), there can only be at most
10 mutex id. Clear this number so it starts from 0 in every rebind.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 8718d123ccaa..bbfe3a464aea 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -400,6 +400,7 @@ static void mtk_drm_unbind(struct device *dev)
 	drm_dev_unregister(private->drm);
 	mtk_drm_kms_deinit(private->drm);
 	drm_dev_put(private->drm);
+	private->num_pipes = 0;
 	private->drm = NULL;
 }
 
-- 
2.20.1



