Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486EEC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222372067B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947403;
	bh=YjrcaMHDpD0i46urK4YSroz51TwSMsewD04w4Z/pCw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vv8eaYqgImgaxdi0H3OL8n1VzQsmykrYReYtzvEk5NRyq5ysi0YbjEav4Str2/1OX
	 KwG9mGKXIda2t3duZDwMLvcGzF+5Rgu8GXmbjEohB54nsSffJOt6TZGrG60W61Sjtj
	 3okLtEoqB3M0TgmoR4jZXHZInWiu9dvQoc/Vtyx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfIHMtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731349AbfIHMtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:49:14 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A101B2190F;
        Sun,  8 Sep 2019 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946954;
        bh=YjrcaMHDpD0i46urK4YSroz51TwSMsewD04w4Z/pCw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4g7xyTJSjtInzgv22vXdjl65CIHcJcroyv4jl/+qoi+AcsJkwMI6Mm72IecXcCtD
         +pZdrmaAZwATBCUtFRLBc5effKGaBex6j5TOUzaumIkKt0bbKYNGM5hEvyROzNeD3P
         br98jj3U24WTaScKudyaptPBCcUwdP3lobOFoQJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 40/57] x86/boot/compressed/64: Fix boot on machines with broken E820 table
Date:   Sun,  8 Sep 2019 13:42:04 +0100
Message-Id: <20190908121144.033654811@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0a46fff2f9108c2c44218380a43a736cf4612541 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/pgtable_64.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index f8debf7aeb4c1..f0537a1f7fc25 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -73,6 +73,8 @@ static unsigned long find_trampoline_placement(void)
 
 	/* Find the first usable memory region under bios_start. */
 	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
+		unsigned long new;
+
 		entry = &boot_params->e820_table[i];
 
 		/* Skip all entries above bios_start. */
@@ -85,15 +87,20 @@ static unsigned long find_trampoline_placement(void)
 
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
 
-- 
2.20.1



