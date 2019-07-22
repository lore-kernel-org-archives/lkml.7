Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC32C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D8322296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gezfKoa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfGVF51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:57:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37756 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfGVF5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:57:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so39506029eds.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 22:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=TqB0rOZLlIYh0a/SpSOrS2aG6wy2S7sHIDUEyeUZVZg=;
        b=gezfKoa3qKy7xPyCUHoxaFJthIwAlw54R2fUek3dXgLyhqVEMHotVYj8+wwaIHrNjC
         IYvfBBQU/JhMWxByqEbyyQipkJJ54h9RUgitieBUKDeIrPLVY7V3O+ZCwxnlxto2GTIb
         UlZj2kUAdLp0mDSWbArVC1AiJO1iT7lxNdWDZdQ6U35CzScgzRWjVOJd16sg0WeTOc6e
         R6fadiWy9m1YNkLIJ3JCB7mVUUuAh5EASppf0MiPR1eA9/fxkO4H0IiGWym1mYJgJu45
         uGUXlOj3BVHEYF+D3xNbDQotLWAdcNhlTTsomh7E+7jYzNqmCSntkgR8PpAV36Coqcrq
         jjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=TqB0rOZLlIYh0a/SpSOrS2aG6wy2S7sHIDUEyeUZVZg=;
        b=Q2A6YkmbtkV0bK2aS9zY6RSkMgpSqUZNmfuNH25S+GPhqEvwYlBGQdXnyEB+GzO3v7
         tzdWNx3n6unSAOP/rXUZ5ePaaRpUY7uTlPzlDK2KlE8Pl8lzfjREEdo41r6YwP3QGLLr
         qXOJX72qYl8w63v2uKh+F6nQKt+2kshO/uExyQUZZaS7Q7oMMVjaAKTX4xUmTCXlq8sk
         N/33HEet9qKgtXjNd+cxnqEPYyO6AZmTrha8IqEp48/A9Qx12ON6hrsVrSa2yFOu+NRL
         n7jxd25TEoHz84MbuAqqEUSm+/GYg0H7f1ZzW2KYrXz0rcnoNMTbF6FuHUOwHUoEvNO9
         aTwA==
X-Gm-Message-State: APjAAAUEW5crx8f/e3mkjZgaSsh6GlIDjQQyE/D6aDw2JG2O3aVZrQu8
        MMTuZF573SPcA4YKhRQuIrc=
X-Google-Smtp-Source: APXvYqx6ImEFwf8Is2ljvvdc4l0y2Rhn6dNHfM+qK/yx45nzcqfiYPSyeBCbYyIS9F+jcjplkkTHxQ==
X-Received: by 2002:a17:906:af86:: with SMTP id mj6mr6292915ejb.157.1563775033987;
        Sun, 21 Jul 2019 22:57:13 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id a6sm10351725eds.19.2019.07.21.22.57.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 22:57:13 -0700 (PDT)
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
Subject: [PATCH 7/8] mtd: spinand: micron: Fix read failure in Micron M70A flashes
Date:   Mon, 22 Jul 2019 07:56:20 +0200
Message-Id: <20190722055621.23526-8-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722055621.23526-1-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

M70A series flashes by default enable continuous read feature (BIT0 in
configuration register). This feature will not expose the ECC to host
and causing read failure.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 6fde93ec23a1..1e28ea3d1362 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -127,6 +127,15 @@ static int micron_spinand_detect(struct spinand_device *spinand)
 	return 1;
 }
 
+static int micron_spinand_init(struct spinand_device *spinand)
+{
+	/*
+	 * Some of the Micron flashes enable this BIT by default,
+	 * and there is a chance of read failure due to this.
+	 */
+	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE, 0);
+}
+
 static void micron_fixup_param_page(struct spinand_device *spinand,
 				    struct nand_onfi_params *p)
 {
@@ -150,6 +159,7 @@ static void micron_fixup_param_page(struct spinand_device *spinand,
 
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
 	.detect = micron_spinand_detect,
+	.init = micron_spinand_init,
 	.fixup_param_page = micron_fixup_param_page,
 };
 
-- 
2.17.1

