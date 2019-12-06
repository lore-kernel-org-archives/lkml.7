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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256AFC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBDB2064B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6zOpJSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLFQ5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:57:31 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35902 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfLFQ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:57:29 -0500
Received: by mail-qv1-f65.google.com with SMTP id b18so150514qvy.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/kvBFKQi677ga7uy55gslQEdaVWu0/AqECgiCr1RRo4=;
        b=m6zOpJSM8yCyfTXahxG+OL8+V57Vx6gFwau0g6LXxOvALmUvIKTagAfW39yvzxqGNL
         TjBpm72RRL0Ww/yzjWMdK+uaaDnUQ2dzuQsAoe/6NUn1VxI95Vz2lWvFaz+FUZrP+/Uc
         OkmXYG0LcAYv+WXfe0XjiVrC0SelB+kkZMXLf+Oo2z9ICorZWiIRWt4HqCtB8dj/VDUB
         87+VYt1PYSsRRI+3T5tdBtXY+Aa03P2l7wb4/IAQZnS74bzthN0pYWCSdelJFTbuIpoW
         BtET0oFC9qi50hjPdLYYAs3Rg0GBGwmmgqyM5cglL0wnGPyeQQ7g2wU9YNco6WcOnhv0
         BwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/kvBFKQi677ga7uy55gslQEdaVWu0/AqECgiCr1RRo4=;
        b=Tk8lRsNvKXG6ivHwdnd2gw/HonS6I4uC+5wxtwznAY6CzJmyS8bBNirS8++j26v1UP
         r8YVHwFATKjS7B0WyWYXBu6059i1sTBfIXLoBGQDJVWDjM0NrN5L6/r4rQ4UM9Y6JXFt
         gsWChkm+tnafK/KgQZaMQMu/qxvXCvwlFs0OXBd67rvFNvWNhFUwQqmEj+dyFuL0Yq/j
         h24Y3wZaSiQfeVsWRtiSL/+3kuGjxWxHWQeDIuNz0XB2hQJr4nfBj5P19YoO7n80B/ZV
         +hK3PtCu4mwrsrXyXvbMExI6FdHIUR/sF94TKKckcYzptKjoPRa5jGJVfCIDeqXeGGi8
         TSrg==
X-Gm-Message-State: APjAAAXLTZnJCygo2G8wnbxmOmSmCSf12jXYqoQgcH/WbdXDg9UMCqrq
        g/sDYvU+TmsxUaiA2gi9ziYC6RI=
X-Google-Smtp-Source: APXvYqymBvd/1/AxoAWKH4D/DsXpniRWT1qj+AJV7blzQm6b/wWqMBwBLoT7ab/8K0ssXhLBLH3JDQ==
X-Received: by 2002:ad4:478b:: with SMTP id z11mr13422754qvy.185.1575651448568;
        Fri, 06 Dec 2019 08:57:28 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y28sm6531373qtk.65.2019.12.06.08.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:57:28 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] x86/boot: Wrap up the SRAT traversing code into subtable_parse()
Date:   Fri,  6 Dec 2019 11:57:04 -0500
Message-Id: <20191206165707.20806-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206165707.20806-1-msys.mizuma@gmail.com>
References: <20191206165707.20806-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Wrap up the SRAT traversing code into subtable_parse().

Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 25019d42ae93..a0f81438a0fd 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -362,6 +362,19 @@ static unsigned long get_acpi_srat_table(void)
 	return 0;
 }
 
+static void subtable_parse(struct acpi_subtable_header *sub_table, int *num)
+{
+	struct acpi_srat_mem_affinity *ma;
+
+	ma = (struct acpi_srat_mem_affinity *)sub_table;
+
+	if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
+		immovable_mem[*num].start = ma->base_address;
+		immovable_mem[*num].size = ma->length;
+		(*num)++;
+	}
+}
+
 /**
  * count_immovable_mem_regions - Parse SRAT and cache the immovable
  * memory regions into the immovable_mem array.
@@ -395,14 +408,8 @@ int count_immovable_mem_regions(void)
 	while (table + sizeof(struct acpi_subtable_header) < table_end) {
 		sub_table = (struct acpi_subtable_header *)table;
 		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
-			struct acpi_srat_mem_affinity *ma;
 
-			ma = (struct acpi_srat_mem_affinity *)sub_table;
-			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
-				immovable_mem[num].start = ma->base_address;
-				immovable_mem[num].size = ma->length;
-				num++;
-			}
+			subtable_parse(sub_table, &num);
 
 			if (num >= MAX_NUMNODES*2) {
 				debug_putstr("Too many immovable memory regions, aborting.\n");
-- 
2.20.1

