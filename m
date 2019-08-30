Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD65C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9292087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsO5zQPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfH3VsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:48:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44692 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfH3VsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:48:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id i78so6050376qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVV2lnPwOeX0GLUaJ7vmcH2fqnxehztPL1uAZs7p67k=;
        b=UsO5zQPFVoEncEhyBWusu7AbBJG0hM5eKksQ5djE5aKLAhKfy7+vWv2eCIxIheWe3I
         s4QoGnOPidtTbwF1cL+W2bC7g/EGoeZJQxaAC+s3GEDlyaRKlsGDlVSBJYIaq1niVQhQ
         005UqMPzL1TC+r5CuMTb0fmifJnw1dTLm5D3LgVJyP8d+TwbJP5kdpckG27JOWVRT66/
         zfHbu3nF3zsunx/nW8xSNq0yUzNn3zzrO4rZKKyCIKi1AAq9G5QZg908kuHy4E7iByUT
         AhOAd8mhX2UY6GbJ4DhDaNUEsuMejaZGeXkCGSiE4cpxVXMJY2jV8NUdq5ni/+QogGMv
         ONoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sVV2lnPwOeX0GLUaJ7vmcH2fqnxehztPL1uAZs7p67k=;
        b=IW7q1jwJ9xJpu0OUEurH6TL0VpJE4B3qV3s4VheL+AsopjEya7K209g4kKEE29fKHD
         k71du76QhxKRway/M5W9JCVIuz/fC/QwdR70laUKmu3deuFVKUOb6vtzw9IrA/9Mlmx1
         bCVE6bkkOiK8fo+3IIghQLHrT+YRWQbNUUd3hIB/yQVz9aH/9CEsExwr3RTXiVgE+R4x
         XCuiD6dHJVaXv2vErsfxo1dvU1m4e3kMksYwbcrR1aQJTtNfwk0lzUFcxKVp9vNOTR9o
         U6pBZbDbsLov/anS5xy1GvBkEpfiUU3mqPqu9Ns35dTIQM6sPV0Udh6U+2qujNXHjiWc
         LUJQ==
X-Gm-Message-State: APjAAAUFpHAdv4ghE0X5GZDHjAiTk9rjg1ID1yhkwtL0RcDL+hlbpwBg
        e7zMeakv34zXdaBup88eZg==
X-Google-Smtp-Source: APXvYqy67RFjdYEffeMRZhf/gnFZYzoLg8yOTGwCBTYZfKG1V4FwmMif6ic04AMJsnI2yqKwghwViQ==
X-Received: by 2002:a05:620a:126c:: with SMTP id b12mr18299361qkl.177.1567201683411;
        Fri, 30 Aug 2019 14:48:03 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a4sm4857834qtb.17.2019.08.30.14.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 14:48:02 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] x86/boot: Get the max address from SRAT
Date:   Fri, 30 Aug 2019 17:47:05 -0400
Message-Id: <20190830214707.1201-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830214707.1201-1-msys.mizuma@gmail.com>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Get the max address from SRAT and write it into boot_params->max_addr.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 908a1bfab..ba2bc5ab9 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -362,16 +362,24 @@ static unsigned long get_acpi_srat_table(void)
 	return 0;
 }
 
-static void subtable_parse(struct acpi_subtable_header *sub_table, int *num)
+static void subtable_parse(struct acpi_subtable_header *sub_table, int *num,
+		unsigned long *max_addr)
 {
 	struct acpi_srat_mem_affinity *ma;
+	unsigned long addr;
 
 	ma = (struct acpi_srat_mem_affinity *)sub_table;
 
-	if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
-		immovable_mem[*num].start = ma->base_address;
-		immovable_mem[*num].size = ma->length;
-		(*num)++;
+	if (ma->length) {
+		if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
+			addr = ma->base_address + ma->length;
+			if (addr > *max_addr)
+				*max_addr = addr;
+		} else {
+			immovable_mem[*num].start = ma->base_address;
+			immovable_mem[*num].size = ma->length;
+			(*num)++;
+		}
 	}
 }
 
@@ -391,6 +399,7 @@ int count_immovable_mem_regions(void)
 	struct acpi_subtable_header *sub_table;
 	struct acpi_table_header *table_header;
 	char arg[MAX_ACPI_ARG_LENGTH];
+	unsigned long max_addr = 0;
 	int num = 0;
 
 	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
@@ -409,7 +418,7 @@ int count_immovable_mem_regions(void)
 		sub_table = (struct acpi_subtable_header *)table;
 		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
 
-			subtable_parse(sub_table, &num);
+			subtable_parse(sub_table, &num, &max_addr);
 
 			if (num >= MAX_NUMNODES*2) {
 				debug_putstr("Too many immovable memory regions, aborting.\n");
@@ -418,6 +427,9 @@ int count_immovable_mem_regions(void)
 		}
 		table += sub_table->length;
 	}
+
+	boot_params->max_addr = max_addr;
+
 	return num;
 }
 #endif /* CONFIG_RANDOMIZE_BASE && CONFIG_MEMORY_HOTREMOVE */
-- 
2.18.1

