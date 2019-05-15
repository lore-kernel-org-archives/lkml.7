Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03B6C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 04:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18BA2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 04:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ijSPLNUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEOE2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 00:28:31 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:53238 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOE2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 00:28:31 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x4F4RRTk023688;
        Wed, 15 May 2019 13:27:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x4F4RRTk023688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557894448;
        bh=d7cf3ix/fLXBYCnmiBpWjAAdbjJ/zdoToHsAdljU21Y=;
        h=From:To:Cc:Subject:Date:From;
        b=ijSPLNUGoR3AMWOtp+aLwtzs84dlUcGxJXpH4F/wn0MI26y3Gb29inD3DopI9h9Cn
         /1tJpAnkst09vBH0bVB8Io1PF0rmV1oiOIjdl6sJ9iPthDfklQi9cyQ2WYUBsADXep
         V2hy7lfXg+9NryC/CZEWVopRUHSvADaOfd2iExNj/zO7yeah/S4OB9Rs2EJveG6C9q
         lScDMn0D9jIc3uvnBUhz8rXXM2PhgrHjaI+C5i4ZPTduM2hz5cDopTnOnNzvGryGCk
         kDdHLy0orS4SnS2kdbey2yKWJz+UP3taOo4bt2g0JNQo2KBFOWgnSA+RhwME4lxuEp
         MIaqnbRuDAB4w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: drop unneeded -Wall addition
Date:   Wed, 15 May 2019 13:27:21 +0900
Message-Id: <20190515042721.8752-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top level Makefile adds -Wall globally:

  KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \

For riscv, I see two "-Wall" added for compiling each object.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/riscv/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index c6342e638ef7..8f7368575bf6 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -36,8 +36,6 @@ else
 	KBUILD_LDFLAGS += -melf32lriscv
 endif
 
-KBUILD_CFLAGS += -Wall
-
 # ISA string setting
 riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32im
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64im
-- 
2.17.1

