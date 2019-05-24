Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF74C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377592175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ed3N0BtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389844AbfEXIyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45514 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389778AbfEXIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id g57so13290447edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjZOCAqCO3l6sOylMJV3BG1AKBRXEuG+IGCZcKuozWA=;
        b=Ed3N0BtCGy2KrRjxgTqaTL3MHlzGpZBsTTx8FSTmwmpH0uBFHwRKyPhA/jP7Z9Ep6q
         TJd+LpH/8IMbH3/A57PWAxKw+6Umw2mgAPzSRXA6eUbOaKXykY0YzLmiHUBDoaeL0zqT
         4b3/gaoPpvVyAEmwrbiirj1Bobt5V1KRsZlgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjZOCAqCO3l6sOylMJV3BG1AKBRXEuG+IGCZcKuozWA=;
        b=RBuTjnrbc5smfczHouc8I5ZkCr3/Q+aoe8bMHmuFsawvujKbOywqGidZbrXi9qw05T
         wTYLzrX4O7R210/4J7m8BrLJ17Ztn9HmjyJzvqHAwmV7MVLm7Wgvw39BbpZW0T2OHVu3
         nF0qCB7KX2Rknl+rTz5HMLrP6Czx8ji1JOIRWvOLiTZY9yWTGyN4yvm1MumkS42+3HP7
         8SZ5WTNuQWp2qrFb3KO8E5xyWzQYXwcjxt9u6N3hUQ/8QkdNLwJtwgaLPy/BcNN8kHuK
         McqvPOMc761WGvmNWvz99Jm/Chw/f5AtKfstlMBxTwFBG/P9PBtkZFUIIefWFl1YfpcL
         QS3g==
X-Gm-Message-State: APjAAAVGsDrm9TZfpyCSnDNJy5bZAq3/xKbkNmFDdIXY/bF9J/cd4Cgm
        j0FOKMClddyIDSR28B9rEtsCfgBx+/o=
X-Google-Smtp-Source: APXvYqw90JW22kbymXTQpmSH2wtmpc3E7xGbmiBHk8MYvAt3SJf376+g2NAganFHL+j0ca7tqriJSQ==
X-Received: by 2002:a50:ba1d:: with SMTP id g29mr48994176edc.298.1558688043136;
        Fri, 24 May 2019 01:54:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:02 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 02/33] fbdev: locking check for fb_set_suspend
Date:   Fri, 24 May 2019 10:53:23 +0200
Message-Id: <20190524085354.27411-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just drive-by, nothing systematic yet.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/core/fbmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d1949c92be98..8ba674ffb3c9 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1985,6 +1985,8 @@ void fb_set_suspend(struct fb_info *info, int state)
 {
 	struct fb_event event;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	event.info = info;
 	if (state) {
 		fb_notifier_call_chain(FB_EVENT_SUSPEND, &event);
-- 
2.20.1

