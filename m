Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A3C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65D820989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HRwgYNCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfE1JGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:06:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33559 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfE1JDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so30687379edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wpi1xWPy33lj9mKcPzFNSCGKIPsIrM24U07obZg4Bbk=;
        b=HRwgYNCSeirp12RNt1fyc5OhQoszF2Uo7tDWacf52/s+HTFiZCUvyKuqcMcCFLqTo7
         osyTlqilBk3yRLl/Vm39fichaec5uHYWxg/SR+yE+xqDXUsKId+uFHmCikQYi4P9iErW
         GcKPar6d/CdwBiFSNkAYtg+09d1NA/M8qXEg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wpi1xWPy33lj9mKcPzFNSCGKIPsIrM24U07obZg4Bbk=;
        b=RmBVupr6hFYlSBw+Hol/oxuNonqhfQODD8EGg5oGh1OTe0K77Dxw7xWkuFAxYFI9Z3
         RySTPFvnu4/mQG3brmTHcddaDi3aeWoyZdU7TGzOYxw8KQ5ILCzEEpg0kUdiBCfunapu
         JNPvAAgGyIXiglQ+fShC8mTdBZ8LMNYtYsn/k+ftmf8+B8RaW8dMPJY4waOT7pEiH9ug
         Nipu1Gx7R0gs63+kFScmfrfpc7urUdmfz/CHYLnq7SUbrVRTwJ4auHOkDjln7fD2Dsg2
         523m3WqdO618byzApXZEHmleny7K8ogR8MHu/stwUHv9QEFgSVfdsogDwJLDuj7+Zgcy
         aWww==
X-Gm-Message-State: APjAAAXpolEVI3UQagJt6fWS5IE9Sym8LUZyon9W96nMkJF0LnCc+jtX
        QLiWng6EcGxBUD409kxT3plwXHsqz0Y=
X-Google-Smtp-Source: APXvYqyMZ+XP/DYBnT+b0/bEtV1bg4DZ2v7pGi2tkNPgOMj6ozhRdzLU/jwSi0kUA3Q+ESL/hNZuXg==
X-Received: by 2002:a50:ad98:: with SMTP id a24mr127149884edd.235.1559034200289;
        Tue, 28 May 2019 02:03:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:17 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/33] fbdev/cyber2000: Remove struct display
Date:   Tue, 28 May 2019 11:02:37 +0200
Message-Id: <20190528090304.9388-7-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entirely unused.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/video/fbdev/cyber2000fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 9a5751cb4e16..452ef07b3a06 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -61,7 +61,6 @@
 struct cfb_info {
 	struct fb_info		fb;
 	struct display_switch	*dispsw;
-	struct display		*display;
 	unsigned char		__iomem *region;
 	unsigned char		__iomem *regs;
 	u_int			id;
-- 
2.20.1

