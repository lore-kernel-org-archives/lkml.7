Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A23C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A0D206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MGTS9F8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfEQHy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:54:56 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:17519 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfEQHyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:54:55 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x4H7sUrd022599;
        Fri, 17 May 2019 16:54:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x4H7sUrd022599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558079672;
        bh=dNdPaWByqRzpxRPRXu1rbieqkbsfoP3hed7EQv0g+cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGTS9F8lm02IiQyLc+QydHgSkZ1Lt6plN/Qcl25xrPFrXokMCiwuVx5cD4AlSf4EL
         qWc/UUF8UKEGzAsQX1bA1gxN25BJuJfXjLpS75lriS+5DsGQ5DHf/9zQ/1nVoyrOy7
         gGj0Jo0lM9flJJuzHDs7YeQVgG4bk3ZkKkEaD3ycH6ajiGuhfOTTus3vBUhb43HAh1
         VEwVPKQ9X0uOcz0zbFWeT2/5OUsQYIIZ2I90T93QKZe8x915NQNyHq484Pn1oByEWl
         ifC/k9+xWTh31Htbjycw+ap8y3YHnV3/d1f/KQqm06/IsEZN3kqSGgyYwJnW5BTh50
         ZgHc9E8aGwPWA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] s390: drop redundant directory creation from tools Makefile
Date:   Fri, 17 May 2019 16:54:26 +0900
Message-Id: <20190517075428.13496-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517075428.13496-1-yamada.masahiro@socionext.com>
References: <20190517075428.13496-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you can see in scripts/Kbuild.include, the filechk creates the
parent directory of the target as needed.

This Makefile does not need to explicitly create the directory.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/tools/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index 8fb66c99840a..4864ea5e6ceb 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -16,9 +16,6 @@ hostprogs-y		    += gen_opcode_table
 
 HOSTCFLAGS_gen_facilities.o += $(LINUXINCLUDE)
 
-# Ensure output directory exists
-_dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
-
 filechk_facility-defs.h = $(obj)/gen_facilities
 
 filechk_dis-defs.h = \
-- 
2.17.1

