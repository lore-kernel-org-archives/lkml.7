Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84731C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476D12085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfX2wLmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEBHK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:10:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46317 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:10:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id j11so662656pff.13;
        Thu, 02 May 2019 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toejBubC2VyS9gb6UJ2Vq2aIqRrvIfX1XgP/QUj3iss=;
        b=TfX2wLmG9Kwtxs3KX/Fx+WySTZMtvxzpn7/dv9MwNDFw0NnRqxbVMtHEYroMbd7yFN
         Y49d/5tSPsTFlhdaVDhSL5EkhUSOeZoh3IVXUKQLHYlezcFgQdtWymjp2H84s1+fAz2V
         I+evDp3SMrGD0sYesiAf0pW3zs2UeDLX1E8w+GBy0Wdrzm3UeCONYFUdVBPMp310ilPO
         Bz/XxSTRL8DYYfpspKASAVNzzTALUzoMqbvZiXgb2tw0xJqVCaskfH6qKm5+vfbS545G
         BTOTrlnX/68EWVaq+kdjl3UBOxzmJ0WZf1AuKSVFiXyfi01S43VDAsbLD3BxjXfvt7Rb
         +BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toejBubC2VyS9gb6UJ2Vq2aIqRrvIfX1XgP/QUj3iss=;
        b=IzzoA1vp0lnpbQqPEs/TWhjbBYkW3syIO648hzNTMAqurMc7/xQ283SNM4n5dyjOzd
         jgaT734QKLho0IixsGGpJxs9/JMUIc0LXTDi5KeTdYtNkBmHJqBn9c24wUFvDjkPHrGT
         /2987lhn9FayI/6ttHkH0MxLxCHwXy2tSgFvnGyiWZseTdYnEugRfUf1xEjvLu1dQxZG
         k3F6009EyBOB0/J+Tn4FN6SgK8KtflXO0U9mqnokPoh/xNJ9Z3+4jih+tmF3W1slZKHt
         amu2ufB48Ng7/JtRcfGVHqSD9zDzVhpVgLqzyp28fC1FA/ZOe53ZsObqHs1IojUXkMOG
         PAqA==
X-Gm-Message-State: APjAAAUB7fjYS+hbtRA4/YCvxXVezIhOwo5u0D5CrRy/1UlHkn8wO/1/
        SgcPDYOY18Lx0DsTQmtAoDY=
X-Google-Smtp-Source: APXvYqxnwBfPwvqA4QnKuxVD0lyIzYqfFi0tUL6Job7+PAcCTCPzr2dn8HUuIqMtTX33awfF8OBA7A==
X-Received: by 2002:a65:5089:: with SMTP id r9mr2424228pgp.14.1556781024227;
        Thu, 02 May 2019 00:10:24 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:10:23 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 08/27] Documentation: x86: convert zero-page.txt to reST
Date:   Thu,  2 May 2019 15:06:14 +0800
Message-Id: <20190502070633.9809-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502070633.9809-1-changbin.du@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
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

