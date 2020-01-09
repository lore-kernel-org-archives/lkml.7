Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D198C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507A92064C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghO3EugB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbgAIOVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:21:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35461 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgAIOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:21:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so7594632wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WK9gkU3m513Bp7Cu1KXOPb6NwVeeFqZuUplsaUVFOIk=;
        b=ghO3EugBL0+/4U4+kMiJ6nLW+1QsNX88U6mry2WtI8EVV8HzkEHzR0K87NLTCQSos0
         kihimaZh5YvIbuaSzQGGkHW8qo48pxNQDa+GEEa+n0X55v7xC6OrJB40TC21P3OIb2Jh
         P6CmXgLCA/oiF8najEnmbqZ5hNYbpdIiI7R1JXjH0Ce2PX6fXWyFR1prAuR337wZljBu
         vZtcohvXrDx9I3jNflVUw/E1UiC8k9swnJCkaFY+ZDImtNMEzpN3tw/m6f/nQgFe4FKp
         JRo862ZtpCgPSmEZeIkqteJKZMFjytf90Roz9N1nDzwPNO92bXCALRQwg2Rcb7l9Dlh8
         FPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WK9gkU3m513Bp7Cu1KXOPb6NwVeeFqZuUplsaUVFOIk=;
        b=Cc9VZJR6qvvTkO4yn9Yl06/FoFSCO0c9p1RVDQICsb666EROkgEtKw1Jj+6Z2ZI62z
         l7c6KIBgDjUqRLY1L7FCMiFJGOVWGLPs5U2LWFg1we87uDYMNjbR//FtgMEDD2LWfKXB
         TZEs+7XRm15DSC67rTX5kxVIVqkuAL04xu/PtKvVHrPQ0/LgXWShXa/WX7SD2oySvDn4
         4eQKK6rYXh5mhJZov4qVUkokjS8mA00322tnY89/PmUP+XprOjMjfV9NFa7AkcVd3y6Y
         GIwoNXVa6Go6DxJOdWaHa8XvutvKrYBbal4M1KgKNuATGY5Wuiea6BwSjTqvjWWp7ly+
         hVAA==
X-Gm-Message-State: APjAAAWlWISKEyLevQIKGDjeU6/8qzW6kHgp7R3IpFqs6kJAJR8gYckb
        mNQpyw6qzgli+gGA6fu1p/s=
X-Google-Smtp-Source: APXvYqwf5cjzGgESlCq81pbBePPTkbxeU1QNXFhPZqiJ69f3+QB80EdywpsFxWfxqtJMEgBWZVeCAg==
X-Received: by 2002:adf:8b4f:: with SMTP id v15mr11505791wra.231.1578579664576;
        Thu, 09 Jan 2020 06:21:04 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id b17sm8337337wrp.49.2020.01.09.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:21:03 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: use DIV_ROUND_UP macro for calculations.
Date:   Thu,  9 Jan 2020 17:20:57 +0300
Message-Id: <20200109142057.10744-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open coded calculation with the more concise and readable
DIV_ROUND_UP macro.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 0b3d18c457b2..cc672620d6e0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -328,7 +328,7 @@ static inline uint16_t scl_get_bili_dn_vskip(int src_h, int dst_h,
 {
 	int act_height;
 
-	act_height = (src_h + vskiplines - 1) / vskiplines;
+	act_height = DIV_ROUND_UP(src_h, vskiplines);
 
 	if (act_height == dst_h)
 		return GET_SCL_FT_BILI_DN(src_h, dst_h) / vskiplines;
-- 
2.17.1

