Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F93C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2952073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079822;
	bh=vkqTVeoP7Gmqtk/Duna3R/OH1Tk748TwIhp/xbYauV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SKAYx0Hq/+6k2/EJRWCChppawvrM3+3SpdKT5uOngYqTiGPOCjIIf9cLMmfAoYFfp
	 tPg8bJNaA+BUv8PlUFPup/aOdGd2pHmTNI7Gb0q44CCpozkzpZF7Be3b7y7I6Iiy+4
	 VKIPZknYGrx+UPoQg4GuNbqa2pHkNwIaxj8CA2k4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfLKPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:15:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731589AbfLKPOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6605320663;
        Wed, 11 Dec 2019 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077249;
        bh=vkqTVeoP7Gmqtk/Duna3R/OH1Tk748TwIhp/xbYauV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rD6kgdcr9+zaA1vtS7VS+3o/efZdD+d1oPj53uGKkUgBBOE2PEzDJFK6CAqoeBG0O
         YAevbIdJ7OkeWpP9lw1P4CWSIlFMVVJOPFqh4Pl54p8Op20y1zT3TGOjn6TzRBxf65
         Fejw9VMsXyZqA90watdFTg4wP3qrl1gC2Yd1BoSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Deepak Rawat <drawat@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 5.3 073/105] drm: damage_helper: Fix race checking plane->state->fb
Date:   Wed, 11 Dec 2019 16:06:02 +0100
Message-Id: <20191211150252.259403546@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

commit 354c2d310082d1c384213ba76c3757dd3cd8755d upstream.

Since the dirtyfb ioctl doesn't give us any hints as to which plane is
scanning out the fb it's marking as damaged, we need to loop through
planes to find it.

Currently we just reach into plane state and check, but that can race
with another commit changing the fb out from under us. This patch locks
the plane before checking the fb and will release the lock if the plane
is not displaying the dirty fb.

Fixes: b9fc5e01d1ce ("drm: Add helper to implement legacy dirtyfb")
Cc: Rob Clark <robdclark@gmail.com>
Cc: Deepak Rawat <drawat@vmware.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.0+
Reported-by: Daniel Vetter <daniel@ffwll.ch>
Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190904202938.110207-1-sean@poorly.run
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_damage_helper.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -212,8 +212,14 @@ retry:
 	drm_for_each_plane(plane, fb->dev) {
 		struct drm_plane_state *plane_state;
 
-		if (plane->state->fb != fb)
+		ret = drm_modeset_lock(&plane->mutex, state->acquire_ctx);
+		if (ret)
+			goto out;
+
+		if (plane->state->fb != fb) {
+			drm_modeset_unlock(&plane->mutex);
 			continue;
+		}
 
 		plane_state = drm_atomic_get_plane_state(state, plane);
 		if (IS_ERR(plane_state)) {


