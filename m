Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ACBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94362184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NzNFKjHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfDKWBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:01:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35849 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDKWB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:01:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so8495154wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4m105n5JXJH4GNf9WN+soWtXGry/vpyc5a/iSxRDFzw=;
        b=NzNFKjHb09kbOIHFC41lGJd95srXDx+k6jOgARNJ6GIQ36ROXxomwgG1t5ZZmtnDcq
         9x0D4BW/E1st5N+fdpO4q/KshtnUPtQJjHjutgQdFrpX/HAI1lc5Ni4VWJC9Jhnak+9a
         WLTkCFzeaPFj4djeAlX7H65RWyYR3vJnvlRvlCcEvZ6vxC6XH5Mo7QYJ4PKFAQdOrrZl
         BH44N+OpoVxPWmBdIAwy0qsgN2oarmGgx7+jb8cJfmn2RlvtqijKBA420rFOYuQ2us0E
         shLtv0GWTTcOa/xcgDqYvMJ0mH2xgXcuRLkpajKWtvCRPnSPjSLKY+s4lAdDjEeGD7+3
         +R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4m105n5JXJH4GNf9WN+soWtXGry/vpyc5a/iSxRDFzw=;
        b=tGKh7bvGHSCpxHdmyruxCNEdM/fYKe/HWL35Af9hQIbbQj53y9ODz/31i5WUj/UKIK
         e3/Nf/k81bq75qbfSGf32amNcZJ573eWMEpU4k7ZO5Bd6ldGABMJNI3W7fBJWi5p5Wzt
         8aIbDohaahUJzZOWykJZQuZ5oxzoSU8kGD+nE9PP+tOhD0BSOtBLbt3LwHXQevufONbD
         67a8FMdZB0ePIHLQuI6q9B1mZEI9nnbbEzMd1nACQBN3tX/kRfwA/Mn+nvC/XhXD90wW
         MNx6QT1QJimCKsBzJP27zwU9NPEzG8qbf/yQFJycG+SMRDZri6ezicGMa5ffPt+mw4DN
         VVMA==
X-Gm-Message-State: APjAAAV+8iqKww7DZxujuCfrfPdtk31Q7eKQjmXm5YEvaglsBJMIDSdd
        wWFgyf2Mo1OtpBQdiVy8oR0=
X-Google-Smtp-Source: APXvYqwvz5r4sd151G017FJh/Vn+1GDk5EwoOrb7sRHdQs5rc/n1+l76wMQOKuKsn5oRdB6Q4mftzg==
X-Received: by 2002:a1c:6783:: with SMTP id b125mr8256171wmc.41.1555020085029;
        Thu, 11 Apr 2019 15:01:25 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0009F15067C8D22C31.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:9f1:5067:c8d2:2c31])
        by smtp.googlemail.com with ESMTPSA id s189sm13266186wmf.45.2019.04.11.15.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:01:24 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     liang.yang@amlogic.com, linux-amlogic@lists.infradead.org,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        jianxin.pan@amlogic.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/4] mtd: rawnand: meson: only initialize the RB completion once
Date:   Fri, 12 Apr 2019 00:00:56 +0200
Message-Id: <20190411220056.19109-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/scheduler/completion.txt states:
  Calling init_completion() on the same completion object twice is
  most likely a bug as it re-initializes the queue to an empty queue and
  enqueued tasks could get "lost" - use reinit_completion() in that case,
  but be aware of other races.

Initialize nfc->completion in meson_nfc_probe using init_completion and
change the call in meson_nfc_queue_rb to reinit_completion so the logic
matches what the documentation suggests.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 57cc4bd3f665..ea57ddcec41e 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -400,7 +400,7 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
 	cfg |= NFC_RB_IRQ_EN;
 	writel(cfg, nfc->reg_base + NFC_REG_CFG);
 
-	init_completion(&nfc->completion);
+	reinit_completion(&nfc->completion);
 
 	/* use the max erase time as the maximum clock for waiting R/B */
 	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
@@ -1380,6 +1380,7 @@ static int meson_nfc_probe(struct platform_device *pdev)
 
 	nand_controller_init(&nfc->controller);
 	INIT_LIST_HEAD(&nfc->chips);
+	init_completion(&nfc->completion);
 
 	nfc->dev = dev;
 
-- 
2.21.0

