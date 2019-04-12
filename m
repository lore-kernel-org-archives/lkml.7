Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026CCC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E742084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gi0j1M3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfDLOgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:36:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLOgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WX6iybjkfSLlj5DKZHfXMiYqnwkNSI8RrI8E3WQ+jdA=; b=gi0j1M3Sp46bU0SZU6OEYUFGj
        a/7A4gIdXabgKMIuy0HISd7zgTpmLRdakrXssA/mr23qUHf08Fcef3viSAfgJDTVO3d3MzbnT/IKo
        +hLNO5REhOWeVxhl0kcyGKXLQ12p0PH1c1cBzbQ2xHs+zzZXSBrr63cJZ77LO+ZG4Pb/PoRYqC/8z
        bYgDTsI86KHRlHjym3+uBb9aBJpLPjBKG+u8ST1ehYuHAxO6vx7MtZQweofexmbGt164k5/CMB+GE
        EsTPnBD68FiyJmiokO8ohTnW/R1azxOMQJ5ZPNXT+Wn5aKox4LALq1/0tg8DlsB+XhSR/sgqyAX6a
        Xu3biwdMA==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hExHd-00078b-Ux; Fri, 12 Apr 2019 14:36:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc:     arnd@arndb.de, linux-arch@vger.kernel.org, mick@ics.forth.gr,
        linux-kernel@vger.kernel.org
Subject: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
Date:   Fri, 12 Apr 2019 16:35:38 +0200
Message-Id: <20190412143538.11780-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing some dead big endian checks in the RISC-V code Nick
suggested that we should have some generic sanity checks.  I don't think
we should have thos inside the RISC-V code, but maybe it might make
sense to have these in the generic byteorder headers.  Note that these
are UAPI headers and some compilers might not actually define
__BYTE_ORDER__, so we first check that it actually exists.

Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/linux/byteorder/big_endian.h    | 4 ++++
 include/uapi/linux/byteorder/little_endian.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/byteorder/big_endian.h b/include/uapi/linux/byteorder/big_endian.h
index 2199adc6a6c2..34a5864526d2 100644
--- a/include/uapi/linux/byteorder/big_endian.h
+++ b/include/uapi/linux/byteorder/big_endian.h
@@ -2,6 +2,10 @@
 #ifndef _UAPI_LINUX_BYTEORDER_BIG_ENDIAN_H
 #define _UAPI_LINUX_BYTEORDER_BIG_ENDIAN_H
 
+#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ != __ORDER_BIG_ENDIAN__
+#error "Unsupported endianess, check your toolchain"
+#endif
+
 #ifndef __BIG_ENDIAN
 #define __BIG_ENDIAN 4321
 #endif
diff --git a/include/uapi/linux/byteorder/little_endian.h b/include/uapi/linux/byteorder/little_endian.h
index 601c904fd5cd..0cdf3583e19f 100644
--- a/include/uapi/linux/byteorder/little_endian.h
+++ b/include/uapi/linux/byteorder/little_endian.h
@@ -2,6 +2,10 @@
 #ifndef _UAPI_LINUX_BYTEORDER_LITTLE_ENDIAN_H
 #define _UAPI_LINUX_BYTEORDER_LITTLE_ENDIAN_H
 
+#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ !=  __ORDER_LITTLE_ENDIAN__
+#error "Unsupported endianess, check your toolchain"
+#endif
+
 #ifndef __LITTLE_ENDIAN
 #define __LITTLE_ENDIAN 1234
 #endif
-- 
2.20.1

