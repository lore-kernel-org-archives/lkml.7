Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B67C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B096920684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfCFO36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:29:58 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:57513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfCFO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:29:58 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MfqCF-1hThQW2uaH-00gIqB; Wed, 06 Mar 2019 15:29:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Laura Abbott <labbott@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipc: Fix building compat mode without sysvipc
Date:   Wed,  6 Mar 2019 15:29:28 +0100
Message-Id: <20190306142944.834167-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:H75Y3y1XhhuHgtSKsBZJYqG7qLjLASDqSw56HBZbDKRz2Jxdu25
 yoWU5INq589yGf24ThmfDpfM94RakAFKKY03O3npaCtgp5I8n10seUVRz+YVeVjELyEOXuC
 Rv8nMvF4Mggi3E6nxCzMOvlbQaqflQLGhKGboYMwKKkKHGp45+GNCgi+JQRccs2f9/Ycti8
 QajF9HsfgrETKO50dB1rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PDeflx3fzNA=:R1oo1EzXibYjLApPlCCzZb
 DkcoRix4Q9uc+K0GfCC1BlPlm19kOuDLLkDS6DYmxjIxunsKJTzuTaqPkJzoXh6FGE49kQFEz
 cqzPkhNM5NKUIOq6FnjBhGAecJ/bw3VV2StTuaB/P5e5ZuEqoC8Qz4fDlT9ttKbacbztLBsnp
 w26V3XtbwS9RUlS3O8NTFL2MDlb68wMFYHqGBLl/+6pXVnPq2iAr2G0OWqr3XnF6bL27PxBF7
 zU0NNjzTG/8V6/6Yd00qnd52DSDzXFg2KxY1O42XNEOgwKBjIVhh05XJmXSJ5Bzqy3M/+pMou
 tBshXOdGTdALzeobPF1lSJb38TyF5Dsio/wS+v0opWefW07n8DnI60zJev6kEOGqZBfsIvj3b
 WmLQwzH9d/tPcB2Qho3LWTipCKF/idk+VIvXX/iMUGwpO+MxUckHbyWkQ/LQuzu089lGTSZNu
 sJWdkWIRnmxPNFL/kEwW3i13pEJX6S/b5glI+o9p8COrQgdGfx8FZN8m2kWRfen8R/RQ+TWhJ
 58z2565CK5J8v/O1Jt0llwYn3Qgc8V8RCK1WvwKwKDg7KPsMkUWOr7JVaJla/hlfCf5k5MfTe
 zVeTJlCV1UjCpw/vbgM18v+u7a3ZeIfQZCruk0BM2/0SGbONH/ehDeQgCDc7tunaO/Jb7pwEc
 J8bGvgvtWt2MMlsa+e/lgMp3lVamuOS0jN5mndydWc3G914J15F2E7Hhq/1r+E0ozce/Kv127
 1+PVbt/z/GCHYxY2ybPlQyKkyzbznPUTGXCZSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As John Stultz noticed, my y2038 syscall series caused a link
failure when CONFIG_SYSVIPC is enabled but CONFIG_COMPAT is
enabled:

arch/arm64/kernel/sys32.o:(.rodata+0x960): undefined reference to `__arm64_compat_sys_old_semctl'
arch/arm64/kernel/sys32.o:(.rodata+0x980): undefined reference to `__arm64_compat_sys_old_msgctl'
arch/arm64/kernel/sys32.o:(.rodata+0x9a0): undefined reference to `__arm64_compat_sys_old_shmctl'

Add the missing entries in kernel/sys_ni.c for the new system
calls.

Cc: Laura Abbott <labbott@redhat.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm about to send off my pull requests for arm-soc, so I'd just
send another one with just this common from my y2038 tree.
---
 kernel/sys_ni.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 85e5ccec0955..62a6c8707799 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -202,6 +202,7 @@ COND_SYSCALL(msgget);
 COND_SYSCALL(old_msgctl);
 COND_SYSCALL(msgctl);
 COND_SYSCALL_COMPAT(msgctl);
+COND_SYSCALL_COMPAT(old_msgctl);
 COND_SYSCALL(msgrcv);
 COND_SYSCALL_COMPAT(msgrcv);
 COND_SYSCALL(msgsnd);
@@ -212,6 +213,7 @@ COND_SYSCALL(semget);
 COND_SYSCALL(old_semctl);
 COND_SYSCALL(semctl);
 COND_SYSCALL_COMPAT(semctl);
+COND_SYSCALL_COMPAT(old_semctl);
 COND_SYSCALL(semtimedop);
 COND_SYSCALL(semtimedop_time32);
 COND_SYSCALL(semop);
@@ -221,6 +223,7 @@ COND_SYSCALL(shmget);
 COND_SYSCALL(old_shmctl);
 COND_SYSCALL(shmctl);
 COND_SYSCALL_COMPAT(shmctl);
+COND_SYSCALL_COMPAT(old_shmctl);
 COND_SYSCALL(shmat);
 COND_SYSCALL_COMPAT(shmat);
 COND_SYSCALL(shmdt);
-- 
2.20.0

