Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4A1C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADE221655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430111;
	bh=pAGEkEdNZrIayxF3+frudUusRfrprRIXZLWd+vVqxh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sa1GodDYbe+7ppXIo/f2m1IZB3RPsMmOL8ZwWU5e3fTrMfcYWpr36Ln5002G7baQ2
	 tZKCS/9xNZfITM3c2A/6fZKdxcisf4tfJ0pw/2SU+TFYIjjqXkNmW5WUJMm/w/uuo0
	 PmEr6C6MsOAVH6rl1csG1/tPGkju3QUkQY+XKe3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404164AbfG2TzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390434AbfG2TzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:55:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6DC1204EC;
        Mon, 29 Jul 2019 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564430105;
        bh=pAGEkEdNZrIayxF3+frudUusRfrprRIXZLWd+vVqxh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BYPmtNJp8wBn2IaIytYLxXcYs5Y00yyy4Fnv6bwBch0bafcpQSMy3H7W++DBP34j
         glWPzWB4QMLmlrvvZJI3c6G5sGoooosVdwCS+0hfNNLPDMBPV8NrMAywAhHndEigN6
         4vs1z6wG67qz+xXGyBbRV2GVenNFZTbqXvWG+70E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Anastasio <shawn@anastas.io>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.2 196/215] powerpc/dma: Fix invalid DMA mmap behavior
Date:   Mon, 29 Jul 2019 21:23:12 +0200
Message-Id: <20190729190813.865994407@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Anastasio <shawn@anastas.io>

commit b4fc36e60f25cf22bf8b7b015a701015740c3743 upstream.

The refactor of powerpc DMA functions in commit 6666cc17d780
("powerpc/dma: remove dma_nommu_mmap_coherent") incorrectly
changes the way DMA mappings are handled on powerpc.
Since this change, all mapped pages are marked as cache-inhibited
through the default implementation of arch_dma_mmap_pgprot.
This differs from the previous behavior of only marking pages
in noncoherent mappings as cache-inhibited and has resulted in
sporadic system crashes in certain hardware configurations and
workloads (see Bugzilla).

This commit restores the previous correct behavior by providing
an implementation of arch_dma_mmap_pgprot that only marks
pages in noncoherent mappings as cache-inhibited. As this behavior
should be universal for all powerpc platforms a new file,
dma-generic.c, was created to store it.

Fixes: 6666cc17d780 ("powerpc/dma: remove dma_nommu_mmap_coherent")
# NOTE: fixes commit 6666cc17d780 released in v5.1.
# Consider a stable tag:
# Cc: stable@vger.kernel.org # v5.1+
# NOTE: fixes commit 6666cc17d780 released in v5.1.
# Consider a stable tag:
# Cc: stable@vger.kernel.org # v5.1+
Cc: stable@vger.kernel.org # v5.1+
Signed-off-by: Shawn Anastasio <shawn@anastas.io>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190717235437.12908-1-shawn@anastas.io
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/Kconfig             |    1 +
 arch/powerpc/kernel/Makefile     |    3 ++-
 arch/powerpc/kernel/dma-common.c |   17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -121,6 +121,7 @@ config PPC
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_MMAP_PGPROT
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -49,7 +49,8 @@ obj-y				:= cputable.o ptrace.o syscalls
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
-				   of_platform.o prom_parse.o
+				   of_platform.o prom_parse.o \
+				   dma-common.o
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o nvram_64.o firmware.o
--- /dev/null
+++ b/arch/powerpc/kernel/dma-common.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Contains common dma routines for all powerpc platforms.
+ *
+ * Copyright (C) 2019 Shawn Anastasio.
+ */
+
+#include <linux/mm.h>
+#include <linux/dma-noncoherent.h>
+
+pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
+		unsigned long attrs)
+{
+	if (!dev_is_dma_coherent(dev))
+		return pgprot_noncached(prot);
+	return prot;
+}


