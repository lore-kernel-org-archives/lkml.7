Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC447C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881EE20659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="L3DRRk/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfFYHv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:51:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfFYHv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:51:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P7pFZr3517263
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 00:51:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P7pFZr3517263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561449076;
        bh=aFmnl0HnacgdSpp5Nb6Ff86EZt32FjBCA+Fqh/ZVgww=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=L3DRRk/cKfD3JMYs1p3bGnQRM0olcp93NPxQEzVnBZSOn2/WixtFfLI90QQlpk5lb
         bKlkWkJ2/IxxmNVsRwF74qcEyGuif6h5tK+YxFVX3hnNws77fy1YGgfPf2LqJ0lhfO
         KqODp2KGd9Qj/5TOHHlc/RoVjHuzqu/twyvXSNB8Enep6npA/pTv8c6nvMmXyOaIp3
         l3SZuckb5yOR+kCxZnzQBasoQO6G5jOAjeruZqB0UiGClwAxvR16DAOqkZVfgOGC3Y
         +c+y8YoSsuCXAX4oXH9S4/Uv87mB82kDN3So1Vgzbv/o+GM5azNSoT2ixCmxQOllzf
         p47Ib+VztP11A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P7pDBi3517260;
        Tue, 25 Jun 2019 00:51:13 -0700
Date:   Tue, 25 Jun 2019 00:51:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c82d735b3d3f0bbfd49a6a4da96bd27c4ba57eb0@git.kernel.org>
Cc:     luto@kernel.org, linux-arm-kernel@lists.infradead.org,
        0x7f454c46@gmail.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, mingo@kernel.org, shuah@kernel.org,
        dima@arista.com, tglx@linutronix.de, avagin@openvz.org,
        will.deacon@arm.com, arnd@arndb.de, andre.przywara@arm.com,
        sashal@kernel.org, daniel.lezcano@linaro.org, huw@codeweavers.com,
        paul.burton@mips.com, pcc@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, salyzyn@android.com, ralf@linux-mips.org,
        vincenzo.frascino@arm.com, linux@rasmusvillemoes.dk,
        sthotton@marvell.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mikelley@microsoft.com,
          salyzyn@android.com, ralf@linux-mips.org,
          vincenzo.frascino@arm.com, linux@rasmusvillemoes.dk,
          sthotton@marvell.com, hpa@zytor.com, daniel.lezcano@linaro.org,
          huw@codeweavers.com, paul.burton@mips.com, pcc@google.com,
          torvalds@linux-foundation.org, mingo@kernel.org,
          shuah@kernel.org, tglx@linutronix.de, dima@arista.com,
          avagin@openvz.org, will.deacon@arm.com, andre.przywara@arm.com,
          arnd@arndb.de, sashal@kernel.org, luto@kernel.org,
          linux-arm-kernel@lists.infradead.org, 0x7f454c46@gmail.com,
          linux@armlinux.org.uk, catalin.marinas@arm.com
In-Reply-To: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] MAINTAINERS: Add entry for the generic VDSO
 library
Git-Commit-ID: c82d735b3d3f0bbfd49a6a4da96bd27c4ba57eb0
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

Commit-ID:  c82d735b3d3f0bbfd49a6a4da96bd27c4ba57eb0
Gitweb:     https://git.kernel.org/tip/c82d735b3d3f0bbfd49a6a4da96bd27c4ba57eb0
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 24 Jun 2019 02:34:24 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 25 Jun 2019 09:44:08 +0200

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
