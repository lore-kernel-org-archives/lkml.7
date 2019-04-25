Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E81C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF052084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="EbEVvKpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfDYXTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:19:21 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45644 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYXTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1556234357; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kkzXoVmj9Y9EGf7wfTEm385M7zBToZLwy97XnNzQF0=;
        b=EbEVvKpdiCdTyIaaHKDD7T+HXSl4le/DoZ2JoxTxAhpqjPnuseBmrbWSVrLAuAh7dP8TPr
        qs7+cq9c74NMvKvzh+MQ3DiYW+RkSqxkLZZ4PsXac5VvRaGdOiPf3LCXqgagbKvSzby02c
        dtwqA6hmZmxZQPVpdEdroEQw4/Hz5kE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 2/3] drm: Add bus flag for Sharp-specific signals
Date:   Fri, 26 Apr 2019 01:18:53 +0200
Message-Id: <20190425231854.24479-2-paul@crapouillou.net>
In-Reply-To: <20190425231854.24479-1-paul@crapouillou.net>
References: <20190425231854.24479-1-paul@crapouillou.net>
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

 include/drm/drm_connector.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 02a131202add..ac7d58fd1e03 100644
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

