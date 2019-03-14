Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D32C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C9820811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="b7FgBjD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCNPDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:03:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38624 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCNPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:03:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so6238404wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmg5VvniQ7MB05NZyKlv/Pxkl3JAvpvx80aGU/gT31I=;
        b=b7FgBjD8v9Lgx7cW5NBrpBU5XuZl3cplso0plqULVDMKqLNBz78BHGrY7a8RmNL2by
         moFqN1JZEPA5HO/0RPI7kaCoHZ6zj2wOX/6ooKdmLmO5qxMUyKwM2VsOd4G7NJr2QuU5
         bkVz/FrjD/w5Ywa9seasWAulITZrAeTgjIbgN2BO1FvYO/EBJmgDsHCXSwIn1Q0y7fVj
         OWlAKXchSKaOv8k4wyzX4TL5mBam4Cm7mnKIw9GGV92JncIX4S+HsktMz6JCB5KGoP4R
         XtDaMv21O6L7cfSlz3yk2lK4N3DE0/dpgLnkD7v0Dn5hOoXaIFnjSVKk/TFsU0t2+yXN
         aJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmg5VvniQ7MB05NZyKlv/Pxkl3JAvpvx80aGU/gT31I=;
        b=IAeiP3qwzsZ4Wka2DrCp4KAVWKA/pk9GafNBEXL28NMHq2dwpgfW1SrRWQ2aNU/ozy
         GI46xm92LRV0gE+8rTdnAd6I28BjbgId2tsx/mx2saB9kRDZLrdzYv2vVIbgGSMaasDg
         aMskuCQlGtvknYylV9GjupIwudR8otpTefCG8z1Ip0jJRzIcf8sJTc30ANk2+TpCnl8s
         pIVc/Onb64pPdJxuUm4Cta8knFgT/usAuw5eP4n34GhbBEFtuJXassmXGAl67nfFj0tb
         W0HnYjCnC+wFhFJUaEBR8sTBpeuy2Muos3YMEl9MMmk2PIBZ/ix3u1vvMhduLpHAJA6D
         ovPA==
X-Gm-Message-State: APjAAAWExWq88WJRYZZldVNHLna0JUn7Xxx+Mka2GJ+A9UtayU7zze2C
        4SpL8UgaCFE/n4yfiukJlwyClg==
X-Google-Smtp-Source: APXvYqxyih97mMDaoDcClCCmzDQcN8TK75BtqyxUOB5bOOgnpDajorY4LwWzvMBETaVDKPEUYEGn8A==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr31362178wrp.247.1552575832917;
        Thu, 14 Mar 2019 08:03:52 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-31-143.w90-86.abo.wanadoo.fr. [90.86.86.143])
        by smtp.gmail.com with ESMTPSA id e23sm3761705wme.15.2019.03.14.08.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:03:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] um: irq: don't set the chip for all irqs
Date:   Thu, 14 Mar 2019 16:03:44 +0100
Message-Id: <20190314150344.8555-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Setting a chip for an interrupt marks it as allocated. Since UM doesn't
support dynamic interrupt numbers (yet), it means we cannot simply
increase NR_IRQS and then use the free irqs between LAST_IRQ and NR_IRQS
with gpio-mockup or iio testing drivers as irq_alloc_descs() will fail
after not being able to neither find an unallocated range of interrupts
nor expand the range.

Only call irq_set_chip_and_handler() for irqs until LAST_IRQ.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
Note: I plan to introduce support for SPARSE_IRQ but AFAICT it will be
a bit more complicated, so in the meantime I'd like to propose this change.

 arch/um/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index f4874b7ec503..598d7b3d9355 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -479,7 +479,7 @@ void __init init_IRQ(void)
 	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
 
 
-	for (i = 1; i < NR_IRQS; i++)
+	for (i = 1; i < LAST_IRQ; i++)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
 	/* Initialize EPOLL Loop */
 	os_setup_epoll();
-- 
2.20.1

