Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3295DC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DB620656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DZf0IHTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbfETJHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:07:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45119 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfETJHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:07:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so6470229pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9fCm6pJfwNnZtBLiOWDCiXX9M7MmpxMOv/deygL7hU=;
        b=DZf0IHTg+6ePioO6PbxXMr3b0sxOtlWkuB0Rp/4yTi2ZN5gA6vpKqzCt+E79/4xyLz
         sTb8V2qQqNyxh1FgxVCOw5Ro+uDhlkiDCr+Teqvov0ZjXg4xmEQAe9q73sschfeV2/7b
         1umWfMmqWgnFDP9XQOT2EyjzH1L1l22e8ByC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9fCm6pJfwNnZtBLiOWDCiXX9M7MmpxMOv/deygL7hU=;
        b=Frzqk2V0Le2x0iPvMDehxzXhje5ZP0yjuMwngjjBC4txfMR4HjyqP7H3e7+SLt5bLe
         KIFINo3ZKTjv5Fhp1rlVevx3J9u9EQ4kzNDCMY1mH9CMFZGQ5hBNBOL0xY/iAKgeLt45
         A4K646sqRY+3ntx/JVaht/XlEeNqt5I5IAC//9CtchUYbQmg1AJCcRTBCm5kqiljnJdz
         rr2eal5sDFSLkc+mh4gqrrCueKQIKxYheQ0nPfqxLbgCa1CkMq5Q4l+BRk9Os4gIO+M6
         +IK7u8U/hs1u9TnAKkjxQ+LUYTNVQLLuQH/lM14racjVQ9zxMrDcLI2tUGnkskcrR2Rv
         6WuQ==
X-Gm-Message-State: APjAAAXAkuZkRK77PszFXqehPk/g8VsXVpYKcCV0gpAjicMmsfB3IHlE
        vKILCq3Ykw14X9pqfLCbHrr0WQ==
X-Google-Smtp-Source: APXvYqySfQ3A6Yya3mnBJTmrp77lvlN5ou8ZoeGALRWlDGRY8S5yM7HkEEgoTE9x3zLO+IG5XbCEIA==
X-Received: by 2002:a63:ee0b:: with SMTP id e11mr21644801pgi.453.1558343259840;
        Mon, 20 May 2019 02:07:39 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.193])
        by smtp.gmail.com with ESMTPSA id d15sm51671614pfm.186.2019.05.20.02.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:07:39 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bshah@mykolab.com, Vasily Khoruzhick <anarsoul@gmail.com>,
        powerpan@qq.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 05/11] drm/sun4i: tcon: Export get tcon0 routine
Date:   Mon, 20 May 2019 14:33:12 +0530
Message-Id: <20190520090318.27570-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190520090318.27570-1-jagan@amarulasolutions.com>
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes tcon attributes like tcon divider, clock rate etc are needed
in interface drivers like DSI. So for such cases interface driver must
probe the respective tcon and get the attributes.

Since tcon0 probe is already available, via sun4i_get_tcon0 function,
export the same instead of probing tcon explicitly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 8f93121fead4..9e9d08ee8387 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -221,7 +221,7 @@ EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
  * are located in TCON0. This helper returns a pointer to TCON0's
  * sun4i_tcon structure, or NULL if not found.
  */
-static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
+struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 {
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun4i_tcon *tcon;
@@ -235,6 +235,7 @@ static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 
 	return NULL;
 }
+EXPORT_SYMBOL(sun4i_get_tcon0);
 
 static void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 			       const struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 84cfb1952ff7..88e971d5f937 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -272,6 +272,7 @@ struct sun4i_tcon {
 struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
 struct drm_panel *sun4i_tcon_find_panel(struct device_node *node);
 
+struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm);
 void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
 void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 			 const struct drm_encoder *encoder,
-- 
2.18.0.321.gffc6fa0e3

