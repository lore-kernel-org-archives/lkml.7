Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAE9C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2241D205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MGTe2BnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfHMPsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:48:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfHMPsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bYwo6s1TNuLWxh58ivSNB10DHzRaGAerqpg52+GdtOI=; b=MGTe2BnACmDFReW2kk7/EXTTs2
        xc0WfLFviefoFUs4zx9BpXn39tZjAsahRzZL6zLIyhCN7+wFPP888OlrZJQV+rcM6w3QQmEAzLpxz
        c7mNAtmxir5utJEBtpZShiVeJrxQKj7ZEUOl5tBjjn+VmOnYs1edE/G7SjyNpnxIdBBUMT7RAWHsn
        tFzEia29CEV4iMFoy0fi1JE3R48ng3/3Doq+gMG05/4PQaIT2oMhtBQYIwpjnnfS4OInYxmJSGjfd
        NeiI2AQTTCcTQJtPOhCd6sMEDiXDU0lV+XmdFg888ngQR3i9XEiolEwCZuRjRN09gaD8zxTAEuKx8
        mUbWlTRA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxZ23-0005Dh-BD; Tue, 13 Aug 2019 15:48:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] riscv: don't allow selecting SBI-based drivers for M-mode
Date:   Tue, 13 Aug 2019 17:47:43 +0200
Message-Id: <20190813154747.24256-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813154747.24256-1-hch@lst.de>
References: <20190813154747.24256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

Do not allow selecting SBI related options with MMU option not set.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/tty/hvc/Kconfig    | 2 +-
 drivers/tty/serial/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 4d22b911111f..5a1ab6b536ff 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -89,7 +89,7 @@ config HVC_DCC
 
 config HVC_RISCV_SBI
 	bool "RISC-V SBI console support"
-	depends on RISCV
+	depends on RISCV && !M_MODE
 	select HVC_DRIVER
 	help
 	  This enables support for console output via RISC-V SBI calls, which
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3083dbae35f7..b2d07e150203 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -88,7 +88,7 @@ config SERIAL_EARLYCON_ARM_SEMIHOST
 
 config SERIAL_EARLYCON_RISCV_SBI
 	bool "Early console using RISC-V SBI"
-	depends on RISCV
+	depends on RISCV && !M_MODE
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
-- 
2.20.1

