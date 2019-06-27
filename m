Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C157CC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABD72146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXWMsjb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfF0Rem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:34:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfF0Rel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:34:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so1339534pgg.3;
        Thu, 27 Jun 2019 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dJ+BNxjFC3f6/V4cs1W2WyxrvmO68alV+TbXVNPKDno=;
        b=VXWMsjb+aKp2CXlOsM4m7BJ8ccf35WVfQ2JPPgEX6A8nH8pX7pWUYDg7sO0BlcwKBE
         KUyrItHn59d8OmiZGND2ijOScXoQyM7HPiFD7W9w+JkLPI2BWm+ePpxOfyjIBcYiGiCc
         0OKxO5L/L8RaJ8LFKYiVDNPxrWjcvTWedYW2ru8DWgcli5gAWmJGvth82CJbQHwhyony
         An+kCpMkVVszH25mpzs8JQ5EQS1b1rUA8QtglvH2ULUWI7ArlMOm9bjY28AL7hp4hSkf
         ASh40YMyGhdemE6U0yqwtzryk0d6baVYdhiRAKq8tWqDJhEav7AAbigUeeGpjtsUSaCZ
         c+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dJ+BNxjFC3f6/V4cs1W2WyxrvmO68alV+TbXVNPKDno=;
        b=ovUMIf45oeQS4fTj3CnLugPwXrrRc8oEdP3uwX11SGXlraOb+VMrZAqf7/malhViuQ
         43KR7yAm32QCN/M7VnJV3DWWxPsovRP7vvd0n/IAxV4oE1fi6bJSzCid+Jd2O7ea5x2z
         Dkljc205SflxHtW8KQrbMLQJ/AzkPIXUfPlw8aVeQnLV4SXAwTH7NOmszAD6yXSdfBDX
         NdL375eZpyVlsNEKr+928O85Vsa3zdbZMSGVdWGH0D9GIy4tV9UsiDmoxvFdZh/ZEJx5
         vxA6vJ6Kp++4zt9FDsmj1oZ8hwQWVrOdWWFm/6DmHghKgAIRruxfU/xMugqdhgQtumj9
         cG4A==
X-Gm-Message-State: APjAAAW2F0gZf1efQxMcKuNwPwNlzoT/lS1UmgE0oJyKQ/CYwj1LHFBb
        Yv4cF5aTPJAfK1qxuQIwgkIivBoQvPI=
X-Google-Smtp-Source: APXvYqyGMFdda4argghrJzPG6GJZHobivNpbseQlf3G2coJxlMdU3GkJZJ3JzLQlwg2pegY93zMEpQ==
X-Received: by 2002:a17:90a:2648:: with SMTP id l66mr7313053pje.65.1561656880991;
        Thu, 27 Jun 2019 10:34:40 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q126sm5400028pfq.123.2019.06.27.10.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:34:40 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/87] ata: sata_sil24: Remove call to memset after dmam_alloc_coherent
Date:   Fri, 28 Jun 2019 01:34:34 +0800
Message-Id: <20190627173434.2193-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),,
dmam_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/ata/sata_sil24.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index bfdf41912588..98aad8206921 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1202,7 +1202,6 @@ static int sil24_port_start(struct ata_port *ap)
 	cb = dmam_alloc_coherent(dev, cb_size, &cb_dma, GFP_KERNEL);
 	if (!cb)
 		return -ENOMEM;
-	memset(cb, 0, cb_size);
 
 	pp->cmd_block = cb;
 	pp->cmd_block_dma = cb_dma;
-- 
2.11.0

