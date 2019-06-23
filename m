Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30289C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0607222CEB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XUorqbSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfFXBlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFXBk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNrCnR2859711
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:53:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNrCnR2859711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333993;
        bh=edl4mcIV9KIInPAdE5Cm1ulGFQS5zNDKqOxX+yAEMWk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XUorqbSn5dewYUPpr08alpXyQq77DD/dZO+CuuSLaenCD6o2UPxnsN7jp4M4d6iCX
         Wd0bNL0NwZ7IjlIRVocXD6DR7oHcyg52g2NSfS0dcfXaOjd4lJrDixAdbPk9JamU06
         9t314WaNiCKzmT3bISwYmEm0q2MmfsBcOLKOt8/fMkFAhPNz7/ERXIPo6RqP81Nhc+
         ja67svlfQ8749/uAjrJ9b7I34zQFkmazQ6ecMoR0ncF9LMK9h9C4UL8nws60t2eCW4
         29v33liZMAXqZLfjJ5m4YkPY7fk/YXN+Ivj2s5t8pEsFXsr+INS2REjpyo4LDVEgiC
         2TthAmjeC0Eqw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNrBsK2859708;
        Sun, 23 Jun 2019 16:53:11 -0700
Date:   Sun, 23 Jun 2019 16:53:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-1e3f17f55aec6510f88ff65dcbaae13435af0ba6@git.kernel.org>
Cc:     andre.przywara@arm.com, vincenzo.frascino@arm.com,
        sthotton@marvell.com, huw@codeweavers.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, salyzyn@android.com,
        0x7f454c46@gmail.com, mingo@kernel.org, shuah@kernel.org,
        hpa@zytor.com, paul.burton@mips.com, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, tglx@linutronix.de,
        will.deacon@arm.com, pcc@google.com, daniel.lezcano@linaro.org,
        catalin.marinas@arm.com
Reply-To: mingo@kernel.org, 0x7f454c46@gmail.com, hpa@zytor.com,
          shuah@kernel.org, arnd@arndb.de, sthotton@marvell.com,
          huw@codeweavers.com, vincenzo.frascino@arm.com,
          andre.przywara@arm.com, salyzyn@android.com,
          linux@rasmusvillemoes.dk, daniel.lezcano@linaro.org,
          pcc@google.com, catalin.marinas@arm.com, ralf@linux-mips.org,
          linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
          paul.burton@mips.com, will.deacon@arm.com, tglx@linutronix.de
In-Reply-To: <20190621095252.32307-14-vincenzo.frascino@arm.com>
References: <20190621095252.32307-14-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: elf: VDSO code page discovery
Git-Commit-ID: 1e3f17f55aec6510f88ff65dcbaae13435af0ba6
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

Commit-ID:  1e3f17f55aec6510f88ff65dcbaae13435af0ba6
Gitweb:     https://git.kernel.org/tip/1e3f17f55aec6510f88ff65dcbaae13435af0ba6
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:40 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:09 +0200

arm64: elf: VDSO code page discovery

Like in normal vDSOs, when compat vDSOs are enabled the auxiliary
vector symbol AT_SYSINFO_EHDR needs to point to the address of the
vDSO code, to allow the dynamic linker to find it.

Add the necessary code to the elf arm64 module to make this possible.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
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
Link: https://lkml.kernel.org/r/20190621095252.32307-14-vincenzo.frascino@arm.com

---
 arch/arm64/include/asm/elf.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 325d9515c0f8..3c7037c6ba9b 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -202,7 +202,21 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 ({									\
 	set_thread_flag(TIF_32BIT);					\
  })
+#ifdef CONFIG_GENERIC_COMPAT_VDSO
+#define COMPAT_ARCH_DLINFO						\
+do {									\
+	/*								\
+	 * Note that we use Elf64_Off instead of elf_addr_t because	\
+	 * elf_addr_t in compat is defined as Elf32_Addr and casting	\
+	 * current->mm->context.vdso to it triggers a cast warning of	\
+	 * cast from pointer to integer of different size.		\
+	 */								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+			(Elf64_Off)current->mm->context.vdso);		\
+} while (0)
+#else
 #define COMPAT_ARCH_DLINFO
+#endif
 extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
 					  int uses_interp);
 #define compat_arch_setup_additional_pages \
