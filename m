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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93915CA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69194218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQQz/Hcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfKBBJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 21:09:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39657 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfKBBJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 21:09:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id t8so15401254qtc.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l7KQ0hMK0q2lU7vW/DT7BMNIzGBaNDHX7UYuOkOBQN8=;
        b=MQQz/HcxtjYg0GJMoDgO8m0eO8SEuAOMIoUmabtgIuW2Z/pVaeTAgrJ2g1ivBNl/JQ
         ClhyxB/cloisuZOuPmYH86/8/WWtCKl+UE08TVRklyA3psgtuyuHTthwdojhzB3gNZR3
         6IxuNO0Sv0hVUri9TKwpVg0TX1HsFr3OzC3EL8EMcH60ZmtYq+zm+9NrU8K350QYxvl5
         JBBpeA4Y6wYpS8uFEPLZYlbTn4oTmkVVqmzlu5pjYsFPbBrRbyHVOZquo2t2l46hbaV2
         c24KuRTSuFf0oucby+tjY7ccDXLw8tBBuKfi3tLLEI0bAZ1ukNXHTqL8OgmaU9YJLAg/
         Ex9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l7KQ0hMK0q2lU7vW/DT7BMNIzGBaNDHX7UYuOkOBQN8=;
        b=UDcP706mvIEel5apahwUMYZgvkO5/ECl5ad9L/R+hLB/1deEIUhMKoy8XXD/qOn+ge
         ISqByX+TVFaYtRKJ0vZHiu3J+1uX64SdJmDcWg5dkvvadTvbhLs9urXHmg/YsFsEKFxl
         +fjxx/jhj9RrRudl+AjLXQKb/3jyM5lT3Sf0wE2jW1cHcRlpGqEelLNvGKDr35tq13qR
         JNDb+ouEgjZBzjH0HR1WhM6A9PD6LnM7LdS2l3rREgKjxIzHTlIAhRETvdObMXM/Feds
         Ru6jCiwgmTQQx+oOEMpMP+toJTzJ5CcA/h4HKurjbOa3iTvGPSlVoshFALgdKwRhC75e
         j+eQ==
X-Gm-Message-State: APjAAAWmVikIhDz9wjzlzUgJ4V3NdnS3ONE1vNKMSEbue/W6TkRc9DQb
        Vu2FCwdLPdMthRM3TS/Gjw==
X-Google-Smtp-Source: APXvYqzWYQhU1xNxgw+DZJwqF3YKuTIyVxW33Y8RUWL/o5MGjLkvqNKflJO/n+Di2Q84Ul/XXbWA9A==
X-Received: by 2002:ac8:92a:: with SMTP id t39mr2521882qth.170.1572656973880;
        Fri, 01 Nov 2019 18:09:33 -0700 (PDT)
Received: from gabell.cable.rcn.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id i66sm4234340qkb.105.2019.11.01.18.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 18:09:33 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] x86/boot: Add max_addr field in struct boot_params
Date:   Fri,  1 Nov 2019 21:09:09 -0400
Message-Id: <20191102010911.21460-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191102010911.21460-1-msys.mizuma@gmail.com>
References: <20191102010911.21460-1-msys.mizuma@gmail.com>
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
index db1e24e56..855d30f64 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -165,7 +165,7 @@ struct boot_params {
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

