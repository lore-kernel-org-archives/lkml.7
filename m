Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC9CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D563E20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="V2RLDQsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfHMNRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:17:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41374 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfHMNRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:17:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id w5so4048834edl.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76Zl8K6WH7/FZX4d76q6nmLAaHErNOtgWon5idKRpYM=;
        b=V2RLDQsyKUoeN1d2FMlrbWcDjccHyEk4ucb2XXg8BSSsx6oezbVRhf5M1szQTLEB9e
         o7o98QPzUl1v35IdBgfwxT8NGOyxNnfFBdtQ6895+3AwYKCUnNPRwRi9Nzo4/6nYOMj/
         +GY5bB2iym4sUO4qbgWjB43P/Uu/ZNxxVVach8cqc6bYdBUUw9j14Jva5RVjld3lR1ro
         HpYSzZR8jeSOUcTqFFA+e89Bca3EmBytnrRx0nETEr9hXYEwp3SWIR5otnfQWrCIVfpt
         4LdiipyUsLd8s1QwzcAv1ShwMzQDDaQljZB2ol7Xa5Q67PzGs0plHhuqmdYpeO+4igjJ
         1npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76Zl8K6WH7/FZX4d76q6nmLAaHErNOtgWon5idKRpYM=;
        b=lIIPA3rQNJ+7XfA6o29G6Nz4XM1REOK0i5TnhCsUs6CBKD+6XTH/2+Q8RIh3S/6ltP
         l8eLz5zbIHATV6NiEtunNqjSCN553CaRVxVkR2jHN8Y/9qGYl/cpy8svdsxWDFXQGvuh
         vf34JzX6BXy0wVOuWnlZ/r6PLnc8A8efaq6pnVPoiNST5fUa2ZnMbxcTIjCaAyCXEL+E
         xdqKbq0Fhp7qS1z0eTZjlvAjV1CppbQKROrJh0hmZ78SVeG27W6OnWL2HJuygkhS3I/p
         gs09Iij3N8fBWDaNJT9dhMxIZTsjV0tJ5pLSMg2ouIx8392Rl1nA8l54nz5336WnBdJz
         1IFw==
X-Gm-Message-State: APjAAAWbtlz349qFHVcKzaOaj0NzqoJ/UBTc298turwMB+OqO4/f/rCj
        tW/XfbYiJLq5siJ9c6WNqWZnTQ==
X-Google-Smtp-Source: APXvYqyHZMRQC9jevvwyI5H9cw12yvfnbE9hVa/qLokzq6j4Lk0stEKtqG7ZfiLGqY0AApwnw+f7og==
X-Received: by 2002:a05:6402:129a:: with SMTP id w26mr20369818edv.167.1565702223689;
        Tue, 13 Aug 2019 06:17:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z9sm3564790edd.18.2019.08.13.06.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 06:17:03 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id B2599100854; Tue, 13 Aug 2019 16:17:02 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/boot/compressed/64: Fix boot on machines with broken E820 table
Date:   Tue, 13 Aug 2019 16:16:54 +0300
Message-Id: <20190813131654.24378-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIOS on Samsung 500C Chromebook reports very rudimentary E820 table that
consists of 2 entries:

 BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] usable
 BIOS-e820: [mem 0x00000000fffff000-0x00000000ffffffff] reserved

It breaks logic in find_trampoline_placement(): bios_start lands on the
end of the first 4k page and trampoline start gets placed below 0.

Detect underflow and don't touch bios_start for such cases. It makes
kernel ignore E820 table on machines that doesn't have two usable pages
below BIOS_START_MAX.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 1b3a62643660 ("x86/boot/compressed/64: Validate trampoline placement against E820")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203463
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
 
-- 
2.21.0

