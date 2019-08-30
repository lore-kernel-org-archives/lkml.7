Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4DBC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A901220673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+c78cGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfH3AvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:51:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38137 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3Auz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id c12so3976329lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rseUd9y/GnXjRY8PsudxS8BEzI5o7BH/gE6GzGNAkz0=;
        b=p+c78cGOyUo6huk/pdHK4LHWxY05E5DmCBl6Y9TnX0wvtYNQzK7/aTvz75AqmlPGvA
         lX3zJWWhAuFN7kMzRbIe4MIRTgqe2XNObWdcxwvAYdo9v+NHqraV4ztUXFoSctAfudEb
         6iWjcDghz5Lkpmgx4rrpBe3K+94vUyybq7SVTJP0KvecAGtDjApjNEeFXlxu6wHYQ2nG
         Aia65Ra96zxOxrfifKlzHZK+MklKrHz3P1CXW6V1T+wu0gkWFEF3j5zl9WfXVvgh/7Iz
         tX+fup/gKLffQChanaOEXwwKRLJP/Zl4iC0qpnp9r8NCvX0yAmZFBiQuq5bIQpJinAgf
         23aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rseUd9y/GnXjRY8PsudxS8BEzI5o7BH/gE6GzGNAkz0=;
        b=BNoyDJvlAgc74Exz6ywK/h8/6auM3ERw1Lliis7oJG2T05AIo1984XS+hka0PuJk08
         sGUZXC91Qr17Guk/wicaxbz8LMIztmCOGTbrwscm5hnvKh4tAPkOjJ5GAqopOWUF8oe2
         xf5n+o+9+c8cvEsRI9PeF1A5eHjEAC+mAECGEJi8BSdGHrCgwNWgBPm1dHtW7gy9EQ3j
         3TZJtO16bsWCmF0HfniK3gcOx4c1hNnLTHRkB4YVL7dckbik3QJaUHkrDYmJW/Qag25v
         jtHAz6HXtossTMVxNFitt5foYwP/T3XXTuoTpDl1NXOm+WYvUEpeLWhTPnUrxnCa36EF
         dwlQ==
X-Gm-Message-State: APjAAAWcXZvqhZvCh8PauTMicOrGAWZm3C1KK5lphk2V8ii6Khk9OELQ
        CNAl3ZygVByqndp08wSmrscxHw==
X-Google-Smtp-Source: APXvYqxNrtZrcEGcDIoDRzM60F5kluGphxsbk/1Bx4tLv8SvOizz47bOc1wno61j8h21RjFX5zUA3A==
X-Received: by 2002:a19:e04f:: with SMTP id g15mr7384740lfj.46.1567126253185;
        Thu, 29 Aug 2019 17:50:53 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:52 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 09/10] arm: include: asm: swab: mask rev16 instruction for clang
Date:   Fri, 30 Aug 2019 03:50:36 +0300
Message-Id: <20190830005037.24004-10-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The samples/bpf with clang -emit-llvm reuses linux headers to build
bpf samples, and this w/a only for samples (samples/bpf/Makefile
CLANG-bpf).

It allows to build samples/bpf for arm bpf using clang.
In another way clang -emit-llvm generates errors like:

CLANG-bpf  samples/bpf/tc_l2_redirect_kern.o
<inline asm>:1:2: error: invalid register/token name
rev16 r3, r0

This decision is arguable, probably there is another way, but
it doesn't have impact on samples/bpf, so it's easier just ignore
it for clang, at least for now.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 arch/arm/include/asm/swab.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/swab.h b/arch/arm/include/asm/swab.h
index c6051823048b..a9fd9cd33d5e 100644
--- a/arch/arm/include/asm/swab.h
+++ b/arch/arm/include/asm/swab.h
@@ -25,8 +25,11 @@ static inline __attribute_const__ __u32 __arch_swahb32(__u32 x)
 	__asm__ ("rev16 %0, %1" : "=r" (x) : "r" (x));
 	return x;
 }
+
+#ifndef __clang__
 #define __arch_swahb32 __arch_swahb32
 #define __arch_swab16(x) ((__u16)__arch_swahb32(x))
+#endif
 
 static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
-- 
2.17.1

