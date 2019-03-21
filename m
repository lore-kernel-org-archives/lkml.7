Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4E8218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6V9Ivn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfCUTL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:11:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43355 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUTL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:11:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id l11so4822386pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jrhyJm4DjlgoSKE9FsegyYw6EdFbtFVOvkBMuBI34cA=;
        b=I6V9Ivn8swuTuGkJe86kLpdb++ZpJhQzkSO1ZDBlpwJ17MhfH4MqEx5PF9m63aCl1w
         oabnR2I1+32AWCPmrYwAEYpkW9RA+EaGmCOfEv/QeLfwFRcc4UfcjfGc9Xgo6e9SS/43
         Qahx3xEi3i9nElOFTMJqh/yLCYQanNH1upT1DYEWMp6KPUi6SlYBN7HYzYZbdjhW6wq9
         f8a6Thq2VcmutnXGnKRQdWE9JCuiKfH4KKw3dBHZQCbAMwcEEs0RG47Et2wKHZ7w/K8z
         Pt1t27ZdtTcnXSX+v7rghFpbkgVNiSsNieYe0nYjd/+TejMaKCIRJqdlF+6Zt4B077Xn
         Jq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jrhyJm4DjlgoSKE9FsegyYw6EdFbtFVOvkBMuBI34cA=;
        b=fggYbBCA00TluMXt+0cGbcqQZ++BO73ROjVxpuczo9l8y1TbRD3hawIyfFH4ap6a1B
         fQZxdahVzMT+eYYSe0YTLjRdC51lE096uxuKPdrcTxXwdMvJ960DybFGqH7IxQUFt7FJ
         4L/8JLZxluaIsgp8I31IkNdyKHOBKZmAN7NiOhxlJZAIKewtjl5H9/my3l8BZCu/k7qb
         6TX8hdLdPzhZvkBbElkVXQw/+7bt5mixTnlsisNuFoR0lYRWvwZH0y1FGsgbmwaYC/Y/
         fEK2EbEuAfgWNRVUhlTogCyKz068zxGz6L9dZtxmhoApBj0yhgpLut2O4QId20uZSbSF
         79Yg==
X-Gm-Message-State: APjAAAWA5Z75OxJjVpzC8mXhPyors2TDn4SwYwxxiM8sMrAreN5vgQzf
        WdBRvMozoINX1FF7G8nxcdI=
X-Google-Smtp-Source: APXvYqys5oTb9fv7GEt0VqMfFT4rHu2vVMUB1raH27m54m0ROtKVsAs/Jy7G2lmHJjBicc2OnikTbg==
X-Received: by 2002:a62:205c:: with SMTP id g89mr4816802pfg.34.1553195517461;
        Thu, 21 Mar 2019 12:11:57 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.35])
        by smtp.gmail.com with ESMTPSA id v4sm9220842pff.181.2019.03.21.12.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 12:11:56 -0700 (PDT)
Date:   Fri, 22 Mar 2019 00:41:51 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, christian@lkamp.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: ralink-gdma: Prefer u32 over uint32_t
Message-ID: <20190321191151.GA3263@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpatch.pl warning: "Prefer u32 over uint32_t".

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index d78042e..2c19287 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -361,7 +361,7 @@ static int rt3883_gdma_start_transfer(struct gdma_dmaengine_chan *chan)
 	struct gdma_dma_dev *dma_dev = gdma_dma_chan_get_dev(chan);
 	dma_addr_t src_addr, dst_addr;
 	struct gdma_dma_sg *sg;
-	uint32_t ctrl0, ctrl1;
+	u32 ctrl0, ctrl1;
 
 	/* verify chan is already stopped */
 	ctrl0 = gdma_dma_read(dma_dev, GDMA_REG_CTRL0(chan->id));
-- 
2.7.4

