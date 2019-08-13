Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13DCC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763772085A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QOZ0pZcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfHMPsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:48:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbfHMPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cfGR43GsDljmM8dFTM8JWcg4vdYoI1COaqr1g9mXt+Y=; b=QOZ0pZcdUpGbicU439RrT2tjKM
        JDYc/QmHefFpDB/pjo08eUGSEXbDNkG3PoGQRk9RJhUN3yEFqBgGNCrqrjXN2VmIO6EmYv37esTUo
        MBuNmFEC8nwknutBxCArSTKaw51W1/hznne9i1+RLDsAYSKbSiu3341sCRFhENYBFgyEU/S5H9LW+
        mAlgkYHemjVcBwqMcLTdnOgr33dEq3/RL/WSUcF9VY+O2T0IU/7kGjfiMN2g7eSLUllt/mgOwobvj
        2M8LlBbWxlKmKZeZbv3cirZ0gW74lFwNm5/Nqq6xtE0RzuSROmEYzR6TM+obIYZbvyj4oqaa+RSFz
        khNQuVBQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxZ1s-0004zn-L0; Tue, 13 Aug 2019 15:48:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 07/15] riscv: read the hart ID from mhartid on boot
Date:   Tue, 13 Aug 2019 17:47:39 +0200
Message-Id: <20190813154747.24256-8-hch@lst.de>
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

From: Damien Le Moal <Damien.LeMoal@wdc.com>

When in M-Mode, we can use the mhartid CSR to get the ID of the running
HART. Doing so, direct M-Mode boot without firmware is possible.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/csr.h | 1 +
 arch/riscv/kernel/head.S     | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 53d7ce74b447..64f8fe84b88f 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -81,6 +81,7 @@
 #define SIE_SEIE		(_AC(0x1, UL) << IRQ_S_EXT)
 
 /* symbolic CSR names: */
+#define CSR_MHARTID		0xf14
 #define CSR_MSTATUS		0x300
 #define CSR_MIE			0x304
 #define CSR_MTVEC		0x305
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index bb96bb7b95d2..275c2ab1e990 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -50,6 +50,14 @@ _start_kernel:
 	csrw CSR_XIE, zero
 	csrw CSR_XIP, zero
 
+#ifdef CONFIG_M_MODE
+	/*
+	 * The hartid in a0 is expected later on, and we have no firmware
+	 * to hand it to us.
+	 */
+	csrr a0, CSR_MHARTID
+#endif
+
 	/* Load the global pointer */
 .option push
 .option norelax
-- 
2.20.1

