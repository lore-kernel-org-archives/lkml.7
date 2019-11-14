Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1578AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE07F20725
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rds8wS/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfKNNZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:25:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35259 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfKNNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:25:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id 8so5891264wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 05:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q25FqYYq1HlyGPjqgeEbhuqnD600bhraE2cbn15efDk=;
        b=Rds8wS/qzXNcvC3Yd9f/9XdyvTQZ3Uht/UdVssSaiVWMebYp+LefE9/zU1mQKhPYcG
         rqPaBRv9FIUj1gh70+cLk7DG/OrEI9Zf+eFRgqaRCH+dZam7uZLaGPgmIGf4MQz6UeNy
         BtAq2oFoy958LNz9eMEe0z+wc4DgSymvgksD4Oh9j846cWK2FiE2j66n2K13H+fgH8Y1
         P5Qss2xAvPiMNCGzltZv3vh8w0Kgclob0u9jLh9M2yumRm2YjnEDIOc+njNf16DNfWuP
         nWHjjdqV1qnlKajPHaqXymwBjZ3sKCpaT6Kd70M99pjohJRP0RP0Pf2lcpfp4LdLUw3i
         VPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q25FqYYq1HlyGPjqgeEbhuqnD600bhraE2cbn15efDk=;
        b=tJTotOiY/rIdeXFz/YmvJWfKDwlenZeUYo6waNAlZNqaC70jvPEwjm+rA61dcMQL5T
         mHQYRUk0BJxNzyMev32GEQtBwkEkXhgpZ/PxKzvECorjGSxJ7G1YBmntG1pgbGTTL/EK
         fByjy17xObkT6nbkb5kpWaS+b+0D6jfngB/BFYC8a7a/FCOmAo25DebY9eWTAtcFAtZo
         hHHsI4v2QsLEW6u66w3HaFU3UClFM76VHGE7jpg7QcoB1Xg2I/CCbrqwZCFiXmfACVHP
         JMwJWlABC0qiVvN8W3EpEjvnThWYWV5Vllm5HFGHGOgoXiBXs8bLQs8MFXroHMG6KVDw
         NhjA==
X-Gm-Message-State: APjAAAUhsiqREv7jG9imiX4s/Ia3f8DyorLdGdleRUEruYlrva2L/a/w
        O4B/V76m7/Lo3SedFa2AtcQ=
X-Google-Smtp-Source: APXvYqxDxppIeOPFqQWV1zapmmqSUALzzrPUav1RgTbEN138v5mV58ouZdmPPao15Uvzkn43K/TCWg==
X-Received: by 2002:a1c:e386:: with SMTP id a128mr8279022wmh.52.1573737925338;
        Thu, 14 Nov 2019 05:25:25 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id l4sm5897905wme.4.2019.11.14.05.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 05:25:24 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        hjc@rock-chips.com
Cc:     heiko@sntech.de, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/print: add DRM_DEV_WARN macro
Date:   Thu, 14 Nov 2019 16:25:19 +0300
Message-Id: <20191114132520.7323-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DRM_DEV_WARN helper macro for printing warnings
that use device pointers in their log output format.
DRM_DEV_WARN can replace the use of dev_warn in such cases.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 include/drm/drm_print.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 5b8049992c24..6ddf91c0cb29 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -329,6 +329,15 @@ void drm_err(const char *format, ...);
 #define DRM_WARN_ONCE(fmt, ...)						\
 	_DRM_PRINTK(_once, WARNING, fmt, ##__VA_ARGS__)
 
+/**
+ * Warning output.
+ *
+ * @dev: device pointer
+ * @fmt: printf() like format string.
+ */
+#define DRM_DEV_WARN(dev, fmt, ...)					\
+	drm_dev_printk(dev, KERN_WARNING, fmt, ##__VA_ARGS__)
+
 /**
  * Error output.
  *
-- 
2.17.1

