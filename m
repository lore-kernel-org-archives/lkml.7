Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8872C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2B42175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cvyCEwSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390277AbfEXIyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34401 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390179AbfEXIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so13377867eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VFKuM3MW7HhJw8g+F0ZAMGgocYe76vTXpU+uF+1TQo=;
        b=cvyCEwSj1QIHhiUcfE6glzcCA2U8gdeQg0UJH+eLHNVqhr9yA74lr76XhDC68i/K4s
         ySqXKthJaclCts4kf7qGy4NZyjN9KsaoOAoblQUPftMCEF/SeQQBYvkHtmqPvnJ5Mrm+
         4wMOGUPvzJhyy1ifC2pEL2npDGzuVq8hf/6JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VFKuM3MW7HhJw8g+F0ZAMGgocYe76vTXpU+uF+1TQo=;
        b=nhFCWMM3Ev89fmil6EFcmhCv9QF84ewowXfBgvDjk2gubUp35YRAPSSElEXJiQ/0nH
         jfOLfoyQ7JC9BqgQ8KSTPDhCO+S9eCnXy0OwgGnHM/LpGsOCgAyvbBwgb0z2KK/HdJAv
         uVTBIXumLbzFdVF+6MPRu48xios0r84Xxl+iFg2hNVrtACKAFSemtvpdn+Hq/irSdymz
         Y/ihycBRH9r/uC7WIKWAmHtu84+KCIaqDVMSU/sAeHKiiEUodydQFz7Zm/+gm40ZOTD6
         Eq3O+/BVf0MEvecXEq4iT+XxUEbGxdg6equoDW6phgzZ9zaoAx2HhNtcIc7yhYQAtUSl
         A72w==
X-Gm-Message-State: APjAAAXx1ML3DTLcX4rKt1ya5lSQIl0+9SZGq4qP9zBpni15cmTq8iF5
        /6sxMecTYf8N7YRmsa+RreWCOYIr4Jc=
X-Google-Smtp-Source: APXvYqxEVgu2quVopIofi1fANkMhstACI2EGNdT+MIZH3gHRE5pFQbfKt9ctKt7SsMjsTvmXSEszUQ==
X-Received: by 2002:a17:906:2ac5:: with SMTP id m5mr81917352eje.71.1558688082399;
        Fri, 24 May 2019 01:54:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:41 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>
Subject: [PATCH 31/33] fbcon: Document what I learned about fbcon locking
Date:   Fri, 24 May 2019 10:53:52 +0200
Message-Id: <20190524085354.27411-32-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not pretty.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 6a4bbb8407c0..8444d5151c2d 100644
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

