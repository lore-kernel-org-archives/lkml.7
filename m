Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3354C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE77221721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBMEN4gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392787AbfFMQjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:39:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbfFMHJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N8QXfZwivbN/UElGqGpKdzwCDnMqjA7ARQHaiJiVE0I=; b=WBMEN4gu+enMfO/mPhWlPZqPSD
        XaGaWOnVp4/G3LLOxwOe++WDHhlwe/40O/ifcrp7EKZx7mR1fjQ0NVuADpwjLA95/GVCVCqft/H9V
        yD/MXFJVuRFUJBNVaeP6LkebwGKE5R3IUhRWM74NRfgd0GXaocG+0KyXWTK17RGfRDBgHbA4S+Yo3
        BazQVH6sDIa312lgsk0ibTINNjpOD9niYppjAdp68cx+nUPEiCJZXLTtGxnJatlc/OW7vLNfj9a2l
        SMVMAT7f1sufpg+UqyuyAX9XlI9RHXbeNZx8cJ0UA3PItXAlSno+a9CjlxhIXSVOwT8oO7caS6MMn
        BfpiZnDw==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbJrY-0004IX-0J; Thu, 13 Jun 2019 07:09:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] binfmt_flat: consolidate two version of flat_v2_reloc_t
Date:   Thu, 13 Jun 2019 09:08:54 +0200
Message-Id: <20190613070903.17214-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613070903.17214-1-hch@lst.de>
References: <20190613070903.17214-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two branches of the ifdef maze actually have the same content, so merge
them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/flat.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/flat.h b/include/linux/flat.h
index 2b7cda6e9c1b..19c586b74b99 100644
--- a/include/linux/flat.h
+++ b/include/linux/flat.h
@@ -69,15 +69,13 @@ struct flat_hdr {
 typedef union {
 	unsigned long	value;
 	struct {
-# if defined(mc68000) && !defined(CONFIG_COLDFIRE)
+#if defined(__LITTLE_ENDIAN_BITFIELD) || \
+    (defined(mc68000) && !defined(CONFIG_COLDFIRE))
 		signed long offset : 30;
 		unsigned long type : 2;
 # elif defined(__BIG_ENDIAN_BITFIELD)
 		unsigned long type : 2;
 		signed long offset : 30;
-# elif defined(__LITTLE_ENDIAN_BITFIELD)
-		signed long offset : 30;
-		unsigned long type : 2;
 # else
 #   	error "Unknown bitfield order for flat files."
 # endif
-- 
2.20.1

