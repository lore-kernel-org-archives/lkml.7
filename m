Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4083BC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF0620873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfGRNm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:42:57 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRNm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:42:57 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MysFQ-1ib6Sk0g0g-00vua9; Thu, 18 Jul 2019 15:42:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: fix RC_CORE dependency
Date:   Thu, 18 Jul 2019 15:42:24 +0200
Message-Id: <20190718134240.2265724-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LalC3fueD8ns/zVd1zUacsqU9/+XR1XYXbOtp5D2bbPKXX/+BVp
 pih72gFX2h3gXxMbIh6oAihZdwH+/zSdgbm4Y7bfVsDmTY6G5T3jf7i2UeGAM3F7/NhQS7x
 +uktKDqfLMK3uI0kgmWZoIlXK1TVxNOL/rDWwUnatfP7uVfpGNnlQOBWndwsJJ+XqMr5b1c
 P3Pgiqsmjam1WjkypwzAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SL2m0TBWswY=:c4RPZmLcftwWBIHOBql1ST
 Aj7g3NbIsK/RqoAvvZS4zv14zCFTUDURjXMcPEpPoL1ANhtfgPatR8MDdJGEXACdmtI6OiUJP
 KpfO9ZJiqVnUgz8M6plbm/SErsdODRZsN76lQ8PWs02Kk8hgpgPpKvgQ7EUV1gNfFSVz5c9FW
 vcM8zBE/RJR1sY1BBMEWrAwVWhXm5djLGsW8whrHOH+YNhi24tnCYlOFcpeGTxtNfk1xPb5re
 nyRGtqVVA/6oahbrPJKVDKxkSXojMfwZN2iqo4XXdDLHHbkVURnMYlDHSfK2qN83BehQvvAEf
 pd+h/0SmQef8O4SmrUOTq+VO7P4q1XV+tWsCSNAEzQltgZlE+EvF3D+djKDVpxuS8OMTUh/J/
 eKS6dSAXzHuiZXiMNe8vEwCfsRQ/rX2uom7j8scK3y4Vts9evB3QQy8xMtjNolJ5UbWznAPtr
 R3S/hr+Ljg1UEbumD/AcnWjZU7J4LiUmH9JpXntzT8HliOc3nww+G45i00fIKlBLMUc93BZhw
 NRzpOAeLwAxn+3bx/jeUWDlIghYldlztzWIMdbG568tJC9zAJcOnoVzh1gdRtdg0c4s64blVF
 rc+yMf+XJmkdWXS/whosAHGE8zySqupOx1bFq/3vsBBvdGkurVRMrTUVaIE/VooOK5jlH4c44
 ar19zSgnKQiIa7F4tTC13ZBjYTnLecbEygJDs2KlNSAUlvRS17+6bUnPymbvi0WozPJSwEzCK
 13nxZFneJ+klscHMykjxh6SU23zJzYiwBVf00A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'imply' causes a new problem, as it allows the case of
CONFIG_INPUT=m with RC_CORE=y, which fails to link:

drivers/media/rc/rc-main.o: In function `ir_do_keyup':
rc-main.c:(.text+0x2b4): undefined reference to `input_event'
drivers/media/rc/rc-main.o: In function `rc_repeat':
rc-main.c:(.text+0x350): undefined reference to `input_event'
drivers/media/rc/rc-main.o: In function `rc_allocate_device':
rc-main.c:(.text+0x90c): undefined reference to `input_allocate_device'

Add a 'depends on' that allows building both with and without
CONFIG_RC_CORE, but disallows combinations that don't link.

Fixes: 5023cf32210d ("drm/bridge: make remote control optional")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index f64c91defdc3..70a8ed2505aa 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -85,8 +85,8 @@ config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
 	depends on OF
 	select DRM_KMS_HELPER
+	depends on RC_CORE || !RC_CORE
 	imply EXTCON
-	imply RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
 
-- 
2.20.0

