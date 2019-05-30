Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE0AC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B2725F58
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9/E6LUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfE3SVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:21:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43148 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfE3SVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:21:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so2471692pgv.10;
        Thu, 30 May 2019 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UBdHo+2366MDlEoeBRVocLtq/sBDv973ycyrjE7aJxY=;
        b=E9/E6LUYd4D0dAqav89AsTQRFk4R1QQPe/2zZVQ1sMKi/zbT8bCNF/4M9bO28+HJIT
         q0yzcUXDCxtVeNzPZ7VKJMhpBjg2Q6Lu1qr3Ckh8oml4xO5W+UjxRqcYp4i1Z+B0IdJ6
         tTh8MGPWzycRuZvWMRNZA0bK++6I2FM9cysX2JG3zReSYiNsEqLokRRXF8hRhBbu37VD
         zwZ/8hD0oPvtj6PuRPlVebNsUHXIEl0cmVq1lsFJWSMedtOh2Nmgy6SmDn91m0gczDYC
         0jr11Wpg6iwP1Q/UD8Og/95UsOzVthnfeMY+xXlDoO6792WVztBqn3OlH6vADw+K5IJF
         Mbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UBdHo+2366MDlEoeBRVocLtq/sBDv973ycyrjE7aJxY=;
        b=bB96MK96w5+scM9p5gOlso+sYXFWMRLovu3tJCNLJZ8qbTfgY4YMF+BcVkmSfWOvhs
         13M7hUiPHxHnFvUYMNToOuEw3Xt42jkZap4U/BEuMWtBTk3C2BcpgwGcDTkGoSTm0Lj/
         heltmI3Ir5SZd8mEgpcgcJADesi7I+5ycdTLNodYCotWp2+EACd75a+X4IDSX/SxHghu
         raktI6iwBEwxc4dd4JHOMHC6jY61F0rMP3tLeaMwyYljPj7aA1t5+I3+zri0ARsQhech
         LDEG676N+nKY+46F6p0cymqNpPyVt4lKCl0YZOWJQ/mk01wnXp34sY4nZrZSm8O8SJGJ
         ksyQ==
X-Gm-Message-State: APjAAAXql8NlMYLBmKQOnQVhpG8rHw520N9Dq4SFtKVqqc417SJ+DWBl
        /YlVv5an4DGRl8qCF760BW0=
X-Google-Smtp-Source: APXvYqwI/dOtmxmOjPbR8FshFhAOZ0ab7pn9JQXRzgbKq1I1gC2KkVRR+g8hGqFnge93QOnLy87pAw==
X-Received: by 2002:a63:dd17:: with SMTP id t23mr4921994pgg.57.1559240467368;
        Thu, 30 May 2019 11:21:07 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id e4sm3141399pgi.80.2019.05.30.11.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:21:06 -0700 (PDT)
Date:   Thu, 30 May 2019 23:51:02 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: dpt_i2o: Remove call memset after dma_alloc_coherent
Message-ID: <20190530182102.GA8140@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning reported by coccicheck

/drivers/scsi/dpt_i2o.c:3092:11-29: WARNING: dma_alloc_coherent use in
sys_tbl already zeroes out memory,  so memset is not needed
./drivers/scsi/dpt_i2o.c:2802:10-28: WARNING: dma_alloc_coherent use in
status already zeroes out memory,  so memset is not needed
./drivers/scsi/dpt_i2o.c:2856:20-38: WARNING: dma_alloc_coherent use in
pHba -> reply_pool already zeroes out memory,  so memset is not needed
./drivers/scsi/dpt_i2o.c:1331:10-28: WARNING: dma_alloc_coherent use in
status already zeroes out memory,  so memset is not needed

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/scsi/dpt_i2o.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index a3afd14..128d4f9 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -1334,7 +1334,6 @@ static s32 adpt_i2o_reset_hba(adpt_hba* pHba)
 		printk(KERN_ERR"IOP reset failed - no free memory.\n");
 		return -ENOMEM;
 	}
-	memset(status,0,4);
 
 	msg[0]=EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0;
 	msg[1]=I2O_CMD_ADAPTER_RESET<<24|HOST_TID<<12|ADAPTER_TID;
@@ -2806,7 +2805,6 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 			pHba->name);
 		return -ENOMEM;
 	}
-	memset(status, 0, 4);
 
 	writel(EIGHT_WORD_MSG_SIZE| SGL_OFFSET_6, &msg[0]);
 	writel(I2O_CMD_OUTBOUND_INIT<<24 | HOST_TID<<12 | ADAPTER_TID, &msg[1]);
@@ -2860,7 +2858,6 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 		printk(KERN_ERR "%s: Could not allocate reply pool\n", pHba->name);
 		return -ENOMEM;
 	}
-	memset(pHba->reply_pool, 0 , pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4);
 
 	for(i = 0; i < pHba->reply_fifo_size; i++) {
 		writel(pHba->reply_pool_pa + (i * REPLY_FRAME_SIZE * 4),
@@ -3095,7 +3092,6 @@ static int adpt_i2o_build_sys_table(void)
 		printk(KERN_WARNING "SysTab Set failed. Out of memory.\n");	
 		return -ENOMEM;
 	}
-	memset(sys_tbl, 0, sys_tbl_len);
 
 	sys_tbl->num_entries = hba_count;
 	sys_tbl->version = I2OVERSION;
-- 
2.7.4

