Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9031C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 03:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883F52087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 03:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfHSDN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 23:13:29 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37661 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHSDN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 23:13:28 -0400
Received: by mail-yb1-f196.google.com with SMTP id t5so126140ybt.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 20:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A70pDx8ZVFbh5we0DnKpwB7v/M6I0DIAyvofyE5IBX4=;
        b=dxKAzLIt9RSR9Hy149eNPPhnpUHOnUSMsGYL1klam+fvxl0kjLTCSqpFhZtw8SSfsi
         K3MVT7Jb6KCgSGULOhUq+vRIpZom2UYDKtwYhPocW2xSmlk9zKbqvqAB3YX1GlABy2S6
         g+DUaDrbq9VdP6VPQXVRVfZMh1ROPPJtY8RV5pmkgR9Z/Vl4tYZiVmSmu/uVHJKwdlYV
         AjZe20U/nOb158wLluHi4ADbOLJpTB7WIlhfKQfJ5V/H38mckiK77y4X/pwGNXOyCYm7
         Remxl9LYYaMtx0zdyYjzLOB/keDAi7zoRIJHBHEtPVegiYKj093LmZVNMSPt9PWS9/48
         ptOw==
X-Gm-Message-State: APjAAAVugjNTHsYARRm+SflFxTPPFcKd5VIEfp6KfNwuw4m3eD4DUp3m
        dJJNzP4X83Ip7Jv9GWjRV/w=
X-Google-Smtp-Source: APXvYqyX9wJL+hv/OtNdHBPS1+KQ0hEO8h3RRoh4HTlbvfIUdjgNYFWxlhk/5mBtwwK3plBfM/zHag==
X-Received: by 2002:a25:cc8f:: with SMTP id l137mr14843735ybf.482.1566184407307;
        Sun, 18 Aug 2019 20:13:27 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id q65sm2860184ywc.11.2019.08.18.20.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 20:13:26 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/gma500: fix memory leaks
Date:   Sun, 18 Aug 2019 22:12:57 -0500
Message-Id: <1566184395-7615-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mdfld_dsi_output_init(), if mdfld_dsi_pkg_sender_init() fails, the
execution is directed to the 'dsi_init_err0' label. However, some
previously allocated buffers and resources are not deallocated, leading to
memory/resource leaks. To fix this issue, revise the 'dsi_init_err0' label.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/gpu/drm/gma500/mdfld_dsi_output.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_output.c b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
index 03023fa..ab9e935 100644
--- a/drivers/gpu/drm/gma500/mdfld_dsi_output.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
@@ -592,11 +592,10 @@ void mdfld_dsi_output_init(struct drm_device *dev,
 dsi_init_err1:
 	/*destroy sender*/
 	mdfld_dsi_pkg_sender_destroy(dsi_connector->pkg_sender);
-
+dsi_init_err0:
 	drm_connector_cleanup(connector);
 
 	kfree(dsi_config->fixed_mode);
 	kfree(dsi_config);
-dsi_init_err0:
 	kfree(dsi_connector);
 }
-- 
2.7.4

