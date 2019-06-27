Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC3C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A4E205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBPEu6SK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfF0RlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:41:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43501 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0RlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:41:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so1664309plb.10;
        Thu, 27 Jun 2019 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2vqCu+MS+Img9r2z6/QFX/3aEGn5jsBEl1RMM1fPhso=;
        b=sBPEu6SKdGSe3KC2j9VKeyQAWYZFWhUaBNyBzY50g1OX35jQJxTbR1eIVKhJ3wYYlg
         8TZ3auYUbbo76pqTOESCWFq4s+l7qWu54nsy1UmsNN0MQrwPy2bEcKXplRK1ALMgDBdn
         Lo0Sv7JieRzOtAKtg0uvcuOIVVf/m+L9hlgzna2q40pDU536YVS70rhWUpXg59jINrii
         aIR69ZEUmRWqLKpZODOA93V2ehqAwgJt6+YCzA9K9645HfSUXdfjmeus6hJEQb3DEXAR
         VRKEMUKYya9WK+kUgqpf6Ill88GLTde84hbbCZgsi+0ADWTGa+AgvSD6yhK2AY70va4u
         GERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2vqCu+MS+Img9r2z6/QFX/3aEGn5jsBEl1RMM1fPhso=;
        b=SpkQ3UH4BU9uAQTfg9OdrBimvhj1k9cR0pjmVW7B5XKSMS99V7vIPMqmtbgCq6owWF
         PoU511phm2QjVUloLinF7bJEIs3Z6qlNlU8KSkxhB2wpnpqPfPBzMIamtYmSLeUC1CWw
         gQWq8l1hmS7kP26DsCK7o5ZQYEbRX5wzDIL/kFy+vYFBKvAaRHaRn9Gy9pLVb6Y90RvT
         2eIMmt5H4LzAgb1N1PRH4z6NrXgy/8/sUHpdxxuwQyUUZPXeaIklFyEaxJPusZV4spmZ
         oA7FwoAw2KYWQoVdUDOPSDzgWB4Mdp4pN9D199LYJeppNrVbXgTFH9rbzLQ9opaSbAB9
         ME/w==
X-Gm-Message-State: APjAAAUdYcrOZrgKc4+SrPQ0AiMNltj4cnEwD2zoeSpBkwgOqerDqIKj
        /+A37NLMQ92HHh/tcRfYSWM=
X-Google-Smtp-Source: APXvYqzgLCO90CGyAwGqPwTMFiEbXZce1PzG6M5RXLVuf6Fyllzefu3WCmJL+Xt1cxzzZq5XfM4oYQ==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr6076022plb.258.1561657278472;
        Thu, 27 Jun 2019 10:41:18 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id y17sm3052099pfe.148.2019.06.27.10.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:41:18 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 45/87] fbdev: mmp: remove memset after dma_alloc_coherent in mmpfb.c
Date:   Fri, 28 Jun 2019 01:41:09 +0800
Message-Id: <20190627174110.4345-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/video/fbdev/mmp/fb/mmpfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/fb/mmpfb.c b/drivers/video/fbdev/mmp/fb/mmpfb.c
index e5b56f2199df..47bc7c59bbd8 100644
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -612,7 +612,6 @@ static int mmpfb_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto failed_destroy_mutex;
 	}
-	memset(fbi->fb_start, 0, fbi->fb_size);
 	dev_info(fbi->dev, "fb %dk allocated\n", fbi->fb_size/1024);
 
 	/* fb power on */
-- 
2.11.0

