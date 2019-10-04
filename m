Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174D4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D742321D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQl3gRnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfJDNpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:45:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39771 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfJDNpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:45:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so7304317wrj.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7b63lo7rprJBUkBEL3uR74RiIh2PXqTM31J1Ekw+88A=;
        b=QQl3gRnS5Y2PmQjDOkVC8P48bAmTs34sQHqLKCsHpepEjnrG80AXz057RggF1X5S1X
         iND2mq1+255/Z5jI8mTANxp8vSudP22ck7d9VlyeNFCghL/JRFTNlfHCISq8TZLDRPlw
         KC6oUNVorpN8wq8YY3JTedMe5ir93vheQ5GglHnfmRKsxkT68Q7+j3eGSKa21ZFHDVwe
         aHvcIEqpzjHpgjcqLEKxIJP9qnNcWEed5+xsv4P8KhAbT7e5RO9IbLrRS6ZeOFONXQQX
         7PrdD3p0Ib3eXKn+WVU2LYiZiaTq5sKNsBKB35D0dqTHpRGbo22Cly2+zfBSjz7HLQn3
         Auag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7b63lo7rprJBUkBEL3uR74RiIh2PXqTM31J1Ekw+88A=;
        b=tZ2skolh6txwLdqHPXrlixqS0wXDd+i9ZCVijZfXwGpoMTc3PpihByzU0yOAB4TT+i
         LWZEE0jSvMivB3gr+5gKGcIjn8rjToBbxNeEnJ06A7qjJkAu0kYYPacTzxA6EJJOeVB5
         GN2+VsenSfisL2Co9eZ8tUVii+1BCDlK3zzmMf4GI/cm0/6IqY9t2ymHfROzGGiWRgU6
         nDo1XYHWdwKpOUArEdlHDvZjZDa1XuVEw4r87sxuqlV9U0abgMqPEGeHWErn+mVRa6oQ
         CwTzixNo0+AQztW+Z4Ff6aLWtozWm9NrG60mZeUUWPShIz56oAP4sSKgmWVNVaSW9yVv
         yuGA==
X-Gm-Message-State: APjAAAVhvNqZwXSVTGMXRm4JdAkRNm/wrBARgNiBqQp+CjDbntYrsNKV
        0/DhwsL/74LvZ+Ipou4wllY=
X-Google-Smtp-Source: APXvYqyuH2pDK0ZacgT1Sh7w09n89xrwx0VUvlJuBAS7apBqNZQjvEdoMoytN4vk2JD9cA5eC/E8qg==
X-Received: by 2002:adf:e341:: with SMTP id n1mr7308483wrj.133.1570196748545;
        Fri, 04 Oct 2019 06:45:48 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a18sm11812563wrs.27.2019.10.04.06.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 06:45:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] x86/mm: determine whether the fault address is canonical
Date:   Fri,  4 Oct 2019 21:45:01 +0800
Message-Id: <20191004134501.30651-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We know the answer, so don't ask the user.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/x86/mm/extable.c     |  5 ++++-
 arch/x86/mm/mm_internal.h | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 4d75bc656f97..5196e586756f 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -8,6 +8,8 @@
 #include <asm/traps.h>
 #include <asm/kdebug.h>
 
+#include "mm_internal.h"
+
 typedef bool (*ex_handler_t)(const struct exception_table_entry *,
 			    struct pt_regs *, int, unsigned long,
 			    unsigned long);
@@ -123,7 +125,8 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 				  unsigned long error_code,
 				  unsigned long fault_addr)
 {
-	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
+	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault at %s address in user access.",
+		  is_canonical_addr(fault_addr) ? "canonical" : "non-canonical");
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
 }
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index eeae142062ed..4c8a0fdd1c64 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -2,6 +2,17 @@
 #ifndef __X86_MM_INTERNAL_H
 #define __X86_MM_INTERNAL_H
 
+static inline bool is_canonical_addr(u64 addr)
+{
+#ifdef CONFIG_X86_64
+	int shift = 64 - boot_cpu_data.x86_phys_bits;
+
+	return ((int64_t)addr << shift >> shift) == addr;
+#else
+	return true;
+#endif
+}
+
 void *alloc_low_pages(unsigned int num);
 static inline void *alloc_low_page(void)
 {
-- 
2.20.1

