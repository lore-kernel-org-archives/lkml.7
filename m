Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6B0C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE87D2081C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=expunge-us.20150623.gappssmtp.com header.i=@expunge-us.20150623.gappssmtp.com header.b="W8rgmeki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfEDAH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 20:07:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38468 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfEDAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 20:07:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so3673110pfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 17:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=expunge-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iovEWy/GQChZ/awOVkY7H6FjwQrlO6bXxHcgVwGcj+4=;
        b=W8rgmekidkx06udnPHuIxrTgcS2YyZ/LnwzT6OTCVziN3r5PRkkLYxoe7fwnd5b0ga
         2VJwv8y76owide44YO6ZyQKvuukxmTgJcLNdo28rpX3HjRdjU5N8L6yMvOsAlTQiPedE
         waro9Bcie9EwVPNqm2XO3FyHPi5rrOykd+55Yx1fHghO74FBmnhDH8EpPCiOMdzuGW3E
         p46lDx1PHKOCTgw6LLFUqgDndChvSBSr2+75BqEEvg2Dvesj7aEiBgkEiK+oLD8Vcdxg
         0XvASQGTgo5FaHaVoUrMynrre74WHv8B4G8Y7riJfNcVdAH4Y9DGcQ9RIhjLhFFASPGP
         2vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iovEWy/GQChZ/awOVkY7H6FjwQrlO6bXxHcgVwGcj+4=;
        b=gsDoFp3B6VnTRVipPbMWW/Yi9CmiCZIb716UpxX5cbcAv104S5Ct5wMwwvhcSQL+4I
         YD8+Nsds8GAdjo3PbnsaesO8RaHNTzK1q5jvucBTTE3XzJ4rf0tNdn6VaIUzxaZcjO+x
         DUf9ohnm9HFCjmLA5V41rts7vG5lwth7VgcujJHp3UVgA9/f1IM2d9/yc26K03LKxCCH
         fyF42GLFirGPlcQjyCEMObh9nkZtUtQVkzjg98PYxtKP15xSz12pHUymR/c+s/6A4wGP
         XrNvszKdfDfgwOGHd2RH0b10IVPLiDLfZgI8kFq2MPgJg4s2oQYo6mMqvQya8kwhhNkU
         mw+w==
X-Gm-Message-State: APjAAAVVeKo+dgZyRl1NUm24IqCoCCZ1oYGLNNJsNcWDj0pY+O3i+HiG
        XifAZIgl2RC1ydL1MK5yCmHdXcYepTxfYA==
X-Google-Smtp-Source: APXvYqzHuVCCkd14uJH1YbxuOuV8rfgJYzruetuIOrsuqy6jbZ3ju1hiUC+6Qr/w2YB8KbnLNyJ5dQ==
X-Received: by 2002:aa7:8d81:: with SMTP id i1mr15024146pfr.127.1556928446138;
        Fri, 03 May 2019 17:07:26 -0700 (PDT)
Received: from gamepad.lan ([2604:4080:1159:80a0:148b:33f9:3a17:5899])
        by smtp.gmail.com with ESMTPSA id c137sm4868997pfb.154.2019.05.03.17.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 17:07:25 -0700 (PDT)
From:   Jared Baldridge <jrb@expunge.us>
Cc:     Jared Baldridge <jrb@expunge.us>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel-orientation-quirks: Update GPD Win 2 FW dates
Date:   Fri,  3 May 2019 17:07:16 -0700
Message-Id: <20190504000716.8063-1-jrb@expunge.us>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPD Win 2 is shipping with a new firmware release date. As
the quirk is still required with the new firmware, this commit
adds the new release date to the quirks table.

Signed-off-by: Jared Baldridge <jrb@expunge.us>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 52e445bb1aa5..e0d0f3169581 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -63,7 +63,7 @@ static const struct drm_dmi_panel_orientation_data gpd_win2 = {
 	.width = 720,
 	.height = 1280,
 	.bios_dates = (const char * const []){
-		"12/07/2017", "05/24/2018", "06/29/2018", NULL },
+		"12/07/2017", "05/24/2018", "06/29/2018", "07/30/2018", NULL },
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
-- 
2.21.0

