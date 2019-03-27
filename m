Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B7EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9F12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710562;
	bh=O0wDP1jtDCbk/j3iImVCP0Rk1gOZStQWkpcI2ft03Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TDddjglr7YkzO6krRpnWy/f29tmu9I7qY9CW7ZNLFR+t1d9wfha3cB7NZXchFazLc
	 5XMyEdP6M4x8GIVKR5QRn/Db6bMdHIEUj5f8lx10PHWnuNq9+Y9pTMoeoYqE4a4iNk
	 hdonhWe90S+C3poqoKtSkBkGdmZ5DZiKh2bAiGyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbfC0SQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389948AbfC0SPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15E92183E;
        Wed, 27 Mar 2019 18:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710555;
        bh=O0wDP1jtDCbk/j3iImVCP0Rk1gOZStQWkpcI2ft03Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRODjLOumFE5+ZQI6zKRaDKdP8bftY7+2B8wodYGsnMmmoL004V3EBboXIAKh+e38
         Exjpx4v6QXIPnvqynL+NElxD89YBnC0VUGeaHOYoiCitclLcTScNXKe+PB/SYlV7j+
         05ndctd+YP+h3ye88wLZSD0C606PfmmPNt+X32tY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 176/192] drm: Auto-set allow_fb_modifiers when given modifiers at plane init
Date:   Wed, 27 Mar 2019 14:10:08 -0400
Message-Id: <20190327181025.13507-176-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit 890880ddfdbe256083170866e49c87618b706ac7 ]

When drivers pass non-empty lists of modifiers for initializing their
planes, we can infer that they allow framebuffer modifiers and set the
driver's allow_fb_modifiers mode config element.

In case the allow_fb_modifiers element was not set (some drivers tend
to set them after registering planes), the modifiers will still be
registered but won't be available to userspace unless the flag is set
later. However in that case, the IN_FORMATS blob won't be created.

In order to avoid this case and generally reduce the trouble associated
with the flag, always set allow_fb_modifiers when a non-empty list of
format modifiers is passed at plane init.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190104085610.5829-1-paul.kocialkowski@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 6153cbda239f..d36b1be632d9 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -211,6 +211,9 @@ int drm_universal_plane_init(struct drm_device *dev, struct drm_plane *plane,
 			format_modifier_count++;
 	}
 
+	if (format_modifier_count)
+		config->allow_fb_modifiers = true;
+
 	plane->modifier_count = format_modifier_count;
 	plane->modifiers = kmalloc_array(format_modifier_count,
 					 sizeof(format_modifiers[0]),
-- 
2.19.1

