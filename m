Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CE8C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE7521841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbfDQUz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:29 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbfDQUz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:27 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3lkT-1hG2Mg2SF1-000wd2; Wed, 17 Apr 2019 22:54:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     netdev@vger.kernel.org
Cc:     y2038@lists.linaro.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v3 2/3] asm-generic: generalize asm/sockios.h
Date:   Wed, 17 Apr 2019 22:51:49 +0200
Message-Id: <20190417205404.1877560-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190417205404.1877560-1-arnd@arndb.de>
References: <20190417205404.1877560-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FOfgVjHtBZ0OW8C3V0LXa7wLWJZ1CEMCBFodtLv5+jGoOIvtmOO
 7Zk231Di7aj03uQiKQq0hrnXKaNTIQSryIk2qwUaugxCw/8DWEUiSN0b5l262JHeax7PWEl
 2Y6w7jKYvUoTJtSBvV44dWezbbKht+hT9J89mml5w7iV3BjhQ73rMaFWWWrvxUMEX/ZUkb8
 N9AA90zeyjE1PbHqG5rtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k063E2GsEco=:4hVEv7dmqHHw0nvomJ3WWl
 IM28bbcnMcYNqTyRRBbGidTTZC3+84JbwDV8vlrlz07ri4hDVZI3QqcPBYbz+8Id/Gu6mZGQc
 S861YuZpM95FOi1DXN7OngEd4KP9ZuTIQEiExZFUsY1w0+jaDqho7EmDyPIMwlfmh9Fh06JPq
 uCCoWcaompQtiTBlHzuhx8Wj7ULlQKlJwWi+eshk8nuoRoAM8jY9ABgf+ERuV05vxJO8sdalg
 oQp+eAyq+WmdiWKpuVkzMWTs7YeyPCzyv5NEgT/9W6qrwdVJWEEQxHy4Qshr7xPiu20iG58bW
 DSUpkbV0LYaGvJaj1pjL8PfeVgBvnrGvV6LBpeBirZ6oLNwS2cSxUowx+qJzU4NLLD7NTYSSS
 x/caJnvJDNNq2wnslZVYVWNTp6H+9p86/B9125Ivyi3Vss8RUnY2xkexYS6oRuGU/6lcbR8fY
 fnJpvHchjG8rh/eRoE0Cu9ifkfcxjbuR7CnVggjkKx9N73BYvyGeAdsDrSESKFqa04b4jBf/G
 Arn/JgIUN+LJfjCcLOF3eNokirNrHAiKPTRyR9H5/t9ZiiqCfpuTrr7lCbVzGy8s6Dcj699jx
 Imm89Y0VPgUNkGyrU3QAXFvJJ8qOZyGUxhhqRIGiRBYdmri5OpNteR+mE6QQ+60S+M3AsiGjA
 WlqudfgzixxtHY9T4y+2zD5U4zf9Lul86qFFiJ2tUSfEZyvn+bSfhvuI4vpGwYM/mWhoUIM6U
 zopSyg2gGU7ywt06aWFeQ41NrrzckovfRLQx0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ia64, parisc and sparc just use a copy of the generic version
of asm/sockios.h, and x86 is a redirect to the same file, so we
can just let the header file be generated.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: no changes since v1
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

