Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A029FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A352082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pl/foEhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfHSOQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:16:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:16:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7JEG4Us4176149
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 07:16:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7JEG4Us4176149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566224165;
        bh=kNu8MarXlKNs9EGB0IGZiHuSCFeD5t2WIZgZBqyJbi4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pl/foEheLJp/qeBf9rhfqjYPYcUZWjvcNPlPAoPA1676cu/UcGbBGBtl4cRsWalDa
         BaJd46PuzDeT4r4f0y+dn2nZABqmo8EJAeBFTjJCSboOJqRlBnUp/j5PFnOraAX999
         y+7Fs/SyEUDyMg8FxjeU223fEwUpDiAxTzKKVIL/QymFOCDqZsqE/VK5Ec5JNHogst
         roX8LpnpWpoBB6kZwUnJT/h/u5dmCLw4Kf3MFQdwbVEp2P2YfOcifwj16PLHYmIUmE
         zlHI7y7d3h/liekDC6m7I7609mqfqQHnqwX6TV26DtEovH2/dS2fDwzlweeW/P1PtW
         rkDabdiWkyfOw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7JEG43k4176146;
        Mon, 19 Aug 2019 07:16:04 -0700
Date:   Mon, 19 Aug 2019 07:16:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-0a46fff2f9108c2c44218380a43a736cf4612541@git.kernel.org>
Cc:     mingo@kernel.org, kirill.shutemov@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, bp@suse.de,
        hpa@zytor.com, tglx@linutronix.de, kirill@shutemov.name
Reply-To: tglx@linutronix.de, bp@suse.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@redhat.com, x86@kernel.org,
          mingo@kernel.org, kirill.shutemov@linux.intel.com,
          kirill@shutemov.name
In-Reply-To: <20190813131654.24378-1-kirill.shutemov@linux.intel.com>
References: <20190813131654.24378-1-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/compressed/64: Fix boot on machines with
 broken E820 table
Git-Commit-ID: 0a46fff2f9108c2c44218380a43a736cf4612541
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

Commit-ID:  0a46fff2f9108c2c44218380a43a736cf4612541
Gitweb:     https://git.kernel.org/tip/0a46fff2f9108c2c44218380a43a736cf4612541
Author:     Kirill A. Shutemov <kirill@shutemov.name>
AuthorDate: Tue, 13 Aug 2019 16:16:54 +0300
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Aug 2019 15:59:13 +0200

x86/boot/compressed/64: Fix boot on machines with broken E820 table

BIOS on Samsung 500C Chromebook reports very rudimentary E820 table that
consists of 2 entries:

  BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] usable
  BIOS-e820: [mem 0x00000000fffff000-0x00000000ffffffff] reserved

It breaks logic in find_trampoline_placement(): bios_start lands on the
end of the first 4k page and trampoline start gets placed below 0.

Detect underflow and don't touch bios_start for such cases. It makes
kernel ignore E820 table on machines that doesn't have two usable pages
below BIOS_START_MAX.

Fixes: 1b3a62643660 ("x86/boot/compressed/64: Validate trampoline placement against E820")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=203463
Link: https://lkml.kernel.org/r/20190813131654.24378-1-kirill.shutemov@linux.intel.com
---
 arch/x86/boot/compressed/pgtable_64.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 5f2d03067ae5..2faddeb0398a 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -72,6 +72,8 @@ static unsigned long find_trampoline_placement(void)
 
 	/* Find the first usable memory region under bios_start. */
 	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
+		unsigned long new;
+
 		entry = &boot_params->e820_table[i];
 
 		/* Skip all entries above bios_start. */
@@ -84,15 +86,20 @@ static unsigned long find_trampoline_placement(void)
 
 		/* Adjust bios_start to the end of the entry if needed. */
 		if (bios_start > entry->addr + entry->size)
-			bios_start = entry->addr + entry->size;
+			new = entry->addr + entry->size;
 
 		/* Keep bios_start page-aligned. */
-		bios_start = round_down(bios_start, PAGE_SIZE);
+		new = round_down(new, PAGE_SIZE);
 
 		/* Skip the entry if it's too small. */
-		if (bios_start - TRAMPOLINE_32BIT_SIZE < entry->addr)
+		if (new - TRAMPOLINE_32BIT_SIZE < entry->addr)
 			continue;
 
+		/* Protect against underflow. */
+		if (new - TRAMPOLINE_32BIT_SIZE > bios_start)
+			break;
+
+		bios_start = new;
 		break;
 	}
 
