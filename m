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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22151C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC3620732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4m/rf3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKOOuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:50:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45387 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfKOOuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:50:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so8255798qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 06:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/kvBFKQi677ga7uy55gslQEdaVWu0/AqECgiCr1RRo4=;
        b=i4m/rf3dtdO7pICpGohK+53jC1YnrR55j3yTG94ilzzFEn1CZNOi4xP3QLIzE4PU2V
         E31vLJ1dr52Pt6jJqef+kSoNsPScUouogqmP+hC4sRUtbonwaZGTGBYcjU9oanAgW9qG
         aw4nIid/3ZmQKnaeLr7wBynEWzFf3nbnL8QSxLAY7/SXpZ7bXv/H/Hwlsb0Pt6VvO948
         w9eicjB1GRQO1uiSE740MTNpwKTg8APZa+3qSt5Px2dYb2MkUXxRXLL5aswEKzjTUBoc
         ink/0aegyGu1D3EMHtv2iiSFnoTB/Q08T+B0cGq5PJzjz39YdeRz5ulaTUctCRFkIuHk
         bjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/kvBFKQi677ga7uy55gslQEdaVWu0/AqECgiCr1RRo4=;
        b=SvcgpJc5znxBW+BfKkYhwlKdZdDuY3LKbm4UuKp8lE96t3F0pLbbSsL+iFe75U7AZQ
         JJXAdUR6zDHA1IU3IcrSraRxZuXTmn1+0N/pYviWZGtIHb2wX899W4rKHjxCSuvniBkj
         Bxkt6Bvr/XoNOp+3BR15n6uni9gmcMmTDxZyAjhPau/E6S1NjEKxO74oXXWlkxHIju9H
         llf1mNSjp2PmL/9hHSJGmMJiuJwPspqaTl33pPZURtJ+37eE2qS33LTXnl2D9PfvQwNa
         u4VQmHuGzF1C0LChp0DXs2l8Wr2fVlIMRIO1dWgCxyWE1aeUhOCZuuysf/AHt/KaL2sG
         KjoA==
X-Gm-Message-State: APjAAAUwnPLk2RxCi6sWkxKkstGbAZ/uqvuykJ8suZha2eS0vcAmhPr2
        yxjGIQtuTV9ReSRYU5fSrg==
X-Google-Smtp-Source: APXvYqzf9IE+1GblOVI93LwlQ/+ywhezhVtH/XFIiHorjM6I+l34HIBgBTS69dj+7YdjMuMhyN9GCA==
X-Received: by 2002:a37:98c6:: with SMTP id a189mr12915499qke.230.1573829411024;
        Fri, 15 Nov 2019 06:50:11 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l124sm4329317qkf.122.2019.11.15.06.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:50:10 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] x86/boot: Wrap up the SRAT traversing code into subtable_parse()
Date:   Fri, 15 Nov 2019 09:49:14 -0500
Message-Id: <20191115144917.28469-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115144917.28469-1-msys.mizuma@gmail.com>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
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

