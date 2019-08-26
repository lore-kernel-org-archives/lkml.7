Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669CAC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377C021872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="B26GOpyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbfHZTBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:01:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38639 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfHZTBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:01:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id q64so7291596qtd.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MVGzHS9ibRvktU9gzuXWTCeM/ZsMv8ZNEfXsJO3ZoxM=;
        b=B26GOpyrtMcVplPhl7Il/MGEWWA8xd6bEnjFdWoHib2Rq2CQ2PBaL6pitAD90OeatG
         tvJzrwjReaiCAXbgM7nLmeUHIJ8/TZBf0kkeT01e/VjRWbOWaZD4xgFGJy/70LhHlAsY
         UnjEME49+kC2iR55o2+mlOizKCmy3OB/EctD8PVQHoI6XHSMF53PwgEfahO3jykEsLIb
         rx3c0uE2DuomPLwTqb/gjWEYyvIfaBDdYx+79C/aU9O3JgLSowUa+EQVq5O5HLoHhJUX
         Vo7WzIj4qCeHmTkqlfQYvj9mS8pVTI0zrxWAM+EBdsWGT1jbV7TzXerLWaktA4hBPL5w
         1G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVGzHS9ibRvktU9gzuXWTCeM/ZsMv8ZNEfXsJO3ZoxM=;
        b=KVFFj4QUb5Nat7k0xqNthf+g3kB62NuRVTTm40TsMjTMQ4GkvROJgoXLA5akQkNYaz
         ymnrYrxS1k543uY5r5iiO4FBpQ/knTLDCm3sa2l6tfRJdTsuni7cK9LczeVzokSBjdh7
         v4/oMGNj0hQhtmy2Im1/VmSFCXlxuMJFV29T8FjLsE1EELATjj6SjD1IXrWW4rQQtxuz
         lXDaXMdVycb56iDhsaDgMtrNaggFnx4QL0ZsIrsdDEtT3K1/TmzhEReX9BKX0lJ/GPOi
         x2gfSnY1c2q+zdSK8YKDa562J+gslLgY+emZ2aw3FmXZyNmTl+W5z+Pt4zy2G02v0hl8
         XCLQ==
X-Gm-Message-State: APjAAAXQE9Gfn6vPk1SIkxzYHqHWiE5GtfNBUvcwtaxon9SJYCo/KdRy
        fj8e7OSA/wFTPGztPeGlkVT6YA==
X-Google-Smtp-Source: APXvYqxeU7d2ypGYD+w4LlmlZBLQ94N4jLKoJtLpD4qFS3r6JUQs+pZr0N0cUZuPWjoo9GSHYRXaKw==
X-Received: by 2002:ac8:64a:: with SMTP id e10mr18640949qth.30.1566846059770;
        Mon, 26 Aug 2019 12:00:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o45sm8614377qta.65.2019.08.26.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:00:59 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com
Subject: [PATCH v1 1/6] rqchip/gic-v3-its: reset prop table outside of allocation
Date:   Mon, 26 Aug 2019 15:00:51 -0400
Message-Id: <20190826190056.27854-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826190056.27854-1-pasha.tatashin@soleen.com>
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of adding another variant of allocation, move
the resetting outside of the current allocator.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1b5c3672aea2..ada18748ed1c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1621,15 +1621,7 @@ static void gic_reset_prop_table(void *va)
 
 static struct page *its_allocate_prop_table(gfp_t gfp_flags)
 {
-	struct page *prop_page;
-
-	prop_page = alloc_pages(gfp_flags, get_order(LPI_PROPBASE_SZ));
-	if (!prop_page)
-		return NULL;
-
-	gic_reset_prop_table(page_address(prop_page));
-
-	return prop_page;
+	return alloc_pages(gfp_flags, get_order(LPI_PROPBASE_SZ));
 }
 
 static void its_free_prop_table(struct page *prop_page)
@@ -1685,7 +1677,6 @@ static int __init its_setup_lpi_prop_table(void)
 		gic_rdists->prop_table_va = memremap(gic_rdists->prop_table_pa,
 						     LPI_PROPBASE_SZ,
 						     MEMREMAP_WB);
-		gic_reset_prop_table(gic_rdists->prop_table_va);
 	} else {
 		struct page *page;
 
@@ -1703,6 +1694,7 @@ static int __init its_setup_lpi_prop_table(void)
 		WARN_ON(gic_reserve_range(gic_rdists->prop_table_pa,
 					  LPI_PROPBASE_SZ));
 	}
+	gic_reset_prop_table(gic_rdists->prop_table_va);
 
 	pr_info("GICv3: using LPI property table @%pa\n",
 		&gic_rdists->prop_table_pa);
@@ -3079,6 +3071,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		its_lpi_free(bitmap, base, nr_ids);
 		return -ENOMEM;
 	}
+	gic_reset_prop_table(page_address(vprop_page));
 
 	vm->db_bitmap = bitmap;
 	vm->db_lpi_base = base;
-- 
2.23.0

