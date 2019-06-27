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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEBAC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4D820644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAn9BeEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfF0RqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:46:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39776 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfF0RqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:46:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so1680248pls.6;
        Thu, 27 Jun 2019 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7g1HWYlZ9UColNnnK/hHjFh9Cp1pGHshvxgfYaG8qpE=;
        b=TAn9BeEBKkVQ/C2A+9fyNmSVI+kx7ZQTFKBiBGFa3jK9TegCwmJRrE3jXDCDYumqXs
         gedeYJTtUtjZU9RSuKAWZrfhXFqp9UewwLJOEVsoYriiGL7u+HlhYNJwhnz4Oe4M+R6u
         tkX1vylyK0epoPY+fUCbVlF0x51C8wO2BYmo1kIAow95Gdh9LQwM7qGudNLQE6k9o/gO
         lRXBPdfnpA88ZGYiaRipzGY8OIt0ZHTwcgfN0OR9/NsIAY2C3CMXagQK7ZV6Y6+itPlb
         W2alwl51ARR+dvvnzkunF+QdIlkSUiF9D8PrGt63q/D+MDff380OalPUwkZhdaUWmHso
         s1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7g1HWYlZ9UColNnnK/hHjFh9Cp1pGHshvxgfYaG8qpE=;
        b=Y0MmHLFOZeodqTpPQpaxFyyD6Xuobm7qrcwUi+spVBccdasEFzOndeGLbkrFF2qQC9
         8zNbmZjliNmyc2YWq6CiMwvtEDQglTQrg4bdKK0z0C7vZAXlFmd8hHSJitXjUiq1QiIy
         23qnbwArOjJmC6jrLyEh/iV5UtIZb1JW/GBVs+aAZJF625Q23Xdc0/FXDM/8wsDQP14K
         P671azlhNF3q4P3s9u3B9gA7fm6IqW17mI4TmGKPaGeQE4Wxa94Y91tmdvxB8jHNC4Ca
         UBwKMn8SU1L8a2pnMzTOwGwTDHwEVKTBCGqV3B074Vzv7cpLF40CzM0sJTumQFScrdBS
         wIpg==
X-Gm-Message-State: APjAAAWFbc3n9mMgersAx/87h0nHGam8ggD1J42I72oxq2zihNYhwbAN
        DIkxJjxOGWhP1gr7zpQ+78E=
X-Google-Smtp-Source: APXvYqw60Qomuysypn5jg3MoT4g+odVyVsYA8hzALKg4lqorUTTWcAW8ZSybIQa9SXqt2kske6H7xQ==
X-Received: by 2002:a17:902:903:: with SMTP id 3mr6116213plm.281.1561657570934;
        Thu, 27 Jun 2019 10:46:10 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id a21sm5015976pgd.45.2019.06.27.10.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:46:10 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 70/87] scsi: aacraid: remove memset after dma_alloc_coherent in rx.c
Date:   Fri, 28 Jun 2019 01:46:05 +0800
Message-Id: <20190627174605.6260-1-huangfq.daxian@gmail.com>
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
 drivers/scsi/aacraid/rx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/aacraid/rx.c b/drivers/scsi/aacraid/rx.c
index 3dea348bd25d..4d3484cbca26 100644
--- a/drivers/scsi/aacraid/rx.c
+++ b/drivers/scsi/aacraid/rx.c
@@ -353,7 +353,6 @@ static int aac_rx_check_health(struct aac_dev *dev)
 			dma_free_coherent(&dev->pdev->dev, 512, buffer, baddr);
 			return ret;
 		}
-		memset(buffer, 0, 512);
 		post->Post_Command = cpu_to_le32(COMMAND_POST_RESULTS);
 		post->Post_Address = cpu_to_le32(baddr);
 		rx_writel(dev, MUnit.IMRx[0], paddr);
-- 
2.11.0

