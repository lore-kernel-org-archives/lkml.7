Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D174C48BDA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2960F2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geEroXRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfF0ReA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:34:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34459 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0ReA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:34:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so1587950pfc.1;
        Thu, 27 Jun 2019 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rm4Hty80lq/K/gNv/Wu+JYcakoFS865X/QwhUMnSBLQ=;
        b=geEroXRsRRS0uQfg7ei2HTk4MvUG6BZ2TCUOkuMG09wlpLIQaVJt8dngZeFm+aa/Em
         lNpcmYDkRC87m5xmo5llMWl1EcA+Jx2Co3GZLz5u7ZMZVz+RW2K8WErcbKUtvEHco5Pz
         gve/9gVGjIApQmEPZa8/njHGb0EseWQr8CiHcUWtSbY4pWvChxjhjk77Z0PaZrD+ENxL
         LuSso5Lpitr6TSo6ISWwhdp3LFc7hsTEs4jcLW71OmBP3mQy7cBkzl91SD7bR13ht9h6
         rDASDyT/TynTDN+ExUIgaVLRU/q3YJIZxFXiSHGD5JMlVcaYt2VP6xiKDl1fSHRHgTNx
         GGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rm4Hty80lq/K/gNv/Wu+JYcakoFS865X/QwhUMnSBLQ=;
        b=Uvur0CYA8W9QuWKtn/aXaGOl8oTJMMr/Jn9vjSYCTF36Ah3jmKOFXkm19N6LRRDJRT
         IAISqK+/JHWp5L3HQrvPZqnsKcCJBZTdmpH1CfvHKYY4WWMB579vF/JDHZoIqkzP8MjW
         vdvx+VWZEefJUD1zq/3fnbSBzmLrMmVB3snsHlFyxPLVRX2/RmgkbZMo9qyaiZKfEwBl
         vhV7PQkpOuy/vWBK3sbyIa/XVw1f7C0O0VOVMU/JTntkGA33I7b7oKPYxIZGuENr+o9e
         hq52qPe+6ZpfXjgEB0+dq17SsQ+B0rUaLSdR7mn5Ip1lHWH9Go9lfqNDLd3+KNexn+Ts
         Kq5A==
X-Gm-Message-State: APjAAAWZfqqv++lMRB7WQPzCMLEPRRMsrtQ10HUW344VDCpwad2hElih
        7A75ZeKZimspR5gNeA47Glo=
X-Google-Smtp-Source: APXvYqzYEADeNpCqcwmyRjIl244F96hTAtvqwROhEGx/WCLpGb4SpknIAr0RW9Wm5avWowOZLRUKWw==
X-Received: by 2002:a65:4383:: with SMTP id m3mr4706076pgp.435.1561656839698;
        Thu, 27 Jun 2019 10:33:59 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id o2sm2638615pgp.74.2019.06.27.10.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:33:59 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/87] ata: acard-ahci: Remove call to memset after dmam_alloc_coherent
Date:   Fri, 28 Jun 2019 01:33:46 +0800
Message-Id: <20190627173346.1933-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dmam_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/ata/acard-ahci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index b1b49dbd0b14..85357f27a66b 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -344,7 +344,6 @@ static int acard_ahci_port_start(struct ata_port *ap)
 	mem = dmam_alloc_coherent(dev, dma_sz, &mem_dma, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
-	memset(mem, 0, dma_sz);
 
 	/*
 	 * First item in chunk of DMA memory: 32-slot command table,
-- 
2.11.0

