Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F92C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9F121BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qiw8hQfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfHGPKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:10:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGPKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T0fRlfd4abk9HYGG1nKDUkxYHuPUXgWRCiR6ogEG6zw=; b=Qiw8hQfyOdRHv9dgEr+L+T6t4
        VKVJyKi4cIowFd1A2bAQ5O+sx4f5bFgaprle29oPO5hzSjNhgSF4sZA7bcX0WPJhOx3v5xU+pTeIg
        2N3eGo+CCNNnfXBPneL2CBB9NzW2FzRnxDE48D5IyzIz4R5PZUG+bZhQqH+fBzkrem8OH1kX3jaAt
        jbC85i1nGo2CYyFYaXoAUIxZGJBnRHcF0PFt85bKi4I3uV5pNbei7AjKwacHP4mI03N5bghwnByjQ
        3XBmgDQ0HUJBHSdhhz0lpXZk+sioooLRussS4R6JMMT3EUFi5haQUdfrTkbnNrKiWSwgmn8vV5bce
        E3FMyYckw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvNZr-0004E4-IF; Wed, 07 Aug 2019 15:10:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     palmer@sifive.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: move sifive_l2_cache.c to drivers/misc
Date:   Wed,  7 Aug 2019 18:10:09 +0300
Message-Id: <20190807151009.31971-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sifive_l2_cache.c is in no way related to RISC-V architecture
memory management.  It is a little stub driver working around the fact
that the EDAC maintainers prefer their drivers to be structured in a
certain way that doesn't fit the SiFive SOCs.

Move the file to drivers/misc and only build it when the EDAC_SIFIVE
config option is selected.

Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/mm/Makefile                            | 1 -
 drivers/misc/Makefile                             | 1 +
 {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c (100%)

diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 74055e1d6f21..d2101d0741d4 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -11,6 +11,5 @@ obj-y += extable.o
 obj-y += ioremap.o
 obj-y += cacheflush.o
 obj-y += context.o
-obj-y += sifive_l2_cache.o
 
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index abd8ae249746..886d48301e8e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,4 @@ obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_EDAC_SIFIVE)	+= sifive_l2_cache.o
diff --git a/arch/riscv/mm/sifive_l2_cache.c b/drivers/misc/sifive_l2_cache.c
similarity index 100%
rename from arch/riscv/mm/sifive_l2_cache.c
rename to drivers/misc/sifive_l2_cache.c
-- 
2.20.1

