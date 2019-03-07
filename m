Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E84620840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCGJPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:15:46 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:34585 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:15:46 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MEC8L-1hBxzM2n1p-00AGZI; Thu, 07 Mar 2019 10:15:17 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Date:   Thu,  7 Mar 2019 10:14:48 +0100
Message-Id: <20190307091514.2489338-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S3kUtMzoNI8KlQ2wKB+ejkwBPfOfIgqsOL/AUMi0Cb+3hosjQHE
 vtgKLV6Ss6vzmeqtYoaAXMilaBkzsri1RGXH5CGNpXl2PtoT/xbylPuhxbfiVT6P5k0yQGi
 ckcewuAugshOAWkiBb1xkm8/ohk0wZotaZqX2VPU0TjcKvX1KcMd9onAwIOXXYdAL/t+E0Y
 P6pOctJCZ+sWe28t7YT2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mcwu7Q9Iyxs=:LmRcAUw+K9SxQVksjd8NUm
 Le0p9KwIkdAGTwiV+h9k3ObOg/tyurz2w+wSt9FkYYKhyxklQvPkz5DUnBFuNUP+sdbnmDAzW
 A2dB/dhghmACaxbWgoPARsSg1AI7YRzHLhFgyDcMtyRDR+FFp5SmAkUS0RduZK8Ny1DZcZOai
 +u+NrFulVIYOJtr+9fHp6pF1p3AYhiKrIM4n+n4DYvvSlDnGhPGgmVYxtkAfYCCIxabwfg6yk
 w/z+hOLE0g94gQRHbv9ZrO8RRxEADgN0TgVedrF0aaECokFiYKZgee3JFL3mkmjsLQctvG2tR
 8bIwnqIYrpI5oW5++OK9qx7klx8szfQ4RAhdwO+RZGXDVxvsYsfUOyD682399ibKegDlLOvSU
 LRAJRWgs5mqbKWP5wKShrJfPX20CSALs/LGwoJdu3fAv0l6VRFxLDoc7yLm/824sXbBNB2p1u
 7BLUAvCuazFxIxM021/Z7u7VqcZWtY0N4Iog+k7saV9k1rZ6gXjrthGjIP2tA+4GBPtAvgWvP
 Z6/uDAZjqCfu2YPv4KnRA6uDtLoaugvgVH3QC2mKf0fxvPX30QsIS50SCwEqVI3UuJGEk4haq
 M9PYCebeM72Wy0RFJLYv0Q0I3dppPfscgDdU76Hl8LYRgC8SfgxLjcE8yMHuQUhPQiKQJ2zOP
 zT03HV8SIa4opwW9msq9b1bZ7n94K6yMr+R/dlmcoXltKkUFRcm9/NeMTDdcb2dIqR4yNkd3g
 0i5GTPB16FGCN9xNN7RBu2QSlkTqhTNdMqbcGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit ARM, I got a link failure in futex_init() when building
with clang in some random configurations:

kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'

As far as I can tell, the problem is that a branch is over 16MB
apart in those configurations, but only if it branches back to
the init text.

Marking the futex_detect_cmpxchg() function as noinline and
not __init avoids the problem for me.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/futex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index c3b73b0311bc..dda77ed9f445 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3849,7 +3849,7 @@ SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
 }
 #endif /* CONFIG_COMPAT_32BIT_TIME */
 
-static void __init futex_detect_cmpxchg(void)
+static noinline void futex_detect_cmpxchg(void)
 {
 #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
 	u32 curval;
-- 
2.20.0

