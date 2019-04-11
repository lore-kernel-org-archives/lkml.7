Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1066C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA362084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eaxUedWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDKJt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:49:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36638 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfDKJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:49:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so6482765wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EbUPiQp2kWySHUg2pHoKdbGhBipl1kAQxXY6evo+BeI=;
        b=eaxUedWV3P1+PcOHA8Rop3EY6By1dwyCijaXakxZp/oP4pNy/JEh2zKOcee/lcXKPg
         cZlJJcOEpHdLA5bFYrYYbH73h5wf2rASKLrtxj5/ib/Hpp02PzDG2W25I0CIRLLigD3p
         //e9ZHsM6Wdtj8brqA+9LLhuDscC+67HAS62UzrUCZR5/SZfM15T7Uua2B7pjP71WTyS
         bsq8rokvGHt+YbuHyVfAOXBnExnZziGoGCA/tz4/fYQ9LLBgv74CouW1GzmSewVYxDKy
         akEsA3PHjPsDOQUL86MAnLjjeCNNYv6+IDobpRAjNiXg8O9JdRMPUcICBPe03JoWayky
         +GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EbUPiQp2kWySHUg2pHoKdbGhBipl1kAQxXY6evo+BeI=;
        b=DatOaOmEMOE03Sri03FaGHRfdMI8RrjV5AAsS0dQ01nmYGCilgzo4A1WpW+W4LDr63
         N5lSzfe/ij3vkRQhOo3AcfGsXBkaFnxF3lqrCEq2fc/8x2aa+M37klf4IqOidKHNLCNJ
         +j/mc97osyc3ksFFwu0IQKbIhLVAnLAz23cmvFBIJ8K7S2gzohnfLhqT6rAKT7C0vC34
         Qu/X14jUArAzZWWFtaZ4RN+RSdsYUJzwX6mKNLkEmseteJbDJZJ7yg7YCX6vUFYJvgJ8
         L31juTgvTa6jTpiHcbJT0g4s7B4hoUbJCnrot9ZwZl2/BPiiFdWVK6I2YBRwkn+Gqmun
         bMbQ==
X-Gm-Message-State: APjAAAXv7n+jq+jfEUo0lnsBkDihiaIcM+T/fyzrHpdSyshhEukgtTt6
        Bk2lwhQXnDR3iBpU3Ppl8kmdNg==
X-Google-Smtp-Source: APXvYqwI5SBUMk5lZ+2gjo54JM5EAbnObI4CyZ7nShgZIzrO2++rlJesvE+964Tio+8RfhPbgpPe0g==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr33041841wrn.29.1554976191924;
        Thu, 11 Apr 2019 02:49:51 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s10sm6434066wmh.0.2019.04.11.02.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:49:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
Date:   Thu, 11 Apr 2019 11:49:44 +0200
Message-Id: <20190411094944.12245-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411094944.12245-1-brgl@bgdev.pl>
References: <20190411094944.12245-1-brgl@bgdev.pl>
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
Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
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

