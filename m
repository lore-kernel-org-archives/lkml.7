Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C088C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DE123717
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0jOYzoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfH3VsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:48:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37240 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfH3VsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:48:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so9289762qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fy5a7OM3WKipJOb0pBIkcn0k9cPfYCaCEfNLlMDhAqE=;
        b=V0jOYzoo+LfyKBY3IERIzxQAZSePtXTZn83TzwZ3Nibc1uBECOYUBSSlHgLrh0dicE
         Ccb85Ia3gTMV4m64kRj2DPgaEIvHEfNzD1ICbNBeJI88oyhLbObzuNMgSKrXsr8JSwdu
         ahJuws4eelDBSRAFCPf6Rfvo40Pa5cfhsfDt+SA6EBTjMtVL77D63RIM3Bj/42GykiIt
         mvhyk12oB7miyz8vvM1LZA2Y+KYwdjKm+uo3XxXn6J7u/Sq4rlJ9L3h8gZBqefU7GGIt
         q4HWbyzvU0NWnRoDz6syVbvsL21ivGHwZopJPm6m36kRiEOo2wkfDiueYBrj7PI7UwON
         guuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fy5a7OM3WKipJOb0pBIkcn0k9cPfYCaCEfNLlMDhAqE=;
        b=WgEl+pbI1uQhq5CtyBeC+N8y/ALy088mnrOmjKdTNtyKrxUpZ3mIaboPUK05d842D+
         c8a9YrhmLa3VCCeRWv4V72xHOEMZBISsKvGLLITVUtIMCTJPZsXgwrTtV3h34MBxMPmb
         h+B44mj3DKWMYiajxjCpz/9XjbM14hA8rk20SOK+HYrUS1QGCibx68Yv9UpYXdc69V17
         1sUc7oQB1IZdJFMdABs4MalZ2v0Q1nVDzXiIOmWwii5qoxZKBDdaeYlP/PDK05cg3Ssx
         7KfOCWPsUnV6QTGAj+YVcS0y1xjiAqV0Zb/OT1dI3wu6xs4Ak6eML3LczYEqK3FSHJKb
         Xi7g==
X-Gm-Message-State: APjAAAU/QPMdD4NocBtqbEiT3iBJtJ0wlTon9GooEAyK2y6BS3dpmAXw
        L9E4NKePDvPGTJOsddKdMw==
X-Google-Smtp-Source: APXvYqxY2hPF6twppIW1bsNq800xKUUB6mZwSm4nE0LNweg1cwdygGw7Bb+rqh//qRv5Gwf9hFGwUQ==
X-Received: by 2002:ac8:6bca:: with SMTP id b10mr17055522qtt.254.1567201681902;
        Fri, 30 Aug 2019 14:48:01 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a4sm4857834qtb.17.2019.08.30.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 14:48:01 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] x86/boot: Add max_addr field in struct boot_params
Date:   Fri, 30 Aug 2019 17:47:04 -0400
Message-Id: <20190830214707.1201-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830214707.1201-1-msys.mizuma@gmail.com>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Add max_addr field in struct boot_params. max_addr shows the
maximum memory address to be reachable by memory hot-add.
max_addr is set by parsing ACPI SRAT.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 Documentation/x86/zero-page.rst       | 4 ++++
 arch/x86/include/uapi/asm/bootparam.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
index f088f5881..cc3938d68 100644
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
index c895df548..6efad338b 100644
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
2.18.1

