Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87315C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9F3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iBzG/BLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbfG3ST3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:19:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40001 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387949AbfG3SQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so30484463pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwrueRwZWSAqh0bKj1yauOeOoZlJ1mklJ4qmJdSKdsA=;
        b=iBzG/BLf6DV7qHIJMA6R58AonXItJC/hmJC+VeIIOPzBhsfbc+KHBZ1QnGmyCC1Mu/
         9DHhmozvJ6Ak6o9nR24uHAtdiq5MFPSftRffrarWqZtpQNOQyYx+ro9H4fY/2ZThHJXz
         Qpo/FEB2D0h7NdgGmzvpeyOPTOFRC073ibkNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwrueRwZWSAqh0bKj1yauOeOoZlJ1mklJ4qmJdSKdsA=;
        b=nuF/Zc1CuK26qCr2aQJohjihp2leYx0VBcXrOvacAIoHJBqOe1fkFBdCzDZGx7wHfY
         Jw6XNITl+PotYd4O+wVGuJTrICrxGuxK5yWR/jEdt4iPEc1TXrAZ8gDWvJlawX7YLUxB
         gbGB4Y5Vozv08bT1oGbwscAkiu75GOQmRCUsIXJ6d+XRNhcKiwDF6hYcK8pp6581BEXP
         c0mOG/7mT83eIWw8yn8IL7hjuxNXXho7UIGmVwWYej6EjzPoZ9ZawagUnuq4u4tdHeVe
         uba1zvrU9TI0zbQMn0V8gCYyKP97Bq8LLe21nqBb+RVh/ZwTSUUJtnZlhHQk675gCPBk
         iMzg==
X-Gm-Message-State: APjAAAURP8QJlZdMUiCzj8Xw3T+qIl9UtEZ6KnXushvcoxmgwOTWpjKv
        laiuqXjPtOXbpqiJ5a8a+TA00qKxMao=
X-Google-Smtp-Source: APXvYqwX2R1Kk20oxjzxSzbr2uAjNNJ68Ndx5sj1YiZlDsfwPqy9XLWM7+PFRo5JbNnA2W9ABKW6bw==
X-Received: by 2002:a63:60c1:: with SMTP id u184mr106173637pgb.275.1564510582206;
        Tue, 30 Jul 2019 11:16:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:21 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 28/57] pcie-gadget-spear: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:28 -0700
Message-Id: <20190730181557.90391-29-swboyd@chromium.org>
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

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/misc/spear13xx_pcie_gadget.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/spear13xx_pcie_gadget.c b/drivers/misc/spear13xx_pcie_gadget.c
index ee120dcbb3e6..5ceeee7cc305 100644
--- a/drivers/misc/spear13xx_pcie_gadget.c
+++ b/drivers/misc/spear13xx_pcie_gadget.c
@@ -702,10 +702,8 @@ static int spear_pcie_gadget_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, target);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no update irq?\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	status = devm_request_irq(&pdev->dev, irq, spear_pcie_gadget_irq,
 				  0, pdev->name, NULL);
-- 
Sent by a computer through tubes

