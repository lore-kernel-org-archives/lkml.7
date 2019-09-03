Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F0BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C2622DCC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D5ZVTnQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfICJcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:32:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbfICJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uQUjIkIkncJWurXe4Me0AkVPHTe6qDZ2I9U/1GukKQs=; b=D5ZVTnQ4KpU508pOzyuNwJfU7L
        wSlryZDkX7cyfC5ohy3+0UEgVqhXhdln2e+fnBAoxp7tNlWJiO4O6JSxSEnKUxLBgm4xSuToaa6gi
        zAETWf0aUilhPI9vxT1OzEES1RXPNnRhCb75CgrgIvTpA4KOcctm2ZGqNSjTZqKfedHRftapAlWZR
        MdrxxEF69CVqMOoheyr3ZGBETajW/bKbCb8nK/mQIHM2xcwkosi4YqxlBHNxeZovA4quTthmJQR9g
        OG8hmPCsMdiB3fw1lM0LBBZjFQXhMfBqWjkx5AjkhACn7WvkX+7I7VByF7sBRe0WtApZhbgs2owpq
        EmQCVyjQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i55BA-0004Jn-2L; Tue, 03 Sep 2019 09:32:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 03/20] riscv: cleanup send_ipi_mask
Date:   Tue,  3 Sep 2019 11:32:22 +0200
Message-Id: <20190903093239.21278-4-hch@lst.de>
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

Use the special barriers for atomic bitops to make the intention
a little more clear, and use riscv_cpuid_to_hartid_mask instead of
open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8cd730239613..2e21669aa068 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -80,17 +80,15 @@ static void ipi_stop(void)
 
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
-	int cpuid, hartid;
 	struct cpumask hartid_mask;
+	int cpu;
 
-	cpumask_clear(&hartid_mask);
-	mb();
-	for_each_cpu(cpuid, mask) {
-		set_bit(op, &ipi_data[cpuid].bits);
-		hartid = cpuid_to_hartid_map(cpuid);
-		cpumask_set_cpu(hartid, &hartid_mask);
-	}
-	mb();
+	smp_mb__before_atomic();
+	for_each_cpu(cpu, mask)
+		set_bit(op, &ipi_data[cpu].bits);
+	smp_mb__after_atomic();
+
+	riscv_cpuid_to_hartid_mask(mask, &hartid_mask);
 	sbi_send_ipi(cpumask_bits(&hartid_mask));
 }
 
-- 
2.20.1

