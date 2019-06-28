Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5741C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0B4215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZqqtvpWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfF1GZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:25:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF1GZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4d9xnAvzKNkkKyPVhbNWAJgevDr+ZONW8crz3L7aYjI=; b=ZqqtvpWT6F+C1D+QtuJqHAWai
        uyjEpVcMj9vNnnPmrg2FzhaAwvR9hEofJ6E/w0PenlzpX6j2Q3cblEQIHmJq4ElsVXeTAadomieGP
        JNvbqiCX6aUaVhYf7UO9vxHzO/3npSzKnkLlloXkQKcYTOXKuJUCzPWxSLnERLp9Nj2uieXtjW5eL
        The79HBgwGA5iNt0u4tle6tLHWgdNfbVPhAV99z3nb/fwFHCfAsVLQXU98SzpMh054DI8/prAN1Mf
        GsoVleFtHveNLTxM+uCuj6qdnblDTMnbQidDYwnyad9soVQTwVFNTEWsNU9IPzhdhIN7k5MSgt8pP
        iaz6za/Ow==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgkK6-0002mU-88; Fri, 28 Jun 2019 06:25:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: clkfwk: don't pass void pointers to ioread*
Date:   Fri, 28 Jun 2019 08:25:24 +0200
Message-Id: <20190628062524.5436-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing pointers with a const attrіbute to the ioread* functions
causes a lot of compiler warnings, so remove the extra attributes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/sh/clk/cpg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index eeb028b9cdb3..4f3d99d37809 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -36,17 +36,17 @@ static void sh_clk_write(int value, struct clk *clk)
 		iowrite32(value, clk->mapped_reg);
 }
 
-static unsigned int r8(const void __iomem *addr)
+static unsigned int r8(void __iomem *addr)
 {
 	return ioread8(addr);
 }
 
-static unsigned int r16(const void __iomem *addr)
+static unsigned int r16(void __iomem *addr)
 {
 	return ioread16(addr);
 }
 
-static unsigned int r32(const void __iomem *addr)
+static unsigned int r32(void __iomem *addr)
 {
 	return ioread32(addr);
 }
@@ -55,7 +55,7 @@ static int sh_clk_mstp_enable(struct clk *clk)
 {
 	sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
 	if (clk->status_reg) {
-		unsigned int (*read)(const void __iomem *addr);
+		unsigned int (*read)(void __iomem *addr);
 		int i;
 		void __iomem *mapped_status = (phys_addr_t)clk->status_reg -
 			(phys_addr_t)clk->enable_reg + clk->mapped_reg;
-- 
2.20.1

