Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D358BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36842084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTvATzP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfEMOq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:46:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37326 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbfEMOq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:46:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so6897330pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=hDlLp8gwqnQ16UXEzX9Fg7JeC4W1dA1vA7VjX4loo84=;
        b=nTvATzP8y/LakwhSQ2DIU1KrlhMsKpIwBwryGeJMQIrmAnjalB6jhX7fO2R02kh8jg
         X/RdM0CtJ6rLAUfW9nMloT9NuWt6b+i609Cj8+5iHOo8pysmnrYf52+YjAqrfjUmZiyg
         /ZJK52Vi5J2nE34G3SURY8GBFUE2k5vMbrro3L1ARN9pplHxP62PaXelCyBq3xakOSf7
         2+tsUFTS3lo6D9JO7JD2vAXJ9DTL7SCmYPvCfc/M/EowNnxu3lOyIaco6JDXo3al3mFM
         r741hMrA4DcsGNtXK6ot4kHwBcLjmmjj8Z90rAJKnogexEO9DQbBRbDsnIZCWQqVKT3o
         j/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=hDlLp8gwqnQ16UXEzX9Fg7JeC4W1dA1vA7VjX4loo84=;
        b=n9Br+jIEdABOSOQ9B6+58MJUHw0B7KbJahvKg52vieXg9fw/toSp5ONl1876RwkuEj
         LZVAsjT73p990tZ+Zb6cqBgEthLgnQTJ46NrREpzeKaI6uu2BzgWA8NTAW02Z3IcKp0S
         4vocxmtu8t5MqIZzTiZGXxK2f4N2C/67hzKHTTV6mCxJVoQCvyOuomCgvpfG8E5Bg8k5
         xRTEUq99VTg3M+I3lKPRRzuj/1+qONaMXY5DAIcnP68u3ImLe2AUVVykJXMKSF1le2tK
         A7kufr6WMQot15fh9VEO3EBvpQfxhYtPDzSDgASWP9m5v6LLPu5BfVSbHtpN37UdYbIi
         1Zcg==
X-Gm-Message-State: APjAAAVsGj672cCVXabiy+jFEVBuBTHaZE/09RbVWdUv20mzPYcUVrRv
        t8ZdK0R64lU7eNngX9JQb9E=
X-Google-Smtp-Source: APXvYqzzzKQrUcOIQAOnu8TxTyv4WlQpQe+3fg6rcjWThxHbMUApW44a0tOe/dwk7j4A3kW8QMGZ+A==
X-Received: by 2002:a63:e645:: with SMTP id p5mr31283713pgj.4.1557758785882;
        Mon, 13 May 2019 07:46:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e62sm17928873pfa.50.2019.05.13.07.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 07:46:24 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eric Anholt <eric@anholt.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] drm/pl111: Initialize clock spinlock early
Date:   Mon, 13 May 2019 07:46:21 -0700
Message-Id: <1557758781-23586-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning is seen on systems with broken clock divider.

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 1 Comm: swapper Not tainted 5.1.0-09698-g1fb3b52 #1
Hardware name: ARM Integrator/CP (Device Tree)
[<c0011be8>] (unwind_backtrace) from [<c000ebb8>] (show_stack+0x10/0x18)
[<c000ebb8>] (show_stack) from [<c07d3fd0>] (dump_stack+0x18/0x24)
[<c07d3fd0>] (dump_stack) from [<c0060d48>] (register_lock_class+0x674/0x6f8)
[<c0060d48>] (register_lock_class) from [<c005de2c>]
	(__lock_acquire+0x68/0x2128)
[<c005de2c>] (__lock_acquire) from [<c0060408>] (lock_acquire+0x110/0x21c)
[<c0060408>] (lock_acquire) from [<c07f755c>] (_raw_spin_lock+0x34/0x48)
[<c07f755c>] (_raw_spin_lock) from [<c0536c8c>]
	(pl111_display_enable+0xf8/0x5fc)
[<c0536c8c>] (pl111_display_enable) from [<c0502f54>]
	(drm_atomic_helper_commit_modeset_enables+0x1ec/0x244)

Since commit eedd6033b4c8 ("drm/pl111: Support variants with broken clock
divider"), the spinlock is not initialized if the clock divider is broken.
Initialize it earlier to fix the problem.

Fixes: eedd6033b4c8 ("drm/pl111: Support variants with broken clock divider")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/pl111/pl111_display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 0c5d391f0a8f..4501597f30ab 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -531,14 +531,15 @@ pl111_init_clock_divider(struct drm_device *drm)
 		dev_err(drm->dev, "CLCD: unable to get clcdclk.\n");
 		return PTR_ERR(parent);
 	}
+
+	spin_lock_init(&priv->tim2_lock);
+
 	/* If the clock divider is broken, use the parent directly */
 	if (priv->variant->broken_clockdivider) {
 		priv->clk = parent;
 		return 0;
 	}
 	parent_name = __clk_get_name(parent);
-
-	spin_lock_init(&priv->tim2_lock);
 	div->init = &init;
 
 	ret = devm_clk_hw_register(drm->dev, div);
-- 
2.7.4

