Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C56C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4592068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9W+t+Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKUVLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:11:10 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44159 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKUVLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:11:08 -0500
Received: by mail-il1-f195.google.com with SMTP id i6so4706657ilr.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JaaCoJhIAtiaGRJbRZpOo5H+WeeydykSc/pOM316fnE=;
        b=j9W+t+RhhqGREioB+OQ4YQdVQIGhvP3WBwyGcA4vwc9LYIpreG+dQ3OFFzMOvHoeKg
         wMnzuQDZ4vZtlZdzjsrJW5KJ00Um9wNNJ2n3pP/AY/1V8ulgXzNqIfXhr+insvuVvueQ
         Sg8hoiZjRai0ym7RscAaVWs4+YhrFdXxkxN34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JaaCoJhIAtiaGRJbRZpOo5H+WeeydykSc/pOM316fnE=;
        b=Qacr4Z0jPYAm175ghwIahD50eNaYMP+vbjICMmiTpqdPr6QrJRtHAAfnTJZBjkLqd0
         VI/uOIavDY+xabDL7eSwy3GvSfU5jBWVHQv9qekRGzrqJ1MXuWEhjg1tukhBE9T+3ts8
         gd7kS4+HoY3VW3H2ITwT152tl+CEZm0Mr7AsrpMJex6DnUlaWlUwgca4pVzMroJzY7v8
         ubLjqBUoenjONaCuHAAg6akXXv69ltrG0o6vdoyn5jx/sIxOq+P6HJUXug68H71ISLo1
         zFgN2J2zvX6TAp+stF5TUAg+gtKBASGGQqZYGB7INwSYe05VUbbgklnS3w5U+vSGsQsO
         NzUg==
X-Gm-Message-State: APjAAAVlYfSC4Op4bQSpcord13MmN9pVXrRuk9RYJPNEUqLcugTyWhdk
        ujYsL9BZKyAPpAFkwt6S3NLjVQ==
X-Google-Smtp-Source: APXvYqx6f+E1fUYsCsExoeBanZoyp3t+U17P+h3Absmz+O2Vi3g8wp2lbs11yxfLT0ryA9tfwTFLJQ==
X-Received: by 2002:a92:d64d:: with SMTP id x13mr12005275ilp.54.1574370666741;
        Thu, 21 Nov 2019 13:11:06 -0800 (PST)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id o184sm1718676ila.45.2019.11.21.13.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 13:11:06 -0800 (PST)
From:   Raul E Rangel <rrangel@chromium.org>
To:     enric.balletbo@collabora.com, Wolfram Sang <wsa@the-dreams.de>
Cc:     Akshu.Agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-i2c@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: [PATCH 1/4] i2c: i2c-cros-ec-tunnel: Pass ACPI node to i2c adapter
Date:   Thu, 21 Nov 2019 14:10:50 -0700
Message-Id: <20191121140830.1.Iae79baaa31014e8b1d8177bcfbcd41514af724f9@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191121211053.48861-1-rrangel@chromium.org>
References: <20191121211053.48861-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C bus needs to share the same ACPI node as the tunnel device so
that the I2C bus can be referenced from ACPI.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I would have added a Fixes annotation, but I wasn't able to find the
hash for https://lore.kernel.org/patchwork/patch/1151436/.

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 958161c71985..ac2412755f0a 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -272,6 +272,7 @@ static int ec_i2c_probe(struct platform_device *pdev)
 	bus->adap.algo_data = bus;
 	bus->adap.dev.parent = &pdev->dev;
 	bus->adap.dev.of_node = pdev->dev.of_node;
+	ACPI_COMPANION_SET(&bus->adap.dev, ACPI_COMPANION(&pdev->dev));
 	bus->adap.retries = I2C_MAX_RETRIES;
 
 	err = i2c_add_adapter(&bus->adap);
-- 
2.24.0.432.g9d3f5f5b63-goog

