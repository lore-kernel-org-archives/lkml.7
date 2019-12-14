Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9F8C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 21:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E46F20866
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 21:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqR3BInj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLNVJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 16:09:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44519 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNVJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 16:09:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19so2521281lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 13:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EQQEq9PTrEL9uBad7QGCPNruaz6IPJiTv99Hu/EpDwA=;
        b=TqR3BInjw/IqJswekxIeRtPW85atl7eHttemwFLOjsc1p6M6IvmN0ZUcclC5MQEjgl
         TcsvPd/dAWMwZPm3JvPw0PjGhyXhqAbyCxR1wjqmg1/8JMgornWJy0V/hdfScF1TWb5N
         1GUKLV4nbTE4px2Bioz3F/gllrAV1Wl2A+3/Ykb1QfBzJL7SOmFfA0avWUZRjYsE52Qr
         isltovE2z9xHXaxNFtmoBWxXdnqm3V3N5vhjf7R/fsB8U69ajWtB0PpiQO0LeUuFpmmK
         pmyJ+W/ybPqYIjAyQ8ZqcxZH47k1tmk1PEfO+gCV9qGj48VPIufxdl9dic4jkAp30hQd
         AWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EQQEq9PTrEL9uBad7QGCPNruaz6IPJiTv99Hu/EpDwA=;
        b=rcbkx/ub6Mz2Fp8QNGqKtR09itgWSzj4Q45Cw3Q3brWxZzufBrt0VGiSuS3tGbSikD
         t+l6yh20/8BmVXSXX7HpW7xdWEy/A3sFRvB8GEKQ0ZYsWEWQUiI5eg3dcXG02f/cHaaZ
         rUHPHlgKojWj6i2IRVp9LgVOBS2A983WAABiVPwqkmcLjU5D50vltnvqcsvXu4UA0dYq
         ODPTYhyxhivmJyjH+1fG4tJ1mIBM8X9JX2J18C4eJ0kfSTpSvOoKziix1jBPo7WJkpyB
         uIr3daIkYVjSXtxZXFcDHuAwvMpk3B2rQmraRWrd+zH3tw1lzW1M0zMy3whxsSexmUPP
         yt5g==
X-Gm-Message-State: APjAAAV+ve1IFv6SqaHK4eMzJ2EuKW6J2tCKHkrUUdt+uTleesGY8v2g
        D7407NlCzZtXN1WHdrAPSRI=
X-Google-Smtp-Source: APXvYqx1W6X0Gtp+sZynYaCyuFsLfu5ht4rhMlovrmvhkUwUUyQl+pOQjTJA3L9dl/7wSGb33qqyIg==
X-Received: by 2002:a2e:809a:: with SMTP id i26mr13794036ljg.108.1576357775077;
        Sat, 14 Dec 2019 13:09:35 -0800 (PST)
Received: from ul001888.synapse.com (18-129-132-95.pool.ukrtel.net. [95.132.129.18])
        by smtp.gmail.com with ESMTPSA id t81sm6236909lff.25.2019.12.14.13.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 13:09:34 -0800 (PST)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     piotrs@cadence.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] git commit --signoff -m "mtd: cadence: Fix cast to pointer from integer of different size warning
Date:   Sat, 14 Dec 2019 22:09:45 +0100
Message-Id: <20191214210946.29922-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a cast to uintptr_t and next to a pointer
In the final assignment the same casting in place
memory_pointer = (uintptr_t)mem_ptr;
Fix warning: cast to pointer from integer of different size

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
This commit fixes a minor issue with a warning
Not sure if we will have problem here in case of
dma_addr_t which can be 64-bit wide on 32-bit arch

---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 3a36285a8d8a..960c3a0be69c 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -1280,8 +1280,8 @@ cadence_nand_cdma_transfer(struct cdns_nand_ctrl *cdns_ctrl, u8 chip_nr,
 	}
 
 	cadence_nand_cdma_desc_prepare(cdns_ctrl, chip_nr, page,
-				       (void *)dma_buf, (void *)dma_ctrl_dat,
-				       ctype);
+				       (void *)(uintptr_t)dma_buf,
+				       (void *)(uintptr_t)dma_ctrl_dat, ctype);
 
 	status = cadence_nand_cdma_send_and_wait(cdns_ctrl, thread_nr);
 
-- 
2.17.1

