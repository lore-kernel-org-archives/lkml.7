Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D216C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7466A20651
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfGGTqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 15:46:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57012 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727501AbfGGTiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 15:38:04 -0400
Received: from 94.197.121.43.threembb.co.uk ([94.197.121.43] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz3-0006fH-Eg; Sun, 07 Jul 2019 20:38:01 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz1-0005Yr-Nk; Sun, 07 Jul 2019 20:37:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Finn Thain" <fthain@telegraphics.com.au>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Date:   Sun, 07 Jul 2019 17:54:17 +0100
Message-ID: <lsq.1562518457.188051372@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 032/129] m68k: Add -ffreestanding to CFLAGS
In-Reply-To: <lsq.1562518456.876074874@decadent.org.uk>
X-SA-Exim-Connect-IP: 94.197.121.43
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.70-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit 28713169d879b67be2ef2f84dcf54905de238294 upstream.

This patch fixes a build failure when using GCC 8.1:

/usr/bin/ld: block/partitions/ldm.o: in function `ldm_parse_tocblock':
block/partitions/ldm.c:153: undefined reference to `strcmp'

This is caused by a new optimization which effectively replaces a
strncmp() call with a strcmp() call. This affects a number of strncmp()
call sites in the kernel.

The entire class of optimizations is avoided with -fno-builtin, which
gets enabled by -ffreestanding. This may avoid possible future build
failures in case new optimizations appear in future compilers.

I haven't done any performance measurements with this patch but I did
count the function calls in a defconfig build. For example, there are now
23 more sprintf() calls and 39 fewer strcpy() calls. The effect on the
other libc functions is smaller.

If this harms performance we can tackle that regression by optimizing
the call sites, ideally using semantic patches. That way, clang and ICC
builds might benfit too.

Reference: https://marc.info/?l=linux-m68k&m=154514816222244&w=2
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/m68k/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -59,7 +59,10 @@ cpuflags-$(CONFIG_M5206e)	:= $(call cc-o
 cpuflags-$(CONFIG_M5206)	:= $(call cc-option,-mcpu=5206,-m5200)
 
 KBUILD_AFLAGS += $(cpuflags-y)
-KBUILD_CFLAGS += $(cpuflags-y) -pipe
+KBUILD_CFLAGS += $(cpuflags-y)
+
+KBUILD_CFLAGS += -pipe -ffreestanding
+
 ifdef CONFIG_MMU
 # without -fno-strength-reduce the 53c7xx.c driver fails ;-(
 KBUILD_CFLAGS += -fno-strength-reduce -ffixed-a2

