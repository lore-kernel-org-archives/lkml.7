Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED8DC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E032184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fh9fskoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfCNOGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:06:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32842 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfCNOGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:06:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id z7so4958992lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JoQ110Vrf5AK+4bC4NE84QgdDWXytINhD/OhnOqdP2Q=;
        b=fh9fskoBT47Vwj675RzPW0UE5fkcyMDhhOe+q6CHcqIRT5zxOUf36ugMa/Wb2sfRr9
         44NQWJiSF+Q3CJ+ChKv2dtVej7hZCQT8W4qYIIbf7foV1RoRPvXNdu6lYARood+yWGAh
         Q5+oOyY5mmC5jxZiKghVCDW3o8qHhWZx/j/0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JoQ110Vrf5AK+4bC4NE84QgdDWXytINhD/OhnOqdP2Q=;
        b=OZF57P2DDvwV/Sy1Rh+E3Fk6qd3PbyQiPk92m7Vw43Ig7zrVjiDgj8gD5oGpvi0Qu4
         PK9TlJB77e1q6Bj6ApLQX56LJp4E6qhfqDw8dguxa8ciXxScXc8KaybT2CO8w0NI+U/G
         sK9Fo+2hGxld2qmb6Ov6hLaM0cxvpSZZDjxyb1XVMCgoxnbdCsVOQrzxBi0HPLN6xiu9
         5i1dANvvVGIKC31nTWULmH4wBm9VE2an/ghgvFYR6vcLuAsL8/xW+MiAMxzfIYpbxuE1
         weO5tPhuQ2nZy1Wboix4LZ0s/YfXErnBSvVj2O30wLYEvVfHASi1fuc5BrUyhNHMifNn
         GPeQ==
X-Gm-Message-State: APjAAAV3UpNvp+737EJ0S5VHVqoH5qrFMVYKaHV1qRX3Lm8QGjrMlS8q
        mrzNOlSfsU6zXyJLtkRLmoJQHg==
X-Google-Smtp-Source: APXvYqyOYohGgB0sG3iRGfHom9JlFc6Nj2LHp8FJ5PhmfMu6I0p2WK0L7KEPf3CtiClLGeAnZttvtg==
X-Received: by 2002:a2e:8585:: with SMTP id b5mr26572298lji.125.1552572389418;
        Thu, 14 Mar 2019 07:06:29 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t14sm2733709lfe.51.2019.03.14.07.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:06:29 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 5/6] leds: netdev trigger: add documentation to leds/common.txt
Date:   Thu, 14 Mar 2019 15:06:18 +0100
Message-Id: <20190314140619.3309-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314140619.3309-1-linux@rasmusvillemoes.dk>
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The various sysfs files used to configure a netdev-triggered LED are
already documented, but let's also add "netdev" to the list of things
one can reasonably set linux,default-trigger to.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/leds/common.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 70876ac11367..7cb88460a47c 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -39,6 +39,9 @@ Optional properties for child nodes:
      "timer" - LED flashes at a fixed, configurable rate
      "pattern" - LED alters the brightness for the specified duration with one
                  software timer (requires "led-pattern" property)
+     "netdev" - LED can be configured via sysfs files (see
+                Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
+                to reflect the state and activity of a net device.
 
 - led-pattern : Array of integers with default pattern for certain triggers.
                 Each trigger may parse this property differently:
-- 
2.20.1

