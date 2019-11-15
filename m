Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03A0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A1E20732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZUF5+zH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfKOOuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:50:19 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43448 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfKOOuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:50:17 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so9624411qtn.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l+4mkyNeIAriOyBCvcPCL0FWxBlCR+Eo/bwv8rBr75Q=;
        b=hZUF5+zHmYT/d8V7di2HpG+vnWA3EgTCIrP4G0wRU7NeDZsZqSe9dd55qd2mRya3ji
         Qc3I/XiDPKPPJyPmoVFMRhcn5onmeSCP7ssi5OpQv487QmpwQHw+89zaODYpTXa0FBXv
         zxaCc/gdF5d2pET+7MyTtOL72PMda7ipeGOUgdUEAH0hXeb90ZXKlZJ51uVry8L0ft5c
         FOuCJCbYEXhcns7knXhOlBG5qmOoF9H/ncpDDCGVdTN+WVkRR2dktFNZIpevbiw4C7Ht
         K1aZ8QvZeAFYj2CGp9i0OksIzgAUnsc09a/SvonfnWlyx+1G6+bet6sdrlGvWMcbn7p6
         NGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l+4mkyNeIAriOyBCvcPCL0FWxBlCR+Eo/bwv8rBr75Q=;
        b=W0vZ503v578Brkcuai/A1HYZdeFR0y4A3bjL7LuTFSAbrXpQIgbG7PhyVB3MpXKbZp
         sdlnLUjHQaE0Jry3MwPYxe3/OtDhxWMHCrbhZ7LYHxbPI6HktIr6RIH1pSt2aMTVZnqw
         J4RasXvr27eW8eh6QRrahZ0LCTAOHcYmJ2sjHukbNS4cepv+xh6uti4WEsFyXpnbjvfS
         fILoaWvSheu/W93/+RPZ1Q0xlDgkP7okMVkxIHDrD56+AKGSvS4Okuh9AQ5byMQHgGMl
         s6GEHSXzA+tABVMpNkxySOz1YI7ROK9cSr/nc2dLS7LzQ60POb3SiJysWa5S7nqzI6e/
         +1aA==
X-Gm-Message-State: APjAAAW77ZrYG9tPO9dcZUweN1h10K6Bg4aQjEvuM32xWskRqPGrw6fX
        3eAt88Ya5n3QYvaRDhK/2Q==
X-Google-Smtp-Source: APXvYqzwpE8i+pIolZtNUclrU4Dad47PZRhH/Fg7eHcjKZD3cqYQNZ62WyIJKkR+V1ztTUZO6I9ZfA==
X-Received: by 2002:ac8:4a88:: with SMTP id l8mr13817252qtq.314.1573829416389;
        Fri, 15 Nov 2019 06:50:16 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l124sm4329317qkf.122.2019.11.15.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:50:16 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] x86/boot: Get the max address from SRAT
Date:   Fri, 15 Nov 2019 09:49:16 -0500
Message-Id: <20191115144917.28469-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115144917.28469-1-msys.mizuma@gmail.com>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Get the max address from SRAT and write it into boot_params->max_addr.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index a0f81438a0fd..47db706656e0 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -362,17 +362,32 @@ static unsigned long get_acpi_srat_table(void)
 	return 0;
 }
 
-static void subtable_parse(struct acpi_subtable_header *sub_table, int *num)
+/**
+ * subtable_parse - Cache the immovable memory regions into the
+ * immovable_mem array and update the index of the array.
+ *
+ * Return the end physical address of hotpluggable region.
+ * The system memory can be extended to the address by hotplug.
+ */
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
@@ -391,6 +406,7 @@ int count_immovable_mem_regions(void)
 	struct acpi_subtable_header *sub_table;
 	struct acpi_table_header *table_header;
 	char arg[MAX_ACPI_ARG_LENGTH];
+	unsigned long max_addr = 0, addr;
 	int num = 0;
 
 	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
@@ -409,7 +425,9 @@ int count_immovable_mem_regions(void)
 		sub_table = (struct acpi_subtable_header *)table;
 		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
 
-			subtable_parse(sub_table, &num);
+			addr = subtable_parse(sub_table, &num);
+			if (addr > max_addr)
+				max_addr = addr;
 
 			if (num >= MAX_NUMNODES*2) {
 				debug_putstr("Too many immovable memory regions, aborting.\n");
@@ -418,6 +436,9 @@ int count_immovable_mem_regions(void)
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

