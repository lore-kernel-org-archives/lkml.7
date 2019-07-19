Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399E6C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06355206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510817;
	bh=Ieid9JHW9cHMr72tyAO8o2PtFtDA8gd5V7g1Ll5dUiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FcNvsPdPzc3UMUz2tr9E+IBekiIKCmNyRaGm8EoDNRIvvtCAcRXnkmA8r1l8E2Eqq
	 QMtDlC0V1prdv76ZZ+yvd02Ce/0yu0HlFim8gnaen3Ba+R0k4wcSl9BCMnkQ3X8M/m
	 0uPgFHFb68jLWAc5j/MoQb0KyTVGmQ+Vn2h5a8HE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbfGSEdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfGSEDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:03:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E71021873;
        Fri, 19 Jul 2019 04:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508979;
        bh=Ieid9JHW9cHMr72tyAO8o2PtFtDA8gd5V7g1Ll5dUiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5bh6m6QcjrG5vQWsN4S8rVrnF6Ec1on8w5uBKEP6KyCSn6i0ePNhVsCBNTaBFk05
         TxxkXvdEtoP0OiaM5k2C3YJpdTKBaZY2w1eoYDTBrJIySVx7ttWArbRMe/3/YpcUkF
         tARG5e898EUGyQagetpbbBIEeCXb3bO9eP6vGQeA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 007/141] drm/bochs: Fix connector leak during driver unload
Date:   Fri, 19 Jul 2019 00:00:32 -0400
Message-Id: <20190719040246.15945-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

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
index 6b6e037258c3..7031f0168795 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_atomic_helper.h>
 
 #include "bochs.h"
 
@@ -174,6 +175,7 @@ static void bochs_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	drm_atomic_helper_shutdown(dev);
 	drm_dev_unregister(dev);
 	bochs_unload(dev);
 	drm_dev_put(dev);
-- 
2.20.1

