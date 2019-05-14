Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA42C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F64F2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAEG2oDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfENWlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:41:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44287 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfENWlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:41:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so1116840edm.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=De9yut+MJE0vq/sB5hhSe0oQe16qEPDC6fhRh/E/rX4=;
        b=oAEG2oDhTeQvIT+TIJ1/M+H2j1bu9UZA21/89ZMpxSGh6uhOo3VN9SjEGnV4jR211H
         /lSWej5qn3euaLZyRYpkGjs4FVm5x9bTWD/7OPQWRXAafIhUVwsBuzWLnTVrEVkrVNcX
         k73fkOUOfzQfZESG8nNuqVAcHp0HvbsyrDUeBeumtxsRW4IwaTiJxeMLGEGmxeN9iTVH
         9zQxghlelWmOdHhGz/Z4MaaquYcfZJ/3rCQMK0NaD0EoS++25v4+5xwXhTHbdCz4H0Ly
         gAMg5EmZDYJ8ghO4rYrwNfgnOdLiJEfLrcS5jQzaLy97Y9KqBp3njb9GmTq1MEkcGydo
         eJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=De9yut+MJE0vq/sB5hhSe0oQe16qEPDC6fhRh/E/rX4=;
        b=GvEdDRILlUf9iOThgzCdANHn7zSRiCPACOq7jX1yer86onro+WrnYh+SXIeiz522HX
         1o2PbzciIaFtpuUWtWaydM34T3pnDOJ/hJRp5HfxKveFiC0v35+3A2qiG+wBj+gcmtgJ
         aL61KNVgbPOAnQK1WQUfUxqLQaRUqPZsJKjJ68jBI00YyWWTms2yIp2Y/R0232Fp1OhQ
         xo+W+tGgGRicPJ1+P7/rTrxKprxMrMbO8JXtT7amr9SoWNqBk3lFXJSi02SkUd/o1waT
         VkXfi1pNP0nJNvgIJifg14Hg0mE036MhleOqlXagh20El68Gc12oUIRxt4pmVmcozxH2
         vMMQ==
X-Gm-Message-State: APjAAAXjVsGISuFVUENrg8nGborLPIYF5ppRgU6pGWvj4PQCSwDbI3Gu
        hte1994anlkASya+BvBUcb4=
X-Google-Smtp-Source: APXvYqw9NrNSs7XlZb0QF7UJKD0u3SI3luy813oEkNyxXO28+mH3GwCCdb2p6CpO3PBJlGPDvPGtrw==
X-Received: by 2002:a50:95d6:: with SMTP id x22mr38290047eda.89.1557873666417;
        Tue, 14 May 2019 15:41:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id j13sm97910eda.91.2019.05.14.15.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:41:05 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] objtool: Allow AR to be overridden with HOSTAR
Date:   Tue, 14 May 2019 15:40:47 -0700
Message-Id: <20190514224047.28505-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, this Makefile hardcodes GNU ar, meaning that if it is not
available, there is no way to supply a different one and the build will
fail.

$ make AR=llvm-ar CC=clang LD=ld.lld HOSTAR=llvm-ar HOSTCC=clang \
       HOSTLD=ld.lld HOSTLDFLAGS=-fuse-ld=lld defconfig modules_prepare
...
  AR       /out/tools/objtool/libsubcmd.a
/bin/sh: 1: ar: not found
...

Follow the logic of HOST{CC,LD} and allow the user to specify a
different ar tool via HOSTAR (which is used elsewhere in other
tools/ Makefiles).

Link: https://github.com/ClangBuiltLinux/linux/issues/481
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 tools/objtool/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 53f8be0f4a1f..88158239622b 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -7,11 +7,12 @@ ARCH := x86
 endif
 
 # always use the host compiler
+HOSTAR	?= ar
 HOSTCC	?= gcc
 HOSTLD	?= ld
+AR	 = $(HOSTAR)
 CC	 = $(HOSTCC)
 LD	 = $(HOSTLD)
-AR	 = ar
 
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
-- 
2.22.0.rc0

