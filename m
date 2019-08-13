Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF48C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DD1205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TlrVNJeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfHMPsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:48:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbfHMPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zL5sx3Cfj7JP5a1Q8ZkxJrzulDl5XP1ddpP2zH1xYVU=; b=TlrVNJeYFqX/T4Oov+fGQbfTFI
        kRICczHDmijyJ7RwDh/20DHmG+SiJNbXfBJ941O6sHqo58JqUIrQdUYxCOrQqHUKdFMFiNzQn8G/L
        lRbW6T/QPiShluu290d5jl1vLzZJznc+jUjOagRLPeihcqmQbYHVWitadNTb3Bn1nD+IYrz8bAAce
        vFo3MY2pZCeygCoTqAtVqW6rPxAkazoWwMVVRSn8YZEuPQ/XFl/W4gONGAdRQHUPBVgOHOdce7kZz
        vfhyKp9qlnciFqYUlTdHp/ClFhn0wJlJSOCF1xAJTM1WGPK57rC4EiMhHH+XD423Q7tA61OdxgErv
        RO7zSVoQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxZ2E-0005Qp-9X; Tue, 13 Aug 2019 15:48:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] riscv: disable the EFI PECOFF header for M-mode
Date:   Tue, 13 Aug 2019 17:47:47 +0200
Message-Id: <20190813154747.24256-16-hch@lst.de>
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

No point in bloating the kernel image with a bootloader header if
we run bare metal.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 670e5cacb24e..09fcf3d000c0 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -16,6 +16,7 @@
 
 __INIT
 ENTRY(_start)
+#ifndef CONFIG_M_MODE
 	/*
 	 * Image header expected by Linux boot-loaders. The image header data
 	 * structure is described in asm/image.h.
@@ -47,6 +48,7 @@ ENTRY(_start)
 
 .global _start_kernel
 _start_kernel:
+#endif /* CONFIG_M_MODE */
 	/* Mask all interrupts */
 	csrw CSR_XIE, zero
 	csrw CSR_XIP, zero
-- 
2.20.1

