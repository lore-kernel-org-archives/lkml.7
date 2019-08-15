Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF7EC32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACA62084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="HWqj9ejN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfHOAk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:40:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42769 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfHOAk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:40:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id i30so387564pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/fmDyudl4ch4OP62eHQXqnVTVLm5jUqLhjp55PmzJvo=;
        b=HWqj9ejNdJQayCUbigjbIXvdJTCNkGhJls8EEyFYC0V8P4n0cTodkeE/HZhHecjB2W
         l7K6/dnZ3R92f0SnXwkyP4/Slv8+iF8HLECnGiERqMUdnAxpOvN6Me8I+/OVNGlTMWWH
         glveWyra0FcWwjnojoIwAzWWCNACyTvNdRFctxY1L0ClXgRia0nJ7aA0BC8IB/kuQBN3
         Pj+r+anTktTiSy2dF3unKDZi5QJdbIEpr3+y+WwRAU9VsbXTYnltGnsmDCenf+WVBJab
         Uc/f4tASqK5hui6iQhES1/wQ3tn4JLbkW7lPDoaTwWFKP02oJTUmptnbNvSC7sdIZ0E0
         sFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/fmDyudl4ch4OP62eHQXqnVTVLm5jUqLhjp55PmzJvo=;
        b=QuILWkRP/6fCaB3/Wsqo11nT32ix5uVnwH2kDOHx8pkCgOquIjKIN6N10E0my0jsyg
         DKBARKaIPnCAxYV8k6sxC5l/FiPVYNNyMzfCuaGwDEG74V3erkICk1zSp6Td+6e5j+ge
         OB/fOSDlavRD0h5yCzWdTpvUlmlgS2XwFOuv9UnXIrbU1/RtcJh+Z0SG8kQHltfrPZWf
         iILqpwTXE2xYFK2UvZqZNsUUtItrJRJK6qHlVoUEem7VYPQiEZeLzpTLtiERHPRUw0V8
         4yC52uC7y26LukyZ4mr5LRf5TuRV1JWbCMBViyMidb52itU+6d5Bt1oepL+e35/5jirH
         o14g==
X-Gm-Message-State: APjAAAXJRyGlDS3oHiFSNOLKrm79kvBs4X6u24WiGdmKb9HBdkkQjyBa
        uB+R94O2JGX+vqN7J/IHhgNWkg==
X-Google-Smtp-Source: APXvYqxJ0ghvU9hcLu7YTY3p+AcV3t2y1ZX9SIluJdDl1sFi0V2JgVZjpV4KqrkTpI3HBiO5NV1fBw==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr1562536pgi.70.1565829625505;
        Wed, 14 Aug 2019 17:40:25 -0700 (PDT)
Received: from santosiv.in.ibm.com ([49.205.218.176])
        by smtp.gmail.com with ESMTPSA id g8sm815917pgk.1.2019.08.14.17.40.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 17:40:24 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v10 7/7] powerpc: add machine check safe copy_to_user
Date:   Thu, 15 Aug 2019 06:09:41 +0530
Message-Id: <20190815003941.18655-8-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815003941.18655-1-santosh@fossix.org>
References: <20190815003941.18655-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use  memcpy_mcsafe() implementation to define copy_to_user_mcsafe()

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/Kconfig               |  1 +
 arch/powerpc/include/asm/uaccess.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 77f6ebf97113..4316e36095a2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -137,6 +137,7 @@ config PPC
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
+	select ARCH_HAS_UACCESS_MCSAFE		if PPC64
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 8b03eb44e876..15002b51ff18 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -387,6 +387,20 @@ static inline unsigned long raw_copy_to_user(void __user *to,
 	return ret;
 }
 
+static __always_inline unsigned long __must_check
+copy_to_user_mcsafe(void __user *to, const void *from, unsigned long n)
+{
+	if (likely(check_copy_size(from, n, true))) {
+		if (access_ok(to, n)) {
+			allow_write_to_user(to, n);
+			n = memcpy_mcsafe((void *)to, from, n);
+			prevent_write_to_user(to, n);
+		}
+	}
+
+	return n;
+}
+
 extern unsigned long __clear_user(void __user *addr, unsigned long size);
 
 static inline unsigned long clear_user(void __user *addr, unsigned long size)
-- 
2.21.0

