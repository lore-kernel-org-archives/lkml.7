Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FAFC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA012064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bBO1J5JP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbfG3SQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:32 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:38223 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387938AbfG3SQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:21 -0400
Received: by mail-pg1-f170.google.com with SMTP id f5so21657456pgu.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIrb+9QaGrA4CxQXfjzh8R8nezV9TE3Cr6X1Du3E37A=;
        b=bBO1J5JP+T89dQ/AK5V/4pokKB9uzaFyrwa96E1/SbzrfJTzO4Y3yUjeEqgJIN0WUw
         JRU0KK+nKZEkJk6q1EFJSMyazZJYZXlfevGzM35kDazcNK0+LeZzSGRq4Gx6Qn9YLbZT
         BfqXsfy7fKDgwkMX2KVusmK2TSONRi9xdXNks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIrb+9QaGrA4CxQXfjzh8R8nezV9TE3Cr6X1Du3E37A=;
        b=VyUcyzfjmSMD3UGwybXNd1r3K01BcrF3j1ZUTZfti9HfLHzFRnm4x7sBgrdoHtQeQY
         DmHFQ3J3kFt5XnxmOCCMiL5CyESDh2Redh/PR2hP7r/d5sDC6q7OEEoaZPY42rVz9fan
         BTSfYjOi8+jqom+Q+BlJltxaXXapwxdUX9nscP2E/ZFv28JOTgqAp1sDTzRLDV9P84HN
         zIKqtvGVJuzAjVkdKQ1TVBgAIvVCCn234Mb8yzy8mESEZt1SWN0eblaZQt9NAJnAL6kM
         B+JoYf57mxxCyNCDI/4+pRxQHlsyq5lrFtY3w1xu/pVekjZGioBTV1qXN/On2z2AhzUJ
         3BTw==
X-Gm-Message-State: APjAAAWnWlylsqrMJre73QFUwobrKkGuk96pQfocRjK9wQz1CSZ+XrtS
        xQw29SNgOXqgex6SfxNcUhnv94BbNU8=
X-Google-Smtp-Source: APXvYqzfX9/j8wRFCU35IpH+6gTm+zZxJarJo017uuRZ/2EPYjlSvPGjcUVF94N0fWxKE6YhmN2o1g==
X-Received: by 2002:a63:7d49:: with SMTP id m9mr102025210pgn.161.1564510580676;
        Tue, 30 Jul 2019 11:16:20 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:20 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Markus Mayer <mmayer@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 26/57] memory: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:26 -0700
Message-Id: <20190730181557.90391-27-swboyd@chromium.org>
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

Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Markus Mayer <mmayer@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/memory/emif.c     | 5 +----
 drivers/memory/tegra/mc.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 402c6bc8e621..f021687ecc5c 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1563,11 +1563,8 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 		goto error;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(emif->dev, "%s: error getting IRQ resource - %d\n",
-			__func__, irq);
+	if (irq < 0)
 		goto error;
-	}
 
 	emif_onetime_settings(emif);
 	emif_debugfs_init(emif);
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 3d8d322511c5..851983c67fc1 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -677,10 +677,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	}
 
 	mc->irq = platform_get_irq(pdev, 0);
-	if (mc->irq < 0) {
-		dev_err(&pdev->dev, "interrupt not specified\n");
+	if (mc->irq < 0)
 		return mc->irq;
-	}
 
 	WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
-- 
Sent by a computer through tubes

