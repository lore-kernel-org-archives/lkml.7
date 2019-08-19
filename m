Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7884DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C4F214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfHSTlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:41:02 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40885 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbfHSTlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:41:02 -0400
Received: by mail-yw1-f65.google.com with SMTP id z64so1278562ywe.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3jjV8Hrc7MgB8gFTbQTU8aPeFAihk9juTlaHbNEZJYw=;
        b=eur31YbXVBwTrhA/H/3RapmG13gNxh5n3/C0H4JjKEuv8QVhjTYQKuwi+5nKDAatU5
         H2oH3BbxMs+l2wfBXmT3rcm9amX46NvAfS6M5hSZIf2qRNHThvYr262LIqyqJbxvm2Kx
         Gyq2wygl6EBW49IV+THhlZJQ4I6hGP2otS4WPyRmSccu271utCqp+Tk9llHY0yUtF5Vj
         061tJIOem+UTDXIFg1u69NwSSzvrMW05ZPEobqRfhAkkCXA03S/8pMYOtXv+pWF8WAMG
         dcgDCMdxMw8v5k8ACU0xYG/6fvjo8Z+sDV64QUOeLzywInHQL7mNBswZzgwsGDLZiEOz
         3iiQ==
X-Gm-Message-State: APjAAAVfom0jxCuT14QFYqBk39rvX78CXoqhHlPSd/NgajYDHXM3/Y9P
        bkfEp2q40WyVr87vfa7FOwk=
X-Google-Smtp-Source: APXvYqzEZxA6S8BJgKrg01+7nFvXMq0L8IVN2kgZ+PiBjevCV5VaF9TSCUylRGOcxLDWF2bsBc3S4w==
X-Received: by 2002:a81:310b:: with SMTP id x11mr18009539ywx.420.1566243661057;
        Mon, 19 Aug 2019 12:41:01 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id 84sm3330637ywp.45.2019.08.19.12.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 12:41:00 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm: Fix memory leaks
Date:   Mon, 19 Aug 2019 14:40:49 -0500
Message-Id: <1566243649-5249-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drm_universal_plane_init(), if 'format_count' is larger than 64, no
cleanup is executed, leading to memory/resource leaks. To fix this issue,
perform cleanup work before returning -EINVAL.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/gpu/drm/drm_plane.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index d6ad60a..2c0d0044 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -211,8 +211,11 @@ int drm_universal_plane_init(struct drm_device *dev, struct drm_plane *plane,
 	 * First driver to need more than 64 formats needs to fix this. Each
 	 * format is encoded as a bit and the current code only supports a u64.
 	 */
-	if (WARN_ON(format_count > 64))
+	if (WARN_ON(format_count > 64)) {
+		kfree(plane->format_types);
+		drm_mode_object_unregister(dev, &plane->base);
 		return -EINVAL;
+	}
 
 	if (format_modifiers) {
 		const uint64_t *temp_modifiers = format_modifiers;
-- 
2.7.4

