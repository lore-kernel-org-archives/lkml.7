Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E7CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0CE2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1U7nwzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDZPdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:33:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43476 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfDZPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:32:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so1788571pgu.10;
        Fri, 26 Apr 2019 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y1AKVJFPbq277WK1HjlwVckr54jHOYhvpvnDgPVgIWM=;
        b=c1U7nwzD5wlXgA3iq0hX82QlEKYEgy/2OEMalYqOj7Jc1xxHy/Q4JSe5bypvRSCCwm
         TSKA6/cdDSMCjR8fTZKFCycxw/aajEGEaqasSp+bGTgm7bz+N/JzIK1GlEW6kCXHBKsx
         xpiPVutbM4pRoISbQZcHIzemmz5750lmcKwF8VVgMZgVvXA8s1c8Zby5tr1O90v5PEAC
         /ZoHkpN3+vvnXDrNEMI+k7qgiscg+faNW7VLJT/q28+pWvzTbfVS+JSt8FhxcgkHkyqo
         yGAhi/qdnTgw8ymgXLWyIkWstAYo+Y2M+JANm8G/CXpCtZYjAd3Awjkmv2T1NJhShQ6f
         UTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1AKVJFPbq277WK1HjlwVckr54jHOYhvpvnDgPVgIWM=;
        b=EV7KBXQcnQh/igzTTKGr930wFV0RHDzemhKdwahh2s/cLF+zOcd4sBut8jWePKyOIz
         qvH/w4Of6xk/nTUDhpDCdaZF2lNihoZZhH6qHZ7nNjxu4i/a8w9lN3NBFBXmQAhQ+s1Y
         wXdYYk7uk+DhrmmUXh5PJYQ9y6CyT75C25BM/t2WlP73rOyTPaGBnrn1Lc2cYrbLs5To
         3siVC9MDGBky+6qgqahqppwH33Ml6IduESlZ+zeMAwj08ciG3rX7Rr66bzdjTAJYG9mx
         Ic1xMIH5OY9QUoWiLe580Gp3Y/vGNCFUcgxNF9V2LAGJNDsKqckkr2nifLzwhkSn4TGd
         b5MA==
X-Gm-Message-State: APjAAAWpWYPq4VKADVA45K1WKLWT/TrvFjc6HXbrtq7jsK+lVw/z620H
        iQQKaQV8jJNwmN+Nroz8ws4=
X-Google-Smtp-Source: APXvYqzCrFcRT1qs6weFxVuAJGhohCk1cqDi13cf1E2RJ9oKc+Gfw7wzKeJ5XdKB7+/TzO0bpBBzcw==
X-Received: by 2002:aa7:8455:: with SMTP id r21mr15411036pfn.253.1556292776149;
        Fri, 26 Apr 2019 08:32:56 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:32:55 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 08/27] Documentation: x86: convert zero-page.txt to reST
Date:   Fri, 26 Apr 2019 23:31:31 +0800
Message-Id: <20190426153150.21228-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/x86/index.rst     |  1 +
 Documentation/x86/zero-page.rst | 45 +++++++++++++++++++++++++++++++++
 Documentation/x86/zero-page.txt | 40 -----------------------------
 3 files changed, 46 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/x86/zero-page.rst
 delete mode 100644 Documentation/x86/zero-page.txt

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 7b8388ebd43d..9a0b5f38ef6b 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -14,3 +14,4 @@ Linux x86 Support
    kernel-stacks
    entry_64
    earlyprintk
+   zero-page
diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
new file mode 100644
index 000000000000..70f10eabca86
--- /dev/null
+++ b/Documentation/x86/zero-page.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========
+Zero Page
+=========
+The additional fields in struct boot_params as a part of 32-bit boot
+protocol of kernel. These should be filled by bootloader or 16-bit
+real-mode setup code of the kernel. References/settings to it mainly
+are in::
+
+  arch/x86/include/uapi/asm/bootparam.h
+
+===========	=====	=======================	================================
+Offset/Size	Proto	Name			Meaning
+
+000/040		ALL	screen_info		Text mode or frame buffer information
+						(struct screen_info)
+040/014		ALL	apm_bios_info		APM BIOS information (struct apm_bios_info)
+058/008		ALL	tboot_addr      	Physical address of tboot shared page
+060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
+						(struct ist_info)
+080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
+090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
+0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
+						OBSOLETE!!
+0B0/010		ALL	olpc_ofw_header		OLPC's OpenFirmware CIF and friends
+0C0/004		ALL	ext_ramdisk_image	ramdisk_image high 32bits
+0C4/004		ALL	ext_ramdisk_size	ramdisk_size high 32bits
+0C8/004		ALL	ext_cmd_line_ptr	cmd_line_ptr high 32bits
+140/080		ALL	edid_info		Video mode setup (struct edid_info)
+1C0/020		ALL	efi_info		EFI 32 information (struct efi_info)
+1E0/004		ALL	alt_mem_k		Alternative mem check, in KB
+1E4/004		ALL	scratch			Scratch field for the kernel setup code
+1E8/001		ALL	e820_entries		Number of entries in e820_table (below)
+1E9/001		ALL	eddbuf_entries		Number of entries in eddbuf (below)
+1EA/001		ALL	edd_mbr_sig_buf_entries	Number of entries in edd_mbr_sig_buffer
+						(below)
+1EB/001		ALL     kbd_status      	Numlock is enabled
+1EC/001		ALL     secure_boot		Secure boot is enabled in the firmware
+1EF/001		ALL	sentinel		Used to detect broken bootloaders
+290/040		ALL	edd_mbr_sig_buffer	EDD MBR signatures
+2D0/A00		ALL	e820_table		E820 memory map table
+						(array of struct e820_entry)
+D00/1EC		ALL	eddbuf			EDD data (array of struct edd_info)
+===========	=====	=======================	================================
diff --git a/Documentation/x86/zero-page.txt b/Documentation/x86/zero-page.txt
deleted file mode 100644
index 68aed077f7b6..000000000000
--- a/Documentation/x86/zero-page.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-The additional fields in struct boot_params as a part of 32-bit boot
-protocol of kernel. These should be filled by bootloader or 16-bit
-real-mode setup code of the kernel. References/settings to it mainly
-are in:
-
-  arch/x86/include/uapi/asm/bootparam.h
-
-
-Offset	Proto	Name		Meaning
-/Size
-
-000/040	ALL	screen_info	Text mode or frame buffer information
-				(struct screen_info)
-040/014	ALL	apm_bios_info	APM BIOS information (struct apm_bios_info)
-058/008	ALL	tboot_addr      Physical address of tboot shared page
-060/010	ALL	ist_info	Intel SpeedStep (IST) BIOS support information
-				(struct ist_info)
-080/010	ALL	hd0_info	hd0 disk parameter, OBSOLETE!!
-090/010	ALL	hd1_info	hd1 disk parameter, OBSOLETE!!
-0A0/010	ALL	sys_desc_table	System description table (struct sys_desc_table),
-				OBSOLETE!!
-0B0/010	ALL	olpc_ofw_header	OLPC's OpenFirmware CIF and friends
-0C0/004	ALL	ext_ramdisk_image ramdisk_image high 32bits
-0C4/004	ALL	ext_ramdisk_size  ramdisk_size high 32bits
-0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
-140/080	ALL	edid_info	Video mode setup (struct edid_info)
-1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
-1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
-1E4/004	ALL	scratch		Scratch field for the kernel setup code
-1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
-1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)
-1EA/001	ALL	edd_mbr_sig_buf_entries	Number of entries in edd_mbr_sig_buffer
-				(below)
-1EB/001	ALL     kbd_status      Numlock is enabled
-1EC/001	ALL     secure_boot	Secure boot is enabled in the firmware
-1EF/001	ALL	sentinel	Used to detect broken bootloaders
-290/040	ALL	edd_mbr_sig_buffer EDD MBR signatures
-2D0/A00	ALL	e820_table	E820 memory map table
-				(array of struct e820_entry)
-D00/1EC	ALL	eddbuf		EDD data (array of struct edd_info)
-- 
2.20.1

