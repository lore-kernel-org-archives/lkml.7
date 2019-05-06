Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6367EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31152206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4r0BE66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEFM5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:57:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38494 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:57:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so6433624pgl.5;
        Mon, 06 May 2019 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzoB/vSPy7jV2JtU428m1t1ku5bTXMAWeaZM/6A39iU=;
        b=W4r0BE66i2CPd5/7c7uxJhGlxwXYx50xJM+iuUZu5QVKq0cKxK9cTqA9iDnUu+aeXo
         RsSe0/Pnp0b0Q0v+rveMzRPIMyfXd72Q3AN0VMgaiNEE74shO9fANQs9+LjtdEwww7tP
         1WI22QUqPenHKQWiU9ro+gqWySQu2SnDHoHWThdaS2hEuEDdnECwYL0crgI6qFPDYIy4
         GzuCo5g7tVBrJ/LDsPdAEclfIxzbBnY03KknA1AiO4BDKGsg3CCr9KagzBL2SrAdsp0s
         Zp6l0d7BnF6pwXiRxFkjqdS/4V51GQ1gRQ13/g8306Pe9GT9voMVtt+KeWNCHti95M3Y
         bNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzoB/vSPy7jV2JtU428m1t1ku5bTXMAWeaZM/6A39iU=;
        b=e9w5d8CGCuMlEFxuPmEImyIl2iJcfX9pPXg6IoDHyzYiAwNpcebjr2xKMp88v37Yv3
         0lJoEawlKxtjNNlS9qLHJvtyRnYJAUHJ5/wuUNPtoyeqvMvFQaacSmteoZgVYoKWm6fO
         K8W4NmC0UUhxjr7td7PIXjtddPFPLeeDJYGQXqF5zArD5tkmGtKCaRISMAoZ+bpA54nh
         aBMA8SAcJ+bUdZuvJMrgQUCSXW7i5Ij2o4mizcnFBG+5x3mPdUfky6Ut0W6GiuYtWhRg
         x2WlPqWZvNU3XPXj26IesD7tTwj2Exhqiet6LIrv5FvkpeMLsmgEzywW/YOu12GolT4v
         jLgg==
X-Gm-Message-State: APjAAAVxyFbe5AtmTatBpVZemu4y1+EfvKYdC1l/Om1fcG9L8jjoRKHf
        +65xJ6KW9FuaNwpP/+h8i00hWg6yZAo=
X-Google-Smtp-Source: APXvYqylMnmETjINQ99AZRx+UbFu7b0p8HUWnziDFoYNJN5BSre2S5wBOQLcAuCFAOF+tK1ATHHE4g==
X-Received: by 2002:a63:1e0c:: with SMTP id e12mr30293701pge.218.1557147423234;
        Mon, 06 May 2019 05:57:03 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id a6sm13696382pfn.181.2019.05.06.05.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 05:57:02 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH 1/2] usbip: Remove repeated setting of hcd->state in vhci_bus_suspend()
Date:   Mon,  6 May 2019 21:55:49 +0900
Message-Id: <20190506125550.7826-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hcd suspends execution, hcd_bus_suspend() calls vhci_bus_suspend()
which sets hcd->state as HC_STATE_SUSPENDED. But after calling
vhci_bus_suspend(), hcd_bus_suspend() also sets hcd->state as
HC_STATE_SUSPENDED.
So, setting hcd->state in vhci_hcd_suspend() is unnecessary.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 667d9c0ec905..e6f378d00fb6 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1238,10 +1238,6 @@ static int vhci_bus_suspend(struct usb_hcd *hcd)
 
 	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
 
-	spin_lock_irqsave(&vhci->lock, flags);
-	hcd->state = HC_STATE_SUSPENDED;
-	spin_unlock_irqrestore(&vhci->lock, flags);
-
 	return 0;
 }
 
-- 
2.20.1

