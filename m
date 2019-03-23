Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CACC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB29021874
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp0XEUqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfCWLew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 07:34:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41989 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfCWLev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 07:34:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so3247659pfn.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 04:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HiyTezxoUk6qedsEYwxuVQ68QLl7+crqseoJCSBSYJE=;
        b=Mp0XEUqyQ94uJJzTd5tsKSMRh/Th1Or26XcS9qUDuoq7vqMN6KFBylA2kkrNDRWWII
         2XdhNnpJA2+BGxIsYkDKpiaoS7yMgXe8pUyD85X99f47tf7rsLMHJ9TstX4RvAiOCJke
         ZlUD8Lpsr4oTWOR3y28CfUHp0ZkPV0f0hYeW9iV0jcr3GnN0FSmV66Eqmm6DUOK9K1dj
         jdTeCRki2GNQ64gRq+OCGHHP81i3V492HOmM67MBDrLFBEoU5snH5d/MJ0w67piNzaBc
         wtVK6dtxZJCBh+ExoyVu+loLU5VngK8H1aLwCjkI5mzQxA4DoE7xpShn0X4TIMP1ZpI9
         dPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HiyTezxoUk6qedsEYwxuVQ68QLl7+crqseoJCSBSYJE=;
        b=AE+bfBhmeUQ4W8DqPMWGwfCLLjPviql1lFwQYMTOLZPSuPZyVKPBM+bLqthv5sAJEn
         hNRZvKCPhSuoyoHL9yo/mTXuhWweMDcVhSZeIiqVjxAlzdJ10avk7CuUDxnrIHL0pf9M
         ux/sdMGpOsAENtyH5OwmRWAPolYgOkiF7gJGfWbPUwk9xkZgbUt/Q4pcbjct5yzwgBtm
         b6ZySQyYVZuqd6ayOqSkLj6dvQ+KpJcLJNE82+Dw0ChrH39LMC0Bgk8enG2Y6s+aodtF
         hUlGmaT2YKxgIzZ0Rm3lXGU5xGu/82cizMp0WL0QPUUNUsR9I6yZj/oOeAuQy2H8UvqT
         kAFQ==
X-Gm-Message-State: APjAAAWtJlqGMZS772QHVKfmrBAzAvvnDliIeM3lCzkTSaDlrSKf++a2
        VVLY25j1k/sEzzlz4CssWJs=
X-Google-Smtp-Source: APXvYqxLLz0VphJRbK5Nx2z2SlgHcMjM5gvzDv2rQonz5aWKaQlCd5wFui27i9HGF6A+Ekpil1Te7w==
X-Received: by 2002:a62:4e8a:: with SMTP id c132mr13810922pfb.24.1553340891306;
        Sat, 23 Mar 2019 04:34:51 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id d75sm12908686pga.66.2019.03.23.04.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 04:34:50 -0700 (PDT)
Date:   Sat, 23 Mar 2019 17:04:44 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, christian@lkamp.de, neil@brown.name
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ralink-gdma: Convert unsigned to unsigned int
Message-ID: <20190323113444.GA9329@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpatch.pl warning: "Use unsigned int instead of unsigned".

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 0b831f8..523c39e 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -162,7 +162,7 @@ static inline u32 gdma_dma_read(struct gdma_dma_dev *dma_dev, unsigned int reg)
 	return readl(dma_dev->base + reg);
 }
 
-static inline void gdma_dma_write(struct gdma_dma_dev *dma_dev, unsigned reg, u32 val)
+static inline void gdma_dma_write(struct gdma_dma_dev *dma_dev, unsigned int reg, u32 val)
 {
 	writel(val, dma_dev->base + reg);
 }
-- 
2.7.4

