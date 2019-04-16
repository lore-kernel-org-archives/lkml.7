Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75FEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BC920872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IgwByiYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfDPRKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:10:36 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52410 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:10:33 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id DD71E10C0C43;
        Tue, 16 Apr 2019 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555434632; bh=Q+2zH/VJWu8Mx6TcS34UmuCucpecWbteZfQxWLZCXvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgwByiYBrPgzjy+z8VAlEUfqoncQnQMFEP5/J/1eO25OY0EthV1H0P0aTjmesY9zS
         2rUGGVcSD+/uMv1phEZKFeLGGLTy9GcYUVHL8WF4Xf9tsWC7TJaLL1h6BaZEwlkK9T
         elAL/EdIMHg/M/X6ntR00nY6tEaFvSjdEah37gBLtdQUUf0hL922Ux3kcJjUMoM9+g
         bp7zqOw6bSKAM2bJ7W1upEkVznZ8gbKmZSIaOTBWpSDcZG7eCi/iljBnPbmkD17IT7
         wBFHMwcr87VOTbM9prVjw11Ri2t+snJ7zjji3+2EIgYCC/6xYixPJ+lltG6PmHaiUC
         X5XFf2Tnvn02g==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.106])
        by mailhost.synopsys.com (Postfix) with ESMTP id A4F1AA023C;
        Tue, 16 Apr 2019 17:10:31 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 1/3] ARC: cache: declare cache-related defines via ARC_MAX_CACHE_SHIFT
Date:   Tue, 16 Apr 2019 20:10:19 +0300
Message-Id: <20190416171021.20049-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190416171021.20049-1-Eugeniy.Paltsev@synopsys.com>
References: <20190416171021.20049-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 * Declare all cache-related defines where we need maximum cache
line size (like SMP_CACHE_BYTES, ARCH_DMA_MINALIGN, etc...) via
one common ARC_MAX_CACHE_SHIFT define.

 * Move all cache-related defines outside '#ifdef __ASSEMBLY__'
guard to make them visible from ASM code.

This is prerequisite for autodetecting cache line size in runtime.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/cache.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index 2ad77fb43639..f1642634aab0 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -9,6 +9,12 @@
 #ifndef __ARC_ASM_CACHE_H
 #define __ARC_ASM_CACHE_H
 
+/* Largest line length for either L1 or L2 is 128 bytes (2^7) */
+#define ARC_MAX_CACHE_SHIFT	7
+#define ARC_MAX_CACHE_BYTES	(1 << (ARC_MAX_CACHE_SHIFT))
+#define SMP_CACHE_BYTES		ARC_MAX_CACHE_BYTES
+#define ARCH_DMA_MINALIGN	ARC_MAX_CACHE_BYTES
+
 /* In case $$ not config, setup a dummy number for rest of kernel */
 #ifndef CONFIG_ARC_CACHE_LINE_SHIFT
 #define L1_CACHE_SHIFT		6
@@ -47,10 +53,7 @@
 	: "r"(data), "r"(ptr));		\
 })
 
-/* Largest line length for either L1 or L2 is 128 bytes */
-#define SMP_CACHE_BYTES		128
-#define cache_line_size()	SMP_CACHE_BYTES
-#define ARCH_DMA_MINALIGN	SMP_CACHE_BYTES
+#define cache_line_size()	ARC_MAX_CACHE_BYTES
 
 /*
  * Make sure slab-allocated buffers are 64-bit aligned when atomic64_t uses
-- 
2.14.5

