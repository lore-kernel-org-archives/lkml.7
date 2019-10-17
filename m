Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE71ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F1F21A49
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q5YAST/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503064AbfJQRiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:38:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440745AbfJQRh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yCcZdwwkx82faMNj1J82WfdjvYqcNb5jT+ohjwodn8U=; b=Q5YAST/IKAvFyWqOCBEo44AHwb
        oUo6RpTL00B4TEqPIU5kw+o6KSfR+aGS/9fymZlPDJ/WpkAC4pNoTBMUQ/awSEpRjKP44QuE5GJdb
        7oftEPEkjbr+UXltBnksMd/0EHXdPFW+F45UEka/z+lRXgd5IUrTwGsqq2Xg/soqYEL4/FHCZTiUh
        4Df79h+sV2PgRt0ggoBd3G0X6hXqkmsEhbsMXaPKm2zQ+uyQL+rP7Rv+v8mZRSAQXjzDln97DZBJO
        1jeUmMdNBqrS1cx4O/KUR0nIJwex8vJM6L1jHxlUNlcViPi567tmx7Xr3E61Ihb4z/9haFS2dklyn
        g5jSaWgQ==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9il-0007OQ-Mr; Thu, 17 Oct 2019 17:37:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] riscv: don't allow selecting SBI based drivers for M-mode
Date:   Thu, 17 Oct 2019 19:37:32 +0200
Message-Id: <20191017173743.5430-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017173743.5430-1-hch@lst.de>
References: <20191017173743.5430-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

When running in M-mode we can't use SBI based drivers.  Add a new
CONFIG_RISCV_SBI that drivers that do SBI calls can depend on
instead.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/Kconfig         | 6 ++++++
 drivers/tty/hvc/Kconfig    | 2 +-
 drivers/tty/serial/Kconfig | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 86b7e8b0471c..b85492c42ccb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -76,6 +76,12 @@ config ARCH_MMAP_RND_BITS_MAX
 config RISCV_M_MODE
 	bool
 
+# set if we are running in S-mode and can use SBI calls
+config RISCV_SBI
+	bool
+	depends on !RISCV_M_MODE
+	default y
+
 config MMU
 	def_bool y
 
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 4d22b911111f..4487a6b9acc8 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -89,7 +89,7 @@ config HVC_DCC
 
 config HVC_RISCV_SBI
 	bool "RISC-V SBI console support"
-	depends on RISCV
+	depends on RISCV_SBI
 	select HVC_DRIVER
 	help
 	  This enables support for console output via RISC-V SBI calls, which
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 67a9eb3f94ce..540142c5b7b3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -88,7 +88,7 @@ config SERIAL_EARLYCON_ARM_SEMIHOST
 
 config SERIAL_EARLYCON_RISCV_SBI
 	bool "Early console using RISC-V SBI"
-	depends on RISCV
+	depends on RISCV_SBI
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
-- 
2.20.1

