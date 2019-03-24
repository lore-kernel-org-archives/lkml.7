Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28126C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19FE2133F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="JILXMdmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCXQJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:09:08 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58484 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXQJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:09:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 53C58A11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 16:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CDhGxSlV8JOV for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 11:09:06 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 1EF889D7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:09:06 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id b16so5987215iot.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EikQbOOPBrEMqbRaYH64XM9ulLCUbkuJUF0VhOtWzcQ=;
        b=JILXMdmqW9JHsRWg+F0j2BbLXwrg2M0x1u6CMkdoKlL/UP7mZrPpaWW8Eo0SOuUvPZ
         ZDpHqirutwemsmULZNHEPPCs1UFJbgk6AmqTbR9yoqUdpDjAeWAQg+/pFZVqZ4OO9Vlh
         CSZ8GClUJuQBzyO7Y3y+ba8XxdgHrAnmK54h6FISSXBZ0y1xGzqy+h81oXImRUz3+9Zq
         fQNrCLydiBXjuSv1wqvMkBIG1eqkZ0vT0xwLc7r4ou4khAY+c0jF8hx4Nekr7/ZFZxBe
         dp6T7H3AzzPnrYTbINLeBFUsJDXvospnRSm0rWxROY1BO7NU1t+oj90OAqZWmmtwDZPm
         lJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EikQbOOPBrEMqbRaYH64XM9ulLCUbkuJUF0VhOtWzcQ=;
        b=AMxCQqIAGGnusuM0f2BCr7uP+7X81Qex4DaCurW+qv1nEPnQIYF5qfgsg6WuK6v8ac
         a8BHeQApYVd/0XB8fs4s86cln+0s84kKFbn830MmKuVePnTki0NSwcux4N1/rDlk2GH4
         0oEFRF9LuooaMr18IjVYP/BHKqTl5E73FL5FF5EwNA2+6waQvTfo7bEywkvJ4HAElkbU
         gzIvodndHEOVFCi5zS2iW+qqmXXd5hya0z8QUIzyi+3e9uNGvUQkGDfkh7ur1skzhOqi
         S6S5QMNLIpe/7fMoN16gVV5W2iqSTmVdyXobam2yGsZLYzDzsj1ipnJTpkf9TxeEvXS/
         a8xQ==
X-Gm-Message-State: APjAAAVJ5PxDqp6Orj9QMneFbU1GYPHas+7GwJqgT05K41+b9hb5bEcZ
        BxcCWLLWnA9PrPRFhofOj/p1l1iX8fcZGbxy+GDxwXKnkezR7YmcwUF6Is64UuzyJTNVvkCkikv
        ljS0HikGZX7pBS3pLxc2lGFEJSeOk
X-Received: by 2002:a05:660c:1c8:: with SMTP id s8mr5799368itk.20.1553443745636;
        Sun, 24 Mar 2019 09:09:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzk4D7zpNS8b8k0qB2Dm1/UHiyT4TGsqXsg/I6Q4C9nB1yGsAI0Zndj3VF2IW54EcKAiMSpWA==
X-Received: by 2002:a05:660c:1c8:: with SMTP id s8mr5799353itk.20.1553443745419;
        Sun, 24 Mar 2019 09:09:05 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id y22sm5034957ita.2.2019.03.24.09.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:09:04 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] tty: 8250: fix a missing check for pci_ioremap_bar
Date:   Sun, 24 Mar 2019 11:09:00 -0500
Message-Id: <20190324160901.23001-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_ioremap_bar could fail. The patch returns in case of failure to
acquire IOMEM. It also releases the acquired resource in the exit path.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v2: Failed to release resource in exit path and incorrect code in non
DMA case, suggested by Andy Shevchenko
v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
Jiri Slaby
---
 drivers/tty/serial/8250/8250_lpss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..7889b2552013 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -170,9 +170,11 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	int ret;
 
 	chip->dev = &pdev->dev;
+	chip->pdata = &qrk_serial_dma_pdata;
 	chip->irq = pci_irq_vector(pdev, 0);
 	chip->regs = pci_ioremap_bar(pdev, 1);
-	chip->pdata = &qrk_serial_dma_pdata;
+	if (!chip->regs)
+		return;
 
 	/* Falling back to PIO mode if DMA probing fails */
 	ret = dw_dma_probe(chip);
@@ -199,6 +201,7 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 
 	if (!param->dma_dev)
 		return;
+	pci_iounmap(param->dma_dev, &lpss->dma_chip->regs);
 	dw_dma_remove(&lpss->dma_chip);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
-- 
2.17.1

