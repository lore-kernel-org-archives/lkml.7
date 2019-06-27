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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC8C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E099720B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+wmBwyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfF0RpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:45:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35033 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfF0RpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:45:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so1688437plp.2;
        Thu, 27 Jun 2019 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GtqDoYZdjCNPoyFmT2TD7ZE9qSjsm0IUOGarsCI7T+Q=;
        b=h+wmBwyV8Tixj2O+sWy8l31nObjipAg+TO8ZOD1FawXtjAPkmUaD1rJ18RJONQeIOD
         pfKB0gFEQ9tYFUYqjn2EvtOTaL10phExcykXStz5XxAXfI57rU9ZeIod6+Eybt8YGC41
         bJ1guGRouk6jAxB2/EHYOK9Zhais/X/2DcRJ0VFX4HHHzbCNAzr/U+OsX5BeoVaq2rQl
         b5jbb8tiqKy3DvgdZFmB65qMbSApc5w814fjs2VjBsaGQT87bArQMrGAuRgBw1fQVQAd
         VNIqorUNK9nIc07J7fwmqeH5COzyTkSTypsLXMPFd3Mf4wWK1aufvaqUXV2q0CEz9YPn
         bdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GtqDoYZdjCNPoyFmT2TD7ZE9qSjsm0IUOGarsCI7T+Q=;
        b=kB/SGahY1Us18bxlzEAPrMqrhIQwtVruZq9VRbtuB7EzYkcTtDYntS1ARaREGlrnK4
         tNZUHJYwKapIoFPLuYlFJ8YoODXoJgOe0PGEdVVNxGU1mZmOW58JowJkFzRRzQ4xLUjA
         Rp9dKdH0FwKigtISOnDKtWcUi2tSuT4kzHaYNh9znlMSEggPyVceHQ7GzvMGJh6CcPBr
         sVOERKWrQI6lbZqA4H/XQHU0sVuhvZSFa4X8pvRdxJcuM73RizMh+pKrz7BZTgH8pkFw
         VNAez1hqqQ89mqGC0KPPLSlA8fntAAGTQqOwT9EeSMDfmnyED+ONohXpRL6I5B0BINaT
         qoTg==
X-Gm-Message-State: APjAAAW8ZO1BoESgDxCjdlXUakP7KcXok0UF8VNGkl3PNszL/KwW/6T0
        Lc+p5hSzYZqPxIRcRwNXzJQFqGRZSu3WMw==
X-Google-Smtp-Source: APXvYqwM6dae6iKAfPHJ3eheK6YtHjxg70ppxMQxQqoHnqMXMjfFFtxiwm8YI33gWEdjNbMiHgyPzQ==
X-Received: by 2002:a17:902:8ec3:: with SMTP id x3mr5910189plo.313.1561657523756;
        Thu, 27 Jun 2019 10:45:23 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id w65sm4027932pfw.168.2019.06.27.10.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:45:23 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 65/87] scsi: dpt_i2o.c: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:45:16 +0800
Message-Id: <20190627174516.5888-1-huangfq.daxian@gmail.com>
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
 drivers/scsi/dpt_i2o.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index abc74fd474dc..b1b879beebfb 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -1331,7 +1331,6 @@ static s32 adpt_i2o_reset_hba(adpt_hba* pHba)
 		printk(KERN_ERR"IOP reset failed - no free memory.\n");
 		return -ENOMEM;
 	}
-	memset(status,0,4);
 
 	msg[0]=EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0;
 	msg[1]=I2O_CMD_ADAPTER_RESET<<24|HOST_TID<<12|ADAPTER_TID;
@@ -2803,7 +2802,6 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 			pHba->name);
 		return -ENOMEM;
 	}
-	memset(status, 0, 4);
 
 	writel(EIGHT_WORD_MSG_SIZE| SGL_OFFSET_6, &msg[0]);
 	writel(I2O_CMD_OUTBOUND_INIT<<24 | HOST_TID<<12 | ADAPTER_TID, &msg[1]);
@@ -2857,7 +2855,6 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 		printk(KERN_ERR "%s: Could not allocate reply pool\n", pHba->name);
 		return -ENOMEM;
 	}
-	memset(pHba->reply_pool, 0 , pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4);
 
 	for(i = 0; i < pHba->reply_fifo_size; i++) {
 		writel(pHba->reply_pool_pa + (i * REPLY_FRAME_SIZE * 4),
@@ -3092,7 +3089,6 @@ static int adpt_i2o_build_sys_table(void)
 		printk(KERN_WARNING "SysTab Set failed. Out of memory.\n");	
 		return -ENOMEM;
 	}
-	memset(sys_tbl, 0, sys_tbl_len);
 
 	sys_tbl->num_entries = hba_count;
 	sys_tbl->version = I2OVERSION;
-- 
2.11.0

