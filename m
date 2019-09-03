Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A61C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB589217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCyz9slh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfICT0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:26:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36644 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfICT0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:26:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so18702944wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6JUyP0FdNo/yk/uL3/c0mgRsVP/O4y/TCGkUF765JIc=;
        b=yCyz9slh7ju286ICZKiNE8G0tYYk4BqAgeN3XepsFF8J72rIrhdVWcokpykTFH1wmk
         yJJCAq1SFBpgjq+t+wC4ycnlGSfxrkTN0CPSyiAE3Uxzurj1UvWhHKZ5xffH6z0Mt2XC
         exPPAHwtwHy2q5kj/mAqxsEFoHd86due2Y4MNi75WLFubFbTOChff9gM9meN1waXSa/A
         SETKYwDpRhG97zCf4+FuUQkXX9q8wM/wJCQKlsZQdKgGiCPP3gF5+BcKGQ3MTMO149sd
         Brg55ngi0l+p1VxdIfso7K/PWZmDtkSHBOhdO/x5PZSb9Ka0aSWe6VyH7ZaPhRwC7+0/
         yHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6JUyP0FdNo/yk/uL3/c0mgRsVP/O4y/TCGkUF765JIc=;
        b=gKo8lStM5c6KrXIB/CVVNpSgW1RTuWy9J5dZXhBFkQtEbC7FCSOF0TIglkNSiAAxUE
         27/0Qc0mBfrKTHL24GbchG3dU3SWTeqBjTYgR8f8ZZ8pFMnimwzj+5pj5WTbG1EQGB1T
         Uz0tG+5KldIyooDpSn+q4Xa/TZu9GAl6+mSfoLi0O744AYhz9AMPtIM1hs8O4Rf1UmVX
         S+89EbZjBQSX2tiTMrUX/TmirCzISpCdKC0PPy8lO10XqH/ZAqLtgGerEZiiKI+2AXZl
         7QL9Dg6J4y68q+7H9TsCRvh5NPy6BQsIztMLTVqQO/wxfLgiYl1CMwbG77riSldBnKUo
         Iesg==
X-Gm-Message-State: APjAAAXwyNDjV72MgO+q1DSjDMSDMKbeVjqZTMkZivKAKdpRUwT5Qnau
        arseZNvb6vZejiw8brT+1xxhaw==
X-Google-Smtp-Source: APXvYqxOFh4+JKlJkxxoUnrPJXNBF38dWEShmyG8xO/kat2UmctwVVTrwndd2ahi1ifNhfhkGcQhuA==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr283856wri.50.1567538793233;
        Tue, 03 Sep 2019 12:26:33 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id b184sm473895wmg.47.2019.09.03.12.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 12:26:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/3] arm64: defconfig: Enable the EFI Framebuffer
Date:   Tue,  3 Sep 2019 20:26:24 +0100
Message-Id: <20190903192625.14775-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903192625.14775-1-lee.jones@linaro.org>
References: <20190903192625.14775-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on the Lenovo Yoga C630 where this patch enables the
framebuffer (screen/monitor).  Without it the device appears
not to boot.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0fe943ac53b5..af7ca722b519 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -540,6 +540,7 @@ CONFIG_DRM_LIMA=m
 CONFIG_DRM_PANFROST=m
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
+CONFIG_FB_EFI=y
 CONFIG_BACKLIGHT_GENERIC=m
 CONFIG_BACKLIGHT_PWM=m
 CONFIG_BACKLIGHT_LP855X=m
-- 
2.17.1

