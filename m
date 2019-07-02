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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AF6C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F05721721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ/zGiP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGBH5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:57:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37997 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBH5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:57:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id 9so7954993ple.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DF4jW8AlvC+djlWYUd2QZGbasaSqRQZjK5QX1QiXecI=;
        b=MZ/zGiP7VKWS/RUj5c+AqnE5pTIQ3ExmWvSeQj6qk3mb+Fa1T2iqUVnuqEk5xXoam6
         Q2gRgaxMSorqsxSszlwPqlHXMEJF8ZY7M+6DhpzbATv7K1GTtq0Z5YWhTw7UxBKYXPuw
         YKo7VqHUaL1qAYKMyjNA46sampnSFTaQCBeiqDOIHLMD6T8tO37l3jueTTQz+D/PFNYO
         DzF/TwlWFm3yAwmY7E9izLv4YgXGM+FCsz9Ki+imIByEu0/pfDxz7pxs7nacUZvpUN5n
         FtYoVuWwkMPb0m4Me0GMq+YEb03Jbkf9Ul6+UWPVNTgNDL5D6IM0aXIRs3FdxE4+W3jU
         KAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DF4jW8AlvC+djlWYUd2QZGbasaSqRQZjK5QX1QiXecI=;
        b=VMdsa9SOHEc2hFFFoxfF9fSF4pIVn4yaC3RphFGNA5xisLWaMP8FIhpe5vGINLIurw
         UBllwizXMugkjCyTY+WSpbOQHzJh8PUTCCJWrgPvgljMGuT/ILemnFgxUEDz3o6qVpyV
         92KT/gvXx0qj4/OnViI5NSUv2pESvtNLZyc85odf1cfxCu4MVr5slUGmUwA+L6CCtvVe
         qC8Q4MN8yqpGxiEm5I7SWFPSer/juESQPxpJkM1GpaixIuwIOcUMqB+19c7ihbugxpub
         VfBgJN3nMR3f/w7vDLbbcNh3yb6YHQSLdAI/7/fw6uZAALGgYQ3k1XrTSYYGvU49TuWF
         MKcw==
X-Gm-Message-State: APjAAAXSjDJy97GnhT9Kll0lJjdd/4qj4p67m/QVgodkm3MHfSE7tkef
        2h11BxMrl8KYozgKQQG35TbxReB5M6Y=
X-Google-Smtp-Source: APXvYqw8KitwquxmoZ7xkWcw4eqLqu1ROrCJgehu2iLE2o838blGsHqiMz1qCpktA+TWHsfQtuW2gw==
X-Received: by 2002:a17:902:7247:: with SMTP id c7mr33474463pll.202.1562054234322;
        Tue, 02 Jul 2019 00:57:14 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id r88sm1447707pjb.8.2019.07.02.00.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:57:14 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 04/27] block: remove memset after dma_alloc_coherent
Date:   Tue,  2 Jul 2019 15:57:07 +0800
Message-Id: <20190702075707.23695-1-huangfq.daxian@gmail.com>
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

 drivers/block/mtip32xx/mtip32xx.c | 5 -----
 drivers/block/skd_main.c          | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index a14b09ab3a41..964f78cfffa0 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1577,7 +1577,6 @@ static int exec_drive_command(struct mtip_port *port, u8 *command,
 				ATA_SECT_SIZE * xfer_sz);
 			return -ENOMEM;
 		}
-		memset(buf, 0, ATA_SECT_SIZE * xfer_sz);
 	}
 
 	/* Build the FIS. */
@@ -2776,7 +2775,6 @@ static int mtip_dma_alloc(struct driver_data *dd)
 					&port->block1_dma, GFP_KERNEL);
 	if (!port->block1)
 		return -ENOMEM;
-	memset(port->block1, 0, BLOCK_DMA_ALLOC_SZ);
 
 	/* Allocate dma memory for command list */
 	port->command_list =
@@ -2789,7 +2787,6 @@ static int mtip_dma_alloc(struct driver_data *dd)
 		port->block1_dma = 0;
 		return -ENOMEM;
 	}
-	memset(port->command_list, 0, AHCI_CMD_TBL_SZ);
 
 	/* Setup all pointers into first DMA region */
 	port->rxfis         = port->block1 + AHCI_RX_FIS_OFFSET;
@@ -3529,8 +3526,6 @@ static int mtip_init_cmd(struct blk_mq_tag_set *set, struct request *rq,
 	if (!cmd->command)
 		return -ENOMEM;
 
-	memset(cmd->command, 0, CMD_DMA_ALLOC_SZ);
-
 	sg_init_table(cmd->sg, MTIP_MAX_SG);
 	return 0;
 }
diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index c479235862e5..51569c199a6c 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2694,7 +2694,6 @@ static int skd_cons_skmsg(struct skd_device *skdev)
 		     (FIT_QCMD_ALIGN - 1),
 		     "not aligned: msg_buf %p mb_dma_address %pad\n",
 		     skmsg->msg_buf, &skmsg->mb_dma_address);
-		memset(skmsg->msg_buf, 0, SKD_N_FITMSG_BYTES);
 	}
 
 err_out:
-- 
2.11.0

