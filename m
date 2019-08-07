Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821B9C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CDC22293
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="VZdtHgLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbfHGO5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:57:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43960 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387915AbfHGO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:57:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so34214878pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTlpYyZD/0q9aMn5q4HeUbQoatHU8kq64x9EtI8Wul4=;
        b=VZdtHgLyYvp56/GWYUxjZY/HaPlw9IM6uayBv0L1h1rXX15pZv6wRLUAO/v/Np+e+/
         mYCkXklk7PCjJYlj/tzE6KbgGjYydDU9b7dpBSN76wMDMI2gAgLjGCvEgpJPIkQNeucw
         LaC7Zguwv8tmyIntCUvnBpfdikKNpME/X6nJOElhwOL/bLgoT1ZdRkgklU8OKyaL/p4/
         McDkB0A/rys21D8xNiYsUFsCPcaC0XV6n+cG0amBF9IZKfwZea9q92VkIwtTF0D238NV
         Zh4XSwH8ILNtTkp/PXHX+l94uUQaH1D45lpk5osGRx5osFfWCO9VGd7dsWy4yahkdPGi
         /ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTlpYyZD/0q9aMn5q4HeUbQoatHU8kq64x9EtI8Wul4=;
        b=KEuunprlRu8GV4F8G4ciOPaf3gz4GJUOJTsDs36I43CMYUa9w47MLBu/1GZTHWKLoF
         yLK9DWbVXc71ZwhtbstU5uJ52rRGEbziEBT6+TrAu8/YA8UkUvrc4Wt6oPTRBeE+c0jK
         km41A/2oVl9gdQgZQO1rkqF1836/jYucFqn/C9w/7Wyia/+lFPFpDxaPtWFkw0aF1+wp
         iJDo2G7K34ikgJEloHHNynAhjqx/GU3WIk2fGc/liNfXcohnFJNGTuFsCZiDE2Ik3HS2
         mpVRaq8NGGdn+K6ac7wMNxEPT4YZj2zrn0++6UZNe1UCwvKH0SwoTpVxKHl20drdpjD4
         qg1A==
X-Gm-Message-State: APjAAAUUg2jUYXkYT7cBhfP3xrdBu57PIpVnKpXASf27V+28ZeaiBdXj
        D7RWeVQETc8Bn2IqVYqm7dybtA==
X-Google-Smtp-Source: APXvYqzqIPLLTzFhaDtVk7gn/hoCZP25Z5oJBF0C5S3MYQQWUzHXCXpS9TJiUqegIGn4gwfPaEj9fw==
X-Received: by 2002:a62:5253:: with SMTP id g80mr9639856pfb.179.1565189858724;
        Wed, 07 Aug 2019 07:57:38 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([183.82.17.96])
        by smtp.gmail.com with ESMTPSA id l4sm93617475pff.50.2019.08.07.07.57.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 07:57:38 -0700 (PDT)
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
Subject: [PATCH v8 7/7] powerpc: add machine check safe copy_to_user
Date:   Wed,  7 Aug 2019 20:27:00 +0530
Message-Id: <20190807145700.25599-8-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807145700.25599-1-santosh@fossix.org>
References: <20190807145700.25599-1-santosh@fossix.org>
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
2.20.1

