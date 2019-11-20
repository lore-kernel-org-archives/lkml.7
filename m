Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEDCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3AA22440
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rf41bOpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKTAKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:10:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33418 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfKTAKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:10:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so26042573wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 16:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zP3c/y1zEBIIe+nmdhsLAUuImqjKLhQzbNYXppbBeW8=;
        b=rf41bOpojEU71gL1F2T4+1ZpIXZqMGkqSjciDJdjNjzI2iA4Gv5PqP6Jx7PcjCWJP1
         SNvrE7QXcFj/pyB5GdkjDgaOty5MVpw4UdGQWi8XptwLjRxNbTqBOulLNZwKSaXEwihq
         KnBzPlIsyEPvStVrIESDfBVxGNB4l8ScPuNKHT2drudQyXQsyHC32D4xJi0N2QAXS7dC
         t0evCbnImj+1iHArhqomssUqAUNmudHjpu3qfjziXBrokBhdfzD2D9ajI75WQGmMZtFA
         AAruOHxnDJqnDNVCVUy5JEKsK4ICiUiY70/FydhgEiPaZkrIx82HnccjaD9ytGtokBkv
         P9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zP3c/y1zEBIIe+nmdhsLAUuImqjKLhQzbNYXppbBeW8=;
        b=nN+O/1FjRt+QAshhshFnnkykF/gnzPC5pJjKDh0LtmK5UfGL7i9INNzYIZaSHKGmrO
         8T7pqFcaBI6hro3+Yn+gdyXlenTY9YTQq/aTffYSy99fwvIzXukliPy+RMPigcqYe7xR
         vFdZqe1OhxlzXx5Tg3H6Uh5p6G34pvB5bwDePHm/OeIdvWn4b08pId1qHaWEiNI+BF9z
         CrdnQNc+MPa+P/DCO+gHiBNySAT2lP3kBOin1TxmLhPWRSm0JiCJSsSs/wShbCN58OaN
         Geqn/x6fZLvl6QnI7a1RmuFuqgHAwllRI2KPQQiXjAIMqG0BXYxsVN922Z2dMK3Fddl7
         CD2w==
X-Gm-Message-State: APjAAAVlMBZVl70sRoUK1MVrvYwYgpXJlSLgkYKx5/m1jE/IoIZCr0Xc
        EX1ZoUk9yzLE9m16hcDg/HqFQdi/
X-Google-Smtp-Source: APXvYqx3piFbrAtObop/LR0fpM8ONtjqvusXVc62KQ/S3z3+tyYkfbat/yc0DdE2vrRtmo1tIXrvZA==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr136156wrp.266.1574208633072;
        Tue, 19 Nov 2019 16:10:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40e1:9900:5dce:1599:e3b5:7d61])
        by smtp.gmail.com with ESMTPSA id w18sm28759230wrl.2.2019.11.19.16.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:10:32 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Subject: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
Date:   Wed, 20 Nov 2019 01:10:30 +0100
Message-Id: <20191120001030.30779-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xsdfec_poll() is defined as returning 'unsigned int' but the
.poll method is declared as returning '__poll_t', a bitwise type.

Fix this by using the proper return type and using the EPOLL
constants instead of the POLL ones, as required for __poll_t.

CC: Derek Kiernan <derek.kiernan@xilinx.com>
CC: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/misc/xilinx_sdfec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 11835969e982..48ba7e02bed7 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -1025,25 +1025,25 @@ static long xsdfec_dev_compat_ioctl(struct file *file, unsigned int cmd,
 }
 #endif
 
-static unsigned int xsdfec_poll(struct file *file, poll_table *wait)
+static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
 {
-	unsigned int mask = 0;
+	__poll_t mask = 0;
 	struct xsdfec_dev *xsdfec;
 
 	xsdfec = container_of(file->private_data, struct xsdfec_dev, miscdev);
 
 	if (!xsdfec)
-		return POLLNVAL | POLLHUP;
+		return EPOLLNVAL | EPOLLHUP;
 
 	poll_wait(file, &xsdfec->waitq, wait);
 
 	/* XSDFEC ISR detected an error */
 	spin_lock_irqsave(&xsdfec->error_data_lock, xsdfec->flags);
 	if (xsdfec->state_updated)
-		mask |= POLLIN | POLLPRI;
+		mask |= EPOLLIN | EPOLLPRI;
 
 	if (xsdfec->stats_updated)
-		mask |= POLLIN | POLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;
 	spin_unlock_irqrestore(&xsdfec->error_data_lock, xsdfec->flags);
 
 	return mask;
-- 
2.24.0

