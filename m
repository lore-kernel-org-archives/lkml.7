Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78733C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4614B20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q5shA3En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfG3SUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:20:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39163 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387867AbfG3SQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so26270011pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZRgwUFN7aB4QupotMQ9tCg3mqSsJrrXGetSngfezJs=;
        b=Q5shA3Enjh1aYJkGa7CHLSK5+sfgQkSZ+NssvYjmWJOmz6jPyn+icjg9Ylr31wCfKr
         ZQI1t3egzlysQAdSvtwCbBUBWF1hpTVJl2f4qWWYhcrXx7l3Yk1St/5UbhioCBq+y38u
         VTZLnVf7MATNHqp7i9IZjh2oBrf6QEpd8zFVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZRgwUFN7aB4QupotMQ9tCg3mqSsJrrXGetSngfezJs=;
        b=A+ba38pTfoD+yKhzq74YCEpcTypaTMMtGZ2LRLjKE3o4bogyZFL7pIMUGnjMSlAdZR
         mxk2Olrigs8ly7mZAlsepGc3cjSoaep+JM35mNgVKawg5u5zBF6eiO/395w/jNC/vc0H
         /9PFNU8KL1DMK1b34XXbWWXTK83zIrUTe1XuBX8RStPmdDc0XXV4Egm+mUKaUObB6F6X
         KZNSbDgzXWbP7YsKAjYvLLVgfydX7j4uFEQm8UI9Xq0pitseguFjafA3O0+KiQb7CTix
         po3YS0750AbXeVdLRfGigA0zVZ04B8e0C8t4tjj11XPYN2DWD0RjeVVrf9Rir1EcBTas
         TFpQ==
X-Gm-Message-State: APjAAAUw4ABMxD1Z5akjrwjF+xyr2TIU5vWS4h4bKcotRIvokxT7JDQm
        hS1a7MOPlHoe1SnU1/2CGShj+lYGsnk=
X-Google-Smtp-Source: APXvYqx19ne61WVROHtoaGvilmfZoa4IZoWg57447aBLoak0f0PYFfDKEDRft6xPTUrf1EGZY5Vgsw==
X-Received: by 2002:a17:90a:bb8a:: with SMTP id v10mr119609285pjr.78.1564510572816;
        Tue, 30 Jul 2019 11:16:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:12 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 16/57] HSI: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:16 -0700
Message-Id: <20190730181557.90391-17-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/hsi/controllers/omap_ssi_core.c | 4 +---
 drivers/hsi/controllers/omap_ssi_port.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 0cba567ee2d7..4bc4a201f0f6 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -370,10 +370,8 @@ static int ssi_add_controller(struct hsi_controller *ssi,
 	if (err < 0)
 		goto out_err;
 	err = platform_get_irq_byname(pd, "gdd_mpu");
-	if (err < 0) {
-		dev_err(&pd->dev, "GDD IRQ resource missing\n");
+	if (err < 0)
 		goto out_err;
-	}
 	omap_ssi->gdd_irq = err;
 	tasklet_init(&omap_ssi->gdd_tasklet, ssi_gdd_tasklet,
 							(unsigned long)ssi);
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 2cd93119515f..a0cb5be246e1 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -1038,10 +1038,8 @@ static int ssi_port_irq(struct hsi_port *port, struct platform_device *pd)
 	int err;
 
 	err = platform_get_irq(pd, 0);
-	if (err < 0) {
-		dev_err(&port->device, "Port IRQ resource missing\n");
+	if (err < 0)
 		return err;
-	}
 	omap_port->irq = err;
 	err = devm_request_threaded_irq(&port->device, omap_port->irq, NULL,
 				ssi_pio_thread, IRQF_ONESHOT, "SSI PORT", port);
-- 
Sent by a computer through tubes

