Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1906C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FD423A7A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="jLkO7by/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfHTIOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:14:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39783 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfHTIOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:14:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so2776513pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NE1NaEdbx0Ad3W/X+QOOKHTKwGbGj5XSKxU/TTh8Rxs=;
        b=jLkO7by/qqpf4wu4gnxFad8HAfnZijx13e7JCXngFfKNhppBWCuNHtQ2BgmHQ8y+Vy
         6aPyPYHjzBFkpNKM5IAN/IJg/97DsknLyRO1uSCiiqNyfwoLieZzEotx0ltiuA3RexkX
         MtcT1vZ5TRSgQDMg0lPH6/cdi84FchS5HSrHWDqOlHeUD2t4efEEKhyA6qKcpCEw1w/p
         8IpMKZ40e+RKRfzXEPVa/GksT1/NawzFT7uqEs2UmAaF4A8ffsbVmCIkIS37ElvPXUWm
         sKJM02huJy+XItD5+gl7g7ZojEgiCTHRFKFCWkfDzRwkdgbVyt4FrZZVEEegbwB3/62H
         ie8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NE1NaEdbx0Ad3W/X+QOOKHTKwGbGj5XSKxU/TTh8Rxs=;
        b=OhpifHm9xeIHkNegtdl3KvJ+A6zbCW8Sq5B9nVwL0/y0AGf4u0GOHrhzIIDEgb0oC3
         OS29vmHRsx5Er/q3odfcS3PiJJj4LMYG6N6aGpto50ACYSzvTz5GsCB4jzCy2RhjhiQO
         ag5/+foEsYo8DGd9CB+vPla5lacNX/tOgmvEJmikKwJjE1+3Vz5hXPkKzy83kflydhmY
         ZvZphEURApweinCC4uBeidi6orxQyLx0pPuk7ZG/TYidQ7+NU3E8k9+8Vj1IorObJLsH
         Gj2FLTHYL++lgtj2rKF72DzN0qP0OQPSilu52CyugpJylOy19T3cDlkpYA45M5/MAbTr
         IJhQ==
X-Gm-Message-State: APjAAAUpZvXzB7OGIa498Uk4GYiiV/7F3glrgDrw5TUgLWHI3hAiLuHx
        dbjAXFD1ZIFA9gRSr7K+nyaNKQ==
X-Google-Smtp-Source: APXvYqzpN38gKGjE+ZcnO/mttN0CxhXhF9Xrz9mularbw2JPZPVaRbCLw8S0D3gs210ontHmxlvYkw==
X-Received: by 2002:a63:9e56:: with SMTP id r22mr23610581pgo.221.1566288853307;
        Tue, 20 Aug 2019 01:14:13 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.78])
        by smtp.gmail.com with ESMTPSA id b14sm18949265pfo.15.2019.08.20.01.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:14:12 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v11 4/7] extable: Add function to search only kernel exception table
Date:   Tue, 20 Aug 2019 13:43:49 +0530
Message-Id: <20190820081352.8641-5-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820081352.8641-1-santosh@fossix.org>
References: <20190820081352.8641-1-santosh@fossix.org>
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

