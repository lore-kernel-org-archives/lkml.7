Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB536C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D77A21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tu/x2l1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgABJzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:55:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50203 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgABJzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:55:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so5106470wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 01:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5OxxgqbSH1bpU+N86be2oTUHJYZJRxIbZuHPbnm3Fbw=;
        b=tu/x2l1kltY3l/Ho0RoApMDAt/R391Ka5kJlJg6PXwy7qAgXQH6wLIfW1KvVsmQ7yk
         bLSE0MrtY1Aw6cO8hTN2Zgx5k2t9wW2cJtXY60vcAcTMrlkxrYBc7aWFlLQVhj/uKabP
         lwDpKRJ0gQ8KxwxqfuINc+B9wGv6WUCkoFEEB14tXtIsVuL0HeLvEAQDmhBjC8gRwYFV
         GNlr+yv3UdPPNEVJ/DZSAox8lDlS/FS33jjU0sC9wA6wN/V+2XwcubyVVV3vUF4hee05
         e/SeDTHCNqX55L+wJ3kAfZml00b1z2kDAdcbFHP8Gp2tR5xjWfcwsTzMZTfH+0NsJ9X2
         ctew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5OxxgqbSH1bpU+N86be2oTUHJYZJRxIbZuHPbnm3Fbw=;
        b=k9O2GpjLpWnkJwCnUVDWBGjiwvDYKRkLw+yEgbVi+1uzMTnrW+GiUW/NHFg083RDaL
         Ddd4/NUyyzZRpzgE8wXBErwu4nqlxwUmKdwVpEWFU7ltDM9ialrOJBZXIspmG9kAgkYI
         vSr/R95VSz/e0bND29sYN0ATsE0BQlUlLK8jWoJwjbD/qGzW6L/sL4B8rlAgcj50KvFa
         FhzrBKGz+ISL5EDwFxiStTa5YSkwaK+trK9fPgIsaodbmTnTkbYBt7XllYSq3CmlOgke
         9kcF9j9lmOgPsESI1e3VcstXg/MAQBiksZQnTvta1kzhzQOWciTGR81xP4izbPJuwmDA
         g+yQ==
X-Gm-Message-State: APjAAAWbXEe4KuUQlgW/QWqBHxLCmtRw5T1YtMB+4fGutYbaigffsYrd
        jPNk2k2EPfXktHP+4rghvVnbi2XhK3Y=
X-Google-Smtp-Source: APXvYqyfwtUdMlicWKNWxM9IPcfk7qztALI/0mg1JSh8RuszTN1DQDP3EUhmM+D0vwjfyKH01pbxIQ==
X-Received: by 2002:a05:600c:2c7:: with SMTP id 7mr13129541wmn.87.1577958919317;
        Thu, 02 Jan 2020 01:55:19 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id a1sm8131464wmj.40.2020.01.02.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 01:55:18 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/omapdrm: use BUG_ON macro for error debugging.
Date:   Thu,  2 Jan 2020 12:55:15 +0300
Message-Id: <20200102095515.7106-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the if statement only checks for the value of the `id` variable,
it can be replaced by the more concise BUG_ON() macro for error
reporting.
Issue found using coccinelle.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index 413dbdd1771e..dbb90f2d2ccd 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -393,8 +393,7 @@ static void dispc_get_reg_field(struct dispc_device *dispc,
 				enum dispc_feat_reg_field id,
 				u8 *start, u8 *end)
 {
-	if (id >= dispc->feat->num_reg_fields)
-		BUG();
+	BUG_ON(id >= dispc->feat->num_reg_fields);
 
 	*start = dispc->feat->reg_fields[id].start;
 	*end = dispc->feat->reg_fields[id].end;
-- 
2.17.1

