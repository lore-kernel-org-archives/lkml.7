Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A28C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2622175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MXvhQ883"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389900AbfEXIyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36577 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389848AbfEXIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so13341283edx.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UC6980ATt6g2nqFDn2Bpgan2GTqp4ZZAGnr3VO2LjI=;
        b=MXvhQ883ZI6MjoDcmscQSlUHPlY4GSGpnnDA7EA0oL6KCVyvdIJCcSA8ZDob+rYv4Q
         Yrk2iypjjBOiEc8bbaoBiT/LxMHAUbs29PGFrSSCOCFddDPLeF1ApmMfSQx33fqaD3qL
         5ewV+rgyTUCICdJmwbrcAG6Ua66Y3MSNyoDNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UC6980ATt6g2nqFDn2Bpgan2GTqp4ZZAGnr3VO2LjI=;
        b=llViSxGylWx9XgHW33lOMFquoE84Zi0Ic3tYMfzpt6vvw8IJvJVs238EhiAZrN+qBD
         2Gqy5qZ6Vo3EiaCuCnfLa6Vy5JCxILLHc6Ya5S9S7mbMwVZym+wf/W6XBBMSg9YlWKUo
         a3hkHAHJat6jKs13yWW9vNjT/0q/S5iKgqEFRxpvGQKSbnhJ+YQqpouTk+hgGoUN9cVp
         QL7WoWn3Hft9KudHNOBPApiPqcjeT/TW0GZOfVNyXQnm4EOTYuwAWCzfKQzoLErQaA0X
         Tj/fH/2ebLGNv/uIVeB9zFrSbh904WA+uHOd+QLRw3tFrvPr/EkmrOjcYiH0cjL5tiIs
         f0ZA==
X-Gm-Message-State: APjAAAWPYyuLH0zFvRjEXFZbCblTKVQXPXFtzb5naB1FQEIASOVaNuV+
        PBDMxr0qxsgDEEmsxQCwhi4TGQUQeDk=
X-Google-Smtp-Source: APXvYqwTY3aF88Cn8gj5s91H5pdsh0XKSkWschqmBu0U2owFwDrDJnYNwYVmMODqBB3WlfzTrjql6Q==
X-Received: by 2002:a50:91e3:: with SMTP id h32mr8775962eda.103.1558688046885;
        Fri, 24 May 2019 01:54:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:06 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 05/33] fbdev/sa1100fb: Remove dead code
Date:   Fri, 24 May 2019 10:53:26 +0200
Message-Id: <20190524085354.27411-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
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

