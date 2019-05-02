Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190CAC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E5D20C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811077;
	bh=ru9PthWpGSsmfn/1Nkaxy2u/a7UwNK0Wh9OvzJQUUtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1kLMAyBWLlAkaDLDwWHN+MU+nFaydl9TQ5JVc8skZ9rKgn38c84xM4u9V2ZmavFEG
	 Wh2aAQBEuORvye6wmc7nOUMRE2JX+vA832Lxa66BeiifuF0D7vmMIQUymiC19uR8uQ
	 inQ5Rv3QSjm6WiHoeUmAjoUyCn0epHKgUZ67LFOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfEBPbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbfEBPbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:31:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D3B321670;
        Thu,  2 May 2019 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811068;
        bh=ru9PthWpGSsmfn/1Nkaxy2u/a7UwNK0Wh9OvzJQUUtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3nwdl7rABcH9I1IwUS6zdDGnuILnuN5iIovc1UjdXHMdRyJsaX/MMcZBbqhW7rVY
         7N5OZlQe5YSLVWF+LpwSqfittoiwmCQ1OQbUPOJDtJ8I5VX1/z3hMNcVGUmfe85fCi
         PZoaKOKv0mawnzn4mP9BAbeiHQksXPlYfMKzac9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 061/101] drm/meson: Fix invalid pointer in meson_drv_unbind()
Date:   Thu,  2 May 2019 17:21:03 +0200
Message-Id: <20190502143343.766148944@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



