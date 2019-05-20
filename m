Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E603CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC48F216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="buEEeU0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbfETOAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:00:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34425 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbfETOAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:00:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so7624wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bk5f0M6WXXbmXTgHtGqHLx2M1jGm6Hu++/ddevpUC3U=;
        b=buEEeU0rxW+e3VpPPy7csd4kPlVjuprnv5G+Zm6gKc+zaXk8TprUccdvM19Ccp4LXh
         EoR8MHoSYy73D0FMJXHN9UXVKLhiWJArCqWVFuKB0QtWmaEsDWRuRvpjbklW9/yzTiDK
         F1tAcywJotdwUGTOr5atQP0RjeO1WyFI0mwqr4M7Of9HhVKUKudFeuGMKjfsdXC2R7eB
         C4t2S/TzdMmRlAECyazDkOnLmHQzwzvS1BBVmm8rm2x93LXMIZZyUm/09M5VlhciSjMq
         1iT1sZQN/QXdKEXq+yZ0VZUHfIZvLof9jMsNr1FgmNIT96LWYQyIi51aTe35PwxOdKtT
         6RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bk5f0M6WXXbmXTgHtGqHLx2M1jGm6Hu++/ddevpUC3U=;
        b=RHINxcW8AXnzlJMXyzMiRaFEKpk6/2Dxq75KGDJwoCRWge/65wBK6xxGETRQIgRYLy
         TaGoX92g1B04SWa2Xk6FBR1xVZ0JBGoRrRve+2puhLqgvbJvsRaQBGBpeGgxMVQOMIYh
         lcFaaPlL4iBk0UxaJBMsVwL4oVFaIwP75Y6WJjNfoKUJChonDxZ2y2QW5irRouZeL+zd
         bsBCoI8OP+UHKR3UEIV8gKeWfhBpeN247eJZq+D187BBM28mU11PocYdNWaDEOK+hR+f
         6Pf4v/oWjisYNnABj8xI5EAmIMsLnjuY5JGK3AXV8coZbKnrotFhWmD/KeABGvKmBSyo
         vMCw==
X-Gm-Message-State: APjAAAUZvQmsEQacE1jQs9rOZdgAhhMNssQREDCmDhcjUDcahblIWpjW
        L1vtoRBMLOYV9ZS+F+K0hGSZfA==
X-Google-Smtp-Source: APXvYqweyz/vJLz3XSJrTqHAwkyOi496405Xmp7phDEGv3avQAvcYEUVMcBQhA7ylJbR35xK+RmgDw==
X-Received: by 2002:a1c:c8:: with SMTP id 191mr11326841wma.6.1558360810799;
        Mon, 20 May 2019 07:00:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l16sm28656473wrb.40.2019.05.20.07.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:00:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] clocksource: timer-meson6: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:00:07 +0200
Message-Id: <20190520140007.29042-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clocksource/timer-meson6.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-meson6.c b/drivers/clocksource/timer-meson6.c
index 84bd9479c3f8..9e8b467c71da 100644
--- a/drivers/clocksource/timer-meson6.c
+++ b/drivers/clocksource/timer-meson6.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson6 SoCs timer handling.
  *
  * Copyright (C) 2014 Carlo Caione <carlo@caione.org>
  *
  * Based on code from Amlogic, Inc
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/bitfield.h>
-- 
2.21.0

