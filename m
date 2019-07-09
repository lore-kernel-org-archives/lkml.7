Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A665AC73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B2E216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="WEJjn3sL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfGIMQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:16:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35525 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIMQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:16:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so9996564plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/D6q9IqqnCEzUrYRXPENA3CK9dVtXBM9qraf2QWS3cw=;
        b=WEJjn3sLVMMM3G8F3q0pi5X+7zVo+wy1uS2MncY8uprFUFCsiDqJn7M0uGznLEo9k1
         zTWo+dAv6u+rHQ4QFhWqEAEKtkPFA5bxtJ1kmTL6PVrfjoDjGnOpwZBu+UcLaES1NRuh
         jp4rGE4KUTOIVMa9e+XvozV5BvHS/2k5bBSW85BmmIBbfmnk7NInLhR2SLvCyeTWzoWD
         ZTbFqdJajckNS54NRHSMJKq0VZ3cK4JUqET1JUmUqRs1HUaefEkP0LasrySTbpnFg6FJ
         pSmjS1GiBLfd1kD82Lco3aQyd2FeOHcB8o0pj9a0dKmK2zr0UV0qoVqgOCcCu1M8SIcD
         +7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/D6q9IqqnCEzUrYRXPENA3CK9dVtXBM9qraf2QWS3cw=;
        b=CC56Ichk0TLHRAEtoWaAijSVbEiacur5IDKrvhSctnHkfGPM1N4BSMKPxJjBi6LS4v
         HsC1PYv3IOO563LSEvxrHLZXdNJ/4DDy0C2uY30K20I3KVLp2aiB7umjQhwSa5ez3hRT
         OrKySx05eIN+ZMikRDEMNEqvjomy1DFmW3Pt8IOUJ09H4UXjfaIG2aFZHzljiaQNQCoA
         wei2lJ62HKxiSwgE6NdEMH8qh279lD9VsGDbVdkPxqawpnmWia1wpxMntzeFoiZ8zmDF
         LmuYdH47ml6gUnGaStj4ux9120ekMiqebT5UitSMGZ9q0/Ncd92tDsTpmf72sPInAJ7n
         4Ikg==
X-Gm-Message-State: APjAAAX5xKuRVOVBmhXBa0+NYoHEyxKyBu4Kv2bwHbAelgajZ0aphi+j
        hoccCdP3cG9Ye2DvJo6BbC41Qw==
X-Google-Smtp-Source: APXvYqxLH/fsm+5ph64L/SdYOrJ1SjqBJSSYJsWOK2/V2bl4VN5e1fFMneN0NSUGDoXmU6TsAaIQkA==
X-Received: by 2002:a17:902:204:: with SMTP id 4mr31128589plc.178.1562674563091;
        Tue, 09 Jul 2019 05:16:03 -0700 (PDT)
Received: from santosiv.in.ibm.com ([223.186.121.175])
        by smtp.gmail.com with ESMTPSA id o15sm21243933pgj.18.2019.07.09.05.15.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 05:16:02 -0700 (PDT)
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
        christophe leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [v5 4/6] extable: Add function to search only kernel exception table
Date:   Tue,  9 Jul 2019 17:45:22 +0530
Message-Id: <20190709121524.18762-5-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709121524.18762-1-santosh@fossix.org>
References: <20190709121524.18762-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In real mode, the search_exception tables cannot be called because
it also searches the module exception tables if entry is not found
in the kernel exception tables.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 include/linux/extable.h |  2 ++
 kernel/extable.c        | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/extable.h b/include/linux/extable.h
index 41c5b3a25f67..0c2819ba67f0 100644
--- a/include/linux/extable.h
+++ b/include/linux/extable.h
@@ -19,6 +19,8 @@ void trim_init_extable(struct module *m);
 
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
+const struct
+exception_table_entry *search_kernel_exception_table(unsigned long addr);
 
 #ifdef CONFIG_MODULES
 /* For extable.c to search modules' exception tables. */
diff --git a/kernel/extable.c b/kernel/extable.c
index e23cce6e6092..6d544cb79fff 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -40,13 +40,23 @@ void __init sort_main_extable(void)
 	}
 }
 
-/* Given an address, look for it in the exception tables. */
+/* For the given address, look for it in the kernel exception table */
+const
+struct exception_table_entry *search_kernel_exception_table(unsigned long addr)
+{
+	return search_extable(__start___ex_table,
+			      __stop___ex_table - __start___ex_table, addr);
+}
+
+/*
+ * Given an address, look for it in the kernel and the module exception
+ * tables.
+ */
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
2.20.1

