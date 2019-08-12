Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6645C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BA020820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="e0nDDZkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfHLJXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:23:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41195 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfHLJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:23:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so38830673pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NE1NaEdbx0Ad3W/X+QOOKHTKwGbGj5XSKxU/TTh8Rxs=;
        b=e0nDDZkGKhyiN7ucCz0CdI9M1/9R9UME8nCcYwuYHM2dvmt9pHIIz0kVBZQMlKczx+
         p3/nBcij6anVq1eRVAuqtUNYvWmnL1/NASB4qEVMfVivaW2DcOm19s2dDP4t8XYxILom
         WYnMYtlAJJ03e8tE0K7CTnMFdrLOF+93r5ym689kXw1YjE+hEHlLCP2CNwRI6xIXV1oA
         v54rqtzCUCfYt92lnRiWkOJVstpX3BMkpuOWmMdef32vWeutbxfr2IM9+jJuO7pIG3bl
         z4OE7zB1kNIU4+MeCBps7LNBawhpNIo5j09tx6903NJlu69eLcYR4MUTcPZuhzc2SVX5
         PVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NE1NaEdbx0Ad3W/X+QOOKHTKwGbGj5XSKxU/TTh8Rxs=;
        b=VMiNBDT3mP2jj8N4CK9vpqvSzkd0KXqQ/lDiFyR86+m+/l6rmt6Nij89YnoLij8JdW
         37LMuVnryDgHvzxAbyEq1ZRO4j6YMDychG7yptVQt1Jh1a6Zqn1HBE+DJ5Bu3zHypLqV
         bEYn6PkFYZucrPMQuUsx0H2UUCKLz9LyQtYFHiBhSELv5hTlUfv74G8JKr3Q4I565091
         saDtbRKID7NzMSMb1xycExgzr39toWaHyh4KgOjaV//BEJB4pKCPAD398EFcuOVkFbkl
         /YShcT4h7QNcHIoXC3uIGJaZR/0easjmdVWEv97dfulr2Nztbyx9hoP4aZY3qEcCwE0i
         S2lQ==
X-Gm-Message-State: APjAAAU4652lO4qpp7EhW5YyX25Bzr6gTNsNvnJqnDIJTDi0VPd/EY60
        xbwFKmK/M2nKDHZFgljfMlU2d07baxpNvA==
X-Google-Smtp-Source: APXvYqzRCnFEuHoEbfb5ReRDBlw/PEuENuNyKapRe69MEZX2MkBDJynghVq3E/2gP2NsRcqf5LYJ4Q==
X-Received: by 2002:a63:e807:: with SMTP id s7mr28474428pgh.194.1565601786689;
        Mon, 12 Aug 2019 02:23:06 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.75])
        by smtp.gmail.com with ESMTPSA id y188sm10543517pfb.115.2019.08.12.02.23.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:23:06 -0700 (PDT)
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
        christophe leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v9 4/7] extable: Add function to search only kernel exception table
Date:   Mon, 12 Aug 2019 14:52:33 +0530
Message-Id: <20190812092236.16648-5-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812092236.16648-1-santosh@fossix.org>
References: <20190812092236.16648-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain architecture specific operating modes (e.g., in powerpc machine
check handler that is unable to access vmalloc memory), the
search_exception_tables cannot be called because it also searches the
module exception tables if entry is not found in the kernel exception
table.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/extable.h |  2 ++
 kernel/extable.c        | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/extable.h b/include/linux/extable.h
index 41c5b3a25f67..81ecfaa83ad3 100644
--- a/include/linux/extable.h
+++ b/include/linux/extable.h
@@ -19,6 +19,8 @@ void trim_init_extable(struct module *m);
 
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
+const struct exception_table_entry *
+search_kernel_exception_table(unsigned long addr);
 
 #ifdef CONFIG_MODULES
 /* For extable.c to search modules' exception tables. */
diff --git a/kernel/extable.c b/kernel/extable.c
index e23cce6e6092..f6c9406eec7d 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -40,13 +40,20 @@ void __init sort_main_extable(void)
 	}
 }
 
+/* Given an address, look for it in the kernel exception table */
+const
+struct exception_table_entry *search_kernel_exception_table(unsigned long addr)
+{
+	return search_extable(__start___ex_table,
+			      __stop___ex_table - __start___ex_table, addr);
+}
+
 /* Given an address, look for it in the exception tables. */
 const struct exception_table_entry *search_exception_tables(unsigned long addr)
 {
 	const struct exception_table_entry *e;
 
-	e = search_extable(__start___ex_table,
-			   __stop___ex_table - __start___ex_table, addr);
+	e = search_kernel_exception_table(addr);
 	if (!e)
 		e = search_module_extables(addr);
 	return e;
-- 
2.21.0

