Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4286C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDA820830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCDUCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:02:14 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:60275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDUCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:02:13 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MF2YC-1glYlH1e2a-00FThj; Mon, 04 Mar 2019 21:02:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] time: Make VIRT_CPU_ACCOUNTING_GEN depend on GENERIC_CLOCKEVENTS
Date:   Mon,  4 Mar 2019 21:01:31 +0100
Message-Id: <20190304200202.1163250-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xI5gu2vKPSIkupmJqeoL+mXwuuLhBf8CCrVugJjyKd+0+WK68gG
 Zn68TELUR5j5tPPZ+qLXp+Vb1ThgNxC/gaBljFI8fvExPvdJSnmVVq528sxrLIkbReJZMO5
 BFjxKSys2s41HgImqCJALV4wBr3MsWWddkGccjmy3tpUoNmSP1YzgpnEKzLh/Ltpv4HXaZi
 6L+sBLn++oWfq3kpQ9uhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mYz9IZLzva4=:pG6EnBfv6mey8i8HkPpYfB
 8PeD2/jYBdNOjl3kJoo1sKiG5uZMETm9g23bhuvNIXenPsmlnAK55s6e9jhMSkPxciziZl1Uj
 EpTuYe3DeaEn2bTRHIth7xpl24C9EWf/ZZgJoRsNb4rhkMVmRHNyPjSEHklguaJEhS30lmPKD
 AbBlTBp3kJyH64Nhc3TKVXT/LQQE+RXD6/69DV47QPYdbk2XBvUHXLUIqyYwLdwyNlW1suSUh
 c+cBu8VbSeG+C8f9QX18LIAXW/cWk9ajH4zYZYe7WsHrlg67Rb6TDdJKAtjmfmLVkcFK4SxWN
 0j3q9H6OmnzcJLQS5Uu8VSB7cRtLPoH72H86tnindxIX5BvvULcpDYaJ6R+i3ift7YS27MFMA
 1WIuaGoNogwxWgYqqE+6QrniMcIzT1ypvPw2FqK8AZLhpYtZfkEwzRl5vlVMksf73yXfrKqIp
 EjKvOFc2EevkscvlSQlK6nW0/9nlLp/IVU5ovetJuwlaoqiRORC2pSHp8L1oo5pIj52w70RLp
 KDT+SMTgwDnwzoonP4YCPaTT++REqOLD3KdX8r63V1QqNxG4CkvLgLrIfrkbnm/O/kh8QbAxf
 Pr/MA6DMzyFUNqWqcNtocS77UUZ12JVA+y5qt5yhndgjZXjJJOl+Bf/c3bas2pUigBrgIRPgZ
 q80GnPpfaRq85njszKKDLDHqkBIaoyrCrtuUfotNKsmfQrW1a5opDV43m+q53z3gfa/wnIm47
 fIW2OcZQlBceHpIXj1guTbQvvldXHR85FLQ+Xg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the CONTEXT_TRACKING Kconfig option into kernel/time/Kconfig
added an implicit dependency on the surrounding GENERIC_CLOCKEVENTS
option, but this is not always enabled when we are able to select
VIRT_CPU_ACCOUNTING_GEN:

WARNING: unmet direct dependencies detected for CONTEXT_TRACKING
  Depends on [n]: GENERIC_CLOCKEVENTS [=n]
  Selected by [y]:
  - VIRT_CPU_ACCOUNTING_GEN [=y] && <choice> && HAVE_CONTEXT_TRACKING [=y] && HAVE_VIRT_CPU_ACCOUNTING_GEN [=y]

Platforms without GENERIC_CLOCKEVENTS are rare enough that we can
probably just ignore that corner case and make it a dependency for
VIRT_CPU_ACCOUNTING_GEN to simplify the configuration.

Fixes: a4cffdad7314 ("time: Move CONTEXT_TRACKING to kernel/time/Kconfig")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index e0a6a35b8428..13442ca7d1ba 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -398,6 +398,7 @@ config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
 	depends on HAVE_CONTEXT_TRACKING
 	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
+	depends on GENERIC_CLOCKEVENTS
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING
 	help
-- 
2.20.0

