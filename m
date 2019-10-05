Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5C0C4CED1
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 01:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2549222BE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 01:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AoBRZZiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfJEBtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 21:49:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44139 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJEBts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 21:49:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id i14so4704027pgt.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QsfvGFuRohKr1l6pObvG2zaoMC/SPwYl/b1JcIlr95c=;
        b=AoBRZZiyqE2wu0IBRSVdfsYjxtvIDFc3OFQ3/Q68YAZySmonyeEsWhuaR4uILfkOUz
         b+xjnizRVuvqQXE0M9iRa9q+5fph3BCYk0aEg8NDiT1gc0Fg4rjpz/W1vu9aTgWcTZYH
         MWKAdMtkoJULfy5aZXPyw+7pb6rIDJ8a2nmUez/mFCUwzR7Au5yef+mzhLaCowgzdKvR
         yx2ziB6ARAWAap2YmLIIhYtiusy3Ko7oayx7bguSzUNQT7fKBQqgoiO7YUTsqvMNiSMQ
         IIQ4Ufne5uaSTeJsdft2L3TdI6B4Aw8zP6AyL+a3Ln5OsGmrTtKJ6Nan+B/dKGHYunI+
         wcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QsfvGFuRohKr1l6pObvG2zaoMC/SPwYl/b1JcIlr95c=;
        b=tmCSnwQ0Bf6dzekPHtem0gDdEcp96gUqPg5qZ10P5DmtKMW88RMZ/QAYJfQ4SwkzEi
         x/YRuqzY/1WOi66bc1PygcVHHz8H8hiyxlg7TcH5rxOTtSlY0Nje4ILupi430f62dSRa
         oeJWzXlObT7f2o5GBnBDxq/juEpr9uOkcwbRPvEGowQ9w77K6i6t/c2Wi9EbXyeeaUpU
         RSr/RNP9b1hLoOT9McHVktBKAddOSK3YG/tQzSGXsSPpCp6VOlYdqWEIliwawaoQm6jN
         gSrZ3mtwVA9ebB2MGptycNDD9aUL/KjPtoHqKcW7qGT7Knx7xMD7OQCn/Iowzx4DDStV
         gcHw==
X-Gm-Message-State: APjAAAVWtb/VuYPqsKiJAU35qvKqgT8f4z/Uj/0f8teg2Gzit4hmQ6QL
        lpC1ejCgm4+V8OsRVEHF5iV76jRcWyY=
X-Google-Smtp-Source: APXvYqzZ5yXKAtja0JWgYFKJLxEwtSMznwcaM9dAht2NSa3+keiDxwDqMaNqRGVqvLI/hLm52rHI8A==
X-Received: by 2002:a63:705b:: with SMTP id a27mr18180320pgn.136.1570240187537;
        Fri, 04 Oct 2019 18:49:47 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b185sm7529508pfg.14.2019.10.04.18.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Oct 2019 18:49:46 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] PCI: endpoint: cast the page number to phys_addr_t
Date:   Fri,  4 Oct 2019 18:49:37 -0700
Message-Id: <1570240177-8934-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify pci_epc_mem_alloc_addr() to cast the variable 'pageno'
from type 'int' to 'phys_addr_t' before shifting left. This
cast is needed to avoid treating bit 31 of 'pageno' as the
sign bit which would otherwise get sign-extended to produce
a negative value. When added to the base address of PCI memory
space, the negative value would produce an invalid physical
address which falls before the start of the PCI memory space.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/pci-epc-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index 2bf8bd1f0563..d2b174ce15de 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -134,7 +134,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 	if (pageno < 0)
 		return NULL;
 
-	*phys_addr = mem->phys_base + (pageno << page_shift);
+	*phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
 	virt_addr = ioremap(*phys_addr, size);
 	if (!virt_addr)
 		bitmap_release_region(mem->bitmap, pageno, order);
-- 
2.7.4

