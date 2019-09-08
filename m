Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE7C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A833021871
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNSou3uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391941AbfIHB2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 21:28:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43356 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfIHB22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 21:28:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id d15so6901213pfo.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 18:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/og7QWBk3tTPC1uU6UPyqBtYUYQLNyBfN0kn6w31nc=;
        b=rNSou3uHGlI9AWB5kprRiAT76DLABO920K6HFBjHc3PNgEQdZEURoKNKSRRcEAB/Cz
         nOJUzAAd/8ahJF4RKE5/7Hw0Svz59Y8PsiSTWozs1NZBSIyGhHpM6sKj5ANiLr2VToRo
         xhLuC0o7tu92Cn1LqgfRegLH7aRXFpKd84KSzllHam6QyrrGlpssE5pHYXDOghIxUz0a
         +Acx5DtQtftpUFajXsr3kCwxskTkB8C0rCflEzhD0cVGgzftY6gw5p12oQp58qr87JIh
         apibBFE5LT72zkh5XyiD+LHb7tdTRLSlhafaTzkdoh6nIA7OP9GhfV3B9eOAy8mc2c52
         oj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/og7QWBk3tTPC1uU6UPyqBtYUYQLNyBfN0kn6w31nc=;
        b=MRw6Vvgm4ffYqgdadGrIyZ2dV4nTogwpLBZF9s5dVTPfG/bl9Nv0YArrWyf5zc+XrE
         1aHPZasSyDZ71zlsH58DAtOU7hWe1i04C7FcKex9s8vpL0a0eEwlOCfGtQsOh2gF9rhV
         bAUiAjiKsehapCe1CztXoOzmX2VEndCCSojVnk79AbW+VHZPaBxRmC1kLn6swx4eCy20
         9RU2qH0Su7yP0tSjalHU2HDjhvCZW3DBzpDNFkOQ8anBHwmcanmupSBMyyx10skqU02P
         Qd6DmSJehwgfEC9aqLnTit7psd5EonHI99CwIgRIN/yKxqQVuNNinofK8WxfYniGZKXn
         4k6w==
X-Gm-Message-State: APjAAAWCOLSN8v+67l6CdHK9vtX46HUtzH7oyahXPkC3VfBwlTyqfJde
        2Kf97TEjlD/ZRONB+73Q3omcGLm6QDI=
X-Google-Smtp-Source: APXvYqwMtbajqxtDr/c+qIAbqUGBUa+5zROlULv6RnsfhCqgsKzd2rPOSO+fVYJn5xuvwW1xKiPGsQ==
X-Received: by 2002:a63:70d:: with SMTP id 13mr15270256pgh.326.1567906108163;
        Sat, 07 Sep 2019 18:28:28 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id s1sm18367884pjs.31.2019.09.07.18.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 18:28:27 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 2/8] kconfig/hacking: Create submenu for arch special debugging options
Date:   Sun,  8 Sep 2019 09:27:54 +0800
Message-Id: <20190908012800.12979-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908012800.12979-1-changbin.du@gmail.com>
References: <20190908012800.12979-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch special options are a little long, so create a submenu for them.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 868fa64a0901..96047140be93 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2146,6 +2146,10 @@ config IO_STRICT_DEVMEM
 
 	  If in doubt, say Y.
 
+menu "$(SRCARCH) Debugging"
+
 source "arch/$(SRCARCH)/Kconfig.debug"
 
+endmenu
+
 endmenu # Kernel hacking
-- 
2.20.1

