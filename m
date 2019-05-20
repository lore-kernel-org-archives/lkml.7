Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2993C072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FA420815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Br4lGjx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfETIWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39846 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfETIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id e24so22524252edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yy90SY5/chDu3adwLkHoQhEeL0uOM1NOJmociVMUU4s=;
        b=Br4lGjx6AYOmC8birJ2u22FSo+1D2WHdSA9O7P/G/jGX+VR9ZzrMY5zOKWlSMg+Ekk
         U7S4K5dfKQHB99S8s5RnjHdJHlT5nyX5dtAmtsyHAEu9H79HKy9hUb5l02yVlqUVeu2L
         gQtPbGsCys6UMB9HaTvvsi7CVFRsYrnsCEO8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yy90SY5/chDu3adwLkHoQhEeL0uOM1NOJmociVMUU4s=;
        b=rxse3CO6WhONUbDZOEKRLIKUmV+dJ2QTZaK6mtasKeuI8cRSnOSoFuxQkaw4R06ERF
         2QLh+IuamtA38PKKE0cRRJUvVE69upKcL4fYsb/29rSuuuuEpPChDn0bG9SNk+5O+1Yb
         O/SVkBs0aneqq30GCPiZdMrqFjFitcDKs5kq4ZCcKx80YsSQft/+510y+4f9SnVI4lQf
         JxQpMRpDafk40HmuRJC3Fr2aWxLEuBvqcjfA52IYvmAPM2UASTgtdnosWlxT/XIHOh+j
         hdMFwFajeUocLVsn/XUZjvdXsKl4XWxanVolLayBuJKmpGInB7BY52uCPf9XdU5K3Yhl
         u6TQ==
X-Gm-Message-State: APjAAAV5SYWXzQO4HtcBbh0SDXrgqEtRdlssgk8PNYnLQDn8k8mldrs2
        tVaabaZmSz6rTinE+zDL5N39K9b8ego=
X-Google-Smtp-Source: APXvYqxdWi1IjK9CrOPrKCYsIFhwO9cGwKSyfvFscq7wlo2HQm/gpu93fgQpMudhegtDzz3SNq4bcg==
X-Received: by 2002:a50:ad18:: with SMTP id y24mr74100466edc.64.1558340549704;
        Mon, 20 May 2019 01:22:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:28 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/33] fbdev/cyber2000: Remove struct display
Date:   Mon, 20 May 2019 10:21:49 +0200
Message-Id: <20190520082216.26273-7-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entirely unused.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
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

