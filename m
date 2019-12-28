Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A811C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400CC21744
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="kiAAsW26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfL1U2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:28:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36794 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfL1U2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:28:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so12372019plm.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 12:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O/NazlIyebGgm2jHBRChRbTb9wSObdQ6N5Bgyi7i27c=;
        b=kiAAsW26ytcRco0kYp0tzDQgd4XIQNe722oGmS6OtNr2W8p69FOcKQV1Mfu0enUGzD
         gZMbna0w/IOgjM4QkcNhnB5zh60rGSQz+UC6Ox+luGu4NjcvUMe2iPcDMzmsMsySgvIE
         Jn/jOIadgILoQXyKU301MMgEkrm6tuU7phT+sdwkOiJGZmlg5w7CpF6QVqt3ks7Psv+D
         Vyz4aIsLr0e+Otg0gXLZ8pYm19AzvIw496AAXLdFdXkqT3ESZN8vuHkSdqBJwVJ/cMHQ
         4VzS3AaGP717AVYQD61WCZiIzTLASb2b6wOg4h+4zucxuOSiX1r5L6Lym8p7VW0wQOeS
         tkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O/NazlIyebGgm2jHBRChRbTb9wSObdQ6N5Bgyi7i27c=;
        b=l7pURecWQTnmHtM4j6/l/KiWd3Wo7RPZtpgTCACK93P+Kt0/t7jAxuAp/7Y+0+azAm
         zo4fwWC45KFIrWqWW1MhUfsoYWTqXTd+x2Wxbxd+QyY781dy2GogFUQbTm/j3/CdXkpG
         UvvZyImbUnyGjAYq/vrwq1wTQ0mE/gdG6stGQBYM3RQ2c2C0E43IQ9W3sHr56GTDYSFW
         NUrxStSfeNaNT5ryy+bA1TQoLQuTvA8oYQCHnix5+dPkgHzRTXSYoQTALzZzLMo1Uqu8
         vTfn4RX036XVvoCWkd8w+kRU5rK9EJJu2lCqMQZic4+e82ceRMNhWmJZvWMwJux54/03
         l60w==
X-Gm-Message-State: APjAAAXO3UNtMUjLpw9uo6HwEmsU3SS3fLzwr4Z23QSFd8e9Co9fCJbm
        EczqVl7CvRDiJtyrv8BxV3Mm9Alin+k=
X-Google-Smtp-Source: APXvYqzil8XHZKEKGXU9xgLOmC+kzkkEd7Atnumax82OKBXXcIfMJT4P+N0l7H8T4ce/5JC7LvTxDA==
X-Received: by 2002:a17:90a:28a1:: with SMTP id f30mr35191546pjd.77.1577564917184;
        Sat, 28 Dec 2019 12:28:37 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id i68sm46771169pfe.173.2019.12.28.12.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:28:36 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [RFC 1/4] drm/sun4i: Wait for previous mixing process finish before committing next
Date:   Sat, 28 Dec 2019 22:28:15 +0200
Message-Id: <20191228202818.69908-2-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191228202818.69908-1-roman.stratiienko@globallogic.com>
References: <20191228202818.69908-1-roman.stratiienko@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Screen composition that requires dynamic layout modification,
especially scaling is corrupted when layout changes.

For example if one of the layer scales down, misaligned lines can be
observed, and dynamic increasing of destination area makes mixer to hang
and draw nothing after drawing modified layer.

After deep investigation it turns that scaler double-buffered registers
are not latched by GLB_DBUFFER bit, instead thay are latched immidiately.

Only way to avoid artifacts is to change the registers after mixer finish
previous frame.

Similar was made in sunxi BSP - scaler register values was stored into RAM,
and moved into registers at sync together with GLB_DBUFFER.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 15 +++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 8b803eb903b8..eea4813602b7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -257,6 +257,20 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
 	return NULL;
 }
 
+static void sun8i_atomic_begin(struct sunxi_engine *engine,
+			       struct drm_crtc_state *old_state)
+{
+	int reg, ret;
+
+	ret = regmap_read_poll_timeout(engine->regs, SUN8I_MIXER_GLOBAL_STATUS,
+				       reg,
+				       !(reg & SUN8I_MIXER_GLOBAL_STATUS_BUSY),
+				       200, 100000);
+
+	if (ret)
+		pr_warn("%s: Wait for frame finish timeout\n", __func__);
+}
+
 static void sun8i_mixer_commit(struct sunxi_engine *engine)
 {
 	DRM_DEBUG_DRIVER("Committing changes\n");
@@ -310,6 +324,7 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 static const struct sunxi_engine_ops sun8i_engine_ops = {
 	.commit		= sun8i_mixer_commit,
 	.layers_init	= sun8i_layers_init,
+	.atomic_begin	= sun8i_atomic_begin,
 };
 
 static struct regmap_config sun8i_mixer_regmap_config = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index c6cc94057faf..915479cc3077 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -25,6 +25,8 @@
 
 #define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE		BIT(0)
 
+#define SUN8I_MIXER_GLOBAL_STATUS_BUSY		BIT(4)
+
 #define DE2_MIXER_UNIT_SIZE			0x6000
 #define DE3_MIXER_UNIT_SIZE			0x3000
 
-- 
2.17.1

