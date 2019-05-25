Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A0EC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B8320862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9n2OcAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfEYR7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:59:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40827 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEYR7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:59:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so6792242pgm.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uwSYiRPVFEjQuM0sSyZ+kLnllnNTFI6WD6DgQoN9mU0=;
        b=m9n2OcAr4oPaQmt5EaECUwWw7q8oAO9NOKTzgtcL5yv9sn0wqLtljcj0twRuahROqC
         hZvgNOUEomUSjZVNMerY0cJFYsJIohHQuWm2sbkQZA99SWXbrBvYMvH73dQV8FWs/P20
         C/9EU96S743OTEfZoOjK/LS9Xmtq1nxz2hELM4oZUWGsxXyH3fta2Ky9VLme4akuow12
         8bUmsdWH0D5HwcggJ2uCehbSJ3T9O3i3rPmkIP+gCTO5g0tCKxv3PHWfBmn3jkKi92y4
         JfmHAbLmOd40HnM7FXZ9ljrT+pbRcBbkYAwOBbGJxm6y2Z6CyaDo3OxiAgoZgrKhom87
         SFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uwSYiRPVFEjQuM0sSyZ+kLnllnNTFI6WD6DgQoN9mU0=;
        b=N+e7pAEg/dwg9kOGx5gGwye4nBTk437A6+bVdE19lA5m7KaFytf2mT37XjNFvNRuYv
         7RO1U0q5+Uu0E/Di6Cx54qBaZCfTfwgYa3UH23KhSrdhdPujW8nqwpLucdLtncUq2F6z
         T7hq9TvlZ+LN8JbKCs1m+TiL4aHFKDnf1LgCEinMQCyYmrysGn1xInh68wxi7H5afsBr
         GodKXzoQL3bGONer6pCfCnu0b+bhOJs634ZALBzo8gzoWj0HZTpwal1e7moi+q1lBwp5
         EkxKLniWc1oGd8J2p1Xvk4HVTwinBwVwWN+jIwKeyVL1zWi+XSNoQFZL/NS5L+3prZNh
         tgdQ==
X-Gm-Message-State: APjAAAWVTgueMxmbpxbSXz00ao//oomElzt/ktQLLNL2J0Gc/xpKJLci
        l8xnCVjUKOg6qt7lzXMHakA=
X-Google-Smtp-Source: APXvYqxIYOz6qPCXV0hkYRbakdXEMJw/cSeGknOs+gkiAXX+J1xDezn9slFmKxF017nCeWGgpOg06Q==
X-Received: by 2002:a62:5103:: with SMTP id f3mr123729284pfb.146.1558807183602;
        Sat, 25 May 2019 10:59:43 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id b18sm10017130pfp.32.2019.05.25.10.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 10:59:42 -0700 (PDT)
Date:   Sat, 25 May 2019 23:29:37 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: analogix_dp: possible condition with no effect
 (if == else)
Message-ID: <20190525175937.GA29368@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by coccicheck

./drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1414:6-8: WARNING:
possible condition with no effect (if == else)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 257d69b..cfcd159 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1411,8 +1411,6 @@ static void analogix_dp_bridge_mode_set(struct drm_bridge *bridge,
 		video->color_space = COLOR_YCBCR444;
 	else if (display_info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
 		video->color_space = COLOR_YCBCR422;
-	else if (display_info->color_formats & DRM_COLOR_FORMAT_RGB444)
-		video->color_space = COLOR_RGB;
 	else
 		video->color_space = COLOR_RGB;
 
-- 
2.7.4

