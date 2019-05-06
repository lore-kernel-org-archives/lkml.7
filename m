Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17815C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D495C206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJBFnWe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfEFRK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:10:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43670 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfEFRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:10:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id t22so6750071pgi.10;
        Mon, 06 May 2019 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toejBubC2VyS9gb6UJ2Vq2aIqRrvIfX1XgP/QUj3iss=;
        b=oJBFnWe0zqeVXTxFfvk5czw0YUjnS+Wcod6pmd8iK5wvocNWX5ZTBClzul47/RKfHw
         yI+Q1lg0XI5lu7oQAW34w73FIH4/5LFBJRsG6ag5f6DzJ9vSyCh5AaQNj4IqVbF+xzi0
         fXa4K4hXUi8GQ6Yfr4L7xgDjvVuHSRfXXe99wnXUnnLWgUCjdrlN6jhMstFPusFTj5iN
         yaGZs1B+naH2sUxhp35p+dLfTYTv7uGkkFBjndBa+lL7HfiYP46mEgCyZzW0Dn4IU/9G
         76mZjPSLCsUSO9Y4uxEFMTnms0jn+fFl+nOEcAHskDQ6tkAPdqns050QfbM3VyzUnxpv
         +Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toejBubC2VyS9gb6UJ2Vq2aIqRrvIfX1XgP/QUj3iss=;
        b=M+2I0/0FW//HRr4gfjlNNCoB0AGBfRC8sa72q75tdyOIgIW2KY2SMll/GubS4y/IGY
         RtJQa8DSetYGK2162kW908mxuSV41myXakWcMKVp5mjF+sP0/jzdh/hklVUUoB2Ly6yV
         MnFGRHvkeTTJwjCBVHb8umXwg28hgi/QUcx2mtBi9yKfO69LcIF8bo3hy+nFA5Wh+/jY
         SxP1rbjPLZ5al7vbnaUZf1ha1oICgmOHeZImnpa/wyUYXuLwRnkjeqFU8xzWife2ZgE9
         nROG9nIjA+GU1KItbuq7PmiE12mcd9My9RgJweAZfu+LkVs9z/aijlwa+PPu2HG1xv65
         KlYg==
X-Gm-Message-State: APjAAAUbHKXPFwM8sXR9sYoTN2dcb5NSeucllEaA8M5c8m5MXfzTmH52
        RZ7+U/BrHWKHtafth/SYtCs=
X-Google-Smtp-Source: APXvYqwuxHiBEK7xzycEIh2YH1bGtikLar4ZqL4qLv+QAKJIssYLs0jCqND18lD0PcQdB5pfi0pWVQ==
X-Received: by 2002:a63:165f:: with SMTP id 31mr33647444pgw.321.1557162623279;
        Mon, 06 May 2019 10:10:23 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.10.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:10:22 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 08/27] Documentation: x86: convert zero-page.txt to reST
Date:   Tue,  7 May 2019 01:09:04 +0800
Message-Id: <20190506170923.7117-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506170923.7117-1-changbin.du@gmail.com>
References: <20190506170923.7117-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/x86/index.rst     |  1 +
 Documentation/x86/zero-page.rst | 45 +++++++++++++++++++++++++++++++++
 Documentation/x86/zero-page.txt | 40 -----------------------------
 3 files changed, 46 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/x86/zero-page.rst
 delete mode 100644 Documentation/x86/zero-page.txt

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index d9ccc0f39279..e43aa9b31976 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -14,3 +14,4 @@ x86-specific Documentation
    kernel-stacks
    entry_64
    earlyprintk
+   zero-page
diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
new file mode 100644
index 000000000000..f088f5881666
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
+===========	=====	=======================	=================================================
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
+===========	=====	=======================	=================================================
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

