Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D8DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC43206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfJHNB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:01:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46220 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHNB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:01:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id AE56F28FF5F
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     kernel@collabora.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Fix comment doc for format_modifiers
Date:   Tue,  8 Oct 2019 15:01:49 +0200
Message-Id: <20191008130150.11399-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004192801.GJ1208@intel.com>
References: <20191004192801.GJ1208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter passes an array of uint64_t rather than an array
of structs, but the first words of the comment suggest that it passes
an array of structs - if the reader stops reading at the word "struct".

If the commit is read beyond that point the reader will likely confuse
"drm_format<SPACE>modifiers" with "drm_format<UNDERSCORE>modifiers" and
understand the meaning as "passing an array of elements which are of type
struct drm_format_modifier". That is not correct.

Only if the reader is able to read the comment as
"array of struct drm_format<SPACE>modifiers" will they be close to the
correct meaning. But still not quite there, because the modifiers do not
influence struct drm_format in any way - it is not clear what "a modifier
of a struct" would be.

The comment is changed to simply say that the parameter passes an array of
format modifiers, which is the correct meaning.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index d6ad60ab0d38..0d4f9172c0dd 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -160,7 +160,7 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
  * @funcs: callbacks for the new plane
  * @formats: array of supported formats (DRM_FORMAT\_\*)
  * @format_count: number of elements in @formats
- * @format_modifiers: array of struct drm_format modifiers terminated by
+ * @format_modifiers: array of format modifiers terminated by
  *                    DRM_FORMAT_MOD_INVALID
  * @type: type of plane (overlay, primary, cursor)
  * @name: printf style format string for the plane name, or NULL for default name
-- 
2.17.1

