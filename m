Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A07C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9D4222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TUJ4g+rU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKMHSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:18:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKMHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F5dHQdVRAaTpNRp+BuVlBL9qm+RFyST7QY7CQw03Vh4=; b=TUJ4g+rUo104R/CBZ+5wCzOi/q
        HTPOTOzTpwhFePhYrf5p+SaLvdHPZEhtU/u4WJt++bx+hOrpaVo13X6cmI53EYiYsbvNFMf3mMc1w
        0O3ooX5m29IslHOHXmf4zjnNSLCz4GMFdGIoDEfLHKvqjtUjstJoujky9CJxbDfjq+Mpsp9Qevpf5
        ei4UqXh3WBXPhlfTAGEhl/VRUR9fpf5t5jnJGfnkh+r8MgmgPb8lRmuRWcTM/dus5SGAng95GWiYv
        vOTmNdyQapjjpjrv30GvOeCLFi8W+DGXmRICwAYQLsQTyOcSJ17qk5lVlMvOqFLk7WjlcCBql8A+o
        NrSrFKXg==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUmvO-0008Bq-52; Wed, 13 Nov 2019 07:18:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 3/3] x86/pci: Remove #ifdef __KERNEL__ guard from <asm/pci.h>
Date:   Wed, 13 Nov 2019 08:18:36 +0100
Message-Id: <20191113071836.21041-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113071836.21041-1-hch@lst.de>
References: <20191113071836.21041-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci.h is not a UAPI header, so the __KERNEL__ ifdef is rather pointless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pci.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index d9e28aad2738..90d0731fdcb6 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -12,8 +12,6 @@
 #include <asm/pat.h>
 #include <asm/x86_init.h>
 
-#ifdef __KERNEL__
-
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
@@ -118,7 +116,6 @@ void native_restore_msi_irqs(struct pci_dev *dev);
 #define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
 #endif
-#endif  /* __KERNEL__ */
 
 /* generic pci stuff */
 #include <asm-generic/pci.h>
-- 
2.20.1

