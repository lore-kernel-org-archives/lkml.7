Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44970C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A082067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfLPOts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:49:48 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:38319 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfLPOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:49:48 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mofst-1hwGO02HIf-00p79V; Mon, 16 Dec 2019 15:49:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Julian Calaby <julian.calaby@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] y2038: sparc: remove use of struct timex
Date:   Mon, 16 Dec 2019 15:48:53 +0100
Message-Id: <20191216144907.1931511-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SD9rTavFUocz6lTgBzyWJKCDwZMGx6GQHqRzwZ5WgDi5LT4Zg47
 60bHxonI53Bup8EujS4+6F+AMH/CfRjJySvogLwX86fOQ7WmIUSun0AYvtDdbHi0DCOuoHc
 HQQtPAOoXE/b+7Nx/Fanu1Vkc3/zSWXyitoA3+dGpn3owdwtAOIrT9udBSwqYgwXJf0Vf55
 Yki730p6PxSbIOZ/qRdXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A28Gjab46IU=:TUSBcmj2VLOO7RKETeVmBR
 1tcCM3ko/hKnpa6Tdwxb21L+ZGs3s6yjR7fFX0/GwWMlqQh7pi3n1KHeKAxh6zJooB/3fa/5o
 5BK9DD27o/1RJNfemhrKN1El8pk4PRC6G2juiuVHAjTViFMINEQaGa9Z6VTBVX+hyGVdJzQUf
 tK94d6+tIJgj6l0oVWL7TS1CtIwrTpGPQc75e2IrJesrvX2rapbVleWe1Dz05xW/1TDPkZcsD
 w7fPFX7winY5wLDW+E1zi6f3/5PlDDcVI28Bmb1Jh+AmGOE12lLqIU+DpDtSiWhfDCNnluwh5
 pS4ROP79ZFWzR2Zg70YenCovyCw8lvKIyHZzacr3i5cyct592BX5Ghlu5HWIu04O16wbgkt+D
 o5dm8O+MzRAv+urpEoAFLca1oofWvS670IyDbnV8hhhJVjlSgfmX91W15B9+s1uyec+dbR7C+
 knrvxqLhupx1Ls8rLg0LI/KzklBWl0uekrqlr84SzmxaDLeDROP1IrzGuFwfdJvppAF298IT5
 1eH7toqXnK+9G9VCPENuC527adM8xmxhXoHbaeIQr3NdzW6ceg/QiUciJ8A/3Cp3+4UO82Vpq
 maxK/nq25gOOHCcldjRgb+sEOpbXgUIr8cbcKlt4Cnes7V+gUzRqzpjb35678QmHna3ovhiFO
 4h0BCnH6gnugAhB+b8AwKzVzuCbybVFBQcP1ezetkovXJ/8nsZohGVinUEdW0UomZNXTw/bJm
 jSbY8FatMuxuMyqjlgZ81SdQwvaHAREzmw8LKAAoPNY2RZVUNmAOe4C5oLtvfX/lU/Utgwskc
 pB6mW8Hp8kmtekDFW1yiIeatoDsoP6j1q21uaIiM2qSJayLZX5qklURkysxFDplncRgEdSRyQ
 HV1TuGVr9Nu7s3cZHeWQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct timex' is one of the last users of 'struct timeval' and is
only referenced in one place in the kernel any more, to convert the
user space timex into the kernel-internal version on sparc64, with a
different tv_usec member type.

As a preparation for hiding the time_t definition and everything
using that in the kernel, change the implementation once more
to only convert the timeval member, and then enclose the
struct definition in an #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: send a version that it at least build tested this time

If this looks ok to you, please queue it in the sparc git for v5.6

 arch/sparc/kernel/sys_sparc_64.c | 33 ++++++++++++++++----------------
 include/uapi/linux/timex.h       |  2 ++
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 9f41a6f5a032..34917617f258 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -548,34 +548,35 @@ SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
 	return err;
 }
 
-SYSCALL_DEFINE1(sparc_adjtimex, struct timex __user *, txc_p)
+SYSCALL_DEFINE1(sparc_adjtimex, struct __kernel_timex __user *, txc_p)
 {
-	struct timex txc;		/* Local copy of parameter */
-	struct __kernel_timex *kt = (void *)&txc;
+	struct __kernel_timex txc;
+	struct __kernel_old_timeval *tv = (void *)&txc_p->time;
 	int ret;
 
 	/* Copy the user data space into the kernel copy
 	 * structure. But bear in mind that the structures
 	 * may change
 	 */
-	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+	if (copy_from_user(&txc, txc_p, sizeof(txc)))
 		return -EFAULT;
 
 	/*
 	 * override for sparc64 specific timeval type: tv_usec
 	 * is 32 bit wide instead of 64-bit in __kernel_timex
 	 */
-	kt->time.tv_usec = txc.time.tv_usec;
-	ret = do_adjtimex(kt);
-	txc.time.tv_usec = kt->time.tv_usec;
+	txc.time.tv_usec = tv->tv_usec;
+	ret = do_adjtimex(&txc);
+	tv->tv_usec = txc.time.tv_usec;
 
-	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+	return copy_to_user(txc_p, &txc, sizeof(txc)) ? -EFAULT : ret;
 }
 
-SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,struct timex __user *, txc_p)
+SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,
+		struct __kernel_timex __user *, txc_p)
 {
-	struct timex txc;		/* Local copy of parameter */
-	struct __kernel_timex *kt = (void *)&txc;
+	struct __kernel_timex txc;
+	struct __kernel_old_timeval *tv = (void *)&txc_p->time;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_POSIX_TIMERS)) {
@@ -590,18 +591,18 @@ SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,struct timex _
 	 * structure. But bear in mind that the structures
 	 * may change
 	 */
-	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+	if (copy_from_user(&txc, txc_p, sizeof(txc)))
 		return -EFAULT;
 
 	/*
 	 * override for sparc64 specific timeval type: tv_usec
 	 * is 32 bit wide instead of 64-bit in __kernel_timex
 	 */
-	kt->time.tv_usec = txc.time.tv_usec;
-	ret = do_clock_adjtime(which_clock, kt);
-	txc.time.tv_usec = kt->time.tv_usec;
+	txc.time.tv_usec = tv->tv_usec;
+	ret = do_clock_adjtime(which_clock, &txc);
+	tv->tv_usec = txc.time.tv_usec;
 
-	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+	return copy_to_user(txc_p, &txc, sizeof(txc)) ? -EFAULT : ret;
 }
 
 SYSCALL_DEFINE5(utrap_install, utrap_entry_t, type,
diff --git a/include/uapi/linux/timex.h b/include/uapi/linux/timex.h
index 9f517f9010bb..bd627c368d09 100644
--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -57,6 +57,7 @@
 
 #define NTP_API		4	/* NTP API version */
 
+#ifndef __KERNEL__
 /*
  * syscall interface - used (mainly by NTP daemon)
  * to discipline kernel clock oscillator
@@ -91,6 +92,7 @@ struct timex {
 	int  :32; int  :32; int  :32; int  :32;
 	int  :32; int  :32; int  :32;
 };
+#endif
 
 struct __kernel_timex_timeval {
 	__kernel_time64_t       tv_sec;
-- 
2.20.0

