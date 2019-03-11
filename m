Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8434BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF8D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msB1N2el"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfCKPvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:51:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46440 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfCKPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:51:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id s23so1884009pfe.13;
        Mon, 11 Mar 2019 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=bu4IbrWa1ZTI+K96nWVl7AHAx8DAHzjVhBaPXw8WmYQ=;
        b=msB1N2elS4w879Qcmqs45axyGI85eOIJNKsbTt7tyLe0reuF/CxuVgggM+49f/5BGd
         paJTnU4iCPNLFAYVeObHOKP2adFQ+2wVOCfBeQaDnQoLfWDM6Bu/Ghs1kQtDTopTU5e5
         f4FtLViHH3hKvuctkE8/sZnl0z8Ri/dLbw8Mcin7DdZrCNx81Pj1LjJqY/3mxleSB58a
         JRvMXoiJjRwpjjbbnGz8tlMl3HyRxljvUcJEVgSV6JYJ3/D3iEv5LPURcrHrrtLf6cYf
         tB7lq6VTvbT5cyS3EmbgA28jIHQ/4vLjV2c1ntbvLGkRZX6r8wtcJXSFYPA4UOZ5B/gH
         hg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=bu4IbrWa1ZTI+K96nWVl7AHAx8DAHzjVhBaPXw8WmYQ=;
        b=sFyahwEasFxMoAMXew2nEHy9TjoDmMfX2kTpneq7TNmwqwe4nANeHvLBTT4IxYPPIb
         c5Qfse/2U0xOHUTts0MBwiWAusmXQYGpL/1AMu740rl44rg39RLVY6NB+BcC51f+ZioM
         eRTE5v8g+braNOd1Qe2D1M/SDtrIrEf+FuqNh9X/qwvLjbCLHXFThtq6jeRLnIdTyK5M
         eXtu0GOL+OqU0LyCblLBJg6CSbzsC3yZLGULBCMipqSDeCE+TZFYFHpi+hVzkKhquUx6
         QksEg6yrMJQn1nbrIvrAUn9PKvj/STeamqXJSKqnTGCtuvbCItNy+2433f53R1d+EuNO
         CkWw==
X-Gm-Message-State: APjAAAVTBsS4zLvMeR9G2lMKBTpcS33xsRhm2brsC7nzpv7kJie2OUZA
        fUZpo4xbHmhVayW0eZX9RSQ=
X-Google-Smtp-Source: APXvYqwxI5R2u0XfFlDQ+0MFPCAwqlLrrph2iDZAxTBobXt6kE3YwuII7j6Sra3xFf9yViBEKV3G1w==
X-Received: by 2002:a17:902:bd97:: with SMTP id q23mr33810806pls.94.1552319480110;
        Mon, 11 Mar 2019 08:51:20 -0700 (PDT)
Received: from sabyasachi ([2405:205:6194:e788:a4f9:f674:88cd:e152])
        by smtp.gmail.com with ESMTPSA id 1sm19832053pfy.68.2019.03.11.08.51.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 08:51:19 -0700 (PDT)
Message-ID: <5c8683f7.1c69fb81.e37f9.75a0@mx.google.com>
X-Google-Original-Message-ID: <20190311155111.GA9038@sabyasachi.linux@gmail.com>
Date:   Mon, 11 Mar 2019 21:21:11 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     aacraid@microsemi.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jrdr.linux@gmail.com
Subject: [PATCH] scsi/dpt_i2o.c: Use dma_zalloc_coherent
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_alloc_coherent + memset with dma_zalloc_coherent

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/scsi/dpt_i2o.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 37de8fb..056383a 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -1370,13 +1370,12 @@ static s32 adpt_i2o_reset_hba(adpt_hba* pHba)
 		schedule_timeout_uninterruptible(1);
 	} while (m == EMPTY_QUEUE);
 
-	status = dma_alloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
+	status = dma_zalloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
 	if(status == NULL) {
 		adpt_send_nop(pHba, m);
 		printk(KERN_ERR"IOP reset failed - no free memory.\n");
 		return -ENOMEM;
 	}
-	memset(status,0,4);
 
 	msg[0]=EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0;
 	msg[1]=I2O_CMD_ADAPTER_RESET<<24|HOST_TID<<12|ADAPTER_TID;
@@ -2836,14 +2835,13 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 
 	msg=(u32 __iomem *)(pHba->msg_addr_virt+m);
 
-	status = dma_alloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
+	status = dma_zalloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
 	if (!status) {
 		adpt_send_nop(pHba, m);
 		printk(KERN_WARNING"%s: IOP reset failed - no free memory.\n",
 			pHba->name);
 		return -ENOMEM;
 	}
-	memset(status, 0, 4);
 
 	writel(EIGHT_WORD_MSG_SIZE| SGL_OFFSET_6, &msg[0]);
 	writel(I2O_CMD_OUTBOUND_INIT<<24 | HOST_TID<<12 | ADAPTER_TID, &msg[1]);
@@ -2890,14 +2888,13 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 			pHba->reply_pool, pHba->reply_pool_pa);
 	}
 
-	pHba->reply_pool = dma_alloc_coherent(&pHba->pDev->dev,
+	pHba->reply_pool = dma_zalloc_coherent(&pHba->pDev->dev,
 				pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4,
 				&pHba->reply_pool_pa, GFP_KERNEL);
 	if (!pHba->reply_pool) {
 		printk(KERN_ERR "%s: Could not allocate reply pool\n", pHba->name);
 		return -ENOMEM;
 	}
-	memset(pHba->reply_pool, 0 , pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4);
 
 	for(i = 0; i < pHba->reply_fifo_size; i++) {
 		writel(pHba->reply_pool_pa + (i * REPLY_FRAME_SIZE * 4),
@@ -3126,13 +3123,12 @@ static int adpt_i2o_build_sys_table(void)
 	sys_tbl_len = sizeof(struct i2o_sys_tbl) +	// Header + IOPs
 				(hba_count) * sizeof(struct i2o_sys_tbl_entry);
 
-	sys_tbl = dma_alloc_coherent(&pHba->pDev->dev,
+	sys_tbl = dma_zalloc_coherent(&pHba->pDev->dev,
 				sys_tbl_len, &sys_tbl_pa, GFP_KERNEL);
 	if (!sys_tbl) {
 		printk(KERN_WARNING "SysTab Set failed. Out of memory.\n");	
 		return -ENOMEM;
 	}
-	memset(sys_tbl, 0, sys_tbl_len);
 
 	sys_tbl->num_entries = hba_count;
 	sys_tbl->version = I2OVERSION;
-- 
2.7.4

