Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B1FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC5220B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810907;
	bh=Q984PhZJaqWQhoxwI2oOnGJKlVH9apJtEXUjudJ3Zlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iyXSGUBDYG/3A1vqB0hX1CuMhJp/Q3O6Wxb6kIvHXLg9Dk+TTr6PhmY1bAWHJzkHy
	 how+bJIGkJNN4oLaFd+/tgpbhLAIhhaO+eTQUkb5V//oQVaXmV9mVTELBmUroJgrlZ
	 bYtKVDxBfAc/ScJ1tcxMyHHui606zfc+98Cs5rUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfEBP20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfEBP2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:28:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05FB8216FD;
        Thu,  2 May 2019 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810903;
        bh=Q984PhZJaqWQhoxwI2oOnGJKlVH9apJtEXUjudJ3Zlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QusinD/Por2o7JKochmdAwRsS4yUJHXy5zP0Pe8hAxm/oTRhWlILkrZe07M9FeVYE
         vtG42CVn+bnYJh0xi0/QnpvsiJXew2G1I3ecXWoAIHVDXPhHsqME6cwXvByxmdG5XA
         gfjWvfr/4tHURBq3aysUn3WY9cn0KYR6ZKb21QGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 52/72] drm/meson: Uninstall IRQ handler
Date:   Thu,  2 May 2019 17:21:14 +0200
Message-Id: <20190502143337.548443721@linuxfoundation.org>
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



