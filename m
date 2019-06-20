Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13EC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6122147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XFTbxOUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfFTKB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:01:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59145 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFTKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:01:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5KA1Bb3907358
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 20 Jun 2019 03:01:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5KA1Bb3907358
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561024872;
        bh=UPkv90uF2Anf0QFRTigvjd0bnuSnlQV0Wt+CGEHfp4w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XFTbxOUT1FQ9RWFB0IAmVYeUmqcQHKBgXTIvjQ2Z2gj9vNGWcLbc6/unQ0hY8TqpX
         8UNXm5xBGF/HATtlUeczUy//uYqw5xulYuJ8EegFIX4/XOEOCIaaOs8zWpqtvKvMFm
         srRg4WudLmqcEvaS0VJjlnkdb6YBYBb7GdXd8beea3pwLXiueH6zpszCMwyA494NDl
         sOhkD9MOVi5aPDtkZzGpqaHYPcszbC15LhSw3LV167loA58xGW2xu9B8HiKLP7d66w
         bYyElrL1c6V9MdH3VfynQ1xr7NDuGvZZ/K/BYCH0eJoXzRtBzapt78O4y0N3d514AL
         NJfHWXO7bq31A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5KA1AbH907355;
        Thu, 20 Jun 2019 03:01:10 -0700
Date:   Thu, 20 Jun 2019 03:01:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lianbo Jiang <tipbot@zytor.com>
Message-ID: <tip-980621daf368f2b9aa69c7ea01baa654edb7577b@git.kernel.org>
Cc:     bjorn.helgaas@gmail.com, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn, hpa@zytor.com, luto@amacapital.net,
        lijiang@redhat.com, mingo@kernel.org, bp@suse.de, bhe@redhat.com,
        akpm@linux-foundation.org, thomas.lendacky@amd.com,
        dyoung@redhat.com, mingo@redhat.com, gustavo@embeddedor.com,
        x86@kernel.org, peterz@infradead.org, tglx@linutronix.de
Reply-To: dyoung@redhat.com, gustavo@embeddedor.com, mingo@redhat.com,
          akpm@linux-foundation.org, thomas.lendacky@amd.com,
          peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
          hpa@zytor.com, luto@amacapital.net, bjorn.helgaas@gmail.com,
          wang.yi59@zte.com.cn, linux-kernel@vger.kernel.org, bp@suse.de,
          bhe@redhat.com, mingo@kernel.org, lijiang@redhat.com
In-Reply-To: <20190423013007.17838-4-lijiang@redhat.com>
References: <20190423013007.17838-4-lijiang@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] x86/crash: Add e820 reserved ranges to kdump
 kernel's e820 table
Git-Commit-ID: 980621daf368f2b9aa69c7ea01baa654edb7577b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  980621daf368f2b9aa69c7ea01baa654edb7577b
Gitweb:     https://git.kernel.org/tip/980621daf368f2b9aa69c7ea01baa654edb7577b
Author:     Lianbo Jiang <lijiang@redhat.com>
AuthorDate: Tue, 23 Apr 2019 09:30:07 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 20 Jun 2019 10:05:06 +0200

x86/crash: Add e820 reserved ranges to kdump kernel's e820 table

At present, when using the kexec_file_load() syscall to load the kernel
image and initramfs, for example:

  kexec -s -p xxx

the kernel does not pass the e820 reserved ranges to the second kernel,
which might cause two problems:

 1. MMCONFIG: A device in PCI segment 1 cannot be discovered by the
kernel PCI probing without all the e820 I/O reservations being present
in the e820 table. Which is the case currently, because the kdump kernel
does not have those reservations because the kexec command does not pass
the I/O reservation via the "memmap=xxx" command line option.

Further details courtesy of Bjorn Helgaas¹: I think you should regard
correct MCFG/ECAM usage in the kdump kernel as a requirement. MMCONFIG
(aka ECAM) space is described in the ACPI MCFG table. If you don't have
ECAM:

  (a) PCI devices won't work at all on non-x86 systems that use only
   ECAM for config access,

  (b) you won't be able to access devices on non-0 segments (granted,
  there aren't very many of these yet, but there will be more in the
  future), and

  (c) you won't be able to access extended config space (addresses
  0x100-0xfff), which means none of the Extended Capabilities will be
  available (AER, ACS, ATS, etc).

 2. The second issue is that the SME kdump kernel doesn't work without
the e820 reserved ranges. When SME is active in the kdump kernel, those
reserved regions are still decrypted, but because those reserved ranges
are not present at all in kdump kernel's e820 table, they are accessed
as encrypted. Which is obviously wrong.

 [1]: https://lkml.kernel.org/r/CABhMZUUscS3jUZUSM5Y6EYJK6weo7Mjj5-EAKGvbw0qEe%2B38zw@mail.gmail.com

 [ bp: Heavily massage commit message. ]

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Baoquan He <bhe@redhat.com>
Cc: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Cc: dave.hansen@linux.intel.com
Cc: Dave Young <dyoung@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Cc: Yi Wang <wang.yi59@zte.com.cn>
Link: https://lkml.kernel.org/r/20190423013007.17838-4-lijiang@redhat.com
---
 arch/x86/kernel/crash.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 576b2e1bfc12..32c956705b8e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -381,6 +381,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
 			memmap_entry_callback);
 
+	/* Add e820 reserved ranges */
+	cmd.type = E820_TYPE_RESERVED;
+	flags = IORESOURCE_MEM;
+	walk_iomem_res_desc(IORES_DESC_RESERVED, flags, 0, -1, &cmd,
+			   memmap_entry_callback);
+
 	/* Add crashk_low_res region */
 	if (crashk_low_res.end) {
 		ei.addr = crashk_low_res.start;
