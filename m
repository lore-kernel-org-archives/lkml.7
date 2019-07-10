Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D36C73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A794520651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfGJFEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:04:42 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:43564 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbfGJFEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:04:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 25A6A18224D98;
        Wed, 10 Jul 2019 05:04:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: low85_b4e0cac78b5d
X-Filterd-Recvd-Size: 1713
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 05:04:37 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] drm: aspeed_gfx: Fix misuse of GENMASK macro
Date:   Tue,  9 Jul 2019 22:04:16 -0700
Message-Id: <cddd7ad7e9f81dec1e86c106f04229d21fc21920.1562734889.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
index a10358bb61ec..095ea03e5833 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
@@ -74,7 +74,7 @@ int aspeed_gfx_create_output(struct drm_device *drm);
 /* CTRL2 */
 #define CRT_CTRL_DAC_EN			BIT(0)
 #define CRT_CTRL_VBLANK_LINE(x)		(((x) << 20) & CRT_CTRL_VBLANK_LINE_MASK)
-#define CRT_CTRL_VBLANK_LINE_MASK	GENMASK(20, 31)
+#define CRT_CTRL_VBLANK_LINE_MASK	GENMASK(31, 20)
 
 /* CRT_HORIZ0 */
 #define CRT_H_TOTAL(x)			(x)
-- 
2.15.0

