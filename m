Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7411C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C2C2186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="d02u9ahP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfHHD3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:29:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40255 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfHHD3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:29:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so67681610qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 20:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wKcnipXNqNm/RJ8fKQegUpgi0jV6GjqcI6lqswIMYM=;
        b=d02u9ahPx43NTrP7AXSn+RdH+k6rfbwOFMrvioM9PezpWYcOD77uZZWhAghObWX0Yr
         y+PzChz9Gjo2xPk3gO9MNhM35RRWnG0k8cOyeclZyizD67jPejudSBgo5U4e135ByFOH
         /Xs2vYw6MPoRj3/6emHYUO9nJv2vm8nlxkaouSxWMfv6APkynkSVkgm/UlvcqpqyJIi1
         +FhLMnlYNBiN6sa6n3L1FivozK3WRZhVOOJ43xrmYUb2UPHdFBoqz+qBsBpEwo/CQvS1
         GdcimICgHzn15gkg/f7FweRGm/+MM7+rPCb37ooSIecXRp4okwI5tvu5ozJmBrfqtUJT
         KCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wKcnipXNqNm/RJ8fKQegUpgi0jV6GjqcI6lqswIMYM=;
        b=i699GbRYMPFrAlYsCjinMVjEuDuLVEpkYggDj9XtTI/cqc5Qf0Z+KcEKXLmhax7e1r
         EBieFWZg9er68df2esRomGrKGExFhxz0GMUtwuT5o9ka/yUuym6hMjy5nygozgYfZkto
         bbVf8UHOH7UEXUe5vfUGxYgksTGkKZlLeUiu+1xbs4331D71VnlWfXmW9Oe4rrxf/LID
         s2uXTyQIXJTdZWliYoWAh0ZEuGf5gQRXXJqtFMCjgSPE+LXlmSZuDJjjnRBe8dvOOqKH
         MQ2O8+73XVpiioyoOkJsozbLONw4vb4HS+XWhB01IINgVZzI+Qb3M7of1AnjeanyHSUb
         m4SQ==
X-Gm-Message-State: APjAAAUoVp9EN4Dx7zUCjYBxkpLlYrSYnbDRy/R0kzlB1L+pByCoc9WF
        1u0bjgxRI6ynBomZKgiJKcRFWa9ipK9igQ==
X-Google-Smtp-Source: APXvYqwujP4p2qNPudtVv0M+LihtsXDG8THeXxk3R/d5qPWADqDjvX33f8rA/TpbUjyWFmtGbU6sKQ==
X-Received: by 2002:a37:4043:: with SMTP id n64mr11669115qka.392.1565234984850;
        Wed, 07 Aug 2019 20:29:44 -0700 (PDT)
Received: from ovpn-120-247.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c5sm42466663qkb.41.2019.08.07.20.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 20:29:44 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64/cache: silence -Woverride-init warnings
Date:   Wed,  7 Aug 2019 23:29:16 -0400
Message-Id: <20190808032916.879-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
VIVT I-caches") introduced some compiation warnings from GCC (and
Clang) with -Winitializer-overrides),

arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
overwritten [-Woverride-init]
[ICACHE_POLICY_VIPT]  = "VIPT",
                        ^~~~~~
arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
'icache_policy_str[2]')
arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
overwritten [-Woverride-init]
[ICACHE_POLICY_PIPT]  = "PIPT",
                        ^~~~~~
arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
'icache_policy_str[3]')
arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
overwritten [-Woverride-init]
[ICACHE_POLICY_VPIPT]  = "VPIPT",
                         ^~~~~~~
arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
'icache_policy_str[0]')

because it initializes icache_policy_str[0 ... 3] twice. Since
arm64 developers are keen to keep the style of initializing a static
array with a non-zero pattern first, just disable those warnings for
both GCC and Clang of this file.

Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/kernel/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 478491f07b4f..397ed5f7be1e 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -11,6 +11,9 @@ CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 
+CFLAGS_cpuinfo.o += $(call cc-disable-warning, override-init)
+CFLAGS_cpuinfo.o += $(call cc-disable-warning, initializer-overrides)
+
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
-- 
2.20.1 (Apple Git-117)

