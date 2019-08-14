Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836C3C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8BD2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNxFr9QT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfHNWFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:05:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41927 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfHNWFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:05:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so281544pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zGCahEylBwx9+hrUl6JBv64qJITZ7AIfmMEaH7B2Nfg=;
        b=KNxFr9QT2oHk0ee5GI2IjIkLTldwP57yZGwcnjUEsIx3OB6B0cmtOER71JKAynaxAl
         tI28WVuAQNFlKsPnyqKGlZnvq7stwRv5qOx8V+A8CfeEzpCSJrEDgGxpC76R/mjugfZV
         cfj3AMX5FF04HK8PouDp/LkA+AYBdKeqGW7mI9yywFHfFa+D9mW3dX3slJb9DT3Vb2nB
         z1VC/a8ZneW4oXJPYnEqJeDKPyPYqbkfh/2OJgcLihAGqC7Bk8dISekepsMevjddKfwG
         JwbAp2kne42JJ1D+FPohAKaeYVSHgGwpEG5iS4sn8vtrJGrv6DbWWHa+MfhexA3EwLHf
         RGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGCahEylBwx9+hrUl6JBv64qJITZ7AIfmMEaH7B2Nfg=;
        b=RUUeEPA13rAcoC32kx9hmpKiZ58eRY7qObdI7Jo80LEDM3gbSOxAkrzGDnAQKSGJTF
         m8e6L5AJ3gYj9HfY7gqE/vjZECKttoSsG4BJs1gzremi+snunD5lEmuqAC8rCjipi1WQ
         lPJ8nbRuQoPk+y16Pko/QCD6PzK4ipwA5Zcwz4D5WuTg860fsAifLbBPAHlRHuXYaB46
         B+N018PBr3z6TPtbsCF4wjI1YfgZAcfDzHwqLKdL1gDGjH3DirY/I+hlVLDNN8fjwjrK
         KAWbDA5m8OBN+aj7DImDLONfFTptKIr6FauZyZw2/DquVUdi15CqelCfxNNHCIOdDldl
         mjLg==
X-Gm-Message-State: APjAAAWi1S+22RJ500YO+UxhhBhfrPe33bluekbDh0q6JYmRONc7SI4D
        moRblpJHA8KKQQPsBnXa6x0=
X-Google-Smtp-Source: APXvYqwdj2exVMetPPaW54oofiik0neX5PkaF4gcffTO1xCR5P3KzJE/Uy1GZgX/vn90YM4nR9bKlw==
X-Received: by 2002:a62:e901:: with SMTP id j1mr2192946pfh.189.1565820313296;
        Wed, 14 Aug 2019 15:05:13 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id g19sm968879pfk.0.2019.08.14.15.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 15:05:12 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] arm64: export arch_sync_dma_for_*()
Date:   Wed, 14 Aug 2019 14:59:56 -0700
Message-Id: <20190814220011.26934-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814220011.26934-1-robdclark@gmail.com>
References: <20190814220011.26934-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 arch/arm64/mm/dma-mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 1d3f0b5a9940..ea5ae11d07f7 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -24,12 +24,14 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 {
 	__dma_map_area(phys_to_virt(paddr), size, dir);
 }
+EXPORT_SYMBOL_GPL(arch_sync_dma_for_device);
 
 void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
 	__dma_unmap_area(phys_to_virt(paddr), size, dir);
 }
+EXPORT_SYMBOL_GPL(arch_sync_dma_for_cpu);
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-- 
2.21.0

