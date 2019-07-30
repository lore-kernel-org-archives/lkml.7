Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B396C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F35E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GVGjSJLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbfG3SQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41948 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfG3SQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so30270958pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxEPX0Crt+HozwMckgTER6BzS7Gj7DRj6+re4zZk/6c=;
        b=GVGjSJLrWBTsdA1KeCTr4CnfI7MnJBxVGr27mIz4n6aw7/OB+K0ph/a7E4sQqaNoY3
         2nPzxcjkDDEkxnRsbIWiUrVSiT9uoK2eb2oQrwGDOaWIrPaGLF2/30/A0yBuV3Kl6PKl
         PE0ND22m63oDOPxMaiv0vPBd0xZ6g8YBoelBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxEPX0Crt+HozwMckgTER6BzS7Gj7DRj6+re4zZk/6c=;
        b=B2FXg755K/qF6hmEfdbIEV2jE4ouimvBYmjiZJxrMXase2M4qRxkmoyATTn4BhsEhE
         VIbWGl0XcOVA5wfWPbjldZdMaz9aiDsQrpvBM2tiI1vffOIbEFbVJ5h2ZtNL3Xs9xa2U
         gWopT5DoGpPLd0kXyv/HMnt4TPm/uN1D4kxk/5Tb/Tt7RAtrmtabBYBaWmtkyl3k7pDs
         JlngyyFrOBAgwzVlxkJCVl+fB5QgcHKzj4g+QiTJAwErzO2SsS+D2s7vU/v16hbkmPis
         /4+uFSQmXL4wlA4urE6IU2uV5aq0TGw1Jt4ySWSocFbcdxNzW7KEjadBxC/ha+xCCWOT
         I1Wg==
X-Gm-Message-State: APjAAAVWGurw+0XleBEkVvkepX+bObz39cpwEtrO4TiTL0pyOCsKh91J
        4DgGu1Zy5hTQBrHmtWN2NlTFhzsQOac=
X-Google-Smtp-Source: APXvYqzqmgMouzy2XYEH6mPfeX1+PAdYNUs9PEZtUnzeyupIW0G/pvkGPsmC8euAlb2LGoaeXNisJw==
X-Received: by 2002:a17:90a:ad93:: with SMTP id s19mr117904573pjq.36.1564510569568;
        Tue, 30 Jul 2019 11:16:09 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:09 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 12/57] extcon: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:12 -0700
Message-Id: <20190730181557.90391-13-swboyd@chromium.org>
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

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/extcon/extcon-adc-jack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
index ee9b5f70bfa4..ad02dc6747a4 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -140,10 +140,8 @@ static int adc_jack_probe(struct platform_device *pdev)
 		return err;
 
 	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
+	if (data->irq < 0)
 		return -ENODEV;
-	}
 
 	err = request_any_context_irq(data->irq, adc_jack_irq_thread,
 			pdata->irq_flags, pdata->name, data);
-- 
Sent by a computer through tubes

