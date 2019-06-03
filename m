Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142BEC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D473F2792D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ktxaZJIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfFCPbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:31:34 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55050 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfFCPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559575889; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCRtvN6bDnPOtOpR9F9ADHP2LKTTl3otOLpu3pQeu+A=;
        b=ktxaZJIAidgdHSgYp+cBaMNV4v9rUFSErAAMlKgHDebwaDqRMIpGq/QBgbQNLqEEx26BVA
        6cUkMT4y95ODpQeKAyRWT8p7h5qWbunEhBzK+IhKwcJhqT0xYj5T8B5s3mSN9OFt/OjrY6
        dUhmCsd+VN7OUfmIzdMjTaWyLRRK8uA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 2/3] drm: Add bus flag for Sharp-specific signals
Date:   Mon,  3 Jun 2019 17:31:19 +0200
Message-Id: <20190603153120.23947-2-paul@crapouillou.net>
In-Reply-To: <20190603153120.23947-1-paul@crapouillou.net>
References: <20190603153120.23947-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DRM_BUS_FLAG_SHARP_SIGNALS to the drm_bus_flags enum.

This flags can be used when the display must be driven with the
Sharp-specific signals SPL, CLS, REV, PS.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v3: New patch
    
    v4: Rebase on drm-misc-next (b232d4ed92ea)

 include/drm/drm_connector.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 547656173c74..5861367f7339 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -323,6 +323,8 @@ enum drm_panel_orientation {
  *					edge of the pixel clock
  * @DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE:	Sync signals are sampled on the falling
  *					edge of the pixel clock
+ * @DRM_BUS_FLAG_SHARP_SIGNALS:		Set if the Sharp-specific signals
+ *					(SPL, CLS, PS, REV) must be used
  */
 enum drm_bus_flags {
 	DRM_BUS_FLAG_DE_LOW = BIT(0),
@@ -341,6 +343,7 @@ enum drm_bus_flags {
 	DRM_BUS_FLAG_SYNC_DRIVE_NEGEDGE = DRM_BUS_FLAG_SYNC_NEGEDGE,
 	DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE = DRM_BUS_FLAG_SYNC_NEGEDGE,
 	DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE = DRM_BUS_FLAG_SYNC_POSEDGE,
+	DRM_BUS_FLAG_SHARP_SIGNALS = BIT(8),
 };
 
 /**
-- 
2.21.0.593.g511ec345e18

