Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC82C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6A9217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889031;
	bh=vRmXBO5Gu0mvfOSr13Grf3KH9xKlAfzS1tCHm0VwrJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IshyM/ui7XgDYN8C0VC9BrvIsBaF4Z3DuwFiuDEJZoCh7RNHSMlQXG0ynwu/irLIm
	 jCM31u5LqCrWYWhk6RZ2F554nN9Nz3inov+5IO/mH+oW15WKxn0vLkH7vomxKd76ju
	 9rhomvidP0HAJ5zn1nKo2T7iTWWzzyJ9234yITzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbfK0VKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733029AbfK0VKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:10:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61F42178F;
        Wed, 27 Nov 2019 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889024;
        bh=vRmXBO5Gu0mvfOSr13Grf3KH9xKlAfzS1tCHm0VwrJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AftuRPYCOhqpgCNZtX6cUt1nyS/JxMkwgXPZIREiHxpTvJ1jIbrE+JLW8cOWMBbe+
         o4DRGlVD+kmrMEovS42ZU0+AIWEmFjcDC5KJ0uq+UcETSn/8+8Oj30m4fyzqOZs2eZ
         6hg/NzsSWvVFvxKdUKqCAildzMyk6Twx/uZR7PtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, stable@kernel.org
Subject: [PATCH 5.3 55/95] x86/pti/32: Size initial_page_table correctly
Date:   Wed, 27 Nov 2019 21:32:12 +0100
Message-Id: <20191127202920.769722416@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit f490e07c53d66045d9d739e134145ec9b38653d3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/head_32.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

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


