Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72793C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1DA217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvoLmCOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDWUss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:48:48 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52778 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDWUsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:48:47 -0400
Received: by mail-pg1-f201.google.com with SMTP id b37so6160044pgl.19
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YSuhbKwpbyapX1rcuSsPD2w0Z5CXJn6nfImMvKjn8qg=;
        b=GvoLmCOA9cilKvBWiDyUgSrvAwlf9SBR1Ln7LvB6ujxXhcCKlbYKjSNQBwet2Vt52b
         rtQCKujLMccx/xKBw19RoykrhsL0Gslvf7lhQJX4vIYix8D4FeGJ8jyzYBRVwhEfkkck
         HRcW4HjjH1nlY8FgAE2Pw+Ie6e8YP1snnlE8tIgWUgrS099YKk2mrs6CIU14xFJGaRLu
         7qfuxWhtGMDEbWWSOmKEFpDZt6F75OZrUCyo/GG2EdmogJnwEsyKCY+0qyN+CplhmyjB
         HThd5B84xiD3f2XxZkn5y+dybpk2Nrztv0wbHBe+tu/ewIQAGOS8L0xy3p5vIvlJ0xV+
         8DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YSuhbKwpbyapX1rcuSsPD2w0Z5CXJn6nfImMvKjn8qg=;
        b=FxQz3z3FMRN8wNBvAccnyitj00z8v2LZZvGfDiGklC+xDGv2qPobMUTOTwXotMRBfz
         dgpJafvo4ywoEk0Q/MocxCwx+gp+/lXGmLCtYCKbS/jguN1lUhZYzWCeLmEUD5/Y6RUC
         1LldtVktG5fgH9T/BQrZGpL2ArxiRedNHuD4V+XVxOwZ0yksKoTnGCIqZ2IVyomNuscJ
         22WiN8Pmn4UeFPsPbTfe+OoR4CzBm1voUKHYhpwIF3qO4FZJuqueZFiTIojdxSDyzDgh
         iycfDEHU9wXjx9Jxwkn+xXJDllhBaUtziwIeGTxHOimBTfwifa2MJB4XSEanDdFEyu40
         HqJw==
X-Gm-Message-State: APjAAAWU2CSE7QbLaeomX+/clceSaWyxjeu0nA3nw7nYvdcXxy22yNd6
        SplAXWNJUXWjZFy0DmqRKZQv3JYYStZcJcNGD1s=
X-Google-Smtp-Source: APXvYqw9NzzO5qJicSg3hII55fRE7rpdZFWDLzihYNJ2NgVbinaSrC7FJ90QlPjHYqtTKV9GM5JPtM+0WnNDDmXoCW8=
X-Received: by 2002:a63:5014:: with SMTP id e20mr2410468pgb.312.1556052526842;
 Tue, 23 Apr 2019 13:48:46 -0700 (PDT)
Date:   Tue, 23 Apr 2019 13:48:20 -0700
Message-Id: <20190423204821.241925-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] ia64: require -Wl,--hash-style=sysv
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tony.luck@intel.com, fenghua.yu@intel.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
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
 arch/ia64/kernel/Makefile.gate | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/Makefile.gate b/arch/ia64/kernel/Makefile.gate
index f53faf48b7ce..846867bff6d6 100644
--- a/arch/ia64/kernel/Makefile.gate
+++ b/arch/ia64/kernel/Makefile.gate
@@ -11,7 +11,7 @@ quiet_cmd_gate = GATE    $@
       cmd_gate = $(CC) -nostdlib $(GATECFLAGS_$(@F)) -Wl,-T,$(filter-out FORCE,$^) -o $@
 
 GATECFLAGS_gate.so = -shared -s -Wl,-soname=linux-gate.so.1 \
-		     $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+		     -Wl,--hash-style=sysv
 $(obj)/gate.so: $(obj)/gate.lds $(obj)/gate.o FORCE
 	$(call if_changed,gate)
 
-- 
2.21.0.593.g511ec345e18-goog

