Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD2AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD7D22D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oPBuX9ND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfICJcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:32:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbfICJcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dmhOcolDwteguY+iE081eVlDE7gRKOPp9YKrsHrQ23w=; b=oPBuX9NDcklPhh+Ml/2+83UZ5v
        4E8VnDLeks2QUrDaE/7YSDMSGIyq9tp8SeN47ZGRQrs2M58SWPJ/haIScuLIhDsKkwGIdxebdMcRt
        FewpcJ9gMSOe8hRF5kpNXJ8prpWjUc6wK1fuWkC64uarqvg+r2K3+mMZ84WbOBlN3vicQnwYCu2Sk
        tzD+6LwsH2TXWFfsKkqTAXd1cLKGALdrJBxlwS6JNSpIMHbafFAHFgXx62KW+CeDlrRiVqnyuRnje
        iWoajAq9TaIWtD69EmrU5M7Xa/diGNoZ0zkRTSyOE1u2sP0X5YAu6614Yr0Fbtp9ios/NakPbfBGi
        6R0Ln5sw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i55BC-0004Md-FN; Tue, 03 Sep 2019 09:32:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 04/20] riscv: optimize send_ipi_single
Date:   Tue,  3 Sep 2019 11:32:23 +0200
Message-Id: <20190903093239.21278-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903093239.21278-1-hch@lst.de>
References: <20190903093239.21278-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't go through send_ipi_mask, but just set the op bit an then pass a
simple generate hartid mask directly to sbi_send_ipi.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 2e21669aa068..a3715d621f60 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -94,7 +94,13 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
 {
-	send_ipi_mask(cpumask_of(cpu), op);
+	int hartid = cpuid_to_hartid_map(cpu);
+
+	smp_mb__before_atomic();
+	set_bit(op, &ipi_data[cpu].bits);
+	smp_mb__after_atomic();
+
+	sbi_send_ipi(cpumask_bits(cpumask_of(hartid)));
 }
 
 static inline void clear_ipi(void)
-- 
2.20.1

