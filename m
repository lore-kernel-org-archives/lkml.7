Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6DFC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5DD205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN7RT0XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfF0RmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:42:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41667 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfF0RmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:42:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so1669306pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a1PhA2Or6OPK8FK6GJ0xMKVx39nWfrgg8OZa9emN5gw=;
        b=LN7RT0XYk5lzaKtqIY6WCCGM5L0jtMOkSd2BNwWK1MTF3BQs2wBZxmE1B6srKD+All
         zW/VsiLSECzJSbsj/De6yZdOCw6igZtdrTR/K7uYS3Cjw3nj8t/yrWpxbWOVYRYS9H2A
         ZP1CixY3j3YhUbXFn/lmpWWO6w5ZRa27hPcvFaJxXag7NU0Ld5N4VVa9VNLuzJQWE9hx
         h21a41wMT10QWnHQbf2eLPNk+wRS3iTJ+xGYFyVR1BD/gAOZGswJz6rhc6KtWw1HoV9B
         DOP7mY/xrmiORWriXeZK1+VAB4GMVOHCS+k6aRgz4A6M17+Ah2EFSBBeFkhpfOZnMdO0
         l4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a1PhA2Or6OPK8FK6GJ0xMKVx39nWfrgg8OZa9emN5gw=;
        b=scyLTn7UXUiCQy675C2FCzp1JuOgzLkqrFMWzSGysaOnv+mpBkRTw21HMEHq4/9WQx
         kYzn4v3UafNCbCXItSJ3CHToCB47SSnxI3c36psU5qxCs61wuFp8E54NmrwaDdafWf2R
         iRuChX7VwdRJ/aMtDwYTDdQl0HOn9P8CnSh9+8Gmu5fILkaUzLCC0yRD2uClluCytjr4
         nvMk9T2H23bhqvxVnNfNqh4/uLTaTYQ6N6LuEVm7n9tmSNxWbJEvAoZXvzHQa6PBtwLU
         cf1HhCijVuLwuLYwEGFxxGZlux8E4rRO0AzUPtRKd+pj+u/Cy9PkkCTDlIxDq3FrmUxq
         wZng==
X-Gm-Message-State: APjAAAXCUFDN0dS09ahRFcPrnPt2pUxGkBRV45ubRa5VSDuydi4kyMMu
        GbGZ4uz0A0aK6CpdQaRqvCE=
X-Google-Smtp-Source: APXvYqyRTr6Xrl6LCdDDX1j2cfNbXCLG3l7lKFZl34Zkg/4yGCb7FtnMr0SFZ+DanxIianCIevQrJA==
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr5937681plt.255.1561657336721;
        Thu, 27 Jun 2019 10:42:16 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id b24sm3391850pfd.98.2019.06.27.10.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:42:16 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 50/87] rtl8712: replace kmalloc and memset with kzalloc
Date:   Fri, 28 Jun 2019 01:42:08 +0800
Message-Id: <20190627174209.4616-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc + memset(0) -> kzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 17dafeffd6f4..87024d6a465e 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -107,13 +107,11 @@ uint r8712_alloc_io_queue(struct _adapter *adapter)
 	INIT_LIST_HEAD(&pio_queue->processing);
 	INIT_LIST_HEAD(&pio_queue->pending);
 	spin_lock_init(&pio_queue->lock);
-	pio_queue->pallocated_free_ioreqs_buf = kmalloc(NUM_IOREQ *
+	pio_queue->pallocated_free_ioreqs_buf = kzalloc(NUM_IOREQ *
 						(sizeof(struct io_req)) + 4,
 						GFP_ATOMIC);
 	if ((pio_queue->pallocated_free_ioreqs_buf) == NULL)
 		goto alloc_io_queue_fail;
-	memset(pio_queue->pallocated_free_ioreqs_buf, 0,
-			(NUM_IOREQ * (sizeof(struct io_req)) + 4));
 	pio_queue->free_ioreqs_buf = pio_queue->pallocated_free_ioreqs_buf + 4
 			- ((addr_t)(pio_queue->pallocated_free_ioreqs_buf)
 			& 3);
-- 
2.11.0

