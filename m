Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B3EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74662208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HUmM6fWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfE1JDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42982 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfE1JDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id g24so2697739eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2XhY37QKiJG0yVeCBJVjNjQRjgX7g+zT5YuLsuJlT/0=;
        b=HUmM6fWW1Qkokcj/zd5Ot2If+OrST6LgqHbbva3UHFF9eJkoMa8t9wN30uRB3Hil7i
         Hc91q9/ULJ947zUpmJgPZwcZmOAeI2WYWWQPocRGWKVj2wKtRnHlrfxXz9WfvOVZabyR
         oBmw1pFE2OHFz+mZds0Vm6nwXAK2VxZ9stb/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2XhY37QKiJG0yVeCBJVjNjQRjgX7g+zT5YuLsuJlT/0=;
        b=lbuORl72pPb1iJfy9BTRGWyKznVtl81q/JyP/C/kToD6ftTEHF879AXEK+jne0MQEC
         wZW10NHET8LbEFkXW/bpZjGE8wooyM9Lp9GdkK9xjWI5SYRxoWA33++wvzryAj8qJwEl
         N/hyAwru3/HLG2uMzCxHU2UZlkzu1Qq7DFKMhJpQZgKuXKxkZ+/r0z2hP9G7+MCtFZwr
         esOLX2tQ1djYiBJ/pdUbbZloe0PWtnmr66QZKCJnC+aYUsmPPpU9X+EImGD5rtjk9JF0
         MRlM/FaLj5ujw4yspHSskchb+ChYGIxyPNKNv2MOev2Ho1otXfLw5MbaRlbA6mVJ8KMT
         Odfg==
X-Gm-Message-State: APjAAAW3UHuI2YYCMBDkj5B35HqZ7yAhnGlEVgv62SHf4YHwM20TUHlx
        kslLrethfhN42wvVTt9H1z6NVPJKyjo=
X-Google-Smtp-Source: APXvYqysJqma/Cwd8MeT0Rq/SJ2o0DZ5nqO5ai6mqVm0Hq+p9CdMzlw4b+pi8PAdwAc8N8a+yr7I9w==
X-Received: by 2002:a50:991d:: with SMTP id k29mr126603128edb.29.1559034197127;
        Tue, 28 May 2019 02:03:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:16 -0700 (PDT)
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 05/33] fbdev/sa1100fb: Remove dead code
Date:   Tue, 28 May 2019 11:02:36 +0200
Message-Id: <20190528090304.9388-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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

