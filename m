Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CFBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973FC20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdG1iXl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389922AbfDXSCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:02:31 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:53513 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389799AbfDXSC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:02:27 -0400
Received: by mail-yb1-f201.google.com with SMTP id y6so15106862ybb.20
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4cWEd2olSrQJQ8tmsuPoZ/kztpf8F/cSWsps4u6UzJM=;
        b=EdG1iXl8Zi4YbNJTGA9Z9SOnNPWVmifAdWUaAWBGhaPMufzkyRsaXWX2LahCvtRBLV
         gR9oxkgA+AuvpPQXlv1J40F/mC+fdOP5dMHRvr0FrnyqtnaOxYaSH7h+EdLbFURGBnuB
         0273YdzlvKHDJ8Wyrx0jN7sNMHsHsSgR+kwohLNt3xw1QpvZj+cfOaaEa2vkznANgEpY
         nGzkRh0R14gQsuorR4mmLSA9xqAYWldfObl838egaeZZu8QQgoqBxjDOb8P9Vg5Ye/32
         n5pw+m62lJ3SJ9Yxc6pNjM88WfbdaTZJaR1oX2R1lXdbwMCU6PiGvlms6ZoxHDHIRamr
         YGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4cWEd2olSrQJQ8tmsuPoZ/kztpf8F/cSWsps4u6UzJM=;
        b=Wts4zy6qNoedhp4sWrPNGyh8ykR2WIGxQoXOU7JbTz/E3sfzIxkxrxp2vMGIapIvMr
         7lM/3X7WNp+DZwtTEUBvfQ+WekR8ya6mUxnM63HxXFlaFe2+PRYKS02jAlKZQevrSBjq
         57ClEYM48RyN2AmspJDOLyFR2MZJV8WpL01wjCt/fBH3Pq8ofLPCX7fTAiORcpTPC8Lg
         WZ2vAOpI4MR8AxKwZjAmXTbY4YfgYyjJu5LSLZwqacJdFKNJPI04CkSfKReXHXVhnogX
         J7THtKoQBBoPfjJcXH8YmzkMSNy3q8Prh9tte/h+dpB7qg2XaTGaOrCO0BQU/AFErYLM
         gp5w==
X-Gm-Message-State: APjAAAWcJM0DjYMouGrfgdhmK2AQnwpDyofwe2wy1WJ/tuGpZwCpsrpc
        /vBY5ieuNpmAtVKk+QPbjB2xznEx0RqtUCCtxTM=
X-Google-Smtp-Source: APXvYqyZoRq7Pl9ugvCWkv7NtZ7aXD7/NvBdNLqZaIQX5bjQl5thcWJdtzVe/p5PCB/NwsxFEd440DlSunYZNnVb/5w=
X-Received: by 2002:a25:42c8:: with SMTP id p191mr28479025yba.442.1556128946422;
 Wed, 24 Apr 2019 11:02:26 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:02:21 -0700
In-Reply-To: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
Message-Id: <20190424180223.253025-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2] sh: vsyscall: drop unnecessary cc-ldoption
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     geert@linux-m68k.org, luto@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Towards the goal of removing cc-ldoption, it seems that --hash-style=
was added to binutils 2.17.50.0.2 in 2006. The minimal required version
of binutils for the kernel according to
Documentation/process/changes.rst is 2.20.

Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
Cc: clang-built-linux@googlegroups.com
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* update commit subject and message as per Masahiro/Geert.

To Geert's question about minimum binutils versions; no change needed to
binutils.


 arch/sh/kernel/vsyscall/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
index 5db6579bc44c..6e8664448048 100644
--- a/arch/sh/kernel/vsyscall/Makefile
+++ b/arch/sh/kernel/vsyscall/Makefile
@@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
 
 export CPPFLAGS_vsyscall.lds += -P -C -Ush
 
-vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
 
 SYSCFLAGS_vsyscall-trapa.so	= $(vsyscall-flags)
 
-- 
2.21.0.593.g511ec345e18-goog

