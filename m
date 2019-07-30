Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E99C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E540220693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="N1oKq68H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfG3Qkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:40:47 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:46189 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfG3Qkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:40:47 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x6UGeiKe027856;
        Wed, 31 Jul 2019 01:40:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x6UGeiKe027856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564504845;
        bh=5pyHzdfmyGH/cRqaNQinrJDuh/jCPE5pxhd6kJmjsHs=;
        h=From:To:Cc:Subject:Date:From;
        b=N1oKq68H6wAu0Q0UpUYSAM/8g6YZutLs3kM86O/nPJL0MLWAEtAzuNSw9Zqz8sYUa
         twMMgGdm/oAuuPT4R6hHjtgzBYdkSPQTtwwn+a/yE5tV2cA7ht8WYJrrTk9at2krbl
         HRR2wmxRNPtKmR2ggYH93rH7d/01eqmfSaOt+y0u0AFkUkcQViDv+UoP8bJPfdvIxM
         0XevXgx48+8hbZoNht4p4Rq0BmdJrzvQP5MQJ8zGLcVflntCloYeRo7L3n23mqaUH+
         LTuPzfn8boEN48Ibg67Mp+reBgiolQSdrxV5YXFbgGFiCQUOj2nC4lsXZLQxTVzlYK
         WfMqpdHuoiRHg==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/raid6: fix unnecessary rebuild of vpermxor*.c
Date:   Wed, 31 Jul 2019 01:40:42 +0900
Message-Id: <20190730164042.2631-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following four files are every time rebuilt:

  UNROLL  lib/raid6/vpermxor1.c
  UNROLL  lib/raid6/vpermxor2.c
  UNROLL  lib/raid6/vpermxor4.c
  UNROLL  lib/raid6/vpermxor8.c

I made a mistake in the Makefile refactoring.

Fixes: 72ad21075df8 ("lib/raid6: refactor unroll rules with pattern rules")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 lib/raid6/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 42695bc8d451..0083b5cc646c 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -66,7 +66,7 @@ CFLAGS_vpermxor1.o += $(altivec_flags)
 CFLAGS_vpermxor2.o += $(altivec_flags)
 CFLAGS_vpermxor4.o += $(altivec_flags)
 CFLAGS_vpermxor8.o += $(altivec_flags)
-targets += vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
+targets += vpermxor1.c vpermxor2.c vpermxor4.c vpermxor8.c
 $(obj)/vpermxor%.c: $(src)/vpermxor.uc $(src)/unroll.awk FORCE
 	$(call if_changed,unroll)
 
-- 
2.17.1

