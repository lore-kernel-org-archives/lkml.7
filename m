Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0663DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB77320820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="FXLvaXon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfHLJXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:23:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43314 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfHLJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:23:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so1612363pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/fmDyudl4ch4OP62eHQXqnVTVLm5jUqLhjp55PmzJvo=;
        b=FXLvaXonyVIAIIdHfE+h+/srPCOougwvG/jI7j3hLrjD+C6AvBOGYiXQTlTO3Dhciz
         MyxbG20eAjLWMBWN4CnSPXkbLzkzkKYnlueT8mDCN9+BjwJv0UShmzszeoBGKxhij0+2
         +mIQgoYUKWkHjbFK7l4Shd8rvC/LRZcYT0HQ6ERx0tOdtDHxn+3pwtXWX6PLTuhzvo2q
         M/5VtViQNupTnwfoqVDhPOxkPssGQaLTGHeEMtMazGK0nt7XOp1ZAlfDszbXjX0mMDc6
         TeEcKeGnLpzFp8CI7MYzCuCHoRRrgnEXJWqiZtcKLq3x4rTdSrYdsO1oNfN8Pl1j1bBS
         dhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/fmDyudl4ch4OP62eHQXqnVTVLm5jUqLhjp55PmzJvo=;
        b=monCgNGn2hy2j8qw5pbGdzaYoZ4rurx5JljEPoOJ5f91v446pFoTuP3+LHaM4UwFPP
         aopoSQdFFA1AJBds52c7nhYYYLr5dNvIN7RBLeOO38ljgrU2oTrorJM14xA0ENAkYQcq
         Xe848PNghK6SE9y7l6/vEzV003q8fj5I0mL/TW/NqyEb0L+wfeLL2q8oX5nX9dqU99Xr
         XG7KVf34e9MjWyppmvbKie3TEQCr2vp6CzbyZE0Mf9kqU4f9h4ct6Y1kuPofZJbWBm5+
         O6pqxxLSkf0ZiPVNXgqij7/KFJ0Klge4HdZdA3emNQCn5kgdQd5p1/uSTVzSzj+JlBUF
         qSgA==
X-Gm-Message-State: APjAAAWG1um/hPDGH0P3uJ+U0o+2VKSDpSH4QCMVqwbH/bAqakttzH3t
        WsM0yr2yoM5X9WuWN2ElIf+DZA==
X-Google-Smtp-Source: APXvYqzUbHHpKF9RpVY5dD8I56SMQRoVpK6MPIZYF1VY+Rqb0ousNfT7P/+4UDqPJ71fmRcBf+8VQQ==
X-Received: by 2002:a63:6947:: with SMTP id e68mr29764764pgc.60.1565601796914;
        Mon, 12 Aug 2019 02:23:16 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.75])
        by smtp.gmail.com with ESMTPSA id y188sm10543517pfb.115.2019.08.12.02.23.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:23:16 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 7/7] powerpc: add machine check safe copy_to_user
Date:   Mon, 12 Aug 2019 14:52:36 +0530
Message-Id: <20190812092236.16648-8-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812092236.16648-1-santosh@fossix.org>
References: <20190812092236.16648-1-santosh@fossix.org>
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

