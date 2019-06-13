Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53D3C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B874E215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qR4pO6bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbfFMQh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:37:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbfFMHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T3Eo5sxQqIJbJF4QyIRsu/lJY1U0q5nAAdAJnHrYrpU=; b=qR4pO6bw2gsxHkiazstPS8oEWM
        FKYMb2SaaIyHmSdhji58kmzc431ERCifOKrpDxBApHJE7IgtwBxrW369WQGKC5gCVcha1mWTZY5GD
        WXoqBl37DzrmY0JsK8g33U+Wyb3rYh3Y0I17JyJrurkteICYq36mzW7LqYqtbNHT3RrR2edx/Gr8E
        pcneECKWd3ucje3iZ3DEOd8MoRsSkZ28YxSsJJqkQvOLon8ZJnGqBbnSEtTFlD00Wf+vC7NzzICEl
        LEVvWKERR+zQxJSAdCF7ep0QFsP8pht5TIN8z/LZWhp3J67XIPvOn3DOiuEBwHV5zEpePy33Hhk9R
        DtlhUctg==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbJrv-0004VL-4D; Thu, 13 Jun 2019 07:09:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] binfmt_flat: move the MAX_SHARED_LIBS definition to binfmt_flat.c
Date:   Thu, 13 Jun 2019 09:09:01 +0200
Message-Id: <20190613070903.17214-16-hch@lst.de>
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

MAX_SHARED_LIBS is an implementation detail of the kernel loader,
and should be kept away from the file format definition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_flat.c     | 6 ++++++
 include/linux/flat.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 0ca65d51bb01..ccd9843e979e 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -68,6 +68,12 @@
 #define RELOC_FAILED 0xff00ff01		/* Relocation incorrect somewhere */
 #define UNLOADED_LIB 0x7ff000ff		/* Placeholder for unused library */
 
+#ifdef CONFIG_BINFMT_SHARED_FLAT
+#define	MAX_SHARED_LIBS			(4)
+#else
+#define	MAX_SHARED_LIBS			(1)
+#endif
+
 struct lib_info {
 	struct {
 		unsigned long start_code;		/* Start of text segment */
diff --git a/include/linux/flat.h b/include/linux/flat.h
index d586bb6e64a7..83977c0ce3de 100644
--- a/include/linux/flat.h
+++ b/include/linux/flat.h
@@ -12,12 +12,6 @@
 
 #define	FLAT_VERSION			0x00000004L
 
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-#define	MAX_SHARED_LIBS			(4)
-#else
-#define	MAX_SHARED_LIBS			(1)
-#endif
-
 /*
  * To make everything easier to port and manage cross platform
  * development,  all fields are in network byte order.
-- 
2.20.1

