Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F0EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A2D23A84
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="FAC88M3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfHTIO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:14:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41009 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfHTIO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:14:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so2907124pfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHTQPelRXoeGRxk9/7QApa3hD+2cD5EffZTn9akbQbg=;
        b=FAC88M3xyO1XNTfnXTZeE2URUxDYQSdUEBxzuzqVjNiG2EIBREa7IcVO0JaXk1TN6N
         +Fc7WDfSdFhc8+r/dbDczub6YKzQyAsR5aQELTD9pGe68hw8INSwRolMbOi7kiCQAO6Z
         1d1gQd92zkfmA7suA4NHPmn23U9T2YW7oU/8AzahKurgzk4r1XoUKjmCS13liO/7drWg
         Y+zlMuyVoWjWrC4X/Ze9MxJ/R8oqt2HU09ksut5VqzIwSJ649g21pc/zbN/3CzPONaEp
         vmzrL3FCOLq9B5KdekqZOBnd7jzKy1A6AoKJiUuYrJopy1aqMSVAtYQWXs1MjECElQkm
         4SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHTQPelRXoeGRxk9/7QApa3hD+2cD5EffZTn9akbQbg=;
        b=sy81EI8VUwp8DpnxSjmmScsi1/dqjISjrHHqwoIsmIEhIHoOkfJrKCsCqhh48YA5/r
         UmjKOTEyR3t1k1SeuU28UU4dj0pqnPmD2TSSZmVvi3NT92XpBZH2UiG1dIyfWC9kLB2t
         mIgPe8BOewG4NSp1hPBELkQvQMPdrcZP3mPP+mY/5DjQy/HGvIyD+Z0lvYGpvmXWcoJT
         gENr+HniU5fEFJfOw4cYe4WkamRk+G2FRQM0GEZhVM/Fpfj8rswmu71ft3ebuuP8Pgox
         mumPQsDlYWkXpajvIUvY19kNWjyWzzSBnQ+UsyYAB9icdp8T5PzNh9FTY8zBkQGa34Nx
         wkrQ==
X-Gm-Message-State: APjAAAX7nbjRANJqg3PNNG7C8901qdwN8iDNmfOquNdLqMnYciz0F16p
        3hPHVukRWMxFofKcn/X6kOSMmA==
X-Google-Smtp-Source: APXvYqy4FSoccV/iKHaOcV7FENxh9+ndEv+zxT0iBqRlg8hAyNtDrU/eQSMAicaHNg93qFUQsO6rhw==
X-Received: by 2002:a63:10a:: with SMTP id 10mr23784675pgb.281.1566288866620;
        Tue, 20 Aug 2019 01:14:26 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.78])
        by smtp.gmail.com with ESMTPSA id b14sm18949265pfo.15.2019.08.20.01.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:14:25 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v11 7/7] powerpc: add machine check safe copy_to_user
Date:   Tue, 20 Aug 2019 13:43:52 +0530
Message-Id: <20190820081352.8641-8-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820081352.8641-1-santosh@fossix.org>
References: <20190820081352.8641-1-santosh@fossix.org>
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
index d8dcd8820369..39c738aa600a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -136,6 +136,7 @@ config PPC
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

