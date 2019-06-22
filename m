Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D7C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DF020665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Kp591VF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFVKPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:15:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48227 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFVKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:15:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MAEh0Q2098137
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:14:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MAEh0Q2098137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198484;
        bh=y1H3uKTIFDEBKPSumoiUJbDtRhwL7T7bukKTDrT0pVs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Kp591VF6P8djKW5ff39cVoq8PPr7kfWb3ug2ZheGcnWqxf0tsg9uCH/j7pZMxG+bz
         jUaUaqNJwgIYf8m/wLgGMeEKToAfbwgb6eIN57oDJ1tU+v9AG+OM0fHCaNXGTeIK7d
         QApSwQ7VVYWL473aVfYo7QSBQ229sgpRKA2G5lL2cMmdEwZ+zt0fdCTVBPEq6URMLW
         sNR0sOjYEiyh6x0lzpPfa/DIhQGxRDd3u0fbuGBe3mqZI/F0sPNh7vvLsOJyqvz5ng
         CEs0FYDIdHG3DW+Oq2y+lTDD3g685b3CPUO/pbw2s1XVeJ1pWQb578ZPrPPeRtvpP/
         VDb1l3U1xMsWA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MAEhpY2098134;
        Sat, 22 Jun 2019 03:14:43 -0700
Date:   Sat, 22 Jun 2019 03:14:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-f987c955c74501c9295a81372c7d363cbe07c8a6@git.kernel.org>
Cc:     tglx@linutronix.de, ak@linux.intel.com, mingo@kernel.org,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, hpa@zytor.com, chang.seok.bae@intel.com
Reply-To: ravi.v.shankar@intel.com, chang.seok.bae@intel.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
          tglx@linutronix.de, ak@linux.intel.com, mingo@kernel.org
In-Reply-To: <1557309753-24073-18-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-18-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/elf: Enumerate kernel FSGSBASE capability in
 AT_HWCAP2
Git-Commit-ID: f987c955c74501c9295a81372c7d363cbe07c8a6
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

Commit-ID:  f987c955c74501c9295a81372c7d363cbe07c8a6
Gitweb:     https://git.kernel.org/tip/f987c955c74501c9295a81372c7d363cbe07c8a6
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Wed, 8 May 2019 03:02:32 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:56 +0200

x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2

The kernel needs to explicitly enable FSGSBASE. So, the application needs
to know if it can safely use these instructions. Just looking at the CPUID
bit is not enough because it may be running in a kernel that does not
enable the instructions.

One way for the application would be to just try and catch the SIGILL.
But that is difficult to do in libraries which may not want to overwrite
the signal handlers of the main application.

Enumerate the enabled FSGSBASE capability in bit 1 of AT_HWCAP2 in the ELF
aux vector. AT_HWCAP2 is already used by PPC for similar purposes.

The application can access it open coded or by using the getauxval()
function in newer versions of glibc.

[ tglx: Massaged changelog ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-18-git-send-email-chang.seok.bae@intel.com

---
 arch/x86/include/uapi/asm/hwcap2.h | 3 +++
 arch/x86/kernel/cpu/common.c       | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/hwcap2.h b/arch/x86/include/uapi/asm/hwcap2.h
index 6ebaae90e207..c5ce54e749f6 100644
--- a/arch/x86/include/uapi/asm/hwcap2.h
+++ b/arch/x86/include/uapi/asm/hwcap2.h
@@ -5,4 +5,7 @@
 /* MONITOR/MWAIT enabled in Ring 3 */
 #define HWCAP2_RING3MWAIT		(1 << 0)
 
+/* Kernel allows FSGSBASE instructions available in Ring 3 */
+#define HWCAP2_FSGSBASE			BIT(1)
+
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1305f16b6105..637c9117d5ae 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1387,8 +1387,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 
 	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE))
+	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
 		cr4_set_bits(X86_CR4_FSGSBASE);
+		elf_hwcap2 |= HWCAP2_FSGSBASE;
+	}
 
 	/*
 	 * The vendor-specific functions might have changed features.
