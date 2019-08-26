Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80189C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5142F21872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UFXzaaLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbfHZTBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:01:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32845 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387577AbfHZTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:01:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id v38so18995846qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2Iyu8V2mhRgac8+S13ID8s2986xy5pxZvhk9T7S5rNU=;
        b=UFXzaaLCAVwRSz6XEcr9mJF5kHCBrdjGe3QkcYu3MGkKN44wfFfrzlG0jc7ANzJ77n
         9EoRiykDzx5lyexiZKGga2j3mHmXj7jLWKeImUzAxoVVED14tv/gZEJHmCbMexLFIPAF
         5ZytoKvyGY0XeEXjN9ofyjZRs3CXeuzBSR6meTOyX137+CHIWynDofBLwZgxFIeOEuwU
         OK7JwW7xuggSckOozTZhHrg1yHzheQ686DtTHSePs2X0r2pswsBkvl7gwF6Fso0bHiKp
         JpJ0aXsoIgjae8qYFNMcuLsCVjUn7vzSman7d/ATv3DURMO5i0LYjOOZX24xNTqRoQ4o
         0w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Iyu8V2mhRgac8+S13ID8s2986xy5pxZvhk9T7S5rNU=;
        b=IHdgFQXQami5T43Pry1T0nuAPfFq2MttzPp2mfnFV/RVM6+1b1HBNXZLUpn01ACEBP
         mJW/TVoBB3X+Tu27IA5nSNIsc1OTcySmGG5rdjmqfgj+AB2KlhftWcF+Lpj+svunYomP
         gAywgjqvCVe6X5U3ESRPU6m8Gi+SoVsgJbmeI21BSrrTEc8au9yeI3lU5i35qi3dMwHk
         iGgLnDO3+03mXKo3RWl4FBBGSi9DD53oxkEVl/3oUMSHIEy9xKaUL+dj0zsjkmVFkLwF
         t9iCZ0KnSnMmYZYFBzh1BTGRPoQ/9qlh99LXc5025bfqrckOcBBMDmSulCRQzd8ehq1N
         UJkA==
X-Gm-Message-State: APjAAAUDkRFsdvvQp1Lx2tN1GpHRxDFNvFNyO0O7JSVQ5Ml8aBG57G+/
        5o718of2NSfmdvUlpsemcEk3MA==
X-Google-Smtp-Source: APXvYqwJEoLilU8DEOh3KuHyqH0S1JmiSp9yFcsGVAyDCCyoqq7RSrfnW4/Garo6AgPuH9RBmHyTWg==
X-Received: by 2002:ac8:317a:: with SMTP id h55mr19163671qtb.105.1566846061160;
        Mon, 26 Aug 2019 12:01:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o45sm8614377qta.65.2019.08.26.12.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:01:00 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com
Subject: [PATCH v1 2/6] rqchip/gic-v3-its: use temporary va / pa variables
Date:   Mon, 26 Aug 2019 15:00:52 -0400
Message-Id: <20190826190056.27854-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826190056.27854-1-pasha.tatashin@soleen.com>
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup, that will help later when a variant that does not
require memremap is added.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ada18748ed1c..656b6c6e1bf8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1668,15 +1668,17 @@ static int gic_reserve_range(phys_addr_t addr, unsigned long size)
 static int __init its_setup_lpi_prop_table(void)
 {
 	if (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) {
+		unsigned long pa;
 		u64 val;
+		void *va;
 
 		val = gicr_read_propbaser(gic_data_rdist_rd_base() + GICR_PROPBASER);
 		lpi_id_bits = (val & GICR_PROPBASER_IDBITS_MASK) + 1;
 
-		gic_rdists->prop_table_pa = val & GENMASK_ULL(51, 12);
-		gic_rdists->prop_table_va = memremap(gic_rdists->prop_table_pa,
-						     LPI_PROPBASE_SZ,
-						     MEMREMAP_WB);
+		pa = val & GENMASK_ULL(51, 12);
+		va = memremap(pa, LPI_PROPBASE_SZ, MEMREMAP_WB);
+		gic_rdists->prop_table_pa = pa;
+		gic_rdists->prop_table_va = va;
 	} else {
 		struct page *page;
 
-- 
2.23.0

