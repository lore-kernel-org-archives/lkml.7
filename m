Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EC2C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 03:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900242082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 03:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfHSDex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 23:34:53 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41812 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfHSDex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 23:34:53 -0400
Received: by mail-yw1-f65.google.com with SMTP id i138so142423ywg.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 20:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uGOYgJda+j4dqh4YXabhCX5Nh2M2wJdXHWQKsrei+A0=;
        b=XDWU6n/No2ZFBD+Ri2ovihYVYFSc7EixeYmSd9oDPcHUJWNcMIO5zgjEpO44J9M1ho
         d0LKFlwZpWbu3LVRIdZK1690QaZl7uvR92w9dC0Gy5ykMhLbwhZDDWUiTuBReuSUa9yc
         q1+V5buwueEP3515+EyQdNOqE5JmYq7EvDron8Uc+SpTkJzua5QW/UpVhp9CWiPZF+rs
         mw96UAuvh9QZLClRVoIzYoEZstnilBPahl6knUwGZLPCjOxXvNJtarVAPw0JXsYTLSd/
         7iERARJ6n6p/1P69wutDUK34Qwqk78ZGmZtP1OYr0kl3b3ck2FzNB/8FcqFj966JeUfu
         1GTg==
X-Gm-Message-State: APjAAAXTvETdDxa3IdpHAh6+XwmbRB/rysOmFlCcaYBwaf7km1nPjAUM
        Uida6EeeniKXCQ75colKukw=
X-Google-Smtp-Source: APXvYqx/Ey+ck+08aUX1naJ+M5Dxnh85vNnbkoHC+QbtC+Md9D2ZDtdB4Divyj/mbjlLXsQOOx/0bg==
X-Received: by 2002:a81:9144:: with SMTP id i65mr14960039ywg.361.1566185692434;
        Sun, 18 Aug 2019 20:34:52 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id b66sm537423ywd.110.2019.08.18.20.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 20:34:51 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/gma500: fix memory leaks
Date:   Sun, 18 Aug 2019 22:34:30 -0500
Message-Id: <1566185684-8014-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mdfld_dsi_output_init(), if an error occurs, the execution is directed
to 'dsi_init_err0' or 'dsi_init_err1'. However, in some cases, some
previously allocated buffers and resources are not deallocated, leading to
memory/resource leaks. To fix this issue, revise the labels.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/gpu/drm/gma500/mdfld_dsi_output.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_output.c b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
index 03023fa..0cf4121 100644
--- a/drivers/gpu/drm/gma500/mdfld_dsi_output.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
@@ -573,13 +573,13 @@ void mdfld_dsi_output_init(struct drm_device *dev,
 	if (mdfld_dsi_pkg_sender_init(dsi_connector, pipe)) {
 		DRM_ERROR("Package Sender initialization failed on pipe %d\n",
 									pipe);
-		goto dsi_init_err0;
+		goto dsi_init_err1;
 	}
 
 	encoder = mdfld_dsi_dpi_init(dev, dsi_connector, p_vid_funcs);
 	if (!encoder) {
 		DRM_ERROR("Create DPI encoder failed\n");
-		goto dsi_init_err1;
+		goto dsi_init_err2;
 	}
 	encoder->private = dsi_config;
 	dsi_config->encoder = encoder;
@@ -589,14 +589,13 @@ void mdfld_dsi_output_init(struct drm_device *dev,
 	return;
 
 	/*TODO: add code to destroy outputs on error*/
-dsi_init_err1:
+dsi_init_err2:
 	/*destroy sender*/
 	mdfld_dsi_pkg_sender_destroy(dsi_connector->pkg_sender);
-
+dsi_init_err1:
 	drm_connector_cleanup(connector);
-
+dsi_init_err0:
 	kfree(dsi_config->fixed_mode);
 	kfree(dsi_config);
-dsi_init_err0:
 	kfree(dsi_connector);
 }
-- 
2.7.4

