Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF6FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FA8206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o50VKtgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfLRDoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:44:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38417 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfLRDoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:44:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id f20so340282plj.5;
        Tue, 17 Dec 2019 19:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+y9h4aE08CuPVLDRigUSeMNj0mFN2Iazg3NzEcyF52c=;
        b=o50VKtgFJWtikhjh86K9Pp/xJL03nCe7uNeHQnLKhET0QZQEmrtcKEpIUAeM5burEi
         /dLWaajjB6izQNe5N9WCjD+mI4E+LkERBxjpMBaeO5aeNTu0pYm3GKdzaa02JDlVdNna
         OWZSGSEpX+04ZPPsfpFdobOzz8zK9P2aviZd90PKbnDDDX1aNnII3vKEAgue17Irpp7q
         3wktnxWRmnb2l4wUmRqtMk6AXhp2P+T/Uo8pDevRzloYXo8dl4o2VkQiuUSOiwaboWzg
         4wbiZCe1wLcr2nsNglw9j6Lw004zKS5IrLZDUizeeXM6Re2lykgfzHKxi6Q58uIlUQlq
         ygYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+y9h4aE08CuPVLDRigUSeMNj0mFN2Iazg3NzEcyF52c=;
        b=Zbe91KUY0XRYZnL/ED/kyabsIkSCcIFaC5gnjkeJ8KdEbYxFZAyynNFFhlb+Lezzv8
         TnY7RVRwy7mRY8OiotTM0dEuXC/lIBQzcoAQYbJ+l9p7yqoTT8svs/mLLazkaBzW/ByJ
         H2sDT+0PJUGuurtD6iQUeeLiKO8BV+1M8aV9ZHdlkN+zdkIF6WfBBBUkjpMoIpbu4SYm
         6fj9jtgN8mgOnGhw0GTdcKbVZbHGm7wuwTnGh3B23019gJ9DkFmZc8dZ1FAtmMnj2tfB
         7AiEOJUNPn5glNRLty4qBTC84R01vcbO6nsdTr0gVC3oz4O4QiPFnd7ylN+h/bR8Jl9H
         yhKQ==
X-Gm-Message-State: APjAAAUY6NEOIFiJd3PgmxCtDhy5mtSGcaU1UqkYt+Jd/PsTs5mmLKtL
        o4rJxZ4GkhGD+L5CTML5v0g=
X-Google-Smtp-Source: APXvYqxbDnldt34tQauFfXHJ9KD9GGYfju4fjtfJwioU9AQjdJDRoygXN3aR7oZ/RlBXPJgQvQEogA==
X-Received: by 2002:a17:90a:c214:: with SMTP id e20mr142755pjt.98.1576640640300;
        Tue, 17 Dec 2019 19:44:00 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id k29sm630606pfh.104.2019.12.17.19.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 19:43:59 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, rogerq@ti.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: gadget: udc: fix possible sleep-in-atomic-context bugs in gr_probe()
Date:   Wed, 18 Dec 2019 11:43:49 +0800
Message-Id: <20191218034349.18919-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

drivers/usb/gadget/udc/core.c, 1175: 
	kzalloc(GFP_KERNEL) in usb_add_gadget_udc_release
drivers/usb/gadget/udc/core.c, 1272: 
	usb_add_gadget_udc_release in usb_add_gadget_udc
drivers/usb/gadget/udc/gr_udc.c, 2186: 
	usb_add_gadget_udc in gr_probe
drivers/usb/gadget/udc/gr_udc.c, 2183: 
	spin_lock in gr_probe

drivers/usb/gadget/udc/core.c, 1195: 
	mutex_lock in usb_add_gadget_udc_release
drivers/usb/gadget/udc/core.c, 1272: 
	usb_add_gadget_udc_release in usb_add_gadget_udc
drivers/usb/gadget/udc/gr_udc.c, 2186: 
	usb_add_gadget_udc in gr_probe
drivers/usb/gadget/udc/gr_udc.c, 2183: 
	spin_lock in gr_probe

drivers/usb/gadget/udc/gr_udc.c, 212:
	debugfs_create_file in gr_probe
drivers/usb/gadget/udc/gr_udc.c, 2197:
	gr_dfs_create in gr_probe
drivers/usb/gadget/udc/gr_udc.c, 2183:
    spin_lock in gr_probe

drivers/usb/gadget/udc/gr_udc.c, 2114:
	devm_request_threaded_irq in gr_request_irq
drivers/usb/gadget/udc/gr_udc.c, 2202:
	gr_request_irq in gr_probe
drivers/usb/gadget/udc/gr_udc.c, 2183:
    spin_lock in gr_probe

kzalloc(GFP_KERNEL), mutex_lock(), debugfs_create_file() and 
devm_request_threaded_irq() can sleep at runtime.

To fix these possible bugs, usb_add_gadget_udc(), gr_dfs_create() and
gr_request_irq() are called without handling the spinlock.

These bugs are found by a static analysis tool STCheck written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/gadget/udc/gr_udc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 64d80c65bb96..aaf975c809bf 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -2175,8 +2175,6 @@ static int gr_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	spin_lock(&dev->lock);
-
 	/* Inside lock so that no gadget can use this udc until probe is done */
 	retval = usb_add_gadget_udc(dev->dev, &dev->gadget);
 	if (retval) {
@@ -2185,15 +2183,21 @@ static int gr_probe(struct platform_device *pdev)
 	}
 	dev->added = 1;
 
+	spin_lock(&dev->lock);
+
 	retval = gr_udc_init(dev);
-	if (retval)
+	if (retval) {
+		spin_unlock(&dev->lock);
 		goto out;
-
-	gr_dfs_create(dev);
+	}
 
 	/* Clear all interrupt enables that might be left on since last boot */
 	gr_disable_interrupts_and_pullup(dev);
 
+	spin_unlock(&dev->lock);
+
+	gr_dfs_create(dev);
+
 	retval = gr_request_irq(dev, dev->irq);
 	if (retval) {
 		dev_err(dev->dev, "Failed to request irq %d\n", dev->irq);
@@ -2222,8 +2226,6 @@ static int gr_probe(struct platform_device *pdev)
 		dev_info(dev->dev, "regs: %p, irq %d\n", dev->regs, dev->irq);
 
 out:
-	spin_unlock(&dev->lock);
-
 	if (retval)
 		gr_remove(pdev);
 
-- 
2.17.1

