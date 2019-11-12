Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34F2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC082196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSi3bo6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfKLRJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:09:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39645 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:09:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so3779648wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q25FqYYq1HlyGPjqgeEbhuqnD600bhraE2cbn15efDk=;
        b=DSi3bo6cDFdgW/C5P50IUyxuHVbJaIT1KQDQJxZkX6fp/LeiGw+F1rG3TDvh0ejvLL
         +syJXdzdFaFffRg7au/lmwpJEdUxQszlMT8S0Up5Vg1LSJvN8wf5L8MoRRGxUDoOS9PH
         iVfi8QICo/cylWoEXrNxkZ7VyUM6cZyeQFg0Pzh2/GoHIa+Giazla9tmWg23/3weCbNl
         CW14uWAm8jBHY3j0C2UGlQFhiWMWffPnJ4qHXg6NWdQuNl+Oe88OmSuvxMO7yAhqkVGb
         x16L6LSwcTuWS0Msty4MCBjXhsSnPLhgD9Genkzfg4gs0SpBy0gVXclGzSw/LC1UDeAI
         Cpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q25FqYYq1HlyGPjqgeEbhuqnD600bhraE2cbn15efDk=;
        b=EVhc5bY7vKF/+DpZAcRxz+Alg+0C7bJEGA5w81Sm/b2vTPy0cLXJ8UGoQ7Y3GYkcgs
         SPrcro+gov16swFgSDWWhiUMEfGZMoqyUnfpg4IIB1lH7ughDtyb4IjEvxMafvUhlZ90
         lWCKjP49Rx5oIKfjl19GqW9Fw139qIH5msbubG2Rm2lhTZ2JUejbyJuSZTB9J5ce65lC
         7069YGrKOuvkYRwCoUEypwlWwj4r4debQ4/iUS2Z6YkRg4u+u5ky2+tXVvZWAGCJzU6W
         mWYyUdM62WVdIEtUwqTnF07v9Z8C8YAmcP21+87T9mBmrEAcb1LDjZy1gaSIq3lInVuZ
         Hkcg==
X-Gm-Message-State: APjAAAXPVQtycwsKb6bVaFQtx2p79cmlIXZjveQ6ueKgxrw6kzXdvuEK
        APAHCnak74sMrYaA4p8pHypF380LpSQ=
X-Google-Smtp-Source: APXvYqw392tT7DEaSUIK7JTdFQ8zHu8LaLkki7a5br3mb2UbvC8pRr6d4QNExxepW5tBpGF1rKulxg==
X-Received: by 2002:a1c:7412:: with SMTP id p18mr4893680wmc.9.1573578558909;
        Tue, 12 Nov 2019 09:09:18 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id b196sm4413071wmd.24.2019.11.12.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 09:09:18 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/print: add DRM_DEV_WARN macro
Date:   Tue, 12 Nov 2019 20:09:09 +0300
Message-Id: <20191112170909.13733-1-wambui.karugax@gmail.com>
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

