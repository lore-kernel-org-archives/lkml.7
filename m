Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64091C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAE52070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZPsZFx07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfHZTBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:01:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36008 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfHZTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:01:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id d23so14988396qko.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0G4wOYVegWG72k6oGUeWPK9tZ0VMm8uCy6edjZslp4c=;
        b=ZPsZFx07m0tAJXmqzDFkTOaZzOQz/AQuMAjRi257nF9B1rGb5m9feEUOR3OKQox5VN
         Q/HB83bhvJZOLD2pOOSznKKi6XqzqCMuS/HwsLqi1sU6qC1NvDfdupTOqPN64xmJTRKg
         Uxj4ePug02LYzhTt0KRIeloMKuigRMiCRq0bxTah7b3VJKt2V/HAVk/LSlC3DlfCrOvK
         6SIbC9drhIvs6jk1NVSauM5S5HwQyUdWRjrTXBiH+fAJrKqk4Zba9eBGP9r0Ao8A/dMd
         iEaGpS5LoxKgrr22zrvMWF4fyKn/QHJ/4exThlvCi19XKYbgYq/HYbqI4e2FLoS5dkJn
         da4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0G4wOYVegWG72k6oGUeWPK9tZ0VMm8uCy6edjZslp4c=;
        b=jFyfm63ZMjblF4NZGOZtnyEhkc4LHsvd3tEhN2MxOTgy17q/t1o317snlRJPe+4iXI
         Sho+wjuTbSrb/ZbKYgaJWQ/BQNEnuq1uTTP0U4Wkv6Ymf03kRq92GQtwfWty4dfAqhV9
         tPOcd8r43M24Ur+gp23hsQ02ke9BUb9OO/VKU4kZbFT7Yf/I9DO7qHOl+LvbPZRZBpJf
         VryOuwsv9Aqt+UJ6KghMDWYU6Z/UD5Tv8/10dElsk6tknlzIgxarf8IxLB/qdY5kAP7v
         rQsg+rf30EueSmJ0jGRygn+869AqV6sF4vIpLdZ7Kznhyiwe8PDCRbn1K/U9FCBp5L3R
         43AA==
X-Gm-Message-State: APjAAAWSnLdtHTVFpywtK6Crq6bZOJNScVI8CstrnonxMUq/Sb5hwrCq
        QV7mqYls0O+IYljMQYOJQONfEg==
X-Google-Smtp-Source: APXvYqyQpwd1cHJy+7egGM9XZ830LpQuYxMo23YJ3RHaBifSxKeOu/wMGe2mnwjs/L5INtNlBUcVYA==
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr18037810qki.352.1566846063737;
        Mon, 26 Aug 2019 12:01:03 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o45sm8614377qta.65.2019.08.26.12.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:01:03 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com
Subject: [PATCH v1 4/6] rqchip/gic-v3-its: move reset pending table outside of allocator
Date:   Mon, 26 Aug 2019 15:00:54 -0400
Message-Id: <20190826190056.27854-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826190056.27854-1-pasha.tatashin@soleen.com>
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again, in preparation of adding a new allocator, move the reset function
outside of the current allocator.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 124e2cb890cd..d5f3508ca11f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1999,15 +1999,7 @@ static void gic_reset_pending_table(void *va)
 
 static struct page *its_allocate_pending_table(gfp_t gfp_flags)
 {
-	struct page *pend_page;
-
-	pend_page = alloc_pages(gfp_flags, get_order(LPI_PENDBASE_SZ));
-	if (!pend_page)
-		return NULL;
-
-	gic_reset_pending_table(page_address(pend_page));
-
-	return pend_page;
+	return alloc_pages(gfp_flags, get_order(LPI_PENDBASE_SZ));
 }
 
 static void its_free_pending_table(struct page *pt)
@@ -2064,6 +2056,7 @@ static int __init allocate_lpi_tables(void)
 			pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
 			return -ENOMEM;
 		}
+		gic_reset_pending_table(page_address(pend_page));
 
 		gic_data_rdist_cpu(cpu)->pend_page = pend_page;
 	}
@@ -3007,6 +3000,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		its_vpe_id_free(vpe_id);
 		return -ENOMEM;
 	}
+	gic_reset_pending_table(page_address(vpt_page));
 
 	if (!its_alloc_vpe_table(vpe_id)) {
 		its_vpe_id_free(vpe_id);
-- 
2.23.0

