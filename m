Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1537C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94D821841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfCVPt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:49:56 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59885 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:49:55 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MUXh8-1hXrXA13M8-00QWTC; Fri, 22 Mar 2019 16:49:24 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Qiao Zhou <qiaozhou@asrmicro.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 21/25] arm64: traps: disable irq in die()
Date:   Fri, 22 Mar 2019 16:44:12 +0100
Message-Id: <20190322154425.3852517-22-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3h0I8WSBNcOUW2oBof6q4Zhu/MkBQ6JfTTEKDc7C3t0ARWbsWDW
 LpKGcnzl45jHUFU9EP6rpjw/bhSVoXTjFVkix+HREzEV0D6h29XjIBciuqjvbl5ioglPyhZ
 o09rVRymoVQv97+wPo7JbUcvIqc+YXMps+5gOFwSUMbgnrjZ60/CJxMhUelO3jFDPtnRZnA
 qwT+QalE3JUyoRCgW6ApA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OyNCwkcqWVk=:fnMCXM6qGiqalwHEgD8Iu2
 pdyteGzjvepTLU+a3gAQMbqAZA+7QMp2r6Duc6ZGbHyBsvLRqjmRyEa8RPuMCpy4zJg8nSt2q
 9NZRKRPGRykTQCCVwky0x4qJZ6zhOJXjP+z9dlHqcxrywdgoAcMOPrGibkrMEQhxCNC+/Xwvl
 S1TJ3gfoefECcdTdnEtUg8CUVdGEPTa5eaaOiUlneggP0hVD6RYYE/fPg9OVCpBICv0YqxfRb
 TshicGNuaCMyxlndntEGftdpt/cQCLNbKzlyNxSnwIXGST2AxFEn2+e4Koi+zrLAgx3yq8tEK
 AXigKZZr7JElicNSnXOAAq9uDVWMk9EV6l0wN5zZmOMqYPkDAbBZ+LscXN4B8UGUQRrNOHsjZ
 ZAt+2niyO+5EWFq4Zs+Ui5zONBpbxw4MiDOchKYerKvLuyr6RPMOIt+vyPbxzA9JNCr28IZrC
 S7b82gW4MQE359l+cI5RidYzYbMaDt4GteSbccTGYgIW5xa5PLYMY98/4thvelGEzNYBjbnRy
 VxQ0q1+sN/sRtpHEfx9YEte8Fjhs5Vx8cL1ThvWJf7PxnmXWqin//WwhlYAscLw+ZT1OQ5SIF
 FmC0A1Fxrzjdbofrt1Bo74vw8VdKyD7g4xMjxXlMPjjB5cHJoqAyI2uxcZzbjth40ZfxtY08X
 HVNXqZ3TNYDPmIFPcUo81haz7hCLWZR3/DWLQinW4+VRyS9nWS0sb7mK9yZ2ntWlrLZjByeCf
 GYKkMLUnW8IRzldjnvyioNNCGZVG2KYUfaCl3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiao Zhou <qiaozhou@asrmicro.com>

In current die(), the irq is disabled for __die() handle, not
including the possible panic() handling. Since the log in __die()
can take several hundreds ms, new irq might come and interrupt
current die().

If the process calling die() holds some critical resource, and some
other process scheduled later also needs it, then it would deadlock.
The first panic will not be executed.

So here disable irq for the whole flow of die().

Signed-off-by: Qiao Zhou <qiaozhou@asrmicro.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
(cherry picked from commit 6f44a0bacb79a03972c83759711832b382b1b8ac)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/traps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5d270ca76aec..6b4579e07aa2 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -239,10 +239,12 @@ void die(const char *str, struct pt_regs *regs, int err)
 {
 	struct thread_info *thread = current_thread_info();
 	int ret;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&die_lock, flags);
 
 	oops_enter();
 
-	raw_spin_lock_irq(&die_lock);
 	console_verbose();
 	bust_spinlocks(1);
 	ret = __die(str, err, thread, regs);
@@ -252,13 +254,15 @@ void die(const char *str, struct pt_regs *regs, int err)
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	raw_spin_unlock_irq(&die_lock);
 	oops_exit();
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 	if (panic_on_oops)
 		panic("Fatal exception");
+
+	raw_spin_unlock_irqrestore(&die_lock, flags);
+
 	if (ret != NOTIFY_STOP)
 		do_exit(SIGSEGV);
 }
-- 
2.20.0

