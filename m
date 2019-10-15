Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45346ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EC220663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU0FNH+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfJOVZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 17:25:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33086 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfJOVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:25:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so15653246lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TupgV0MHjA8yhWmBL3cewNdEfIAySH9lA2snhT2KSA0=;
        b=gU0FNH+YkmD9qkMKyKIVtHQfL7lcArLVLw6hAZPGPh9wu58EpZ+OqTE5ywg4R6bFY+
         pkXIAD4EvoB/gq5QY5gfkd6tVajJJ+I7cgDFtE8U3E9XxbgIDHsFg5+ggcrBta64PCLp
         cCQ6uS/yBUw6Qefb03aimc23o9T6g2wc3Sg2H/xgKMAC3Af+08SLkLOBKVyduCs/ak54
         Tvc5EFS+2zAcirOKtZE0J6UoCXUvPvyOdFgeYoIimjMc9CxfwajW5OJrVyopbuEmmlhy
         eokWvZ336DJO9Kbbe0n+eEvJVpXqF+xa1u4SlwDxi8nEmoYHMz9QKwp/a233ViLfOUnU
         5Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TupgV0MHjA8yhWmBL3cewNdEfIAySH9lA2snhT2KSA0=;
        b=cbOO6x67iymOcc0hZ/rw5TwygQs+8iqYHP6JKff07KgplAddnNsxZvvB7tEqMZhmOe
         09Lux2E+AOkZt1nbwPcTAlvwruhm04R992xzheQu88JxWC/tcdEDoeqExuew3BAuURgW
         7inZBsOhwEwhFi/tF9wqbhJXGA+1N9IEt0BQL8a+YTQK/RTrjLRZZUSkP6J9i1CAPIJe
         w15sVEq3fpfaqq8MYjYhKvTLLb//UlnBJxDrc8u3FxDLn7YSzO/Bb1gqiVzJq41uJr6U
         FYSVkPdXu7AohpBzOM0vPD7T2B4QDhsU08WbRXT4P1ixYhg7OuY1UhgaUTVtZ1LV/I4m
         H/rg==
X-Gm-Message-State: APjAAAU92/FaD1ODGB6n1hh7c5LF7jCfT1uy5AQK/G7TNiC0cEU2lswV
        NJuGsimbNXTjBCr0n5QfEKizfZodlh4=
X-Google-Smtp-Source: APXvYqwYi9FHUGev/22Lws4+0G8iiMlMBA/PDnRq6muX/tFrhu8jEDv03Ihqb6Wd32ENbMM1SI5v7A==
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr21412169lfm.109.1571174750137;
        Tue, 15 Oct 2019 14:25:50 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id w30sm5313233lfn.82.2019.10.15.14.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:25:49 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: implement arch_dma_coherent_to_pfn
Date:   Tue, 15 Oct 2019 14:25:26 -0700
Message-Id: <20191015212526.1775-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trivial implementation for arch_dma_coherent_to_pfn.
This change enables communication with PCI ALSA devices through mmapped
buffers.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig          | 1 +
 arch/xtensa/kernel/pci-dma.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index bf492f9e1f75..f78e6b6f8b6f 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -3,6 +3,7 @@ config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT if !MMU
+	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_QUEUED_RWLOCKS
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 154979d62b73..6a114ce23084 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -200,3 +200,9 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	if (!dma_release_from_contiguous(dev, page, count))
 		__free_pages(page, get_order(size));
 }
+
+long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
+			      dma_addr_t dma_addr)
+{
+	return __phys_to_pfn(dma_to_phys(dev, dma_addr));
+}
-- 
2.20.1

