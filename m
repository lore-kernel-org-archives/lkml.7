Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57437C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202392183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="h4j3kYs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbfDRIwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:52:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34385 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:52:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3I8qGPm114581
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 01:52:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3I8qGPm114581
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555577537;
        bh=9Gsl1Hd49NqPXiKHVLBPRhhblAYhzRDst6D+toK6CqE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=h4j3kYs1AnLgpokIpKHZuW2LdWkUY6fvMUlZ3TASXGJttx7gYpK8rhDDYi8mmtd91
         tQrZq+EFK6zEa4WDEltRH4H6Ea9HxTPuGtoRf+RleIVRHIEwxiXucyOfxrmsg7LDtW
         J7cPseV4oag4XAb2Pybmkp/x5U9JDphBqFG+n7hKt6HuOVmjqOJWHHBXcMxaLpFZ0T
         2Y92ek2GwXvcVj5JTV35B9IPN7aW27PB1llCwHQ1AOQdJb3anKoKOdQl95k99nDi9v
         HrKAhhyJwfsMIur7HSKel6ZibtcDUPRr/jTnbQH6J8lKz5F4C1Vwmf5eqGXQd+S7HI
         hJMoqveSxDlTg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3I8qFjI114577;
        Thu, 18 Apr 2019 01:52:15 -0700
Date:   Thu, 18 Apr 2019 01:52:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-ec3937107ab43f3e8b2bc9dad95710043c462ff7@git.kernel.org>
Cc:     bp@suse.de, thgarnie@google.com, dave.hansen@linux.intel.com,
        bhe@redhat.com, x86@kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, keescook@chromium.org
Reply-To: hpa@zytor.com, keescook@chromium.org, mingo@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          dave.hansen@linux.intel.com, bhe@redhat.com,
          kirill.shutemov@linux.intel.com, tglx@linutronix.de,
          x86@kernel.org, luto@kernel.org, bp@suse.de, thgarnie@google.com
In-Reply-To: <20190417083536.GE7065@MiWiFi-R3L-srv>
References: <20190417083536.GE7065@MiWiFi-R3L-srv>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm/KASLR: Fix the size of the direct mapping
 section
Git-Commit-ID: ec3937107ab43f3e8b2bc9dad95710043c462ff7
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

Commit-ID:  ec3937107ab43f3e8b2bc9dad95710043c462ff7
Gitweb:     https://git.kernel.org/tip/ec3937107ab43f3e8b2bc9dad95710043c462ff7
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Thu, 4 Apr 2019 10:03:13 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 18 Apr 2019 10:42:58 +0200

x86/mm/KASLR: Fix the size of the direct mapping section

kernel_randomize_memory() uses __PHYSICAL_MASK_SHIFT to calculate
the maximum amount of system RAM supported. The size of the direct
mapping section is obtained from the smaller one of the below two
values:

  (actual system RAM size + padding size) vs (max system RAM size supported)

This calculation is wrong since commit

  b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52").

In it, __PHYSICAL_MASK_SHIFT was changed to be 52, regardless of whether
the kernel is using 4-level or 5-level page tables. Thus, it will always
use 4 PB as the maximum amount of system RAM, even in 4-level paging
mode where it should actually be 64 TB.

Thus, the size of the direct mapping section will always
be the sum of the actual system RAM size plus the padding size.

Even when the amount of system RAM is 64 TB, the following layout will
still be used. Obviously KALSR will be weakened significantly.

   |____|_______actual RAM_______|_padding_|______the rest_______|
   0            64TB                                            ~120TB

Instead, it should be like this:

   |____|_______actual RAM_______|_________the rest______________|
   0            64TB                                            ~120TB

The size of padding region is controlled by
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING, which is 10 TB by default.

The above issue only exists when
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING is set to a non-zero value,
which is the case when CONFIG_MEMORY_HOTPLUG is enabled. Otherwise,
using __PHYSICAL_MASK_SHIFT doesn't affect KASLR.

Fix it by replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.

 [ bp: Massage commit message. ]

Fixes: b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52")
Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: frank.ramsay@hpe.com
Cc: herbert@gondor.apana.org.au
Cc: kirill@shutemov.name
Cc: mike.travis@hpe.com
Cc: thgarnie@google.com
Cc: x86-ml <x86@kernel.org>
Cc: yamada.masahiro@socionext.com
Link: https://lkml.kernel.org/r/20190417083536.GE7065@MiWiFi-R3L-srv
---
 arch/x86/mm/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 3f452ffed7e9..d669c5e797e0 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -94,7 +94,7 @@ void __init kernel_randomize_memory(void)
 	if (!kaslr_memory_enabled())
 		return;
 
-	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
+	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
 	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
 
 	/*
