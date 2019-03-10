Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC3BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB67320657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQqHqNlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfCJVWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:22:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45522 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCJVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:22:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id d18so2955356qtg.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tY5ndg9ty18rlikudHknRC51BZ9hqezjKFxag+QBIs0=;
        b=VQqHqNlb+EtDiSotVv3QJj7UO+e5X32urpF6o3KQVUi8Y2qU+7tbhGD0PljFBQHtG9
         E/G5XpX9MRVuRQmU8ePMJEby5E2mCShon6adEAWCrrOrh0sNZIdOeG2pV2ylK948WlyP
         wi5tTmYmxV0pKARSOpDMEv6FYalGdiUZ/xwsjw7wS5SlXop8pyeaSAS5RAttQIjNhBgk
         kENCyYoYdgeHjaafp36GnaayUGkHQXkhMhSzOe8XDAbes1dSwvA2hDbfXv+zzktYOnTL
         YCUGQNq7w3AIKXYZHaE9dYHNepzpjIZob9IbCeL+UuD38gTHedwHkBZHcpDXPnDMDQho
         RSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tY5ndg9ty18rlikudHknRC51BZ9hqezjKFxag+QBIs0=;
        b=i1+/jjsfS40IJyo5mVXvlf/53JGnVGfMpGMvGG13Dm95gYvbrhalHgS2p7cw+vhA9t
         2097nnXrHBwogco2IdiRemEm2C+sxf/fgAlP0EG9vyouuADhvGkT1fx5BNCyTUqXIYvq
         8kpgEvmnk/gKfXtQCdyIsOO7fKVdk8SeTwjHYRRElNJcTQN9690ylbu8dqAtlKDLl6X5
         aXg6GR3nQLLBKpUMDOQGMMuCi+ycer0ELGtvpSWz/LCBvs2KaO0B1EkLi3s3h6PxQtpq
         GbvaBWq0A05+ZIJSMzWb+ONj6z+U1JVTS90qWrhGaLatu2dEvNMKqPb091dXBbnF+F28
         pchw==
X-Gm-Message-State: APjAAAXfVUsBTrDCVcJ3CEe4bn6mAlNV3qDhBd73Eklr7j99ghLrhJVr
        JLMpUFf3YHVy/0uMnQFbwLVhnUbyLSU=
X-Google-Smtp-Source: APXvYqzOqvt3O8HnJkZ0SM25hDFXsRCQc1oKpjAXEsdoEVnOZHm5ak0SR6HJ/UsvcaXRoSoHrcXBHw==
X-Received: by 2002:a0c:9ae5:: with SMTP id k37mr24437826qvf.128.1552252963786;
        Sun, 10 Mar 2019 14:22:43 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id h11sm1293302qth.13.2019.03.10.14.22.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Mar 2019 14:22:43 -0700 (PDT)
Date:   Sun, 10 Mar 2019 18:22:41 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: Remove useless call to drm_connector_register()
Message-ID: <20190310212241.4fsqejz5rlnp7m2k@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function vkms_output_init() is invoked during the module
initialization, and it handles the creation/configuration of the vkms
essential elements (e.g., connectors, encoder, etc). Among the
initializations, this function tries to initialize a connector and
register it by calling drm_connector_register(). However, inside the
drm_connector_register(), at the beginning of this function there is the
following validation:

 if (!connector->dev->registered)
   return 0;

In this sense, invoke drm_connector_register() after initializing the
connector has no effect because the register field is false. The
connector register happens when drm_dev_register() is invoked.
Therefore, this commit removes the drm_connector_register() from
vkms_output_init().

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_output.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 3b162b25312e..a6cee4c279c2 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -71,12 +71,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
 
-	ret = drm_connector_register(connector);
-	if (ret) {
-		DRM_ERROR("Failed to register connector\n");
-		goto err_connector_register;
-	}
-
 	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
 			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
-- 
2.21.0
