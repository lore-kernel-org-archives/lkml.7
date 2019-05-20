Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F88CC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250862081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Rbh03cPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfETIXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:23:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41955 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731482AbfETIXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:23:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so22532306edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FCOGJKruV68PCMlFcu0Jcdh8P9H2/Ftv0Ji3KZWmbUo=;
        b=Rbh03cPzhJBRqu9N582ybR/hmSNxX1iWpRzgNhumzuQbtDBL/jZRwtE6ZiEMqds9e5
         nCEi/0ReTps2K5chpBg2DyfeG8uZ0uMJ48T7NmIfs/PZqn8j6RZVAiv4FMoOYEF4THte
         f9YBRVbl9RZXkjWKtYSH8orRr9dQVQY+ptY/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCOGJKruV68PCMlFcu0Jcdh8P9H2/Ftv0Ji3KZWmbUo=;
        b=fbjGlykc8XMYV3bYDbT7WKkWNXbEsIGgTanPc5bRtVDF/2H6FkMswPRic0DjnXuKaS
         44qIfDgZpBtdUVforqu9+91rYtnxcnwIHCuGkXA6H+nn2lPYen7qHoV9rSSv6Ubso9xj
         zXnWfM+hTjOgF71znKeJdXE0Gdd7DIynyoxUMRKtivF27Ng3+7Rir64IK0kO/VDC28YN
         wqeZThvlY3mwwTNCtrw2HqYZsDBJ9gn7r/Oa1Zv+chLMVUUxfUK8eqSkIUC7E4FA9yqp
         0e5sNNq45xBDbhWTCwm5s64MTlBQpq3+j3SjkP2VwGOv4sTDwgN5qGnvCfpFx83Mw8HT
         IdhA==
X-Gm-Message-State: APjAAAXbzcjfwFxKZPMXfUjoitYeHJ3SoB2212SRlGBBXy1R8eDeGQpk
        cEGUYJsCHZvlonJA42ofcALYlw==
X-Google-Smtp-Source: APXvYqz+JhrLTRZhNTc3DaIv8DkUxRltlxdyj4OAkPrhoscMsBVYEJlPpazmYVAIf3UpLblLmQV4AQ==
X-Received: by 2002:a17:906:7d50:: with SMTP id l16mr57720102ejp.84.1558340579630;
        Mon, 20 May 2019 01:22:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:59 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>
Subject: [PATCH 32/33] fbcon: Document what I learned about fbcon locking
Date:   Mon, 20 May 2019 10:22:15 +0200
Message-Id: <20190520082216.26273-33-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
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
index b40b56702c61..cbbcf7a795f2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -87,6 +87,25 @@
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

