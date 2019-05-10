Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A88C04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E17217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MHB8Lky9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfEJSB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:01:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45454 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfEJSB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:01:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so3352178pgi.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbtCsKv7hG2/orbM/XgL2O3eOGHr7k43kMSlYIHqPRs=;
        b=MHB8Lky93XR/C1O9SsZiIo90x9iJ0xNSA/OJ2OdT3k3uBaSScU5hXNEF1AFpyh26er
         RF3MJCnb5wT3aI5JNz0qkDIrZ2GBuyuhWw4lVrnC9oAV9Niir+AI4qUoJ6PwEenwS2k4
         sqAS2jjgJdkRuJPTC7hFXF4oFYcJyew4Z42kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbtCsKv7hG2/orbM/XgL2O3eOGHr7k43kMSlYIHqPRs=;
        b=XZFWwj0B3b9/pe9DatCwnG1kHV7T91rzD45o4QvzMTCyrlkQItjXXpyiiV1/3/he6I
         7XYTuOuSBI9ZDe8HoVHZr0NY/oyfEzAJ4YGMGadub9YSUAadXMQp6X+dsPQY+6XXEyml
         3qxj2Kpn+6U5HRq34lBnZIN1/QDO3hmXU6pNw6ACxL6N3DMyWOFeKhE5By6h5kM31Y8H
         nhjTqEWmCAUT/Afb4x3UMOP0Ak2FuCrDl9JMuCbcnroupvJi59bbd0y6f/6VSy3nH528
         GnKfvKcpWxYK0Yb17HQL0nArfpZpvZZC4zBoHpY0dWCDq/I9GjMzW9s3tJT+tXPgsBUJ
         JDHw==
X-Gm-Message-State: APjAAAVN640jDowZXRe9PH2zw2sj5tiZUwmNaCBHv4pxhDhJwSmpXbM+
        CP3C77b/f4DF/zh4LnEJxH188Q==
X-Google-Smtp-Source: APXvYqyD9MttCW2kkXWSSeKI9jwZ2G/llntfGe7CGcA+4Bbk6a6MWVLyLkzt7Xtk89rzsBgkVD6gxg==
X-Received: by 2002:a62:528b:: with SMTP id g133mr16396095pfb.246.1557511315420;
        Fri, 10 May 2019 11:01:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s19sm7556740pfe.74.2019.05.10.11.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:01:54 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/5] firmware: google: memconsole: Use devm_memremap()
Date:   Fri, 10 May 2019 11:01:48 -0700
Message-Id: <20190510180151.115254-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510180151.115254-1-swboyd@chromium.org>
References: <20190510180151.115254-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm version of memremap so that we can delete the unmapping
code in driver remove, but more importantly so that we can unmap this
memory region if memconsole_sysfs_init() errors out for some reason.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/memconsole-coreboot.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/google/memconsole-coreboot.c
index 86331807f1d5..0b29b27b86f5 100644
--- a/drivers/firmware/google/memconsole-coreboot.c
+++ b/drivers/firmware/google/memconsole-coreboot.c
@@ -85,7 +85,7 @@ static int memconsole_probe(struct coreboot_device *dev)
 
 	/* Read size only once to prevent overrun attack through /dev/mem. */
 	cbmem_console_size = tmp_cbmc->size_dont_access_after_boot;
-	cbmem_console = memremap(dev->cbmem_ref.cbmem_addr,
+	cbmem_console = devm_memremap(&dev->dev, dev->cbmem_ref.cbmem_addr,
 				 cbmem_console_size + sizeof(*cbmem_console),
 				 MEMREMAP_WB);
 	memunmap(tmp_cbmc);
@@ -102,9 +102,6 @@ static int memconsole_remove(struct coreboot_device *dev)
 {
 	memconsole_exit();
 
-	if (cbmem_console)
-		memunmap(cbmem_console);
-
 	return 0;
 }
 
-- 
Sent by a computer through tubes

