Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E43C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BF6208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UDOJPO3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfHGCa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 22:30:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40447 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfHGCa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:30:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so41044472oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 19:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=fcElZ7wudLl4OkkEiYYbZc12nuQcPIrxhzg+jbUkCuA=;
        b=UDOJPO3zORas6F4lihQxqeo6VOtTY+/Xof7TmRXnf8qQUc4oez8VQ/ykzcGIVigsL4
         GJUsYrn9ctOdXiLvrCEuuAkVfhfbC/4RNOx9O8f6r+ALL9lk0XaWiEZefw8Gikyg70j7
         YWiReY8nHjjs37lp24se6ySXefKSqFwgxZet5atWG7LwNkf+o46yRjA8XmKuXrDs803m
         FdwKFQGlB8fMBtl/0FCegXzTLcqfvF5Oyy0NpUDd07EwRJtE3wSUgBSj+3/xGh07JVBe
         m7mO//rTcZJzlpA1SlT7YukYp28nav+zwLLex55kBNQfGLdHK2CB9TjxYd93qXzYdjGp
         op3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=fcElZ7wudLl4OkkEiYYbZc12nuQcPIrxhzg+jbUkCuA=;
        b=od3IbtXF0b4bEiHw5MizJfqp+ePQpOLujqIIm5A7Nz65GyF2Q5UvPAsUKsYD7a9qub
         Odh4aWTUqvjuA4epCHAYei4TrvJCAI3rQFR6O5pHT1MpbbBF7ZYlzLtEBjnqvnqtKEDz
         NyNU259SY8msO/JzlkF4Tq3JtIfGPyis9ZBg8m2JDX98wgjwjRgknYZE7RzCv743Zqjr
         pLaI4bodVlJgkU52QiLr+LNseGIYXHkzXCzroIHYxA2H4ENIqVpViMOrouS0ctQBE9fT
         iFzk5OGt/NxuIHcPP/EdxfY18heUaq3KHUUohMgr2qoJmFZ+At4RenqFzB884d1wS2wZ
         w6rA==
X-Gm-Message-State: APjAAAUB7XsWtYF67iq8PWHMoIltZvfw3MYSK34v6ZGgSZpwnJhUwu3e
        u2lVKWn9adp3LvqCk5HuPbrNTKkPBDc=
X-Google-Smtp-Source: APXvYqy5awZKyZbsdh5g/oDEBb/x5E1IQyxC8xQ0M2N6V6fiNDKO+jW2FnJkWzfnrjdoiyAlwXiY8Q==
X-Received: by 2002:a05:6638:40c:: with SMTP id q12mr7740016jap.17.1565145026561;
        Tue, 06 Aug 2019 19:30:26 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id y20sm73451455ion.77.2019.08.06.19.30.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 19:30:25 -0700 (PDT)
Date:   Tue, 6 Aug 2019 19:30:24 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [PATCH] riscv: kbuild: drop CONFIG_RISCV_ISA_C
Message-ID: <alpine.DEB.2.21.9999.1908061929230.19468@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The baseline ISA support requirement for the RISC-V Linux kernel
mandates compressed instructions, so it doesn't make sense for
compressed instruction support to be configurable.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atish.patra@wdc.com>

---
 arch/riscv/Kconfig  | 10 ----------
 arch/riscv/Makefile |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59a4727ecd6c..8c5b9329ec46 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -197,16 +197,6 @@ config TUNE_GENERIC
 
 endchoice
 
-config RISCV_ISA_C
-	bool "Emit compressed instructions when building Linux"
-	default y
-	help
-	   Adds "C" to the ISA subsets that the toolchain is allowed to emit
-	   when building Linux, which results in compressed instructions in the
-	   Linux binary.
-
-	   If you don't know what to do here, say Y.
-
 menu "supported PMU type"
 	depends on PERF_EVENTS
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7a117be8297c..e23e066c55e2 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -38,7 +38,7 @@ endif
 riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
-riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
+riscv-march-y				:= $(riscv-march-y)c
 KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
-- 
2.22.0

