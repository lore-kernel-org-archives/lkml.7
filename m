Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C41C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6397820733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7xQebnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfKOM4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:56:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38973 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKOM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:56:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id l7so10875862wrp.6;
        Fri, 15 Nov 2019 04:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zl2ziWu9h9r+anHj81CPAfex8e8EGnRdPPch4YNtMiQ=;
        b=K7xQebnIDdBtsKSe6FwIP/b+aZDnURsKt2OkpT05PVRTFHvfiBs+djJMAESReJiRaY
         6S/t3NOfJIG94ptKw8OrPU6okP/sX10J8J2XClyNpigLlsOgiAj5K2i4LSo7OY1tkddE
         ObUjjbU6IKRdNSLH618FhmefwUTYrBMCr+os1ZUky8udoMocFHI+maxEBeNs4YniCmD8
         kFE854F05ruWbXswau149pEQwjdgcTK3dWAHsoSymSZzbxmcX37c1nbbjTqY96nTbReh
         Vwl90K1tiWMe3R/xvaqEMb7mgs3L2Masir/SP98cuxf8HuVacbtuzWndwqOy39Lk176a
         x3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zl2ziWu9h9r+anHj81CPAfex8e8EGnRdPPch4YNtMiQ=;
        b=E+xoOa2l4JDMFDj2U+Fd2pr1vd4qsxdWOnr04wQg+fLUhJQ5ejLsTqlxbBfg7RWhpS
         /13Sezm9x3liNJOk0JwLab4i9Dh/IDJomgFbA5WLOlMkav79pBvHV/20XLDbdH8kTdgd
         CQC0oZ/NQJkMzTC3PaVpTl2XrflDYnx8yaOuRstWisYJMxljfivq/J+ovBkXjho2qST/
         uAr6wKFO2FdHRQnFer1bZTe/NIPD0FleMB+BaJRPUX66+cRNXJpy8un3XnzSumeKb+yE
         fBA+u7Xsg/Do1IK9ZbdvxvXDNFqzpM2LulqBRk+0c5+2kcZ+QjLmvUSL6PQ2sESSNrKB
         xoJA==
X-Gm-Message-State: APjAAAU3nd9jlBk0Xh5pLIzTEjRo8oJ8hKuxrYHOCAaNsG8K/PApwd6S
        m+kDv7HtvrCWDNGDsEzzhxs=
X-Google-Smtp-Source: APXvYqwwCV2gTXDlQV8u2BuA95HjOtF9SccJemzA5pxrwuJwzDoqjqKOeNqXhQB0JsySb9EyfQTWuA==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr14581960wri.138.1573822588646;
        Fri, 15 Nov 2019 04:56:28 -0800 (PST)
Received: from localhost.localdomain ([86.121.29.241])
        by smtp.gmail.com with ESMTPSA id y67sm10483122wmy.31.2019.11.15.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 04:56:28 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH] gpio: mpc8xxx: Don't overwrite default irq_set_type callback
Date:   Fri, 15 Nov 2019 14:55:51 +0200
Message-Id: <20191115125551.31061-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The per-SoC devtype structures can contain their own callbacks that
overwrite mpc8xxx_gpio_devtype_default.

The clear intention is that mpc8xxx_irq_set_type is used in case the SoC
does not specify a more specific callback. But what happens is that if
the SoC doesn't specify one, its .irq_set_type is de-facto NULL, and
this overwrites mpc8xxx_irq_set_type to a no-op. This means that the
following SoCs are affected:

- fsl,mpc8572-gpio
- fsl,ls1028a-gpio
- fsl,ls1088a-gpio

On these boards, the irq_set_type does exactly nothing, and the GPIO
controller keeps its GPICR register in the hardware-default state. On
the LS1028A, that is ACTIVE_BOTH, which means 2 interrupts are raised
even if the IRQ client requests LEVEL_HIGH. Another implication is that
the IRQs are not checked (e.g. level-triggered interrupts are not
rejected, although they are not supported).

Fixes: 82e39b0d8566 ("gpio: mpc8xxx: handle differences between incarnations at a single place")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/gpio/gpio-mpc8xxx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 16a47de29c94..d88ebefb8147 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -377,7 +377,8 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	 * It's assumed that only a single type of gpio controller is available
 	 * on the current machine, so overwriting global data is fine.
 	 */
-	mpc8xxx_irq_chip.irq_set_type = devtype->irq_set_type;
+	if (devtype->irq_set_type)
+		mpc8xxx_irq_chip.irq_set_type = devtype->irq_set_type;
 
 	if (devtype->gpio_dir_out)
 		gc->direction_output = devtype->gpio_dir_out;
-- 
2.7.4

