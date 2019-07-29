Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66601C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342A92171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429085;
	bh=KJf2K2UdkZTGt+0mCo4df6+uIaLto5eUYkcRQ8ZM+Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ch/B6iTn9O1sqm1xCKJWvutXsp4LxDuvCnC5FAV2gpSyWpPnCtrrt6a9hX9SclcFW
	 soKLHI8Angv/BuS2Qd8s/h3+kq0Fhb/F4+1SVJGnVrBs3oz4CHwbrz8XzM9af7ZCE2
	 dwzcTSIEcTqaq9OfCVriXmBZibGftF4CcdIFgDMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388828AbfG2TiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388437AbfG2TiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:38:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96DC2171F;
        Mon, 29 Jul 2019 19:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429080;
        bh=KJf2K2UdkZTGt+0mCo4df6+uIaLto5eUYkcRQ8ZM+Rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/hPW1vwK1CB+RKtrY0TBiJNfHtnjkYKclF7WLLFS9zsy3Wez9h2MLcrxvSSzIyc9
         M51B79wW3mx3d5BtMoZqzzO5IIN7hadk3DXJnzvrUEYERvb9jss6kpmkTXVctTEp8Y
         xNdO6j/Ywxzd6UPvvKvhn0yT7ajf5TcX9u8gYs+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 279/293] drm/crc-debugfs: Also sprinkle irqrestore over early exits
Date:   Mon, 29 Jul 2019 21:22:50 +0200
Message-Id: <20190729190845.641798943@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d99004d7201aa653658ff2390d6e516567c96ebc ]

I. was. blind.

Caught with vkms, which has some really slow crc computation function.

Fixes: 1882018a70e0 ("drm/crc-debugfs: User irqsafe spinlock in drm_crtc_add_crc_entry")
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Emil Velikov <emil.velikov@collabora.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190606211544.5389-1-daniel.vetter@ffwll.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_debugfs_crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index f689c75474e5..2901b7944068 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -366,7 +366,7 @@ int drm_crtc_add_crc_entry(struct drm_crtc *crtc, bool has_frame,
 
 	/* Caller may not have noticed yet that userspace has stopped reading */
 	if (!crc->entries) {
-		spin_unlock(&crc->lock);
+		spin_unlock_irqrestore(&crc->lock, flags);
 		return -EINVAL;
 	}
 
@@ -377,7 +377,7 @@ int drm_crtc_add_crc_entry(struct drm_crtc *crtc, bool has_frame,
 		bool was_overflow = crc->overflow;
 
 		crc->overflow = true;
-		spin_unlock(&crc->lock);
+		spin_unlock_irqrestore(&crc->lock, flags);
 
 		if (!was_overflow)
 			DRM_ERROR("Overflow of CRC buffer, userspace reads too slow.\n");
-- 
2.20.1



