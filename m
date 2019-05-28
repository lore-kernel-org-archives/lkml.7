Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8ACC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8E8208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LmD9YyG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfE1JEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:04:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36052 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfE1JD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so30641126edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOGyYDuulYoZlGMMrGlYnho9Xow/hNHN2r6g5KqqxbA=;
        b=LmD9YyG7s+OqvV8GaC+iTvVDRdtjPeq/zghiL4J+/ZI7u5Eg21vxnuzwTFovpBti8O
         3LjHgkfSbO5QNC3qJK3ek9epxYfj2V3oUkdq1yYwA2dDDqa0UrVbBDP43PYt6yNfhlLc
         AWLn+vFL5yhJ8lJhJdU43jJDDzQDEKyiJifa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOGyYDuulYoZlGMMrGlYnho9Xow/hNHN2r6g5KqqxbA=;
        b=NiNbkrbQ28lP+njWdmc23AOOzDj7cLEGYsZPwEjZAx5zO87rvixxhs5I9CO9UXBZ1l
         im61ciwBghAoynJh7qVE2YQIuMzfw+1ScRzy13DX1/0tLreZ0glR5pj80ost1nIvA0S3
         KdfidlVTCY40z+o/qRNtA5JgtqVME4BCEkFREadAr2uI8WnI4pmwEiYrN3sOYguOZzhS
         fJtzLwXvhwF6/HG6F9BGjykDMAB25xn0A5vHLpYQgyjfZYViSdE2AvpJMNUw53qwMC3N
         g4tTy4EfGdrbDZdf7SfOiA3BXh7ojUEgpVELvfeQJDB9nmc86c06MVhkH/Lo4RTcVycI
         W8NA==
X-Gm-Message-State: APjAAAWwFzsjj4BuZNxi4Wgjtp5vJZ+0HHtAVrNsiYEO/I+Midmj1XC2
        pamA2EQtEaJv7o4Xek9xNhUupz6b+N8=
X-Google-Smtp-Source: APXvYqyUrqB+xoH0ka3duTbZa5FPC3QZa0uDwLH0U5RXdNxaQd1JKD8pOMMaPMJ2kKeKORQcacvUQg==
X-Received: by 2002:a50:e048:: with SMTP id g8mr128055262edl.26.1559034236177;
        Tue, 28 May 2019 02:03:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:55 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>
Subject: [PATCH 31/33] fbcon: Document what I learned about fbcon locking
Date:   Tue, 28 May 2019 11:03:02 +0200
Message-Id: <20190528090304.9388-32-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not pretty.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index fbd28aeff307..d6ba3610ee83 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -88,6 +88,25 @@
 #  define DPRINTK(fmt, args...)
 #endif
 
+/*
+ * FIXME: Locking
+ *
+ * - fbcon state itself is protected by the console_lock, and the code does a
+ *   pretty good job at making sure that lock is held everywhere it's needed.
+ *
+ * - access to the registered_fb array is entirely unprotected. This should use
+ *   proper object lifetime handling, i.e. get/put_fb_info. This also means
+ *   switching from indices to proper pointers for fb_info everywhere.
+ *
+ * - fbcon doesn't bother with fb_lock/unlock at all. This is buggy, since it
+ *   means concurrent access to the same fbdev from both fbcon and userspace
+ *   will blow up. To fix this all fbcon calls from fbmem.c need to be moved out
+ *   of fb_lock/unlock protected sections, since otherwise we'll recurse and
+ *   deadlock eventually. Aside: Due to these deadlock issues the fbdev code in
+ *   fbmem.c cannot use locking asserts, and there's lots of callers which get
+ *   the rules wrong, e.g. fbsysfs.c entirely missed fb_lock/unlock calls too.
+ */
+
 enum {
 	FBCON_LOGO_CANSHOW	= -1,	/* the logo can be shown */
 	FBCON_LOGO_DRAW		= -2,	/* draw the logo to a console */
-- 
2.20.1

