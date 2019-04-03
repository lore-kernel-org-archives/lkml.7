Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A2021473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="A04uYCjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfDCIjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:39:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51048 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbfDCIjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:39:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so6485465wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyVO49/CFrb8tlJhFjLf9gLLU2qkrv+fZ4PPlIbwCrg=;
        b=A04uYCjZL7GMtM4GH8OXe4LrtpdhJVa7Gg4r7DIsmuEtUo3tcJd2hr6l1eZFJWJd1R
         I1dtvQvMIV1PAQnIUAfCcuFd8izfKHFMfQ6HBEqLugYrgL6N4hYZP4sfEq9bg9OqjRpJ
         wZCLOl3HIkjZ3tdYTCeN+kSinm3ijc3+Hhrmun21hePYd0PeKD6LXtWHkALgKKnVXORI
         H1AIjDT/Gu9SwBmf5dscSEjVP8VteQFZAWal5cOrKiKs7Kr/4WsYtnfmUT3WK1Je21Z7
         z9bsZ65KTGjsWq3iONOBhVWaGOvzOgJQkl0kVgszDSIZb58NMQse461K49ewNNrjOY3D
         PvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyVO49/CFrb8tlJhFjLf9gLLU2qkrv+fZ4PPlIbwCrg=;
        b=Y9PODcz2OgilMlosojA8VugMMZhhwZNR35ZK4ZYDTM3wEcyCxlRWQGQiBMGmzJoR8t
         6BZ1wQ0UuUeBwMOHtzW+hfZEmsIipeB9sWdXB7cXZrkUk9JFGy+OIM13oAWpnUMkiNxG
         YUFHpIA6RpGgm4eOGvevlR4CaDLp8feoyghptirFfh5NklldY38/iRK2OSYlKXLik957
         h/K9cx2g+q9nP4iTnqytq2IL0L4TBgPD9/RrDqpZcZKlcP66mJG6Gop40AYzysf1D5rq
         CfEAyjshUYPvMQe+x6huLl6Q+fOtr0diiWr8Dis1GWUpDteWP7OeWE5eFuH6JwXN0jNR
         vc2A==
X-Gm-Message-State: APjAAAXm5jrd0DgdnP+H+oLrADEKTOkRK4mhL+5xWpiSDI0UKBdkzju5
        88wBlYgzOPKVR1pYdnzGDt3ZPA==
X-Google-Smtp-Source: APXvYqyrht7hYEtkbiA/4NFmf6bVYJtU2bASi7Wpba9M0qK4s33JaATy6G5Ou/GlVxWYmRqKUC03Uw==
X-Received: by 2002:a7b:c403:: with SMTP id k3mr1230893wmi.58.1554280752811;
        Wed, 03 Apr 2019 01:39:12 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v192sm23655771wme.24.2019.04.03.01.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 01:39:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
Date:   Wed,  3 Apr 2019 10:39:02 +0200
Message-Id: <20190403083902.3975-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403083902.3975-1-brgl@bgdev.pl>
References: <20190403083902.3975-1-brgl@bgdev.pl>
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
2.21.0

