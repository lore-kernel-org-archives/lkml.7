Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D5AC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A651920651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="MRFvu9yG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfG2EAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 00:00:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34396 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfG2EAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 00:00:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so21290315pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 21:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYoJ39RZguTRCAW4cRr4Uas+ZKo6lunMYQdFjdRdsTU=;
        b=MRFvu9yGIaq501dGo53Wv1aWIiI20JHn/6SaR94cUOslhI01cqY1OscbkEB4bafSG1
         NBkC5W3wF79PW6D2yVd4qpKhmZ7USzlCQqRymQ9bE4FPoKV03h8CcwNbFWVBOwH01Raw
         dxkiW1LSRNIFBAtarYOwUGaHeYtJLPLYhXGFXorjWP4nHNx/8BQHAp12B/bs50htbTEu
         kgPHDrtE1sz8OIZWcDDdTf2V1d7KesTjR3plDml/XAxwW7/fsvOWrVmgGMQb43vt/wGV
         EJ+3DucHOnenE4bsMxKp4tMZaw6jaERPpzvmtH7SeSgHa7Zdo4CZ7k+OT/tOlfHWD+HH
         y05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYoJ39RZguTRCAW4cRr4Uas+ZKo6lunMYQdFjdRdsTU=;
        b=qILsK+pXA6faA8ZY9UYITwt0BumKhcBFoTd++m7oINu4oN5ijG6HRT3zc7ajAof5ry
         JHlMyRItrNrH058vHAVH76ZObLptNzj4mjEa3qsiYtRuQVEVQcbex/Vl3k601RbDBTcX
         5ru0gs8W9rIcM4AsHzGH4KXW7OkS0sbar0yJtCyUyLHgyAChLFX4vqo9Snb5O8WPtjv3
         Ys8ajKWbagItygYD+roYUXqOb4TEgwauf8ah5zxF+Ht3ekGIlnpRKsp8eT/ghpHbyabw
         sC0RVLQpXSrQOKfsxnNll3v9QE1JqqHlHlRz/njPACzzqhiygirVr3+/8BXC+68FQrLm
         zFgA==
X-Gm-Message-State: APjAAAXzbCO9Z/y3iMc9LjR2gLQamODiBEfQCAjPxmUQzLH31vr38UBG
        xGdnV6713QhKa/vkhRMWrT0=
X-Google-Smtp-Source: APXvYqxwHDNnwSRWBDGz3KvI8+gl/wzLhz3CdSqZBPFmXcyEmav46uRKQPVHfO14UC8UXzFmksdBxQ==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr101944058pgj.4.1564372840933;
        Sun, 28 Jul 2019 21:00:40 -0700 (PDT)
Received: from santosiv.in.ibm.com ([183.82.17.52])
        by smtp.gmail.com with ESMTPSA id g1sm100033948pgg.27.2019.07.28.21.00.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 21:00:40 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [v6 6/6] powerpc: add machine check safe copy_to_user
Date:   Mon, 29 Jul 2019 09:30:11 +0530
Message-Id: <20190729040011.5086-7-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729040011.5086-1-santosh@fossix.org>
References: <20190729040011.5086-1-santosh@fossix.org>
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
index f516796dd819..18d831f52fa7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -135,6 +135,7 @@ config PPC
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
+	select ARCH_HAS_UACCESS_MCSAFE		if PPC64
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
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

