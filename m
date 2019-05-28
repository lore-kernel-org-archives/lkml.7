Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891AEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F09C208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="I/7AsYIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfE1JEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:04:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37330 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfE1JEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:04:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so30611563edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HU1EQ+v38P9QJolnmXZTrOO2rSD6T7u0Lqw2ZLkiLWs=;
        b=I/7AsYIlcIbykNwShZDT9vqdf0W2l+mAfbQvvY1pNwfgs1W0LbkA4t+YgIW85/3uHO
         bTSykFOJBi17eYvOrMy8aAuO/GbqB2OLqAj4V9SBcfmO69y+tfbM0o7u5JDDHKRZ4I+y
         c4JkYTOM0jo97idl5z+S/KV2EusVrq92+9MXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HU1EQ+v38P9QJolnmXZTrOO2rSD6T7u0Lqw2ZLkiLWs=;
        b=tGgHvKzKnBTVma1+CuMDVQeySLJUSTKEj/NdGykMuV6xy7lgRhOM6nDwTldTw9zTdv
         8yPmj2If3Quty3GIIlrd15QXogqXpgGJX6iweEe1lg378nCIp6i0lhPyUL2oMjefHH2T
         Q9Pnw6ZBSEyu21UQ6jR5OUiMNQaVH+x+YdM9keuvsii3akvGjSbwYOwOE8Ygl+FhBuxl
         8hTzu2M6noWrC66S6vT3MyT/ahXI44foxG2Nizs8/CRDpx+rPn0nWvndeir7lAtMlIdl
         /YbZfmZq4aIpJIGCFPV9IKD4SComr7Spp+sl54uFu5d0O/bKyGymgUcvszopwR2aYdeE
         h7dQ==
X-Gm-Message-State: APjAAAVIovfNt0Z2HmaZPSOHRv0QrNVMB5nEF+2e7o0N8jVt+1Do98xU
        I85/kJr+OT/s/FWduhER77hS6TEiP3s=
X-Google-Smtp-Source: APXvYqz9RdhfaDx2JF7fgePZMlTSmHplGB4DlBCTqMFDkYawJ7AszXHKVriOXKY3FK7S7TQRU+5DbA==
X-Received: by 2002:a50:b3a6:: with SMTP id s35mr129117953edd.220.1559034238538;
        Tue, 28 May 2019 02:03:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:57 -0700 (PDT)
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
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 33/33] backlight: simplify lcd notifier
Date:   Tue, 28 May 2019 11:03:04 +0200
Message-Id: <20190528090304.9388-34-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all the work I've done on replacing fb notifier calls with direct
calls into fbcon the backlight/lcd notifier is the only user left.

It will only receive events now that it cares about, hence we can
remove this check.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/lcd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index ecdda06989d0..d6b653aa4ee9 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -30,17 +30,6 @@ static int fb_notifier_callback(struct notifier_block *self,
 	struct lcd_device *ld;
 	struct fb_event *evdata = data;
 
-	/* If we aren't interested in this event, skip it immediately ... */
-	switch (event) {
-	case FB_EVENT_BLANK:
-	case FB_EVENT_MODE_CHANGE:
-	case FB_EARLY_EVENT_BLANK:
-	case FB_R_EARLY_EVENT_BLANK:
-		break;
-	default:
-		return 0;
-	}
-
 	ld = container_of(self, struct lcd_device, fb_notif);
 	if (!ld->ops)
 		return 0;
-- 
2.20.1

