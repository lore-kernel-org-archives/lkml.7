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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3463BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BAF20732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kio4pezu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKOOuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:50:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42857 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfKOOuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:50:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id t20so11039780qtn.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lJzGk9L/f6bPyPgYlAcUVdIxyQcpeRxruAGEz+vTV7Y=;
        b=Kio4pezu6ImCeG2mPNJ6cPi+B1BcudVnJhiprS6CAi5A8YzlqUWhO792FzvS8MrFal
         ksgM8cf9zP5ST2BhbT4/d7PIWE6RbQRpispbVKb810Sbg7p5CACIX8WL0/NUAp2l5KwD
         eUbMRsbDDVBIAoB/st4X7XDPXYVR4ryycYoUmgNHqqiPzRUyOl/LyCxzgRa7vW5PhQEJ
         8ssNa2FI9WSz69+DGdMlTNviAUEcrTzOUSsn4Tr+hhPcQT3aSpvB8NIlVnBpRba6te5m
         /z0+1ZDOV6MtL9wqaelZUJ+Bv9cLhvEst0qMN9ixi5UBb96emno5nZBco/4MSb3uCTQZ
         SI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lJzGk9L/f6bPyPgYlAcUVdIxyQcpeRxruAGEz+vTV7Y=;
        b=D7slwXLlSU3hylbQCCQaIFVXoTltz1IRtJoxR0bT/ugmUMA4xWxGCMd5+BEDNmXfGt
         R3Wig3dI+S6jLRYqX+lEATuT89tttbT3TC3PLCz2SSMkW9MhsxtllDo3iTBYYdgCcqnL
         LUNVrgwtIPQKgCuQ9re6CV+lwp4UYY23uYsyArJGwooRuKGskl1vTMXyyRYNbbPct3h8
         TEreHLKcq1Q9MKYB4RoVmxdDNJ6X9woh4uqiHtYVLcR0jrJ2eFkLnx4cvMGuxSDelHOh
         cppvivI39OA5XNooG9qidsdBYKD+W1AJltpztqzOU3R2S3NmBtI29u56wzIRX7P7zKkj
         U2kQ==
X-Gm-Message-State: APjAAAWWruu9YgelsFypcUY0cn9mp6TbaghNgNNrca51d3FI8oB5Oe4h
        knxoXKTOrok6AZjOC4Uf2A==
X-Google-Smtp-Source: APXvYqxPVD04HrF7ATil6Ea+ZZAB/kHds6U9F7YKwXNNfzjn9hxw10gw+PKCsKze4/ehSjYzwlweqQ==
X-Received: by 2002:ac8:1b85:: with SMTP id z5mr14017615qtj.308.1573829414000;
        Fri, 15 Nov 2019 06:50:14 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l124sm4329317qkf.122.2019.11.15.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:50:13 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] x86/boot: Add max_addr field in struct boot_params
Date:   Fri, 15 Nov 2019 09:49:15 -0500
Message-Id: <20191115144917.28469-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115144917.28469-1-msys.mizuma@gmail.com>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Add max_addr field in struct boot_params. max_addr shows the
maximum memory address to be reachable by memory hot-add.
max_addr is set by parsing ACPI SRAT.

Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 Documentation/x86/zero-page.rst       | 4 ++++
 arch/x86/include/uapi/asm/bootparam.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
index f088f5881666..cc3938d68481 100644
--- a/Documentation/x86/zero-page.rst
+++ b/Documentation/x86/zero-page.rst
@@ -19,6 +19,7 @@ Offset/Size	Proto	Name			Meaning
 058/008		ALL	tboot_addr      	Physical address of tboot shared page
 060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
 						(struct ist_info)
+078/010		ALL	max_addr		The possible maximum physical memory address [1]_
 080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
 090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
 0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
@@ -43,3 +44,6 @@ Offset/Size	Proto	Name			Meaning
 						(array of struct e820_entry)
 D00/1EC		ALL	eddbuf			EDD data (array of struct edd_info)
 ===========	=====	=======================	=================================================
+
+.. [1] max_addr shows the maximum memory address to be reachable by memory
+       hot-add. max_addr is set by parsing ACPI SRAT.
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index c895df5482c5..6efad338bba9 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -158,7 +158,7 @@ struct boot_params {
 	__u64  tboot_addr;				/* 0x058 */
 	struct ist_info ist_info;			/* 0x060 */
 	__u64 acpi_rsdp_addr;				/* 0x070 */
-	__u8  _pad3[8];					/* 0x078 */
+	__u64 max_addr;					/* 0x078 */
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
-- 
2.20.1

