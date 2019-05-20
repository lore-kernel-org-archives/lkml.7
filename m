Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F98C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC20F20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fdxIA47E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfETIW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33530 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETIW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so22607297edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+7lASPDHVp4K6Shi6AhuJ3vCu7cy9RDPQGFtgAVXYo=;
        b=fdxIA47EdjdY0cAD59y+tCVIUFAcmt0tExaffadsAFlVmlZ8JqvFsP8koUpxE9wSpH
         k+EmmKz6vl+ykzYBeKPaQCP9IAnfqdF7RppIkaJCFu/UcmKLRSVP7teK6x0UwcvAxlkF
         FQf4alrfYArjUBDWAskQ29Ppbr4fa71rZV97s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+7lASPDHVp4K6Shi6AhuJ3vCu7cy9RDPQGFtgAVXYo=;
        b=MsFWUm3vFuHP/ZRamUFdB2Wjng5qdvDTkUzmMNEYb+cYKlhfsrjUn1k8iKV5fOP0Z6
         J8IM3kezlqigkLudf9hHOB60wuVCks1v8fOtLE6H4Foud9L+oTxYym4bWcJWfRIb3oAc
         RPQ4DOFXs8M6+qnjWflhjxrItmvwfTqPcWWz898oxe4Wu/DAPHK0Aya5GrLINAlGvblU
         CtBDmMUa4hmim/3Ai0hYwXGVy+1MpJoZUXNS8KaJ3mgDhSPz4mg1VzzGLiF07AJLlFZ8
         sFBKAcZVYQTGcVuU1E6rGaACkq3kVMW7RrY8XSNOBDSSw6o490R05igpsNy0EfhDryyf
         58Ng==
X-Gm-Message-State: APjAAAUo27X+rsIPrvNua/LM3add8/0Z18cTxhDT8oXUfgI5cfaxMIjJ
        AMrx0mvnmQ1eCDzebibZ10MW2Q==
X-Google-Smtp-Source: APXvYqzH5cPNdv7MYAD+y/4MNq7TDcKB1eyAl64aeRO4GzFk1JnGrIJO/wyx6J/F/ggn0Pw2mY0qXA==
X-Received: by 2002:a17:906:6603:: with SMTP id b3mr57042868ejp.128.1558340545071;
        Mon, 20 May 2019 01:22:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:24 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Date:   Mon, 20 May 2019 10:21:45 +0200
Message-Id: <20190520082216.26273-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
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
index 4721491e6c8c..fc3d34a8ea5b 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1964,6 +1964,8 @@ void fb_set_suspend(struct fb_info *info, int state)
 {
 	struct fb_event event;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	event.info = info;
 	if (state) {
 		fb_notifier_call_chain(FB_EVENT_SUSPEND, &event);
-- 
2.20.1

