Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA6B20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429534;
	bh=uPp4tapojiNozBdE6upd4Gpo8ntR3WWdTAio4QDbu9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dl+OglenE20riwQ73qTRaV45eSh116hp94VRm9+6u8fM++OV2PVb/1KpMTc4GtxZY
	 KwbWOf4TIy0HUJmDtz3ZOwHZHzEzTbo7Rszvn1XgMk1EaR8hbSaiglf7CkrriJlTYH
	 YGIojHou2w+FEuPBm3a9Dkw//RK8FsmmkPIEYOBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfG2Tp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389945AbfG2TpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:45:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD9812054F;
        Mon, 29 Jul 2019 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429524;
        bh=uPp4tapojiNozBdE6upd4Gpo8ntR3WWdTAio4QDbu9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFgNEDWbLLTvf3mgJimVcvk9ytHFlNkQgwbhsY2EEsE0I3xB2lj4x+QQkLmBFAU2P
         1Mg4ObWOgeBf4XlsWG3z9H1dOWlMZ80tkCJdyQfiPQWCNutusFGQfy+L/zwGtHdkGu
         6c7FVU96qrGLTziainCNBWO92tqojzBze0wcS4Fg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 012/215] drm/bochs: Fix connector leak during driver unload
Date:   Mon, 29 Jul 2019 21:20:08 +0200
Message-Id: <20190729190741.665670375@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3c6b8625dde82600fd03ad1fcba223f1303ee535 ]

When unloading the bochs-drm driver, a warning message is printed by
drm_mode_config_cleanup() because a reference is still held to one of
the drm_connector structs.

Correct this by calling drm_atomic_helper_shutdown() in
bochs_pci_remove().

Fixes: 6579c39594ae ("drm/bochs: atomic: switch planes to atomic, wire up helpers.")
Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Link: http://patchwork.freedesktop.org/patch/msgid/93b363ad62f4938d9ddf3e05b2a61e3f66b2dcd3.1558416473.git.sbobroff@linux.ibm.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index b86cc705138c..d8b945596b09 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_atomic_helper.h>
 
 #include "bochs.h"
 
@@ -171,6 +172,7 @@ static void bochs_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	drm_atomic_helper_shutdown(dev);
 	drm_dev_unregister(dev);
 	bochs_unload(dev);
 	drm_dev_put(dev);
-- 
2.20.1



