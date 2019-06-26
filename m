Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C8EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371C720644
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tK92GWKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfFZMhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:37:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33351 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfFZMhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:37:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QCak4c4104662
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 05:36:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QCak4c4104662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561552607;
        bh=JYZFktAEiOopO81lWiOb4UtCUbUGECwWdh0u6lvqJHQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tK92GWKVDyR57EKGsT1XD7t1EpxT7qUZw+wIjLhtswr58EGnTFmRxvzgYSx9i8J8e
         cujeD1y6e77TfgaL9FUniU0FRvrB6mJtlnlvt+9QWIyV1ywIkjlE6NjHAVCLdZLmJe
         V8W3aMCggyt9js8WErmJTzQ9IbXuHOb/zIStwo4votdQCOxmxnnwK6EwaOBlUbFHvG
         YT38b8GFEuu0sS5PECf8Hntljd8f4nJOzr7GzBX0f8Y/QgnSukMlwTWA5tXRWRMBMq
         fYIm4hob52RG+lGy1W73+h7OTGZ4NhfKIYrylDl3iou/cg6qWtTwrA9w1i9bl2Wofp
         27DBvqEPwO5Wg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QCajw34104655;
        Wed, 26 Jun 2019 05:36:45 -0700
Date:   Wed, 26 Jun 2019 05:36:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e70980312a946a56173843cbc0104b3b0e57a0c7@git.kernel.org>
Cc:     vincenzo.frascino@arm.com, mingo@kernel.org, avagin@openvz.org,
        torvalds@linux-foundation.org, dima@arista.com, pcc@google.com,
        will.deacon@arm.com, 0x7f454c46@gmail.com, luto@kernel.org,
        hpa@zytor.com, salyzyn@android.com, arnd@arndb.de,
        catalin.marinas@arm.com, huw@codeweavers.com, ralf@linux-mips.org,
        daniel.lezcano@linaro.org, andre.przywara@arm.com,
        tglx@linutronix.de, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, paul.burton@mips.com, shuah@kernel.org,
        sthotton@marvell.com, sashal@kernel.org, mikelley@microsoft.com
Reply-To: hpa@zytor.com, luto@kernel.org, salyzyn@android.com,
          0x7f454c46@gmail.com, arnd@arndb.de, catalin.marinas@arm.com,
          mingo@kernel.org, avagin@openvz.org, vincenzo.frascino@arm.com,
          torvalds@linux-foundation.org, dima@arista.com, pcc@google.com,
          will.deacon@arm.com, paul.burton@mips.com,
          mikelley@microsoft.com, shuah@kernel.org, sthotton@marvell.com,
          sashal@kernel.org, andre.przywara@arm.com,
          daniel.lezcano@linaro.org, huw@codeweavers.com,
          ralf@linux-mips.org, linux-arm-kernel@lists.infradead.org,
          linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
          linux@rasmusvillemoes.dk, tglx@linutronix.de
In-Reply-To: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] MAINTAINERS: Add entry for the generic VDSO
 library
Git-Commit-ID: e70980312a946a56173843cbc0104b3b0e57a0c7
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

Commit-ID:  e70980312a946a56173843cbc0104b3b0e57a0c7
Gitweb:     https://git.kernel.org/tip/e70980312a946a56173843cbc0104b3b0e57a0c7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 24 Jun 2019 02:34:24 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 07:28:11 +0200

MAINTAINERS: Add entry for the generic VDSO library

Assign the following folks in alphabetic order:

 - Andy for being the VDSO wizard of x86 and in general. He's also the
   performance monitor of choice and the code in the generic library is
   heavily influenced by his previous x86 VDSO work.

 - Thomas for being the dude who has to deal with any form of time(r)
   nonsense anyway

 - Vincenzo for being the poor sod who went through all the different
   architecture implementations in order to unify them. A lot of knowledge
   gained from VDSO implementation details to the intricacies of taming the
   build system.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: LAK <linux-arm-kernel@lists.infradead.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Huw Davies <huw@codeweavers.com>
Cc: Shijith Thotton <sthotton@marvell.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de

---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0ed735994a5..13ece5479167 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6664,6 +6664,18 @@ L:	kvm@vger.kernel.org
 S:	Supported
 F:	drivers/uio/uio_pci_generic.c
 
+GENERIC VDSO LIBRARY:
+M:	Andy Lutomirksi <luto@kernel.org>
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Vincenzo Frascino <vincenzo.frascino@arm.com>
+L:	linux-kernel@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
+S:	Maintained
+F:	lib/vdso
+F:	kernel/time/vsyscall.c
+F:	include/vdso
+F:	include/asm-generic/vdso/vsyscall.h
+
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
 S:	Supported
