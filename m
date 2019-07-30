Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51751C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29107208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TlcSYsi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfG3SRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:17:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46700 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388066AbfG3SQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so7122435pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+82S8/9l3RlSCvnKeKawflqrH/StvaK39xoOnKGt6wU=;
        b=TlcSYsi7glyOH7X4H9JlbNDkm8XjBQAstYeWbgqw07zas2P03f2K8Fjku1aCMmICrP
         I/C/tHGKoIOIBF7EgAlxUMLYRlZ6t7WXDgkenvI4mrfT0xj76QqFx55XnQa+kJAf2quY
         JbDflPAIZvaWBK9jq09BWz9zZL2Y3ZafI6Q3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+82S8/9l3RlSCvnKeKawflqrH/StvaK39xoOnKGt6wU=;
        b=fgGyArfJHlz91EycrnIM04JBJX9n/vfsmQgmZvYuvIcKoEM37BuyheJH4yYaJhuB5O
         7RV695tS19hCwYRHS1S3e10yfXJ4IZenLVOPlYY7VELm0JZsKeNORMZcjUEfGLEb9ozD
         xqeiTjBaRCf0W27FG2FdKxcge6ndetX765nBnRdS/mb97czGzfrkMXFJFSQE0br0MPQu
         dj9mEFrK/qNubz/LmQCAUxFKPleVrM4V8vgisGRaticf57qnYEaYfVKCemsS0hbSnPMe
         F0WM2DMf/lisPwWdPDpvpVROjqKCuuFo0DYh/juFUmHlVocLtHnj9zuV+6JwEuH4jesh
         VwYw==
X-Gm-Message-State: APjAAAV9GMKXLeDOMmatos//+CYcPpXJxkuUcTydFBUnthMUS/s7Sm3a
        w1YSbOhyUufLHPo/AV3tHWra5owdQh+YLw==
X-Google-Smtp-Source: APXvYqzspcViBxAdQFIJUu2zDdjB8LRveAOvdGlL903eu8SOsqoKLVYBqb+YpIQB9b+wpB2mcyLdYg==
X-Received: by 2002:a63:8a49:: with SMTP id y70mr15165970pgd.271.1564510604947;
        Tue, 30 Jul 2019 11:16:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:44 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Roman Kiryanov <rkir@google.com>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v6 55/57] platform/x86: intel_int0002_vgpio: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:55 -0700
Message-Id: <20190730181557.90391-56-swboyd@chromium.org>
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

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Darren Hart (VMware)" <dvhart@infradead.org>
Cc: Roman Kiryanov <rkir@google.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/platform/x86/intel_int0002_vgpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
index d9542c661ddc..4f3f30152a27 100644
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -166,10 +166,8 @@ static int int0002_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Error getting IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
-- 
Sent by a computer through tubes

