Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6767C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931B02085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iP0z8EV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfHLGzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:55:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfHLGzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b/1SYLwCRu5ERaaMVaIVgm/WJjkkAxvP0cPxYMfvmxg=; b=iP0z8EV+pbbylTdR8wLneXOgP2
        kKToqwGy3QXjsfIkrX8OVuuOg4ufM97VYsJW0Hb/C/SoVlfAVB4BotohvpeUPkh0rUs+TZJvOa8QU
        zt84qTKrogtTUMxDnwGI3iOs4EU1jk5Xk/AFpVI0Y+YCp4uIh0Q7QYeLnxbgKtQ+3/hj/1JsQEzAT
        OH76bleQgiQbNN53z12DVsDzlW2L9wENKjeqLx/vur9wHwt4TMu6+a85NrNPvzCJT80MwGl2pDQWH
        1l9sp2nVJm08NnarW4s3TTgEwnZphWr42lm2QjiF/n09ReyrOFq7HLSrggr8V9ZQYmTcKA9CrezEa
        fBshxHOg==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hx4Eu-0000FE-TO; Mon, 12 Aug 2019 06:55:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ia64: annotate switch fallthroughs in ia64_handle_unaligned
Date:   Mon, 12 Aug 2019 08:55:22 +0200
Message-Id: <20190812065524.19959-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812065524.19959-1-hch@lst.de>
References: <20190812065524.19959-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the "no break" comments with something that the compiler
recognizes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/unaligned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/unaligned.c b/arch/ia64/kernel/unaligned.c
index eb7d5df59fa3..2d4e65ba5c3e 100644
--- a/arch/ia64/kernel/unaligned.c
+++ b/arch/ia64/kernel/unaligned.c
@@ -1431,7 +1431,7 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 		if (u.insn.x)
 			/* oops, really a semaphore op (cmpxchg, etc) */
 			goto failure;
-		/* no break */
+		/*FALLTHRU*/
 	      case LDS_IMM_OP:
 	      case LDSA_IMM_OP:
 	      case LDFS_OP:
@@ -1459,7 +1459,7 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 		if (u.insn.x)
 			/* oops, really a semaphore op (cmpxchg, etc) */
 			goto failure;
-		/* no break */
+		/*FALLTHRU*/
 	      case LD_IMM_OP:
 	      case LDA_IMM_OP:
 	      case LDBIAS_IMM_OP:
@@ -1475,7 +1475,7 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 		if (u.insn.x)
 			/* oops, really a semaphore op (cmpxchg, etc) */
 			goto failure;
-		/* no break */
+		/*FALLTHRU*/
 	      case ST_IMM_OP:
 	      case STREL_IMM_OP:
 		ret = emulate_store_int(ifa, u.insn, regs);
-- 
2.20.1

