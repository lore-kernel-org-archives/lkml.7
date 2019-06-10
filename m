Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C815C4321B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FE42175B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V8RFOZDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbfFJWQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:16:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390378AbfFJWQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h6J+QiOYKdoEDaESTAbqz0t3lndQulVAC+cSepnSvyI=; b=V8RFOZDdLN5chLDdbnVNK9dlJ1
        uM5w5wcrJO3+EZ1UHI1Wb7sGkact57SKESY7N/vrePmN6J9ymUTz0rocYalDwv/x5hQ+IMedgMgAc
        wl6Un4zMZ9Pe5bagqhYSEtmiqTQ5qDi9szAP/8e+L78AffT8CyyjsSzgAAzL+VkZHLWLqSw2PT+xi
        NPVGY7HJQr8dQJ2jazZN8KiG5Qyp03r+KVbBUNwDG4/KFvxHaoNQ4VU0M/CQbtQ3W1ydVkspsO9pe
        K2BhHiKUh/3u+35Jh73MILlEk6vMV5B3d6bz/+a+UG6CN8qTERqDNty7DmYmFk/eOhRcveplsenzs
        KD1Mi8vw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haSat-0003Ll-PD; Mon, 10 Jun 2019 22:16:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] riscv: improve the default power off implementation
Date:   Tue, 11 Jun 2019 00:16:13 +0200
Message-Id: <20190610221621.10938-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610221621.10938-1-hch@lst.de>
References: <20190610221621.10938-1-hch@lst.de>
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
---
 arch/riscv/kernel/reset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index cfb6eb1d762d..17c810985ad0 100644
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

