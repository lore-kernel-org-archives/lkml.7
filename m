Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C0C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 13:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB9D214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 13:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jik12TfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfFHNry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 09:47:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45184 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHNry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 09:47:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so2734602pfm.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3IWvfaaFNGT8InqNZfLakELSo2uZGE/lq61PgOtWuqA=;
        b=jik12TfGQsA03SvtFh12eDLYdq4hPzA/zHinCwJ/6BS1eweB3ckVQb3BAnuelT/yUV
         FpSBb6FNpT8Uc+1U6+yoYk9JPGLSWw2EZanS0yBhqZJ7g2+dHBHvxinAsOviUyRAUBf4
         BDo3elDwVg97RxEHHSAQStZOSVwqQTIDdX/3XnBGNoGiZY5dKpgd0pNq8Jf9rXbEvD9F
         g5dsA0AhNEWPDSlHChOAcurk7ErVmmlP2KHXym/Ebjx4PJt1V8Qriq86vm0Ib+O94em5
         GjMGQXLBXQGpfptoS6J/C86g1HwEaXa9vtYjPh5pFzY2t0ZyK9c2A4fldRpJkGdZ64hY
         5X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3IWvfaaFNGT8InqNZfLakELSo2uZGE/lq61PgOtWuqA=;
        b=NvphJ8F4VxthypPSQLUvmjWAqfbETIGVWgtnkqj6mFZkGgIAss9vi2Kao9L6qc6mMA
         T/Rm1qp9FGt0BUS7zfyVQbKYa2qSSOdQ1PIJxMJtodyxTZm8oYhFFmm7uiqhbqgP6r6C
         FWV03dOslNJCWpstAwGAc8ViRxjiO6UR31141oK+uC01/mOCAQoUI+uH6CDvFpd+vD85
         48QrB2u671fGq8C+ANQRpH6duMxOQWaxMYoZYDJR6oI1Gov0nvNVQJjinfznsiDAlheV
         I8r7eDNhRaQkZ1WmOsWcM1zG5uEQY5MTyhH6cYteBpsqQF+pzd1zb3qpFp/MAdFTHhU7
         ISsg==
X-Gm-Message-State: APjAAAUmQ6PIt/Q7kHDR8AN9GQgglMKHmH9sqWlZg7/GWLSRXU+5RfZb
        tWEru6dyI8TTXlkXnwFCyUI=
X-Google-Smtp-Source: APXvYqxbPnMVTaDU8ckvWZuirNQsy8vxQztNRUwJS0Fc0PfgQsDLfHNcDcOGhSNloa+4qIU2X/NRfQ==
X-Received: by 2002:a63:4c:: with SMTP id 73mr5477620pga.134.1560001673375;
        Sat, 08 Jun 2019 06:47:53 -0700 (PDT)
Received: from soonoo-tp.localdomain ([175.125.62.120])
        by smtp.gmail.com with ESMTPSA id m19sm12944138pff.153.2019.06.08.06.47.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 06:47:52 -0700 (PDT)
From:   Soonwoo Hong <qpseh2m7@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Soonwoo Hong <qpseh2m7@gmail.com>
Subject: [PATCH] blk-mq: fix coding style
Date:   Sat,  8 Jun 2019 22:47:28 +0900
Message-Id: <20190608134728.4655-1-qpseh2m7@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a space before colon in ternary operator

Singed-off-by: Soonwoo Hong <qpseh2m7@gmail.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ce0f5f4ede70..374b13e89bb1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1377,7 +1377,7 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 		cpu_online(hctx->next_cpu)) {
 		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
 			raw_smp_processor_id(),
-			cpumask_empty(hctx->cpumask) ? "inactive": "active");
+			cpumask_empty(hctx->cpumask) ? "inactive" : "active");
 		dump_stack();
 	}
 
-- 
2.21.0

