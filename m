Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D5C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E0421835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNvFyTAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfLFQ5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:57:33 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39734 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfLFQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:57:31 -0500
Received: by mail-qv1-f66.google.com with SMTP id y8so140542qvk.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l+4mkyNeIAriOyBCvcPCL0FWxBlCR+Eo/bwv8rBr75Q=;
        b=GNvFyTAU6v6aXSQWFKL0VuXC2dEXOok0bp4rkLsKKc1mrqq3AD4IWT8hY3mHdf/Awv
         yBZKhIUZgTHkAwkDJBIRuZRfTqLDLmho+s9CaQC2Ntfs9gShEoGUyc7cOGVpC2etN4Ue
         bWcI6gyfa4bh0tlk4sFfQKX35RVAmAK58tvZ3H+LsCVQu6XJRl/KdOAZZlyLVGLTwBPC
         ltsKVWM+CiOsSXv7Ic/rFkZ+qfCxZLh33yNnxjytBOD3Doa0FJYN+2lzHdjfecbpu6ZG
         I36bHPZRpPrqEYbXaxTVNIvU6zPtJyNNWYeQnw3GeKB9HoKG9JUy5UHgemEGEIQZMabY
         Ps9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l+4mkyNeIAriOyBCvcPCL0FWxBlCR+Eo/bwv8rBr75Q=;
        b=DIo8vNy3NApeWp89yblW/fjCwDo5BRnrOzvrs9LW6JVAUVx4adgjuye33uRvpT0e5i
         xcUK96aHazSxoCELhUj6vWHxbPTMFzbuGWt7r6367c/43E1C0sMN/ml6MJAyc59HDZjH
         XHjCSX5b8UhqJ8xrEct9liuV0Tlx/3522dNSKVIcIvC5IZiiLr67412xzFv93lRpjhQJ
         tfvbUEZK4ljPtZz8BM6ZfcJ5DoWix7RDVPXH2++SeSm7PPUaomca79BTBGvFdyvkDWCE
         6vS6ZGQSgAGVJuItu5J/4Lnhn87MlWZocRbuBb6XyVumJ9I+AHWAnIy1XyLleWA+L6ld
         BwWQ==
X-Gm-Message-State: APjAAAVRZNrVnvcH1qFafSayZ6DBnBvtnmgE2ECsdrh2f1+jbCKomIpA
        wEFdq5ee4PBst6G3qycr3g==
X-Google-Smtp-Source: APXvYqzP02vYEztCRv3k64AwB8k1FT05immmIt3+5IRzko9VEccNNPbPPHkbG3h70zIAjnCB+teSeQ==
X-Received: by 2002:a0c:92c9:: with SMTP id c9mr13598384qvc.168.1575651450760;
        Fri, 06 Dec 2019 08:57:30 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y28sm6531373qtk.65.2019.12.06.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:57:30 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] x86/boot: Get the max address from SRAT
Date:   Fri,  6 Dec 2019 11:57:06 -0500
Message-Id: <20191206165707.20806-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206165707.20806-1-msys.mizuma@gmail.com>
References: <20191206165707.20806-1-msys.mizuma@gmail.com>
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

