Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E00C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9878020856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfDBNpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:45:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43428 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731473AbfDBNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:08 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002of-JY; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004vq-7H; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Torsten Duwe" <duwe@lst.de>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.942415914@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 67/99] powerpc/configs: Don't enable PPC_EARLY_DEBUG
 in defconfigs
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 2b874a5c7b75fdc90fdd1e2ffaa3ec5a9d21e253 upstream.

This reverts the remains of commit b9ef7d6b11c1 ("powerpc: Update
default configurations").

That commit was proceeded by a commit which added a config option to
control use of BOOTX for early debug, ie. PPC_EARLY_DEBUG_BOOTX, and
then the update of the defconfigs was intended to not change behaviour
by then enabling the new config option.

However enabling PPC_EARLY_DEBUG had other consequences, notably
causing us to register the udbg console at the end of udbg_early_init().

This means on a system which doesn't have anything that BOOTX can
use (most systems), we register the udbg console very early but the
bootx code just throws everything away, meaning early boot messages
are never printed to the console.

What we want to happen is for the udbg console to only be registered
later (from setup_arch()) once we've setup udbg_putc, and then all
early boot messages will be replayed.

Fixes: b9ef7d6b11c1 ("powerpc: Update default configurations")
Reported-by: Torsten Duwe <duwe@lst.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/configs/g5_defconfig     | 1 -
 arch/powerpc/configs/maple_defconfig  | 1 -
 arch/powerpc/configs/pmac32_defconfig | 1 -
 arch/powerpc/configs/ppc64_defconfig  | 1 -
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 5 files changed, 5 deletions(-)

--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -283,7 +283,6 @@ CONFIG_DEBUG_MUTEXES=y
 CONFIG_LATENCYTOP=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_PPC_EARLY_DEBUG_BOOTX=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -137,7 +137,6 @@ CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_PPC_EARLY_DEBUG_BOOTX=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -349,7 +349,6 @@ CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_PPC_EARLY_DEBUG_BOOTX=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_PCBC=m
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -339,7 +339,6 @@ CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
 CONFIG_XMON=y
 CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1261,7 +1261,6 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_XMON=y
 CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_PPC_EARLY_DEBUG_BOOTX=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y

