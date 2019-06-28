Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6C2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E931205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfF1KeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:34:13 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfF1KeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:34:13 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M4JVv-1hgX5U2JRx-000Hmo; Fri, 28 Jun 2019 12:34:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/armada: fix debugfs link error
Date:   Fri, 28 Jun 2019 12:33:40 +0200
Message-Id: <20190628103359.2516007-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yDMdCFNWi3eU4ukD4Asr7J3rQl5xwCdYhWLt3CtMOZ0hUYFIVP0
 TN6nF1GWbhjRGe5AH0LiQ9iSfgDYTsV5YQjtAF49GKiyIbUdB56yLZ4vgitW4ndREs6VNRr
 XkiMQi+73hO8i64aUnRo/CspzmUQgF20+bQmrefYvEus5jIt2eFZjWVmUDp6cEgTjB1F9zd
 +4QDLSFXVhUEWpYEMDfrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WII6mkT31vU=:BJ3SdIyV3vMTpydYamkxj3
 DQJ7SUbnIXLT8VuLoKVLblLnbDI/iGV1QFIjaBputIyypzuRsuVz9SoAlCRLZ0/V/49TaYKc8
 g9mMlRbYjtcoiraCXQawDU1tgPJdFXcJacv4m/RjC4LLVYx7SlSid2m2isZdt6n+L73VZGUfu
 8ioGU3ZxwLRLzKHaXWU6tdGGoopQJNsjIcQ9hw99N05MOXgYYwoWRkn7LUCNC7c9MZgh18DJ4
 mKQR1DRFJvFfDvhkD4LpmqUasp17SZTasN1iJ6FuR5L2VxnhDjWuw3/vnKjf4Ug8vlCsHtiDy
 OjPFGIzKi5jJlrsy3DctMBgmhARIee2QXsmXgfuILwzFDiHE2A5WpKV7VIYjik8xTRCwvsBiP
 fz1+vTdI6Xyd5IpWY+DC9y1xzqjE0SPPruvX5zexTObFOr+88SMPl1qA64vPZf16/vlRglbsR
 sXYGwz4ZmOybPKI8ZdQAsjFamsQVgpOTmmk0bq+c0VyvfmK7LrkRqhQ8oNSLsIlUC3JozMH0x
 igINaxkEZXuOUsTL2GRbwDlF96yGL4yW/tqSjTb5GXP8aqdcdi4VCPd+Bg5l6iHhLEKMnp5Fp
 NMBPKaRjnrpayLeo+YSvO6KE0WEtDA14YWtMZoHKKyA6MIwbrcTYg4RSSMpJ0R9JBNBG/nV+R
 aVS21HUCWOrZEQzN53AdaIAUS+44q1TKitFQCJj9sdyIsRoaXJZKwdSGJtGiP+V5C1WahM5N1
 TFkifZmoEny1NieOKP1F0CNeCChPt83nYiyOkg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugfs can be disabled at compile time, causing a link error
with the newly restructured code:

drivers/gpu/drm/armada/armada_crtc.o: In function `armada_drm_crtc_late_register':
armada_crtc.c:(.text+0x974): undefined reference to `armada_drm_crtc_debugfs_init'

Make the code into the debugfs init function conditional.

Fixes: 05ec8bd524ba ("drm/armada: redo CRTC debugfs files")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/armada/armada_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index e3a5964d8a65..03d3fd00fe00 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -773,7 +773,9 @@ static void armada_drm_crtc_destroy(struct drm_crtc *crtc)
 
 static int armada_drm_crtc_late_register(struct drm_crtc *crtc)
 {
-	armada_drm_crtc_debugfs_init(drm_to_armada_crtc(crtc));
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		armada_drm_crtc_debugfs_init(drm_to_armada_crtc(crtc));
+
 	return 0;
 }
 
-- 
2.20.0

