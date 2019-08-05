Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C6CC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC37820B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="ofzpa4RM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfHEGXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:23:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33164 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfHEGXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:23:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so39085828pfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 23:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTlpYyZD/0q9aMn5q4HeUbQoatHU8kq64x9EtI8Wul4=;
        b=ofzpa4RMVAg9SEnJH93KWyT5+FnI3bDtLrgWsm3zOuSoKpwJefrzrWUNT5B8mPsCo5
         FHqW38pd2ClHxZp3vHitq4XQikfaDrcGann4aQk3idg3ZMoEdRPmo8Bh7u0SHZk9mnk3
         Qm/PWosgezMuZvPx/H1J4tRxnrFttBph68j+lK7tVvrHoeQ4gDxyiJGtQe8zjp/XvT42
         9WBBVjSoW3kbtpzPZJhWwNp5bQjwYoGN+p0v6Tqv+anrZTt6/9+6fwdl9DD+lVPgOqnd
         iKglAljvNwz+aLB/fzPM5QUO6O98NQV4eEY83+LDRp+m+svmXRJZAZ6PpoRZEQU0SUk7
         Anmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTlpYyZD/0q9aMn5q4HeUbQoatHU8kq64x9EtI8Wul4=;
        b=eeonzND4rsavpUTBYXggviyHPCKs9zbysi2nWrTfk+M9CVOCZyqiHvLM19RWZRkv2R
         L9fWgbmzYfQLXAlWMKf+LdR3RUcZB8rQGTu07ELU+6zudIJIcgq3Ah2Tkf6gZJF2cdjB
         9jD0vwkhUlVobBO3KLDZ4gQ+FnMXqdAbiOLnRp38Ul0zrx8g9UlhyPMLsWy52f3URrs3
         3VBUMdufzAihYBsz6x4mUd/ThmGx4apD3u+pj6lngJikl2GdAyFiMlotS198kHEz/wxU
         SFPPOmBuLLrOulg9js/O0vdfTRGzIeUzLP+9RVURcEQG/T/Ui/cF/kQnxXNGzC0dDJWh
         ebdw==
X-Gm-Message-State: APjAAAVXlDtoEFwF9a40GAxvvCgzmBiRHrSo7DfQVzehkp84try4WX1M
        LzURYMPMThL/atLALCKt4QPoFw==
X-Google-Smtp-Source: APXvYqx2a53J7+K3AmO8itomjLV2KyMw6dQquJOLFFdxZSKfiDrkTVsqjyaK3xoFqKxYlp7ye3PD6A==
X-Received: by 2002:a17:90a:7148:: with SMTP id g8mr16739525pjs.51.1564986179854;
        Sun, 04 Aug 2019 23:22:59 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.66])
        by smtp.gmail.com with ESMTPSA id i14sm124680082pfk.0.2019.08.04.23.22.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 23:22:59 -0700 (PDT)
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
Subject: [PATCH v7 7/7] powerpc: add machine check safe copy_to_user
Date:   Mon,  5 Aug 2019 11:52:25 +0530
Message-Id: <20190805062225.4354-8-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805062225.4354-1-santosh@fossix.org>
References: <20190805062225.4354-1-santosh@fossix.org>
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

