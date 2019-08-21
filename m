Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A73C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFF022D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ72Vsxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfHUQuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:50:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46158 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:50:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so1619767plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vOsVwGQVH1pTZWvq9RI6vtuGHBdFwAhJmBlw43kNz3A=;
        b=FQ72VsxxF827h9uCn8Oe0rXRQviu1GeO5KJ5ZnYaHmnTcsTrXDgA02aZoVxzzwkPnK
         81t2/yP7/Lh7Oh0Aaia/sF/5LwkDv02xopWWgzbOzZzAZd50EtXiTyl8ujxFMnINCVbf
         bJ18EY9IEauG17V36C72VrrrR0kF4F4iVOvPaEMCscYx0I/5U/sbOdyuxpKJXLf5d0Rf
         d2do7MjrXdckd/cq/oaogcJm7m5J+Gz6XdjW9V/Ug+yxW5JpExkHXtgAIen8MeJGo0lG
         +FspHDWBgJD0uJsy6EzwKkTQVTW7XYSVSxALZ8pbx0knLRoUVrbw+gJL0q6j+RM8EH2V
         NCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vOsVwGQVH1pTZWvq9RI6vtuGHBdFwAhJmBlw43kNz3A=;
        b=tIBi56EJtyan1sWqLxu1zKdiO5RHO3g23w/sEyzVP1Nwo8kLemZ0s2RgOUh0GrS4sE
         q86p3HHVr0/0XUhq5i2G7AONBWXFwE48XRnq23MIj2UqOLU7wTZz1f7ON+Skx8Qu9BEU
         8pVd1JowcIoqWjN22rcg1Pk7SFc5Yb3dpCZUjUWhj/DQ/Ekuax+uSLj14A1HJBklG6sL
         OA7fdyql/jWt0m2JckdSkX+04AulHZcWtyA+E40KvNwCELxtVxNwqqtT7cVhlFTL5cS7
         Y0JObIsGeuP9Dfc78izNT6sWylezFdnQUjoK4Y9qAIgIg3IQGXnOf4Xu3Y55uH4wmCVi
         NwqQ==
X-Gm-Message-State: APjAAAVlHrb4gbb0w+uzmGlvjyoaLQ8IW/3ly1ii+64UIO36FVk0xmsT
        ibvwuchWb2oHuoxIcQpkSv0=
X-Google-Smtp-Source: APXvYqysov090aoIXmaNouZ7wKZfGapTlQ8KNwROhLrDyXYtHem3aHvFouvEGUr5PJrADORE+bfYHg==
X-Received: by 2002:a17:902:33a5:: with SMTP id b34mr2368689plc.286.1566406224148;
        Wed, 21 Aug 2019 09:50:24 -0700 (PDT)
Received: from localhost.localdomain (M106072039032.v4.enabler.ne.jp. [106.72.39.32])
        by smtp.gmail.com with ESMTPSA id j187sm33956245pfg.178.2019.08.21.09.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 09:50:23 -0700 (PDT)
From:   Tokunori Ikegami <ikegami.t@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Tokunori Ikegami <ikegami.t@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Liu Jian <liujian56@huawei.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: cfi_cmdset_0002: Fix do_erase_chip() to get chip as erasing mode
Date:   Thu, 22 Aug 2019 01:46:51 +0900
Message-Id: <20190821164655.5860-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chip state is set to erasing by the function after getting chip.
So it should be to get chip as erasing mode at first.
But previously it was to get chip as writing mode then fix as erasing.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/chips/cfi_cmdset_0002.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index f4da7bd552e9..74b07a0bdaa2 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -2344,7 +2344,7 @@ static int __xipram do_erase_chip(struct map_info *map, struct flchip *chip)
 	adr = cfi->addr_unlock1;
 
 	mutex_lock(&chip->mutex);
-	ret = get_chip(map, chip, adr, FL_WRITING);
+	ret = get_chip(map, chip, adr, FL_ERASING);
 	if (ret) {
 		mutex_unlock(&chip->mutex);
 		return ret;
-- 
2.11.0

