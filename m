Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D7BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EB121741
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfDPUiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:38:22 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPUiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:38:22 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N0nOF-1gtrD33xzx-00wlMo; Tue, 16 Apr 2019 22:37:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH net-next 2/3] asm-generic: generalize asm/sockios.h
Date:   Tue, 16 Apr 2019 22:32:49 +0200
Message-Id: <20190416203620.539628-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416203620.539628-1-arnd@arndb.de>
References: <20190416203620.539628-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xkQvlCVeFcocDpA6GJ/DsjcZtCWIXeVY+jedgURaIidy1n6x1Kb
 BCAE2c/OSfq+6+LMaeMdLasPUB8BXpIiI4kJcPRn1psjavRjkQNWtoLHFHBquvN+A0tx5u7
 TSZBiCV/8sJDSXRpWq7wEwvhBdqcQKVD8mVjIeVeYCCbXmLJCToXe0hc+Af+dn8FCVyrwnr
 41KEsBlq3Nw5UQWS7DZOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3iqgD1Uyltk=:WCHkFy9q6gsfLPH0m+BbiN
 t/q/aOoKGcnKY99gsEtrbeZgrOPp0ab9lBVlK3EsCSzVNW969D3JvskrQ36TaSSyBOaJHiiJP
 ExgjiCTocbmlHlifIKdCGfUFliohx8fs2nBjf+/+yhtYCVX9ktuPHqg3leyPWULiK0dakEPGH
 Ghgz3NUvLIHYpF6MrdBy2hhVHxg8+8fEWlLFe6BWO6/kDAgVkcoFc3o7ul+6dNj9PZVyCYUZI
 NdHPeg6jLi+JkwkpR5w94Ufs0Hn05SeNhd3UujlkJNLo1tR2reA4hN3nOSxjxWcuhqeEcrM2S
 w5J71TD30FaWXsXVf0fpjXwgvjmMKNMKhbpjQK/YIQuZde0dvlu5v9KwWalh9t2TYXYGwtPue
 YawvYtgnEXQfQ2X6olFLPHTPTYVsGWDL61tQaS/aaPh4nPWsOtiQ1Kzo9PNfoSb/JReRqebuh
 OfdgAVW8Wx/kkSDARcc0LjmXJxZIPawxuIHDmUVWL6pi1cch4vN2y/Ee8kdxHsoxH2IuSRaaM
 zmWjmm8UHwvAEZbNzKcrg4+wCjE8T5CE/qH7im/5jtmmQcXQUHVWoeDtzS/29duTWKvyFG7wH
 lBK/NyjsfRcD7JJ5czYNpbnyao+Ccz987DButlaqs5ymuy6MNHsoibsGu6+AjgKi17pGYby7/
 4aPCkxgKYW7ybsa1dajubIGLO5pPV1Gnen7CvkdokmZE7aGF57m+ARMLCzPUBMuLmsW6e25Xw
 ZNrAMimAYwcq9Lz+ljDHDNVq5AO4VMIZi8GQaA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ia64, parisc and sparc just use a copy of the generic version
of asm/sockios.h, and x86 is a redirect to the same file, so we
can just let the header file be generated.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/uapi/asm/sockios.h   | 21 ---------------------
 arch/parisc/include/uapi/asm/sockios.h | 14 --------------
 arch/sparc/include/uapi/asm/sockios.h  | 15 ---------------
 arch/x86/include/uapi/asm/sockios.h    |  1 -
 4 files changed, 51 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/sockios.h
 delete mode 100644 arch/parisc/include/uapi/asm/sockios.h
 delete mode 100644 arch/sparc/include/uapi/asm/sockios.h
 delete mode 100644 arch/x86/include/uapi/asm/sockios.h

diff --git a/arch/ia64/include/uapi/asm/sockios.h b/arch/ia64/include/uapi/asm/sockios.h
deleted file mode 100644
index f27a12f95d20..000000000000
--- a/arch/ia64/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_SOCKIOS_H
-#define _ASM_IA64_SOCKIOS_H
-
-/*
- * Socket-level I/O control calls.
- *
- * Based on <asm-i386/sockios.h>.
- *
- * Modified 1998, 1999
- *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
- */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif /* _ASM_IA64_SOCKIOS_H */
diff --git a/arch/parisc/include/uapi/asm/sockios.h b/arch/parisc/include/uapi/asm/sockios.h
deleted file mode 100644
index 66a3ba64d53f..000000000000
--- a/arch/parisc/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ARCH_PARISC_SOCKIOS__
-#define __ARCH_PARISC_SOCKIOS__
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif
diff --git a/arch/sparc/include/uapi/asm/sockios.h b/arch/sparc/include/uapi/asm/sockios.h
deleted file mode 100644
index 18a3ec14a847..000000000000
--- a/arch/sparc/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_SPARC_SOCKIOS_H
-#define _ASM_SPARC_SOCKIOS_H
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif /* !(_ASM_SPARC_SOCKIOS_H) */
-
diff --git a/arch/x86/include/uapi/asm/sockios.h b/arch/x86/include/uapi/asm/sockios.h
deleted file mode 100644
index def6d4746ee7..000000000000
--- a/arch/x86/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/sockios.h>
-- 
2.20.0

