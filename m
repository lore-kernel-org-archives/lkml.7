Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D2AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CD321670
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgGhYPxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfE0MPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:15:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45893 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfE0MPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:15:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so9486585pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UgMa49/CXAIFVmKElCefxmiPU7Ly3jsRaFKqmaNzYxk=;
        b=dgGhYPxCcW3WWOSfXAK4cawTdNYAntuom/Q44qKYhoXSkArjRPj54mQFQf5VNb8ImT
         oLYMf+hlO3FaR3xqWS2NhU3UXe7+BpSpQzWWTWl5ku3nx/WI1vja5WxER0KxbFp+Bq0V
         VFE2Be9sIyNjEI2Z2TYE7rzNAyJyFGkcVgdqtLrpHdzXo/B//y4O4j0/oeE2XiOOkXjA
         5ItQSW504Fd3X0F9Oh/l9yj6E7ZhkFY4WAbX2HcbPVEeoJeVxF8eNhhMosChst3egUrY
         LlA39Sl7xP4d9CT96KFqxSanSqnOFiTXZVS1SZgwX4nWJHSWxJW1I8PoOS8TSWXvsl5L
         DKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UgMa49/CXAIFVmKElCefxmiPU7Ly3jsRaFKqmaNzYxk=;
        b=LwFU1HVHF4+7ajdMkEV7W+erCgTerz1rX+pgP476oM46DETslFXI2J7DITr2B9FG1c
         FmcDCpk0sQELF7Q5tky3jCs2cOkkB0hhDM/lLJfdhQJbcFb1IYs2bE3iZbKw6ZLx8xYA
         Etay3RY5izjkX5WDY+PtFurAFg9gnVtA8j9f2hParuWqHvNjT1Pviy5gnBSeflMsMuhJ
         FfcoW6QcGvZjTmOepk4ZrDzasAcK7K13DB/LGAyfkC7btbwXijvuxXD2ru/HEqrnoYxF
         1F73egmBiUs9rr15GCUChG2eN/m1WIL1wQmE2H4BJdereV6ndP4OUfJZgqaHi9PYZN7D
         FQUA==
X-Gm-Message-State: APjAAAVT64oNk2zgrYvvHC3c7c/nSOAmr3gAbxS2JV9is/ywS0mi7SXI
        +uOkYqnmqHI3Gp6h8aWp4HapKLCo
X-Google-Smtp-Source: APXvYqxS2piUYDwcMVqQI47Y6BNpTk2A4nMwnH6IesVP9VwLN7wBTaTydMwaf4+U23IaB32BcCeb6g==
X-Received: by 2002:a17:90a:37ef:: with SMTP id v102mr31239181pjb.12.1558959302575;
        Mon, 27 May 2019 05:15:02 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id r185sm13609106pfc.167.2019.05.27.05.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 05:15:01 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] mtd: remove unused value for mtdoops
Date:   Mon, 27 May 2019 20:14:40 +0800
Message-Id: <20190527121440.19271-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since hdr was never used, we need not reserve and init it

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 drivers/mtd/mtdoops.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index e078fc41aa61..6ae4b70ebdbb 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -191,14 +191,8 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 {
 	struct mtd_info *mtd = cxt->mtd;
 	size_t retlen;
-	u32 *hdr;
 	int ret;
 
-	/* Add mtdoops header to the buffer */
-	hdr = cxt->oops_buf;
-	hdr[0] = cxt->nextcount;
-	hdr[1] = MTDOOPS_KERNMSG_MAGIC;
-
 	if (panic) {
 		ret = mtd_panic_write(mtd, cxt->nextpage * record_size,
 				      record_size, &retlen, cxt->oops_buf);
-- 
2.18.0

