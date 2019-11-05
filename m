Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14341CA9ED4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE5B214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd10ct4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbfKECX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 21:23:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35596 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfKECX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:23:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id q22so5290407pgk.2;
        Mon, 04 Nov 2019 18:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/XQPTUQdnIxsmo3yaVIj6Nhp7ayUgTHZ2bwUnPNImsM=;
        b=Jd10ct4X+ROh8H/H8/GovQp0g/sOl6KugUoMq/WSwkvJ/f/QIezkkw31N/HGoIeJNL
         u8JY7bP2fskwM/NYY7xsXG/z+0lWi7vHPZ7TIgksLH7QzYIGi8VpD69aY9SQIfEGt36D
         xtJm1N/H3CazKJ2gaOz6SuRLF63o0PdX8zF9XHCaYtRcDYdlALP71yPxow6PTCtxTP7T
         uG3REIVtR4TTc5RUxcsTwuzl4MAGEOEz+c8V2BYLQao9nMsRtmx2azYwRYsjfjSbQir5
         +frsGoDVKSWGynfv9BGOEYXGy9NMR4njp862VMtTqOrPp96jmOaain5hDH2xhsAUD+F0
         mZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/XQPTUQdnIxsmo3yaVIj6Nhp7ayUgTHZ2bwUnPNImsM=;
        b=WxVMaN27M6wyGbmoi4op9I+qlrCKg+kWNoNONCqw2S1aoU9d4HT/J9EPTrc8T1OHs0
         06RNj7SNz2RhouaWFzfUk03mFM7yYDEwM3+Rn/5STTZbhGWM2rPDOjvLAT2C3vWjQrH2
         q1l9cnOjjr00AL4AkXrlyl4l5vZyedQrHVvgNsRjRYLgNCDBNv0cMiw9SD84CEQyYxME
         TKTmKjCFrKF6Dpq2HIKImQwAwOovDc/yGBKP/uB9ObZqblRqC99OLtooo4O2QvJobqxN
         h8fIPuXD4lWIGUwKTBOx0umJpg1/MoqsDq9L7OB+PM3rX4BMTMHqSRX8SE14fBENCjs5
         TSYA==
X-Gm-Message-State: APjAAAUBGE2f2ch7CgZAw5WZi9si9WNt7r7Er/ExcucbhPa+EN9lj/k8
        MMpBhqH/E+FMRgAdgpj5olQ=
X-Google-Smtp-Source: APXvYqyEXXvmBDJFhtUty1uv1FGUNd0Ur5OhXUk9ZCW72Fx+BuP7WqteYWkiW8tLMyajdedzB7HOhQ==
X-Received: by 2002:a63:c103:: with SMTP id w3mr3193120pgf.275.1572920607597;
        Mon, 04 Nov 2019 18:23:27 -0800 (PST)
Received: from jamal-desktop (97-126-66-56.tukw.qwest.net. [97.126.66.56])
        by smtp.gmail.com with ESMTPSA id u3sm15397779pgp.51.2019.11.04.18.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 18:23:27 -0800 (PST)
From:   Jamal Shareef <jamal.k.shareef@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jamal Shareef <jamal.k.shareef@gmail.com>
Subject: [PATCH 1/3] drm/tegra: dc: Remove space after parenthesis
Date:   Mon,  4 Nov 2019 18:23:20 -0800
Message-Id: <8e5b985c756f33decd07a728b7fc24b5518b3b47.1572920482.git.jamal.k.shareef@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572920482.git.jamal.k.shareef@gmail.com>
References: <cover.1572920482.git.jamal.k.shareef@gmail.com>
In-Reply-To: <cover.1572920482.git.jamal.k.shareef@gmail.com>
References: <cover.1572920482.git.jamal.k.shareef@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes space after left parenthesis. Issue found by checkpatch.

Signed-off-by: Jamal Shareef <jamal.k.shareef@gmail.com>
---
 drivers/gpu/drm/tegra/dc.h | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 0c4d17851f47..01fe9cc078ff 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -406,15 +406,15 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DISP_ORDER_BLUE_RED        (1 << 9)
 
 #define DC_DISP_DISP_COLOR_CONTROL		0x430
-#define BASE_COLOR_SIZE666     ( 0 << 0)
-#define BASE_COLOR_SIZE111     ( 1 << 0)
-#define BASE_COLOR_SIZE222     ( 2 << 0)
-#define BASE_COLOR_SIZE333     ( 3 << 0)
-#define BASE_COLOR_SIZE444     ( 4 << 0)
-#define BASE_COLOR_SIZE555     ( 5 << 0)
-#define BASE_COLOR_SIZE565     ( 6 << 0)
-#define BASE_COLOR_SIZE332     ( 7 << 0)
-#define BASE_COLOR_SIZE888     ( 8 << 0)
+#define BASE_COLOR_SIZE666     (0 << 0)
+#define BASE_COLOR_SIZE111     (1 << 0)
+#define BASE_COLOR_SIZE222     (2 << 0)
+#define BASE_COLOR_SIZE333     (3 << 0)
+#define BASE_COLOR_SIZE444     (4 << 0)
+#define BASE_COLOR_SIZE555     (5 << 0)
+#define BASE_COLOR_SIZE565     (6 << 0)
+#define BASE_COLOR_SIZE332     (7 << 0)
+#define BASE_COLOR_SIZE888     (8 << 0)
 #define BASE_COLOR_SIZE101010  (10 << 0)
 #define BASE_COLOR_SIZE121212  (12 << 0)
 #define DITHER_CONTROL_MASK    (3 << 8)
@@ -422,17 +422,17 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DITHER_CONTROL_ORDERED (2 << 8)
 #define DITHER_CONTROL_ERRDIFF (3 << 8)
 #define BASE_COLOR_SIZE_MASK   (0xf << 0)
-#define BASE_COLOR_SIZE_666    (  0 << 0)
-#define BASE_COLOR_SIZE_111    (  1 << 0)
-#define BASE_COLOR_SIZE_222    (  2 << 0)
-#define BASE_COLOR_SIZE_333    (  3 << 0)
-#define BASE_COLOR_SIZE_444    (  4 << 0)
-#define BASE_COLOR_SIZE_555    (  5 << 0)
-#define BASE_COLOR_SIZE_565    (  6 << 0)
-#define BASE_COLOR_SIZE_332    (  7 << 0)
-#define BASE_COLOR_SIZE_888    (  8 << 0)
-#define BASE_COLOR_SIZE_101010 ( 10 << 0)
-#define BASE_COLOR_SIZE_121212 ( 12 << 0)
+#define BASE_COLOR_SIZE_666    (0 << 0)
+#define BASE_COLOR_SIZE_111    (1 << 0)
+#define BASE_COLOR_SIZE_222    (2 << 0)
+#define BASE_COLOR_SIZE_333    (3 << 0)
+#define BASE_COLOR_SIZE_444    (4 << 0)
+#define BASE_COLOR_SIZE_555    (5 << 0)
+#define BASE_COLOR_SIZE_565    (6 << 0)
+#define BASE_COLOR_SIZE_332    (7 << 0)
+#define BASE_COLOR_SIZE_888    (8 << 0)
+#define BASE_COLOR_SIZE_101010 (10 << 0)
+#define BASE_COLOR_SIZE_121212 (12 << 0)
 
 #define DC_DISP_SHIFT_CLOCK_OPTIONS		0x431
 #define  SC1_H_QUALIFIER_NONE	(1 << 16)
-- 
2.17.1

