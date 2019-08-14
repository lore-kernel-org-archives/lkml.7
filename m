Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFFEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8695214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTIl/9Tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfHNWKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:10:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46301 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfHNWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:10:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so272881pgt.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgMxpqnDCUKKSviaeDfqej3uE+25ke/kBD5EQ8QhSvk=;
        b=BTIl/9TkKL1+c9ssk34W7XBCbm+8s/A7Aw49hrbdu/fvCvAhPq7IzZM6LQxNWC2QoE
         43Fy8M+wBoAaew0rOCWEYQwW7hi4OWCZw6V6ljV8i60R6zk3xV1oqtX+5OAjikb7TOo1
         euYSXyToMva4nrJeLoOG98FDCZPQBFYfVuK757KSMnKyMdqqDJ7hJn9O82GWwbVWL9Va
         YaafGnFOnoXjFAO3qaf7hnVlz6fUzZ9nRvXAT9cifyZdFjtDpGNfVhryES6wHppUEFRl
         N8nXSFKxcF2k8iMc+4q6OzgcKiepinofnK8FF77cgrT+mIe6oir15Gjrwq/AEM4yw+XV
         l75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgMxpqnDCUKKSviaeDfqej3uE+25ke/kBD5EQ8QhSvk=;
        b=jI3DrReiE+j1C+xBX5lxHIThEu3AJBoKjtLKJZR2YdzKCoXPrZgWbswzemonEIEORR
         zEpy/0IssgbZTry8xBeo1D5yKv/v8OCsxvKZMYl5e7t9f4+rM08fhj7RvccLYwUkkc1q
         ezmaApo7s+4mEG+GnxWGmx4gYw4x1RfOdOHH3kgJJeWAMrLXH7RbHGcZGsG9wjfQcKD/
         qQZYzp3DaM5xv5mQN+1U7wxHxTUUPG9oUtZOYOZBkx6O2cQaaRvZEl5OzG1KlPZYaEZe
         vc4gAyoA5nSDqcmN87piFZxPLn6RPucsJmnPcRqTzVQ5rWg+kNvIBwamRyaN9c6QbCwR
         7eDg==
X-Gm-Message-State: APjAAAU9yb9OpeQ/r4ianyey+DuB16/XJN6d0p9XrULVzWe0owEffHNT
        Q8iyYotcPmd0USpZ9HSeoYk=
X-Google-Smtp-Source: APXvYqxT0bYRzWmURPra22SeQuhBS+23yZe3pSx10q32MZ/PWreU7JH+YXqDftobAJdodjbhda6e0Q==
X-Received: by 2002:a63:de4c:: with SMTP id y12mr1125128pgi.264.1565820604373;
        Wed, 14 Aug 2019 15:10:04 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id a189sm929015pfa.60.2019.08.14.15.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 15:10:03 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@chromium.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] powerpc: export arch_sync_dma_for_*()
Date:   Wed, 14 Aug 2019 14:59:58 -0700
Message-Id: <20190814220011.26934-4-robdclark@gmail.com>
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
 arch/powerpc/mm/dma-noncoherent.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index c617282d5b2a..80d53b950821 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -401,12 +401,14 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 {
 	__dma_sync_page(paddr, size, dir);
 }
+EXPORT_SYMBOL_GPL(arch_sync_dma_for_device);
 
 void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
 	__dma_sync_page(paddr, size, dir);
 }
+EXPORT_SYMBOL_GPL(arch_sync_dma_for_cpu);
 
 /*
  * Return the PFN for a given cpu virtual address returned by arch_dma_alloc.
-- 
2.21.0

