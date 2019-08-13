Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DBDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424E5214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BUC5njc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfHMPsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:48:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbfHMPsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AO+4c0ecIi/uQLR0CK7Q9a7X2o8vLwm3CNoO+BGwqJg=; b=BUC5njc7cJ4ycTCKrUoVAIUDiU
        M2O8l3cujM2hjuWnyxV+LQOek5j8D8LzJwXNN6uaqD6btVceWLFkeS12A6OJforpmOhPaIjjV3bi4
        7MFwBPjgB7g96YWKhPAwo8y1JBPLwTxjZCoaqBZQ1e5tbVi+1NlZRpvWLxMLhQsBVqxLSjBmj3EU6
        6+6bSolI52RKDAFISaHEaisWd1vtcgabet1ZO0fLAVikUILOSmzT60um0jG211EZblvS0gR83BZe9
        eZQoy4recnudfgoeOSEYxxN1rxENMhNqDTw7AV3/WcVWyQhLwNXvbQk+D/BiVrWdTa/LEaS4FLzvy
        IjW+Aq4g==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxZ1m-0004tx-V9; Tue, 13 Aug 2019 15:48:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 05/15] riscv: improve the default power off implementation
Date:   Tue, 13 Aug 2019 17:47:37 +0200
Message-Id: <20190813154747.24256-6-hch@lst.de>
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

Only call the SBI code if we are not running in M mode, and if we didn't
do the SBI call, or it didn't succeed call wfi in a loop to at least
save some power.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/reset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index d0fe623bfb8f..2f5ca379747e 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -8,8 +8,11 @@
 
 static void default_power_off(void)
 {
+#ifndef CONFIG_M_MODE
 	sbi_shutdown();
-	while (1);
+#endif
+	while (1)
+		wait_for_interrupt();
 }
 
 void (*pm_power_off)(void) = default_power_off;
-- 
2.20.1

