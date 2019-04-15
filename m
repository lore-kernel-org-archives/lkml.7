Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1533AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E083B20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfDOPJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:09:20 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:33614 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfDOPJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:09:18 -0400
Received: from heffalump.sk2.org (unknown [88.186.243.14])
        by smtp5-g21.free.fr (Postfix) with ESMTPS id 6AFF45FFD8;
        Mon, 15 Apr 2019 17:09:15 +0200 (CEST)
Received: from steve by heffalump.sk2.org with local (Exim 4.89)
        (envelope-from <steve@sk2.org>)
        id 1hG3EQ-0002iC-L5; Mon, 15 Apr 2019 17:09:14 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, corbet@lwn.net, bhe@redhat.com,
        kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
        alex.popov@linux.com, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] Fix 56-bit addresses in Documentation/x86/x86_64/mm.txt
Date:   Mon, 15 Apr 2019 17:08:53 +0200
Message-Id: <20190415150853.10354-1-steve@sk2.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a PT typo, and the following 56-bit address-space
addresses:
* the hole extends from 0100000000000000 to feffffffffffffff
* the KASAN shadow memory area stops at fffffbffffffffff (see kasan.h)

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/x86/x86_64/mm.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index 804f9426ed17..6cbe652d7a49 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -72,7 +72,7 @@ Complete virtual memory map with 5-level page tables
 Notes:
 
  - With 56-bit addresses, user-space memory gets expanded by a factor of 512x,
-   from 0.125 PB to 64 PB. All kernel mappings shift down to the -64 PT starting
+   from 0.125 PB to 64 PB. All kernel mappings shift down to the -64 PB starting
    offset and many of the regions expand to support the much larger physical
    memory supported.
 
@@ -83,7 +83,7 @@ Notes:
  0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm
 __________________|____________|__________________|_________|___________________________________________________________
                   |            |                  |         |
- 0000800000000000 |  +64    PB | ffff7fffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
+ 0100000000000000 |  +64    PB | feffffffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
                   |            |                  |         |     virtual memory addresses up to the -64 PB
                   |            |                  |         |     starting offset of kernel mappings.
 __________________|____________|__________________|_________|___________________________________________________________
@@ -99,7 +99,7 @@ ____________________________________________________________|___________________
  ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
  ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
  ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
- ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory
+ ffdf000000000000 |   -8.25 PB | fffffbffffffffff |   ~8 PB | KASAN shadow memory
 __________________|____________|__________________|_________|____________________________________________________________
                                                             |
                                                             | Identical layout to the 47-bit one from here on:
-- 
2.11.0

