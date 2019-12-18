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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AF1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238F2218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFjv0Qxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLRJoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:44:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41104 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfLRJoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:44:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so904342pfw.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 01:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6h0m2YWX8yYd6d187upTdSatGcan2CL4xPYwJto0+vg=;
        b=LFjv0QxpqHiCP73+CLsrR4H4P8N3R6mUA39Ea4DhHZpiwA6jsof3eIm7pDB5BT42Gp
         zPNSw+VBxbfLTxFLGHqNU9akb3miT1JPhUEQPMTlV/Rc/cTjR7+JlijlzcX/gXrfqZ0F
         kh0VXs/JR18l1mjpfv14bZ91jAjE4Cy683ODYo5bcUQ5+u4HVT/bVK9gj/ku84dLqbqv
         QSEitrjAtzIbFxC6IMDQhsXa/t8BlUoHN4H30gnT9P7PXdNzYpOA4zQsu1XC2Sz/ZxXC
         qD8ZsSN8Y/YkN1vU2FpE5EG3ce7Pq0sJBZy0tEos1cVObDdrkIFdijPzq1KQvaSnWQBx
         1OlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6h0m2YWX8yYd6d187upTdSatGcan2CL4xPYwJto0+vg=;
        b=ED/giPlse621xkLF4nIL3ixaT5mxcsqK9cobMEhCL70On2pEvefEwUDIruoT0Xv01h
         fXYHmk6NSh4NV7+4AyxnA9aeIvIXXq+Xl63NLTIGrgHR5HX+fERueM2OjI3/Ik69hfXy
         2D0SclaynKmzUav03jUOSA4/ST4QxgLXV8jm/o/HpElPXIYysZiadk53Y50ung0o9xak
         Ug9oMzUROlp0J+3+NbMQtW6BjYB9TtR4nNl+B1kVSD3fqxKTG8r+lOQ4+R4IBm38LbuQ
         /NQxqRWuw1WzG1XMMUif+DqHe8kC2IyDq1pe0uNvchrwHjQ4ZT0kt9wl85DyuE/N2d0A
         oanw==
X-Gm-Message-State: APjAAAXvXffycucVblFyN8po28LDG6Cn/AhpeB8acdueQhU8ma5TTBnB
        NMLGFYBwuXdsN7VTbg7hyL8=
X-Google-Smtp-Source: APXvYqyrfPJWnV816t5c/xqoJjuJRAzraLeyLgyB/zGjVJUwk6p3yAYhNfX7MTSVl7ydZ4S6NVDbtA==
X-Received: by 2002:a63:f844:: with SMTP id v4mr1929895pgj.71.1576662263590;
        Wed, 18 Dec 2019 01:44:23 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id i127sm2538436pfe.54.2019.12.18.01.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 01:44:23 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] uio: fix a sleep-in-atomic-context bug in uio_dmem_genirq_irqcontrol()
Date:   Wed, 18 Dec 2019 17:44:05 +0800
Message-Id: <20191218094405.6009-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

kernel/irq/manage.c, 523:
	synchronize_irq in disable_irq
drivers/uio/uio_dmem_genirq.c, 140: 
	disable_irq in uio_dmem_genirq_irqcontrol
drivers/uio/uio_dmem_genirq.c, 134: 
	_raw_spin_lock_irqsave in uio_dmem_genirq_irqcontrol

synchronize_irq() can sleep at runtime.

To fix this bug, disable_irq() is called without holding the spinlock.

This bug is found by a static analysis tool STCheck written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/uio/uio_dmem_genirq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 81c88f7bbbcb..f6ab3f28c838 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -132,11 +132,13 @@ static int uio_dmem_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
 	if (irq_on) {
 		if (test_and_clear_bit(0, &priv->flags))
 			enable_irq(dev_info->irq);
+		spin_unlock_irqrestore(&priv->lock, flags);
 	} else {
-		if (!test_and_set_bit(0, &priv->flags))
+		if (!test_and_set_bit(0, &priv->flags)) {
+			spin_unlock_irqrestore(&priv->lock, flags);
 			disable_irq(dev_info->irq);
+		}
 	}
-	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
-- 
2.17.1

