Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D02C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFFF217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368357;
	bh=uHfEdp+sQctZzGHNpvJhFMzN4aZjylMxH3g3CAc5tAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ysnCE9+ygIdXViN0iCBLZ0tyJHlStezm0BKR5+XX6oqqsNbkqVFSn4O03L3E09RLu
	 R7+XVVfIGmaGBucjSso24uoLKbiKcpkkInstfMyhdtoGeqXW7+pttM2yyx4CteIS4t
	 AcDbkIP+aD7ZpmnT95SX4GREAioutxEUFLnSUJaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbfDDI7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbfDDI7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:59:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C070E21741;
        Thu,  4 Apr 2019 08:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368351;
        bh=uHfEdp+sQctZzGHNpvJhFMzN4aZjylMxH3g3CAc5tAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGuh5BWm132/cH5khn6rUaScgGGthqoclRfjI0PBaw0lLmZLjR1s/vciGLDJk4cu2
         voRWEqVLdjdf/c3oRuE7UQw1gf/71MAbQJV/EHaOBHSrYRIfDGSvuAUE4PeNdayeMo
         mbc3nwjXfLmB9QbG3ZW6i4RjSZc9A4pTuW5V51aU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 112/121] drm: Auto-set allow_fb_modifiers when given modifiers at plane init
Date:   Thu,  4 Apr 2019 10:48:20 +0200
Message-Id: <20190404084551.332045960@linuxfoundation.org>
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
index 7a00351d5b5d..71186bf90760 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -203,6 +203,9 @@ int drm_universal_plane_init(struct drm_device *dev, struct drm_plane *plane,
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



