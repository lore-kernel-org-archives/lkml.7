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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0CEC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03622146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYBq2wjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfF0Ref (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:34:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41879 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfF0Red (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:34:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so1658779pls.8;
        Thu, 27 Jun 2019 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+kSecBPDQ3wKiG0c4Aix4ApQzupSauK2asU/f8XLmXs=;
        b=pYBq2wjIhDEwZCjUpeJb8Of8BX1OB9EXHtDiNReRLhBoLjJ/y4FTJyxlxRgiu6M6VS
         u4oiiQJyLP5sumLrhVwHJ2Y/F/QCujoEJAWfb5ZfCxcenOAsKK+iFXYmTyAfNdt9YVP5
         4dIPsEXwfTzAnod0Ge18suOBJrJEAxol/ZS+fonnxEiox6pTRnvWg7YqeAnYfQrsBrnr
         JtqIhkYsmZccKUv2nj6BjSGhYHz2XXESZemSTFzAizpwSFk5ybZ/5X0MJAGYmL39oFev
         TOMBMxoEB6gx2jabposFneLxrcpwHHhQb8jQIllAab8WSYX1M0vVaLeZBPsEMKvgcH72
         EFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+kSecBPDQ3wKiG0c4Aix4ApQzupSauK2asU/f8XLmXs=;
        b=g8cIY6PvAzC4IKuWwI41tM22Zs5vcTXDpBwSPIJQ0yyao24y1NsjdTqVRTrDsclLAk
         8JdAX7bKmxahLN1I6Wz/6dbjBmAelIvrXG0X6ox0CPMMUmyoLfoGkTIQ293CNNcwEohu
         un0STVhWh7cBxqZSUOKeHfOE3Gp1zlCJpTnLxEYXvkQQUK7Dibpdae9rLntJDDaBQUmb
         Wr5S4pvAjhgY7AmmvN9fLKbf65Hmn4x7lD/IRahRNsLQ+Um03HvTm8twty0wLZ1kwarX
         RbPKhcm033LpKSG40vI4NNNrTkQx+qvp7PiI1mq22P+9uNvxa0QEzn3RLYgm0ltdzpmW
         LAbA==
X-Gm-Message-State: APjAAAXSBXhhAbtUinbnCF4sBjBEPwMkyIfpmlCIidipx7gptWDEPPUQ
        FD7idz8lOH/c5N0WKqULVEUTbb4nJhU=
X-Google-Smtp-Source: APXvYqyAWLmymCdfToklsBLshEYLpeHEZ/CLPTmIo6bRU0ae9CCo1O4lQx5HVwWnqypnPGOD/LMCyQ==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr6065578plp.241.1561656872909;
        Thu, 27 Jun 2019 10:34:32 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id d12sm3320008pfd.96.2019.06.27.10.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:34:32 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/87] ata:sata_qstor: Remove call to memset after dmam_alloc_coherent
Date:   Fri, 28 Jun 2019 01:34:26 +0800
Message-Id: <20190627173426.2141-1-huangfq.daxian@gmail.com>
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
 drivers/ata/sata_qstor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 7ec0c216a6a6..865e5c58bd94 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -477,7 +477,6 @@ static int qs_port_start(struct ata_port *ap)
 				      GFP_KERNEL);
 	if (!pp->pkt)
 		return -ENOMEM;
-	memset(pp->pkt, 0, QS_PKT_BYTES);
 	ap->private_data = pp;
 
 	qs_enter_reg_mode(ap);
-- 
2.11.0

