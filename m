Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ED3C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B03D21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQZOvOii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfGBH7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:59:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42567 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGBH7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:59:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so8672669plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KmjmTx0cDkAe4BsoggF2c5USLaF9+w472czn75Hcufo=;
        b=nQZOvOiiMWp71KsGpJf9anNa7j+Qh5ulamvYcOwB+F1kQEnmVU8z2ljIC6lWa2eoNz
         E/Hgtglt5mqjqdPE7//2TmVLLsTjZK/DxeYJnrlY40R+Aneax9zJkF0vDdaTSUZL24XM
         nQCijGboPDyU0Q6JPbLRK5mGRJQHk5luxNfXx+h8YeU0qyZ1IJP7MueMZEky8aLN9RQX
         qzHE+Uc0E6x62N3JToCnRkT02uYTAQF6rksm+wQIszJnFhQy3mhLjnCDATslJlZrE7NF
         BMNOohUbTlEjCzccfjaxbhZ1cHljT/p8henGPaUnuTWGn9JyZT0cqQE9MNVBbcYz5m1S
         /eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KmjmTx0cDkAe4BsoggF2c5USLaF9+w472czn75Hcufo=;
        b=G7naGuuKntRmZp10OPcftG3auRXgMZmZ4Six6pEaIM8zJJGnd+WPIUqecSoVTqcw0e
         W8VpOkwSyLltait2VKh0jdVTlAxCkVU3bglRyMwPobSLNl9zujrcjB6MUZzVVCQtYL5z
         DiCZ1MWck6SU7g6MVXMD7Npqh34J4H8pG+jwRknihtyj+PARpKvFtMo1Y6ZzUzohQtcd
         K+ebb37UFIy3Ru2M+g/+3l1gALzmrtiNHrYh28l4oeolPcvVmKjZhpBuDKY/OdocnMyT
         WU5ZPEI97uhmk5oAktr+M9BptI44sx9YX1quiPbF0ir7zcdE/JHncj+gn3FZ0A+K2viu
         XgQw==
X-Gm-Message-State: APjAAAVywlft5tSyTz/QrqdlZOsRyN04U1R90YDUSkevTuh9n6UiyOAc
        E1SSqbBo9FOuQOx5MteT8Otwhbw6fZk=
X-Google-Smtp-Source: APXvYqzei0pbG+Byd7D2lL0lSUz20mFAHLGGsRpjERQohVPIhLnxvY16UN/ioZSNA86OBXTn6fQiaA==
X-Received: by 2002:a17:902:968d:: with SMTP id n13mr34117851plp.257.1562054385931;
        Tue, 02 Jul 2019 00:59:45 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q13sm13404740pgq.90.2019.07.02.00.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:59:45 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 23/27] video: fbdev: remove unneeded memset after dma_alloc_coherent
Date:   Tue,  2 Jul 2019 15:59:40 +0800
Message-Id: <20190702075940.24585-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

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

