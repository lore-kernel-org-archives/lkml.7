Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772E2C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB9521019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmVPdU1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfGKPIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:08:21 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44745 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfGKPIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:08:20 -0400
Received: by mail-vk1-f195.google.com with SMTP id w186so1398063vkd.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b9wODXZFfpHcCOK1sBgHRLZLuNp2LmEM/dZSDNkYBNA=;
        b=BmVPdU1yYp3zyIgEU5yo3jBbFK2/YY8LLayzz4rqbGQeB0vU7n+HNl59IdmfGhYdSm
         TYMCLEXoA3G6CEIeNo16zOsJ84wsX6hLU2wVn4h97UJdZ36jDRT4UuPwX5tl4Ek383iC
         Iyiv3Z07CGT9JeHspYs7o8MbR+3kOzrejqTSX3dap0pRSP94ljFAduJVUW6mAqSestlI
         kn2wWgZHkUuzmXGMAPyVpuqRMTGPPZFUC3XbClIq7SWOHvDIJf1izk0XKbGAjZ35xtzA
         Bs1njlGjBVV+l8lsBakYX5WhmnPZN+LkprQ5J9Aky9xy+7KrVTNNknwSQBJ//pZhTwwh
         CV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b9wODXZFfpHcCOK1sBgHRLZLuNp2LmEM/dZSDNkYBNA=;
        b=Y/FxojKa3//ddVxDL18fLY6xy1VDjwy/rlQkQplg+xghBtZfc4HF7H2OHIUpcz6EwX
         WZBNAjTQzhXMq4BkHOzqguZyuHye8kZkh31wvF3a9kf/Mfj6RJyMld6+OZfDE/ZK059g
         ymoSNg5GY4UzrPSEarraRC+uVa5pPcZrnC9p7y+Jomgw1Wq7Q5svr4lJ1jmBC/2Wiphj
         y1ZGztGelCujvTfkv6fOwtyYkDZzU/C/+wH/KMnxlJqX6h2OVu0HjKMT/drypLbiW9FI
         P3467Js0gSkwtupkzeKlNpWs1RP8GHMaa0botLcJdhoJhBEgEhGSOiYn3sZV3g0xkrNt
         Y1zQ==
X-Gm-Message-State: APjAAAXB0UoMXldAj3Mf/Sp7IBf0L0YsJcPaTASX2QH2IwNcMAHBpamD
        M/UKjSMu3ZGrzsFlO1Cg0w==
X-Google-Smtp-Source: APXvYqxkDprvU74sG7TYm7KLqOv1ibtwNSnSHMA6wu2BKuI8pJnQXBerx9KU9y6oxXxqQUCBcw4p6Q==
X-Received: by 2002:a1f:1b0a:: with SMTP id b10mr3636733vkb.19.1562857699433;
        Thu, 11 Jul 2019 08:08:19 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id v5sm6660357vsi.24.2019.07.11.08.08.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:08:18 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     iamkeyur96@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: most: remove redundant print statement when kfifo_alloc fails
Date:   Thu, 11 Jul 2019 07:08:02 -0400
Message-Id: <20190711110809.17089-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This print statement is redundant as kfifo_alloc just calls kmalloc_array
and without the __GFP_NOWARN flag, already does a dump_stack().

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/staging/most/cdev/cdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/cdev/cdev.c b/drivers/staging/most/cdev/cdev.c
index d0cc0b746107..bc0219ceac50 100644
--- a/drivers/staging/most/cdev/cdev.c
+++ b/drivers/staging/most/cdev/cdev.c
@@ -463,10 +463,9 @@ static int comp_probe(struct most_interface *iface, int channel_id,
 	spin_lock_init(&c->unlink);
 	INIT_KFIFO(c->fifo);
 	retval = kfifo_alloc(&c->fifo, cfg->num_buffers, GFP_KERNEL);
-	if (retval) {
-		pr_info("failed to alloc channel kfifo");
+	if (retval)
 		goto err_del_cdev_and_free_channel;
-	}
+
 	init_waitqueue_head(&c->wq);
 	mutex_init(&c->io_mutex);
 	spin_lock_irqsave(&ch_list_lock, cl_flags);
-- 
2.22.0

