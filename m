Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84552C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0277C21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="R2myvgJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfCVLTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:19:50 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:49955 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:19:48 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x2MBJOAx005370;
        Fri, 22 Mar 2019 20:19:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x2MBJOAx005370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553253565;
        bh=mjX7gWLqxfrSGG3MxUHbg7ISc2KHT2li4GGCKm5wk8E=;
        h=From:To:Cc:Subject:Date:From;
        b=R2myvgJnpb+V9Zc5zA5hdagmwGCrhhC9EaSNL5DvY6XEDtVIQbwlwMjgU+jWnwufb
         WxV7f3kHX0078AOtLJAkdA7e3W5BykURq0etRqOtG0Id2lmHY9AxME7evrVph3utyG
         fP37EKETU2CEfaQxEVe3uedyV44ZUTPviyOtCIFrzwRFSBJECeAhsU0m36HYxP+DmV
         S7J1XJLDWEwMV5lT5vfbdROklgbupAUtsP3S+seQ2++X0ZodFqHQgX1/RUEKTfAs0v
         3KwExE+LCNA6CWTOCMHvs6HOsUPBZCLuIxNG8yLLZPLoS3kcDrhkZAtgaaYrbpOZvB
         r6DrOBZk0xGAQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] csky: remove redundant generic-y
Date:   Fri, 22 Mar 2019 20:19:14 +0900
Message-Id: <1553253554-5307-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7cbbbb8bc297 ("kbuild: warn redundant generic-y"),
redundant generic-y is reported. I missed to delete this one.

scripts/Makefile.asm-generic:25: redundant generic-y found in arch/csky/include/asm/Kbuild: ftrace.h

In this case, csky-specific implementation exists in
arch/csky/include/asm/ftrace.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/csky/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 2a0abe8..e01a576 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -12,7 +12,6 @@ generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += fb.h
-generic-y += ftrace.h
 generic-y += futex.h
 generic-y += gpio.h
 generic-y += hardirq.h
-- 
2.7.4

