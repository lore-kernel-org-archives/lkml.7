Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B951C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B789205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axsFtOim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfETTGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:06:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42897 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfETTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:06:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so25387047eda.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ha5skDnnLVo1GJdX/CM9NCe/isDa5RVzOLC2hACwN2I=;
        b=axsFtOim/WJJUWbZJz8/i03Ph3xHSdnz2DNiFe2Q6ydh5h1ov4vVORzsbiXKu4xf3q
         T8qv/PEpxWr/0XCWg+dWz8Fbaqo589CjX1+CVNrsRQPm6vq6/RXK4BqJzc9BhtvujQrZ
         demB+VLNkgwH1e0xE3eug2/mCTuZFgVuDohU1BXXR1t0EH3Y4i/vbvv0uxYEIFLqOCEC
         TPGQYB4l2GEP/AQW0Gok9TgGpg3Cw1wI6/Ut7kpZeQzBoL8bJ232hzUu8gdtfCfJfWHN
         EjgU7pK/15Z32ja3bM/p+QKiSiu6Yy0oYnjSC4CtNuX0geMW+vdVUWmEhToZq0HwBiug
         6bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ha5skDnnLVo1GJdX/CM9NCe/isDa5RVzOLC2hACwN2I=;
        b=nTnIKglAJFzLXqj0WnioMvvjbXPAkt4BsG0OAM+TB5PiYXAyHF/7WBgPQvNBpmWPkZ
         fHYTsULzfamu0IOZb+FYux3Nety1c/XwPnIWlFpIr09jocJwsTm1ot43wrUyKXLEVkZT
         OILw7mQNRN9vcrRixnQuMyDLAMVZtSvmU4dN1GasaL9jvwEJQSEpGysE1mkRiRdj8yp/
         TmGblMm9ab454glE3XnvHI5WG6Qr45BCa8NcSlxwkeHOwFpXctnPwpEdLRZRrmljtxeQ
         TH6WsIBLmJKSLNTnvplMwSg2Ze8gl/T6VCY1y/8hE0JSO4ttOyh7yfQc2TpKxVMRNHSD
         DH1w==
X-Gm-Message-State: APjAAAWKhwD0lwBd6h+27X6TG0qCb3kPbqFUJlE+ynoZf2C2uJYZ+rBq
        bbfYe4ErcLRx83kz85TROTA=
X-Google-Smtp-Source: APXvYqyWvFHznLLZAKJYcWfcC8Mw2lOlwRgpCokpiyR1YDPRGyEJ1tL7Kq0aOnmIeJBSNK8fKiOsAQ==
X-Received: by 2002:a17:906:1303:: with SMTP id w3mr8731735ejb.196.1558379171104;
        Mon, 20 May 2019 12:06:11 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 11sm3201967ejv.64.2019.05.20.12.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:06:10 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 2/2] mtd: nand: raw: brcmnand: fallback to detected ecc-strength, ecc-step-size
Date:   Mon, 20 May 2019 15:05:12 -0400
Message-Id: <1558379144-28283-2-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1558379144-28283-1-git-send-email-kdasu.kdev@gmail.com>
References: <1558379144-28283-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change supports nand-ecc-step-size and nand-ecc-strength fields in
brcmnand DT node to be optional.
see: Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt

If both nand-ecc-strength and nand-ecc-step-size are not specified in
device tree node for NAND, raw NAND layer does detect ECC information by
reading ONFI extended parameter page for parts using ONFI >= 2.1.
In case of non-ONFI NAND parts there could be a nand_id table entry with
ECC information. If there is valid device tree entry for nand-ecc-strength
and nand-ecc-step-size fields it still shall override the detected values.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index ce0b8ff..a4d2057 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2144,6 +2144,17 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 		return -EINVAL;
 	}
 
+	if (chip->ecc.mode != NAND_ECC_NONE &&
+	    (!chip->ecc.size || !chip->ecc.strength)) {
+		if (chip->base.eccreq.step_size && chip->base.eccreq.strength) {
+			/* use detected ECC parameters */
+			chip->ecc.size = chip->base.eccreq.step_size;
+			chip->ecc.strength = chip->base.eccreq.strength;
+			pr_info("Using ECC step-size %d, strength %d\n",
+				chip->ecc.size, chip->ecc.strength);
+		}
+	}
+
 	switch (chip->ecc.size) {
 	case 512:
 		if (chip->ecc.algo == NAND_ECC_HAMMING)
-- 
1.9.0.138.g2de3478

