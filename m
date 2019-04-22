Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EF0C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458BC204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963689;
	bh=FuDcAin+IjuMiPtgjpgAA5UrwqlL8qLDmzQSajn3e9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qm1WN3f3LmZUkGzBur3yqunY1LPA64hCorPXd3CvZ+UAow2lIbcDB6x1MzcooFjL8
	 pasqeOf169xqEUmNRgDhKttXyA20I1XEDFL798cOjFDQx4Y+1HKUdKKTFAy8Q7sBzg
	 QpoJNAx/xBTSEk75X4UC2iupUiZemBjOcgHYML+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfDVTn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbfDVTn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:43:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8C521901;
        Mon, 22 Apr 2019 19:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962236;
        bh=FuDcAin+IjuMiPtgjpgAA5UrwqlL8qLDmzQSajn3e9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLOnVKpXsVm/qqo2NmIC8Mmr8x4Lz+PCpa7+WlBruiYcVFaQxQi0syM2L6q0Jt2ms
         xRAbhuxSArNN9cISmKGN/JPxg5tpAVutFwnaWjiyCPexkbs9T9W/8W0nDKhk9CdBiN
         nsOKtB4AOLaLwN4A2gitWLPGfAiI86j+zEE/PiA0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 56/98] drm/meson: Fix invalid pointer in meson_drv_unbind()
Date:   Mon, 22 Apr 2019 15:41:23 -0400
Message-Id: <20190422194205.10404-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

[ Upstream commit 776e78677f514ecddd12dba48b9040958999bd5a ]

meson_drv_bind() registers a meson_drm struct as the device's privdata,
but meson_drv_unbind() tries to retrieve a drm_device. This may cause a
segfault on shutdown:

[ 5194.593429] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000197
 ...
[ 5194.788850] Call trace:
[ 5194.791349]  drm_dev_unregister+0x1c/0x118 [drm]
[ 5194.795848]  meson_drv_unbind+0x50/0x78 [meson_drm]

Retrieve the right pointer in meson_drv_unbind().

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190322152657.13752-1-jean-philippe.brucker@arm.com
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 12ff47b13668..c1115a96453f 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -336,8 +336,8 @@ static int meson_drv_bind(struct device *dev)
 
 static void meson_drv_unbind(struct device *dev)
 {
-	struct drm_device *drm = dev_get_drvdata(dev);
-	struct meson_drm *priv = drm->dev_private;
+	struct meson_drm *priv = dev_get_drvdata(dev);
+	struct drm_device *drm = priv->drm;
 
 	if (priv->canvas) {
 		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
-- 
2.19.1

