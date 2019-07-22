Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA33BC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C266821955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAeg5YAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfGVF5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:57:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44855 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfGVF5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:57:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so39452486edr.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=JWav04oSOMMfjnrIfRfnbnhq134i7LRODNuQ+JDA4d8=;
        b=iAeg5YAbgEc4aYUgaNNECEsRpX+e9jc1I5YBQtLvCy5UcbJE62lDIR8qMw5Uo0URLB
         OR5S1U843vWDtFQk2NDReGy4Qxb7N98CbYzYs19BsFtoqLD5DWV07b8V1JPSFcBXbjyW
         HWYtON8kw3CBY7KNYNNyGUBHFOA2grIb+ldo42JgaM/4i3ZcSJ6dGqY8b5ov1FKoVBoE
         u87X+cv6T+p3shg/9BvIHVmZMWjV6L+fwDaG0iRgxd82oLNaJqJYY0HpMvnJNy+GF4+3
         1xdSCLtQ22Jf1yyhsfFqpq9MU4Nvy6SLNJPh91tNdAwCOX3JwyfS85HihQlxDN91dRgF
         e32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=JWav04oSOMMfjnrIfRfnbnhq134i7LRODNuQ+JDA4d8=;
        b=YS5qXYoHfhcKQ3jUpe/uVMzXsKdv8mzwWZohJLguGg+GV2cke1lhVfkQyUE4do8RQ/
         3PkAebFArLNKML2ibOf/Bn9PpP9YfVSduFlm4kKE19ulr0eO/i3JSrUndNLY7RfB+0Oy
         i4lBbc/26GSFdBvmUP0QUlzFsNpXNZtwCVXqmj65o90sA5x3+jAnmALG14G2W+mk/Do7
         2rq4lhq7v19WEiZY3EXkMjZGDxLV4AQvHfIaf4m578oGxu4Y5un2nlc3BSz8c8hvr+g7
         4G75ocab8tUieKBr2xlCy+NutgvR1FruCfxAFr1I1eSStMOW4kEIZ/MoVxC90Lhzenii
         u85w==
X-Gm-Message-State: APjAAAU8T3AutSwTd1Lf51Hv0ZLoKvJjlArCPcFsLp4BOR5WBl7eckU7
        SQu/o2QYZsZaMRpRDnM9ttE=
X-Google-Smtp-Source: APXvYqzUeEvZzXubeuDVswHFU5kKDVfDWDqDmcg24fW79naD2l793eQa7IXung57mhGRdtZ8MAtoew==
X-Received: by 2002:a50:89b4:: with SMTP id g49mr58295914edg.39.1563775036035;
        Sun, 21 Jul 2019 22:57:16 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id a6sm10351725eds.19.2019.07.21.22.57.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 22:57:15 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [PATCH 8/8] mtd: spinand: micron: Enable micron flashes with multi-die
Date:   Mon, 22 Jul 2019 07:56:21 +0200
Message-Id: <20190722055621.23526-9-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722055621.23526-1-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Some of the Micron flashes has multi-die, and need to select the die
each time while accessing it.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 1e28ea3d1362..fa2b43caf39d 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -90,6 +90,19 @@ static int micron_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+static int micron_select_target(struct spinand_device *spinand,
+				unsigned int target)
+{
+	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(0xd0,
+						      spinand->scratchbuf);
+
+	if (target == 1)
+		target = 0x40;
+
+	*spinand->scratchbuf = target;
+	return spi_mem_exec_op(spinand->spimem, &op);
+}
+
 static int micron_spinand_detect(struct spinand_device *spinand)
 {
 	const struct spi_mem_op *op;
@@ -105,6 +118,7 @@ static int micron_spinand_detect(struct spinand_device *spinand)
 	spinand->flags = 0;
 	spinand->eccinfo.get_status = micron_ecc_get_status;
 	spinand->eccinfo.ooblayout = &micron_ooblayout_ops;
+	spinand->select_target = micron_select_target;
 
 	op = spinand_select_op_variant(spinand,
 				       &read_cache_variants);
-- 
2.17.1

