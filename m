Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FF5C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD63C214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922621;
	bh=kk6m7oqgxlpf6vd45ai+mnWZ/Nc5zkaoohWgJWYbBwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xvwCE/u3kcgmvLfc1Ubjis2MWndXT28mY20oxjyXUcTMRuRlGoUl/fXalSnoIIN4h
	 ANaTOMeSmPZlSZ7OoHCQ9yoTRT3mDybwGNzMUX67l3x3mDxVUgpgZZQv61PRyANNSP
	 Nz7IUcqX4Pih7M2ZbnMJAhH+dwY96yeY4IL312eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbfFGPuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbfFGPuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:50:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB9F120657;
        Fri,  7 Jun 2019 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922618;
        bh=kk6m7oqgxlpf6vd45ai+mnWZ/Nc5zkaoohWgJWYbBwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNEpvVTwJX22tlhYpebBCJUIy1lT2iPzzClttF22BZsQQ3CDqYLjUsx4lDZd7PTBV
         485bqbM+JfM4V1NZS3jtZlPLr1n2iz+Oxy1s2QTRpclNlmY2mC9IpiYckC+D5tNnqY
         +SVYJQBGue6meC6Jh52hhWmrO0J25rrBUAvYAptg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 5.1 78/85] drm/fb-helper: generic: Call drm_client_add() after setup is done
Date:   Fri,  7 Jun 2019 17:40:03 +0200
Message-Id: <20190607153857.634347024@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noralf Trønnes <noralf@tronnes.org>

commit 6e3f17ee73f7e3c2ef0e2c8fd8624b2ece8ef2c9 upstream.

Hotplug can happen while drm_fbdev_generic_setup() is running so move
drm_client_add() call after setup is done to avoid
drm_fbdev_client_hotplug() running in two threads at the same time.

Fixes: 9060d7f49376 ("drm/fb-helper: Finish the generic fbdev emulation")
Cc: stable@vger.kernel.org
Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20190401141358.25309-1-noralf@tronnes.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_fb_helper.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -3317,8 +3317,6 @@ int drm_fbdev_generic_setup(struct drm_d
 		return ret;
 	}
 
-	drm_client_add(&fb_helper->client);
-
 	if (!preferred_bpp)
 		preferred_bpp = dev->mode_config.preferred_depth;
 	if (!preferred_bpp)
@@ -3329,6 +3327,8 @@ int drm_fbdev_generic_setup(struct drm_d
 	if (ret)
 		DRM_DEV_DEBUG(dev->dev, "client hotplug ret=%d\n", ret);
 
+	drm_client_add(&fb_helper->client);
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_fbdev_generic_setup);


