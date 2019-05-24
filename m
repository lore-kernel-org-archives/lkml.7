Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC6C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDF0217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Nh3n8kL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390291AbfEXIyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44500 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390248AbfEXIyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so13304637edm.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NmvrGIUWQkTElry91PwheZTmzBnjKP7PR8ohbwjeRGw=;
        b=Nh3n8kL/lOQMsn5ZR8TvohBEqbIzE7Lgj3nCIy9tF9DcXQiDN/rMDZEKzdjjQlKv2v
         DBcU1thQcKCne7ZjTeekcxfx+fSPE39PVenj5kjlxDaGWTjihc9VVQH/EXPWiuIuPEI+
         oThhEVt/uxjw2gJKXFL2oGTpb8aHJS//3bOh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NmvrGIUWQkTElry91PwheZTmzBnjKP7PR8ohbwjeRGw=;
        b=BoXeUwAmzPxQ0sm5rd8Gjc0o5hNzULdPHlU1FKhNk7bG03Zo/2mgb4gRrmUO+fnQqe
         Hhq8JTCh6QIrGezYwCkD93vWPMfN0Fa13VurBBZPTZteC2Gpx8mlxz8IVvGSr0Ymy9Qh
         A9I/F/b0zQ9fZmbVPu+DQVq10PrN1T276HO52U5UWIhwyTZmPqxK7HQ0FIPxqCmmrO66
         WIv/Qmygd9Fvyo+OEucXE7XnWIOvpox5Vjl/wd8FmFxIJC12wzveEDNXisfAua5IY/Le
         m3f9dSLvV6qj/VdRLCBDHbz+8wns/IOUchpxfiyG9olJdnaTlO700khZkaNx9PSfdwQO
         wr6w==
X-Gm-Message-State: APjAAAXqmXVDIZf6Mkiv14h/PMvTfroE0JOTAC9gA/nUR4H2OmXHujiu
        ratcIg+oP8TdfMTPqBwCLKB3boG/jcw=
X-Google-Smtp-Source: APXvYqwajf0oCHKmp7dOkjnUHWvBU13ALDXZf5gmM/1TI3Cp7xnjVwoelMbSOCmGIhHgMN29lqIMcQ==
X-Received: by 2002:a17:907:20cd:: with SMTP id qq13mr55869127ejb.170.1558688084971;
        Fri, 24 May 2019 01:54:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:44 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 33/33] backlight: simplify lcd notifier
Date:   Fri, 24 May 2019 10:53:54 +0200
Message-Id: <20190524085354.27411-34-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
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
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/lcd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index a758039475d0..8ea5e5937ae2 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -29,17 +29,6 @@ static int fb_notifier_callback(struct notifier_block *self,
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

