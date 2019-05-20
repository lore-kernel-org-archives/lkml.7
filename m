Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60561C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A9120815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dAezrIqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfETIYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:24:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33535 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbfETIW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id n17so22607515edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UC6980ATt6g2nqFDn2Bpgan2GTqp4ZZAGnr3VO2LjI=;
        b=dAezrIqrBzbowSUT4bmjJHvFuoRDUot4TIt1DhCg1IdwLfIZ3foHIhAdtsVYqWZwkH
         LtfD6E9Lp7CdA0Ph5XoRHNGw3IYX/hRpt6SrjJ0o0ikqzT8aSMWH8VLcAZjH2VdaA0DA
         +zsohuUeum3CLs9yqrlxm9Bd+Anxdag2Obl88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UC6980ATt6g2nqFDn2Bpgan2GTqp4ZZAGnr3VO2LjI=;
        b=HXNBYkJD/uHUO2Z9K9N0MICSHoE0IzWlsQ8XG1egQjaqNVwX9LIkmrqym1fkf2XDbd
         /IiyrGO6fb4o3yn9343Btc9t9zgXxPKgxVMv1vx+1oURSv43Bx7ktekABfLj6rIlOlhT
         nnLOXBCm645XYderI71Sqz3ppk+1qimiPdoDXl4w3Hl3xAWhUK3Z4mqEkeq4o3iM8CEd
         SKs0LC/wDYa5iO5hViabGrbijiFdUq33wRZgtoAfZoWYVs5Ld56gskGlaQSSFZCNjSzS
         0vIyGswYmo3CfGlMIIJ5hGBI34inNhCEcj20ihoID3H4089LiDselHhVlkwnakvxHu/l
         tW1A==
X-Gm-Message-State: APjAAAUrj5UoVngQ8NibD47l11504CwzAheXwL/KUUoVBa9U9dZ1P3Rd
        uiwSpiDFP3AOtJkFwC/06gedhA==
X-Google-Smtp-Source: APXvYqzDLu9/GndEePgiMrQ6/ujxXJCreTf5PlH4FgvtQmGS1mXtvAIi9EhfVpK0KKXgJ8vPKQxX3Q==
X-Received: by 2002:a17:906:b741:: with SMTP id fx1mr5110659ejb.45.1558340548318;
        Mon, 20 May 2019 01:22:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:27 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 05/33] fbdev/sa1100fb: Remove dead code
Date:   Mon, 20 May 2019 10:21:48 +0200
Message-Id: <20190520082216.26273-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivated because it contains a struct display, which is a fbcon
internal data structure that I want to rename. It seems to have been
formerly used in drivers, but that's very long time ago.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/sa1100fb.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 15ae50063296..f7f8dee044b1 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -974,35 +974,10 @@ static void sa1100fb_task(struct work_struct *w)
  */
 static unsigned int sa1100fb_min_dma_period(struct sa1100fb_info *fbi)
 {
-#if 0
-	unsigned int min_period = (unsigned int)-1;
-	int i;
-
-	for (i = 0; i < MAX_NR_CONSOLES; i++) {
-		struct display *disp = &fb_display[i];
-		unsigned int period;
-
-		/*
-		 * Do we own this display?
-		 */
-		if (disp->fb_info != &fbi->fb)
-			continue;
-
-		/*
-		 * Ok, calculate its DMA period
-		 */
-		period = sa1100fb_display_dma_period(&disp->var);
-		if (period < min_period)
-			min_period = period;
-	}
-
-	return min_period;
-#else
 	/*
 	 * FIXME: we need to verify _all_ consoles.
 	 */
 	return sa1100fb_display_dma_period(&fbi->fb.var);
-#endif
 }
 
 /*
-- 
2.20.1

