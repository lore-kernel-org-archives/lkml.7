Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E55AC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93F02085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810896;
	bh=103IIVtV6+xh/OXIIjA/YpQjaO27tWWfkEtJ1a/NFaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n1Ry3a2E7opAQlIUbSSJ5+83GW6LPXTKqXun4isiw3CKMpJdUVlsB/hWldsPlJ+PA
	 TfoIoCTMIsSZZ/w6IzOjnNGsYWq39qnjyuVp7e5NDsuj/TcbrwmsXofZ7qXd2e0JuW
	 0m2CtFn4IM1Zb/B0qVJva4V3WadLqfFU56MU2L/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfEBP2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbfEBP2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:28:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D682081C;
        Thu,  2 May 2019 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810890;
        bh=103IIVtV6+xh/OXIIjA/YpQjaO27tWWfkEtJ1a/NFaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txRNBnctveZjAuEow8FXatEKowC9RRvzDqh6+opG5l5b5joT+wcK6xrpdwhNvvHzy
         43JSTkfLQsvjMpJf+YwvRpYDIftfjs8Vs42hIEOJQ50t24uFaJIImwEB2HBlyNY31D
         RfIuRyIlJua+8UTRL1KMkI9HEdZcywd9ZQRv0F10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 51/72] drm/meson: Fix invalid pointer in meson_drv_unbind()
Date:   Thu,  2 May 2019 17:21:13 +0200
Message-Id: <20190502143337.487724584@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
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
index 611ac340fb28..4a72fa53a1d5 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -317,8 +317,8 @@ static int meson_drv_bind(struct device *dev)
 
 static void meson_drv_unbind(struct device *dev)
 {
-	struct drm_device *drm = dev_get_drvdata(dev);
-	struct meson_drm *priv = drm->dev_private;
+	struct meson_drm *priv = dev_get_drvdata(dev);
+	struct drm_device *drm = priv->drm;
 
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
-- 
2.19.1



