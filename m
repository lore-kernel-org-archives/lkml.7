Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F5AC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178492190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfGVR01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:26:27 -0400
Received: from sauhun.de ([88.99.104.3]:42124 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731334AbfGVR0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:11 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id 275FB4A1494;
        Mon, 22 Jul 2019 19:26:10 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] gpu: drm: bridge: analogix-anx78xx: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:09 +0200
Message-Id: <20190722172609.3731-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172609.3731-1-wsa+renesas@sang-engineering.com>
References: <20190722172609.3731-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/gpu/drm/bridge/analogix-anx78xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index 3c7cc5af735c..be7756280e41 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -1350,10 +1350,10 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 
 	/* Map slave addresses of ANX7814 */
 	for (i = 0; i < I2C_NUM_ADDRESSES; i++) {
-		anx78xx->i2c_dummy[i] = i2c_new_dummy(client->adapter,
+		anx78xx->i2c_dummy[i] = i2c_new_dummy_device(client->adapter,
 						anx78xx_i2c_addresses[i] >> 1);
-		if (!anx78xx->i2c_dummy[i]) {
-			err = -ENOMEM;
+		if (IS_ERR(anx78xx->i2c_dummy[i])) {
+			err = PTR_ERR(anx78xx->i2c_dummy[i]);
 			DRM_ERROR("Failed to reserve I2C bus %02x\n",
 				  anx78xx_i2c_addresses[i]);
 			goto err_unregister_i2c;
-- 
2.20.1

