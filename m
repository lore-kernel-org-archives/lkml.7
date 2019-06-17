Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADB2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD4E20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806413;
	bh=QJf27Qb/dJuewX1xtCeVJs7PldHnm/zNe9TQQdObKf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NOZw03oEPUTgKns7QagAO43xxCv1s8xefcWi64tck/ATfRuNgMJb2Ncq5FnUj71RP
	 CM882jnz+wvWVJxc3d/ARlyeNusU93bCte4Jj8In7kSuwIuX1BVQPUc9+vo1yrr20Y
	 hwvM+hZTj6gvT4SmqzOUxEk0HKQdbL/awk0lorls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfFQVUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfFQVUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:20:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1960D20B1F;
        Mon, 17 Jun 2019 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806409;
        bh=QJf27Qb/dJuewX1xtCeVJs7PldHnm/zNe9TQQdObKf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgETYPXX4MM5aBVZl8qjnuadRH8SwaP/VhJOfSUQd6vH3uGzPBNpk22eqXoTQbuth
         xShcYT4lD56X4HkYuQqhCGlVrZUowdY73lx18J0z6z8h23T5DFH0ypbBi6a1sL1iuP
         hmKlf3mfrMAp6CP+TJoPQhHY12GSP3ADOhZ9iGRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Heinrich Fink <heinrich.fink@daqri.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.1 040/115] drm/i915: Fix per-pixel alpha with CCS
Date:   Mon, 17 Jun 2019 23:09:00 +0200
Message-Id: <20190617210802.066159118@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 77ce94dbe586c1a6a26cf021c08109c9ce71b3e0 upstream.

We forgot to set .has_alpha=true for the A+CCS formats when the code
started to consult .has_alpha. This manifests as A+CCS being treated
as X+CCS which means no per-pixel alpha blending. Fix the format
list appropriately.

Cc: stable@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Heinrich Fink <heinrich.fink@daqri.com>
Reported-by: Heinrich Fink <heinrich.fink@daqri.com>
Tested-by: Heinrich Fink <heinrich.fink@daqri.com>
Fixes: b20815255693 ("drm/i915: Add plane alpha blending support, v2.")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190603142500.25680-1-ville.syrjala@linux.intel.com
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
(cherry picked from commit 38f300410f3e15b6fec76c8d8baed7111b5ea4e4)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_display.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -2444,10 +2444,14 @@ static unsigned int intel_fb_modifier_to
  * main surface.
  */
 static const struct drm_format_info ccs_formats[] = {
-	{ .format = DRM_FORMAT_XRGB8888, .depth = 24, .num_planes = 2, .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, },
-	{ .format = DRM_FORMAT_XBGR8888, .depth = 24, .num_planes = 2, .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, },
-	{ .format = DRM_FORMAT_ARGB8888, .depth = 32, .num_planes = 2, .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, },
-	{ .format = DRM_FORMAT_ABGR8888, .depth = 32, .num_planes = 2, .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, },
+	{ .format = DRM_FORMAT_XRGB8888, .depth = 24, .num_planes = 2,
+	  .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, },
+	{ .format = DRM_FORMAT_XBGR8888, .depth = 24, .num_planes = 2,
+	  .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, },
+	{ .format = DRM_FORMAT_ARGB8888, .depth = 32, .num_planes = 2,
+	  .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, .has_alpha = true, },
+	{ .format = DRM_FORMAT_ABGR8888, .depth = 32, .num_planes = 2,
+	  .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, .has_alpha = true, },
 };
 
 static const struct drm_format_info *


