Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530CFC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324292173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfFNOjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:39:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49259 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfFNOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:39:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hbnMF-0006G2-Pz; Fri, 14 Jun 2019 14:39:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/mgag200: add in missing { } around if block
Date:   Fri, 14 Jun 2019 15:39:11 +0100
Message-Id: <20190614143911.21806-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an if block that is missing the { } curly brackets. Add
these in.

Addresses-Coverity: ("Structurally dead code")
Fixes: 94dc57b10399 ("drm/mgag200: Rewrite cursor handling")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/mgag200/mgag200_cursor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_cursor.c b/drivers/gpu/drm/mgag200/mgag200_cursor.c
index f0c61a92351c..117eaedec7aa 100644
--- a/drivers/gpu/drm/mgag200/mgag200_cursor.c
+++ b/drivers/gpu/drm/mgag200/mgag200_cursor.c
@@ -99,10 +99,11 @@ int mga_crtc_cursor_set(struct drm_crtc *crtc,
 
 	/* Pin and map up-coming buffer to write colour indices */
 	ret = drm_gem_vram_pin(pixels_next, 0);
-	if (ret)
+	if (ret) {
 		dev_err(&dev->pdev->dev,
 			"failed to pin cursor buffer: %d\n", ret);
 		goto err_drm_gem_vram_kunmap_src;
+	}
 	dst = drm_gem_vram_kmap(pixels_next, true, NULL);
 	if (IS_ERR(dst)) {
 		ret = PTR_ERR(dst);
-- 
2.20.1

