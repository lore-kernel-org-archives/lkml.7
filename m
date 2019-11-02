Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59742CA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303DF218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4w0sVaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfKBBJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 21:09:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34672 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfKBBJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 21:09:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id 205so11098561qkk.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FNEy2tjllNac7TGpNIeINoGyg9O8UmQJiFsXOS83HnQ=;
        b=X4w0sVaqg9YPTa4r/3IdKQbM6Q7uQgrNtPAnD6fQZWNMnj7AEBPdJpztW0I783FEP8
         og7zUjeee5qbyFhlU4eNdmC8qRCNqBt/p2C3DB/dHXG/lbbhyJeo53D0B3LPajYyP6hG
         Q0wSoPD6C3b3uWpcRZqPpGmZZC6PfT3yjglkVH5/Lk7sX43F3aCGwBaeAIi3nJMSwCzz
         IIFeRMUBkZt6fhexFbGaan9w8xlgwozSTZFm9t7/MLuBWea5L9+fR1lO86jgxaQxIc18
         7NUPdhuYFh9qkYK9LCFCF8i2B4xh/Vyi2v0IHrL5eARs0vERsWDH8DswwICGEWOnqrD6
         Cjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FNEy2tjllNac7TGpNIeINoGyg9O8UmQJiFsXOS83HnQ=;
        b=b60vll4d8MRC03Pptjl/WQLVqnvACYflWvpPeIaIZFhz9sFk7F0hotpfW3ciU6+M0V
         jhdMRxGrq9xyX1mHYdLYUrQG7UO/iVgSPuKeayqZ5JbvLmV5AUj2T8i1KXZJL9Qb3wDk
         r/vedWQlKTGWkR8hFutanFqRUbQgw9oiqr40z7RY+kOv5+0l+w5oCvbHgoG/OZYwffmO
         C7wn4XgYdBRypYY/7gLC/wsLdIktIPf8RkkW8I0TJ58v79RzMybfH4lvLsdtqDraNmY6
         S2y1HgawcpG3C/hMDGQwf4tIHxHOJJhPANR9m3Wih47ZxrkuYspGvACeG7zL2fa+awNY
         3/eA==
X-Gm-Message-State: APjAAAU31V+sN36Yc2CjrTWhn2EFdzKCm1nrfbKgne3SDR84Cw6S/Sjl
        HWBvxcjS/fwYTfhkCKeaSw==
X-Google-Smtp-Source: APXvYqwyUcyxPhSpvgEftBela0mdkIQwjd75/uve7d7WOZrJmnvL6NzfqI4coKuvwgrpRryNlUbBTA==
X-Received: by 2002:a37:6305:: with SMTP id x5mr13210163qkb.498.1572656974842;
        Fri, 01 Nov 2019 18:09:34 -0700 (PDT)
Received: from gabell.cable.rcn.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id i66sm4234340qkb.105.2019.11.01.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 18:09:34 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] x86/boot: Get the max address from SRAT
Date:   Fri,  1 Nov 2019 21:09:10 -0400
Message-Id: <20191102010911.21460-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191102010911.21460-1-msys.mizuma@gmail.com>
References: <20191102010911.21460-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Get the max address from SRAT and write it into boot_params->max_addr.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index a0f81438a..764206c23 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -362,17 +362,25 @@ static unsigned long get_acpi_srat_table(void)
 	return 0;
 }
 
-static void subtable_parse(struct acpi_subtable_header *sub_table, int *num)
+static unsigned long subtable_parse(struct acpi_subtable_header *sub_table,
+				    int *num)
 {
 	struct acpi_srat_mem_affinity *ma;
+	unsigned long addr = 0;
 
 	ma = (struct acpi_srat_mem_affinity *)sub_table;
 
-	if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
-		immovable_mem[*num].start = ma->base_address;
-		immovable_mem[*num].size = ma->length;
-		(*num)++;
+	if (ma->length) {
+		if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)
+			addr = ma->base_address + ma->length;
+		else {
+			immovable_mem[*num].start = ma->base_address;
+			immovable_mem[*num].size = ma->length;
+			(*num)++;
+		}
 	}
+
+	return addr;
 }
 
 /**
@@ -391,6 +399,7 @@ int count_immovable_mem_regions(void)
 	struct acpi_subtable_header *sub_table;
 	struct acpi_table_header *table_header;
 	char arg[MAX_ACPI_ARG_LENGTH];
+	unsigned long max_addr = 0, addr;
 	int num = 0;
 
 	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
@@ -409,7 +418,9 @@ int count_immovable_mem_regions(void)
 		sub_table = (struct acpi_subtable_header *)table;
 		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
 
-			subtable_parse(sub_table, &num);
+			addr = subtable_parse(sub_table, &num);
+			if (addr > max_addr)
+				max_addr = addr;
 
 			if (num >= MAX_NUMNODES*2) {
 				debug_putstr("Too many immovable memory regions, aborting.\n");
@@ -418,6 +429,9 @@ int count_immovable_mem_regions(void)
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
2.20.1

