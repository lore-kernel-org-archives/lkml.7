Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962ACC31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9952089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y6IBXfaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfG3SQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45317 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfG3SQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so30253088pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tblS6BVfocVa/rJGDu0MAsbUNCheBT9eaxwmPT42hss=;
        b=Y6IBXfaOrrf4DvYbUVSN4l/eoXWSrdJZ+oKj9SEL5KymdE/wLLqwHq2yDUrJxQOmpH
         03e0bQ3NmwQkX7PRSsbzb4l06yliLX508MuAb0Erk/73Q3CWM4vFIjzua0Z/YeZXt8yJ
         m9XWFP4IAQUYfweqNfjEOG/zia5oYgx/ewr+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tblS6BVfocVa/rJGDu0MAsbUNCheBT9eaxwmPT42hss=;
        b=LHM2iiUHEYU6hJsEyaxMermY7MFJiIywRXpQjpAqav1ag+LLjqmpTtb+M74YE81tcQ
         8AcKrkpG4xRx3BmcWSK3bI7rs58k0nqiTzGGZmeKbzIs8iAtUwNijrohBpWm0XyOBqiR
         WUDD+K30O7zLB1aLw+m+/TFoVgeVC7F9TbefOeLjMpgMN32eYVONpArmuyHw2KjAdi2r
         mGCRWtyTyYrnLR8gst6X7ftij9iJjp0o5Wb547U8YcvvABWn6Mhfay3Yd0cC59PWFdzb
         VXbGe+jFgIztcP7Ssqmu2ezKHBU60TsJ7qoYSz2URpRTxVTQpHeJ3kefU1wUizTNYSkQ
         SL3Q==
X-Gm-Message-State: APjAAAV0mfNFw99amnExZ3B1L56lPr5RMWhmyWmP8vUvH9gyugVBbdUL
        zb0yzhnmiye+Vp0iINwe4ipW4W8uuyQ=
X-Google-Smtp-Source: APXvYqynQRi9eEPfwOzKRakpOvoPSklMlI3EDqT/HFgfvEAhxEKIpDr63Ydcwmi7AVNwd29oCjUTOQ==
X-Received: by 2002:aa7:989a:: with SMTP id r26mr30665218pfl.232.1564510560726;
        Tue, 30 Jul 2019 11:16:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v6 02/57] bus: sunxi-rsb: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:02 -0700
Message-Id: <20190730181557.90391-3-swboyd@chromium.org>
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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/bus/sunxi-rsb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 1b76d9585902..be79d6c6a4e4 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -651,10 +651,8 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 		return PTR_ERR(rsb->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	rsb->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(rsb->clk)) {
-- 
Sent by a computer through tubes

