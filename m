Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D7C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D338206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2EYg2QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfGUSPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 14:15:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33179 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfGUSPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:15:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so17976940plo.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RWwLZt/rt3rzH+QJKbsOFH6f0FNBf1yA2AONMe227Ak=;
        b=P2EYg2QAnNUbU3edGEbUEtYVrJRG76A7b0Brz9dpH6TpPooOr0Jo1P0e8Gdft5T3dn
         PP/qZG+gyty4qKDJl0c1Vy8cbBApIuwPOUTFiBgPD8QyvXZt/IagX/d9+BkqvDZTl2il
         C+MUUBa0fm6EG3pqtQPCiWsu79ojKs/Jl1IOXAFaE2dwGRVxwosrUVk5A9AL9Owwcvdk
         fJe6vKUKzFReByV1D6poE8WPcJiyhlmsAWUdmhocaYsP3coFXxw4WkF8W83qcgY8jAMO
         qcktb+53nUerGJE2SkSn4Lc9+2bmJkG0FO/VzoOssUjCuP++aUiHOku1/669hBw6J3Ha
         hTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RWwLZt/rt3rzH+QJKbsOFH6f0FNBf1yA2AONMe227Ak=;
        b=bHGnLr8+iFDf7D5PRCg8YdX5lLcmjMGUZQK4kaOQPU8ftBORIBkq3c6UI2d4mYZI6v
         qCDH0g75dO3oXNeOG13WjGVMRf4EIgTtfbe2yoE8akry7D0t503GqO5ODFAy9+UUNbxx
         4Zd8Gn4wYcWNE/cP3cYUec6KBIznuRDGxKCVfr8n5IQPiNxsA3t3CQEgCSTLzKZXlX6r
         dPJ11XBarOV7pX94WIaBprGYzdWsNvYiH+6REs8tefvcFK7JVCdOWbmp6Xne/czyY7wd
         Y0K0y0iOfL4YCwC6xXWyl5/xX3T4h2BFSWAOZCZ3ONZgG/ViFaiyFiQnr7kP7GYx0q3L
         GRaQ==
X-Gm-Message-State: APjAAAVKdbe3GFr47H22zJ+/Gh5HcTeNJpYfGZT64vU20dPI3SiB6UxV
        g1V2RVQYsYtMPgcIi0Q3P7Q=
X-Google-Smtp-Source: APXvYqxsFR6/nJOopb1myYnRstaWcWMyoLeAJ5eu/0DJ3inVuljlHLs/0ckz4mLYB2FUulM73NnvJw==
X-Received: by 2002:a17:902:124:: with SMTP id 33mr72747169plb.145.1563732942128;
        Sun, 21 Jul 2019 11:15:42 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id 35sm38914619pgw.91.2019.07.21.11.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 11:15:41 -0700 (PDT)
Date:   Sun, 21 Jul 2019 23:45:36 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] irqchip/tango: Add NULL check after memory operation
Message-ID: <20190721181536.GA13450@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NULL check after kzalloc operation.

Fix below issue reported by coccicheck
./drivers/irqchip/irq-tango.c:189:1-5: alloc with no test, possible
model on line 193

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/irqchip/irq-tango.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
index 34290f0..761b9fa 100644
--- a/drivers/irqchip/irq-tango.c
+++ b/drivers/irqchip/irq-tango.c
@@ -187,6 +187,8 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
 		panic("%pOFn: failed to get address", node);
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
 	chip->ctl = res.start - baseres->start;
 	chip->base = base;
 
-- 
2.7.4

