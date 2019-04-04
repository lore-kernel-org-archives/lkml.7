Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3488BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BE721872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368335;
	bh=il3rizSI9p2oH0wH/AP/sk9DXfGPEAtec6qBxzPhQRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GZq9h9823x6qeqhFKi0cB1Ab9566BEtH3/dUD3DWXfNRuUxDqHA+wBgGUvjdy+dQX
	 vYcI2iRC2WHuA6fCy5yqK2qpJWhMjH5a5gTxK5bXDauVJaGc3S6vC7qP5fGhJhWw8c
	 EJl+mcgKr2YGM1gp/2XmG8o8ghfh+i9rqF4bWXUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfDDI6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbfDDI6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:58:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F15E2177E;
        Thu,  4 Apr 2019 08:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368327;
        bh=il3rizSI9p2oH0wH/AP/sk9DXfGPEAtec6qBxzPhQRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1crH89KKzCFp1x7z8fzg5iQ7dWUmgiQQIUAbt7szJd8niIDYe/wgMdjRCBxlYLENA
         jWHeNk8zShcfxVSNUqP3a3LPhrVcFurzVT9sWOkA21BuRtzb1j1lRhf4cqyfLQ6bhu
         zx9mr+7MblN67ltYeDixq/ZaYJX592lr3r+QQMkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 113/121] drm/nouveau: Stop using drm_crtc_force_disable
Date:   Thu,  4 Apr 2019 10:48:21 +0200
Message-Id: <20190404084551.382906560@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 934c5b32a5e43d8de2ab4f1566f91d7c3bf8cb64 ]

The correct way for legacy drivers to update properties that need to
do a full modeset, is to do a full modeset.

Note that we don't need to call the drm_mode_config_internal helper
because we're not changing any of the refcounted paramters.

v2: Fixup error handling (Ville). Since the old code didn't bother
I decided to just delete it instead of adding even more code for just
error handling.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com> (v1)
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181217194303.14397-2-daniel.vetter@ffwll.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 6d99f11fee4e..4bc8e9fe3095 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -750,7 +750,9 @@ static int nv17_tv_set_property(struct drm_encoder *encoder,
 		/* Disable the crtc to ensure a full modeset is
 		 * performed whenever it's turned on again. */
 		if (crtc)
-			drm_crtc_force_disable(crtc);
+			drm_crtc_helper_set_mode(crtc, &crtc->mode,
+						 crtc->x, crtc->y,
+						 crtc->primary->fb);
 	}
 
 	return 0;
-- 
2.19.1



