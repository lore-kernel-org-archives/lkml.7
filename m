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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481E9C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B4225FAE
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2f1cgQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfE3SaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:30:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39940 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3SaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:30:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so4487680pfn.7;
        Thu, 30 May 2019 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=icbxC9bWDA/gr+Swd+x5aWdN0xZB1FG4LYelE4YdeDY=;
        b=b2f1cgQhL+d74DQIZw+OUVAoOEEfz25VEOH8kZHyO7DKC5vt8Dn25S0y1NYrsC4BYk
         gmOr2vR1nUP/xsc6Qw+RAsBQybjXa7Ow16A4xO+qbmPfxAfrw/zyv6jvRs85Vn5N+qXN
         Yyx0qhntZ9x+Q6i0N88xresUO3zpUK8Q/zgyJRbp7SYxOVQcOmlY2ktq/DQ42r8qmhFY
         8sjd0RC59bGwrkMwZAnR84Bso12toiC2uPdS5gXplVZV6U18hC+vuWkNutbiGWIxqZFl
         oHD5oTwmC2rWDPoJWcJ8WO3NXfwayGqCBPe60v7bMWQmSFvvERO7tKZ7oR0xxHcITsse
         aIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=icbxC9bWDA/gr+Swd+x5aWdN0xZB1FG4LYelE4YdeDY=;
        b=oGtIc8TUMyDQvOJNrCJY05si37aewBl+yP9NJEgRrbE6FDkzolRHFeZq3W6SDhQrfV
         Q9ePV9oO0ie4gJ8qgJrIPPNXtjx1FOlHtA1i0IxI6RCsPxAJ1hzwZNPMDu30Nv2AuxB5
         U/0wpbFAHkCmNJ1/VWyIZC08jrazUZpZKWbTqxLVweaYoPbtr8E+7Qg7sMw6LXrdU38Z
         Qzh8JnjyzA62T1jPWfD5ILU1BjAOu++PMGJfwNnTYR9ru5XTy1xmz0L4GfL98rvZIpcI
         YVaiCN/eFlJRBhPmwBIGEgFtZZb/sM6UY3/LHdqHM7qBgHN5LKlSeeuD/+EJC/pfrOMM
         aC8A==
X-Gm-Message-State: APjAAAVEJy3/Np5ZR5xf2mmFKa7gjpsegvbZoDxT9uj3gfK8x6LQJzTf
        l72IxpEq/KPcvEliZVW2TCs=
X-Google-Smtp-Source: APXvYqxmXZ1NRNEntwY+yrXIl+p4r36/Zk5hcBsFtCkMgEo1FMWC52x7y2R5LXECgCPXcSactAjdJg==
X-Received: by 2002:a17:90a:9382:: with SMTP id q2mr4803031pjo.131.1559241017239;
        Thu, 30 May 2019 11:30:17 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id w1sm5341263pfg.51.2019.05.30.11.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:30:16 -0700 (PDT)
Date:   Fri, 31 May 2019 00:00:13 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: pmcraid: Remove call to memset after dma_alloc_coherent
Message-ID: <20190530183013.GA8526@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning reported by coccicheck

./drivers/scsi/pmcraid.c:4728:3-21: WARNING: dma_alloc_coherent use in
pinstance -> hrrq_start [ i ] already zeroes out memory,  so memset is
not needed

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/scsi/pmcraid.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index e338d7a..112a617 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4678,8 +4678,6 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 			pmcraid_release_control_blocks(pinstance, i);
 			return -ENOMEM;
 		}
-		memset(pinstance->cmd_list[i]->ioa_cb, 0,
-			sizeof(struct pmcraid_control_block));
 	}
 	return 0;
 }
-- 
2.7.4

