Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5176DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B552068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfKUUOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:14:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33409 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfKUUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:14:35 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXsqT-0004fb-Ea; Thu, 21 Nov 2019 21:14:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 03C4B1C1A4B;
        Thu, 21 Nov 2019 21:14:26 +0100 (CET)
Date:   Thu, 21 Nov 2019 20:14:25 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/pti/32: Size initial_page_table correctly
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, stable@kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157436726590.21853.2642908261946434695.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f490e07c53d66045d9d739e134145ec9b38653d3
Gitweb:        https://git.kernel.org/tip/f490e07c53d66045d9d739e134145ec9b38653d3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 Nov 2019 00:40:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Nov 2019 19:37:43 +01:00

x86/pti/32: Size initial_page_table correctly

Commit 945fd17ab6ba ("x86/cpu_entry_area: Sync cpu_entry_area to
initial_page_table") introduced the sync for the initial page table for
32bit.

sync_initial_page_table() uses clone_pgd_range() which does the update for
the kernel page table. If PTI is enabled it also updates the user space
page table counterpart, which is assumed to be in the next page after the
target PGD.

At this point in time 32-bit did not have PTI support, so the user space
page table update was not taking place.

The support for PTI on 32-bit which was introduced later on, did not take
that into account and missed to add the user space counter part for the
initial page table.

As a consequence sync_initial_page_table() overwrites any data which is
located in the page behing initial_page_table causing random failures,
e.g. by corrupting doublefault_tss and wreckaging the doublefault handler
on 32bit.

Fix it by adding a "user" page table right after initial_page_table.

Fixes: 7757d607c6b3 ("x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Cc: stable@kernel.org
---
 arch/x86/kernel/head_32.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 30f9cb2..2e6a067 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -571,6 +571,16 @@ ENTRY(initial_page_table)
 #  error "Kernel PMDs should be 1, 2 or 3"
 # endif
 	.align PAGE_SIZE		/* needs to be page-sized too */
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	/*
+	 * PTI needs another page so sync_initial_pagetable() works correctly
+	 * and does not scribble over the data which is placed behind the
+	 * actual initial_page_table. See clone_pgd_range().
+	 */
+	.fill 1024, 4, 0
+#endif
+
 #endif
 
 .data
